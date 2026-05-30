import React, { useState, useEffect } from 'react'
import { FileText, CalendarDays, WalletCards, ReceiptText, TrendingUp, Printer, FileSpreadsheet, RotateCcw } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const toInputDate = (date) => {
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

export default function LaporanPenjualan() {
  const [data, setData] = useState({ transaksi: [], total_penjualan: 0, total_transaksi: 0, chart_data: [] })
  const [startDate, setStartDate] = useState(toInputDate(new Date(new Date().getFullYear(), new Date().getMonth(), 1)))
  const [endDate, setEndDate] = useState(toInputDate(new Date()))
  const [loading, setLoading] = useState(false)
  const [resetting, setResetting] = useState(false)
  const [reportPrintMode, setReportPrintMode] = useState(false)

  useEffect(() => { fetchLaporan() }, [startDate, endDate])

  useEffect(() => {
    document.body.classList.toggle('report-print-mode', reportPrintMode)
    return () => document.body.classList.remove('report-print-mode')
  }, [reportPrintMode])

  useEffect(() => {
    const closePrintMode = () => setReportPrintMode(false)
    window.addEventListener('afterprint', closePrintMode)
    return () => window.removeEventListener('afterprint', closePrintMode)
  }, [])

  const fetchLaporan = async () => {
    setLoading(true)
    try {
      const res = await api.get(`/laporan/penjualan?start_date=${startDate}&end_date=${endDate}`)
      setData(res.data)
    } catch (e) {
    } finally {
      setLoading(false)
    }
  }

  const formatDateTime = (value) => {
    return new Intl.DateTimeFormat('id-ID', {
      weekday: 'long',
      day: '2-digit',
      month: 'long',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
    }).format(new Date(value)).replace(/\./g, ':')
  }

  const escapeExcel = (value) => String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')

  const printReport = () => {
    if (data.transaksi.length === 0) return toast.error('Tidak ada transaksi untuk dicetak')
    setReportPrintMode(true)
    window.setTimeout(() => {
      window.print()
      window.setTimeout(() => setReportPrintMode(false), 2000)
    }, 80)
  }

  const exportExcel = () => {
    if (data.transaksi.length === 0) return toast.error('Tidak ada transaksi untuk diexport')

    const rows = data.transaksi.map(transaction => {
      const items = transaction.details?.map(item => `${item.nama_barang} (${item.jumlah} x ${formatRupiah(item.harga_satuan)})`).join('; ') || '-'
      return `
        <tr>
          <td>${escapeExcel(transaction.kode_transaksi)}</td>
          <td>${escapeExcel(formatDateTime(transaction.created_at || transaction.tanggal))}</td>
          <td>${escapeExcel(transaction.metode_pembayaran?.toUpperCase())}</td>
          <td>${escapeExcel(transaction.status)}</td>
          <td>${escapeExcel(items)}</td>
          <td>${Number(transaction.total_harga)}</td>
        </tr>
      `
    }).join('')

    const html = `
      <html>
        <head><meta charset="UTF-8"></head>
        <body>
          <table border="1">
            <tr><th colspan="6">Laporan Penjualan Sultan Cell</th></tr>
            <tr><td colspan="6">Periode: ${escapeExcel(startDate)} sampai ${escapeExcel(endDate)}</td></tr>
            <tr><td colspan="6">Dicetak: ${escapeExcel(formatDateTime(new Date()))}</td></tr>
            <tr>
              <th>Kode Transaksi</th>
              <th>Waktu</th>
              <th>Pembayaran</th>
              <th>Status</th>
              <th>Detail Barang</th>
              <th>Total</th>
            </tr>
            ${rows}
            <tr>
              <td colspan="5"><strong>Total Penjualan</strong></td>
              <td><strong>${Number(data.total_penjualan)}</strong></td>
            </tr>
          </table>
        </body>
      </html>
    `

    const blob = new Blob(['\ufeff', html], { type: 'application/vnd.ms-excel;charset=utf-8;' })
    const url = URL.createObjectURL(blob)
    const link = document.createElement('a')
    link.href = url
    link.download = `laporan-penjualan-${startDate}-${endDate}.xls`
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    URL.revokeObjectURL(url)
    toast.success('Laporan Excel berhasil dibuat')
  }

  const resetReport = async () => {
    if (data.transaksi.length === 0) return toast.error('Tidak ada transaksi untuk direset')
    const confirmed = window.confirm(`Reset ${data.transaksi.length} transaksi penjualan dari ${startDate} sampai ${endDate}? Data transaksi dan detail barang akan dihapus dari laporan.`)
    if (!confirmed) return

    setResetting(true)
    try {
      const res = await api.delete('/laporan/penjualan/reset', {
        data: { start_date: startDate, end_date: endDate }
      })
      toast.success(`${res.data.deleted || 0} transaksi berhasil direset`)
      fetchLaporan()
    } catch (e) {
      toast.error(e.response?.data?.message || 'Gagal reset laporan')
    } finally {
      setResetting(false)
    }
  }

  const tunaiCount = data.transaksi.filter(t => t.metode_pembayaran === 'tunai').length
  const qrisCount = data.transaksi.filter(t => t.metode_pembayaran === 'qris').length
  const averageSale = data.total_transaksi ? data.total_penjualan / data.total_transaksi : 0

  return (
    <div className="report-page">
      <div className="report-print-area">
      <div className="page-heading report-heading">
        <div>
          <span>Laporan Kasir</span>
          <h1>Laporan Penjualan</h1>
          <p>Pantau transaksi tunai dan QRIS berdasarkan periode tanggal.</p>
        </div>
        <div className="report-heading-actions">
          <div className="report-date-range">
            <CalendarDays size={18} />
            <span>{startDate} sampai {endDate}</span>
          </div>
          <div className="report-action-buttons no-print">
            <button type="button" onClick={printReport} className="report-action-button print">
              <Printer size={17} />
              <span>PDF / Print</span>
            </button>
            <button type="button" onClick={exportExcel} className="report-action-button excel">
              <FileSpreadsheet size={17} />
              <span>Excel</span>
            </button>
            <button type="button" onClick={resetReport} disabled={resetting || loading} className="report-action-button reset">
              <RotateCcw size={17} />
              <span>{resetting ? 'Reset...' : 'Reset'}</span>
            </button>
          </div>
        </div>
      </div>

      <section className="report-filter-panel">
        <label className="field-group">
          <span>Tanggal Mulai</span>
          <input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} />
        </label>
        <label className="field-group">
          <span>Tanggal Akhir</span>
          <input type="date" value={endDate} onChange={e => setEndDate(e.target.value)} />
        </label>
      </section>

      <div className="report-summary-grid">
        <div className="report-card primary">
          <div><TrendingUp size={24} /></div>
          <span>Total Penjualan</span>
          <strong>{formatRupiah(data.total_penjualan)}</strong>
        </div>
        <div className="report-card">
          <div><ReceiptText size={24} /></div>
          <span>Jumlah Transaksi</span>
          <strong>{data.total_transaksi}</strong>
        </div>
        <div className="report-card">
          <div><WalletCards size={24} /></div>
          <span>Tunai / QRIS</span>
          <strong>{tunaiCount} / {qrisCount}</strong>
        </div>
        <div className="report-card">
          <div><FileText size={24} /></div>
          <span>Rata-rata Transaksi</span>
          <strong>{formatRupiah(averageSale)}</strong>
        </div>
      </div>

      <section className="report-table-panel">
        <div className="report-table-header">
          <div>
            <h2>Riwayat Transaksi</h2>
            <p>{loading ? 'Memuat data...' : `${data.transaksi.length} transaksi ditemukan`}</p>
          </div>
        </div>

        <div className="report-table-wrap">
          <table className="report-table">
            <thead>
              <tr>
                <th>Kode</th>
                <th>Tanggal</th>
                <th>Pembayaran</th>
                <th>Status</th>
                <th>Total</th>
              </tr>
            </thead>
            <tbody>
              {data.transaksi.map(transaction => (
                <tr key={transaction.id}>
                  <td><span className="item-code">{transaction.kode_transaksi}</span></td>
                  <td>{new Date(transaction.tanggal).toLocaleDateString('id-ID')}</td>
                  <td><span className={`payment-pill ${transaction.metode_pembayaran}`}>{transaction.metode_pembayaran}</span></td>
                  <td><span className={`status-pill ${transaction.status === 'lunas' ? 'paid' : 'pending'}`}>{transaction.status}</span></td>
                  <td className="money-cell strong">{formatRupiah(transaction.total_harga)}</td>
                </tr>
              ))}
            </tbody>
          </table>

          {!loading && data.transaksi.length === 0 && (
            <div className="report-empty">
              <FileText size={42} />
              <p>Tidak ada data penjualan</p>
              <span>Coba ubah periode tanggal atau buat transaksi baru.</span>
            </div>
          )}
        </div>
      </section>
      </div>
    </div>
  )
}
