import React, { useState, useEffect } from 'react'
import { FileText, CalendarDays, WalletCards, ReceiptText, TrendingUp, Printer, FileSpreadsheet, RotateCcw, Search, XCircle, Eye } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api, { getApiErrorMessage } from '../services/api'
import toast from 'react-hot-toast'
import Modal from '../components/Common/Modal'
import CustomerReturnModal from '../components/Sales/CustomerReturnModal'
import Button from '../components/ui/Button'
import Textarea from '../components/ui/Textarea'
import sultanCellLogo from '../assets/sultan-cell-logo-round.png'

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
  const [activeTab, setActiveTab] = useState('transaksi')
  const [loading, setLoading] = useState(false)
  const [resetting, setResetting] = useState(false)
  const [showResetConfirm, setShowResetConfirm] = useState(false)
  const [reportPrintMode, setReportPrintMode] = useState(false)
  const [search, setSearch] = useState('')
  const [paymentFilter, setPaymentFilter] = useState('semua')
  const [statusFilter, setStatusFilter] = useState('semua')
  const [selectedTransaction, setSelectedTransaction] = useState(null)
  const [returnTransaction, setReturnTransaction] = useState(null)
  const [savingReturn, setSavingReturn] = useState(false)
  const [cancelTarget, setCancelTarget] = useState(null)
  const [cancelReason, setCancelReason] = useState('')
  const [canceling, setCanceling] = useState(false)
  const [cancelError, setCancelError] = useState('')
  const [returnReport, setReturnReport] = useState({ retur: [], total_retur: 0, total_barang_retur: 0, filter_options: { alasan: [] } })
  const [returnLoading, setReturnLoading] = useState(false)
  const [returnFilters, setReturnFilters] = useState({
    start_date: toInputDate(new Date(new Date().getFullYear(), new Date().getMonth(), 1)),
    end_date: toInputDate(new Date()),
    search: '',
    alasan: 'semua',
    metode: 'semua',
  })

  useEffect(() => { fetchLaporan() }, [startDate, endDate])

  useEffect(() => { fetchReturnHistory() }, [returnFilters.start_date, returnFilters.end_date, returnFilters.alasan, returnFilters.metode])

  useEffect(() => {
    document.body.classList.toggle('report-print-mode', reportPrintMode)
    return () => document.body.classList.remove('report-print-mode')
  }, [reportPrintMode])

  useEffect(() => {
    const closePrintMode = () => setReportPrintMode(false)
    window.addEventListener('afterprint', closePrintMode)
    return () => window.removeEventListener('afterprint', closePrintMode)
  }, [])

  useEffect(() => {
    document.body.classList.toggle('receipt-print-mode', Boolean(selectedTransaction))
    return () => document.body.classList.remove('receipt-print-mode')
  }, [selectedTransaction])

  const fetchLaporan = async () => {
    setLoading(true)
    try {
      const res = await api.get(`/laporan/penjualan?start_date=${startDate}&end_date=${endDate}`)
      setData(res.data)
    } catch (e) {
      toast.error(getApiErrorMessage(e, 'Gagal memuat laporan penjualan'))
    } finally {
      setLoading(false)
    }
  }

  const buildReturnQuery = () => {
    const params = new URLSearchParams()
    Object.entries(returnFilters).forEach(([key, value]) => {
      if (value) params.append(key, value)
    })
    return params.toString()
  }

  const fetchReturnHistory = async () => {
    setReturnLoading(true)
    try {
      const res = await api.get(`/laporan/retur-pelanggan?${buildReturnQuery()}`)
      setReturnReport({
        retur: Array.isArray(res.data.retur) ? res.data.retur : [],
        total_retur: res.data.total_retur || 0,
        total_barang_retur: res.data.total_barang_retur || 0,
        filter_options: res.data.filter_options || { alasan: [] },
      })
    } catch (e) {
      toast.error(getApiErrorMessage(e, 'Gagal memuat riwayat retur pelanggan'))
    } finally {
      setReturnLoading(false)
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
    if (activeTab === 'retur') return printReturnReport()
    if (data.transaksi.length === 0) return toast.error('Tidak ada transaksi untuk dicetak')
    setReportPrintMode(true)
    window.setTimeout(() => {
      window.print()
      window.setTimeout(() => setReportPrintMode(false), 2000)
    }, 80)
  }

  const exportExcel = () => {
    if (activeTab === 'retur') return exportReturnExcel()
    if (filteredTransactions.length === 0) return toast.error('Tidak ada transaksi untuk diexport')

    const formatItems = (transaction) => transaction.details?.map(item => `${item.nama_barang} (${item.kode_barang}) - ${item.jumlah} x ${formatRupiah(item.harga_satuan)}`).join('; ') || '-'

    const rows = filteredTransactions.map(transaction => {
      const items = formatItems(transaction)
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
              <td><strong>${Number(filteredTotal)}</strong></td>
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

  const printReturnReport = () => {
    if (returnReport.retur.length === 0) return toast.error('Tidak ada retur pelanggan untuk dicetak')
    setReportPrintMode(true)
    window.setTimeout(() => {
      window.print()
      window.setTimeout(() => setReportPrintMode(false), 1600)
    }, 80)
  }

  const exportReturnExcel = () => {
    if (returnReport.retur.length === 0) return toast.error('Tidak ada retur pelanggan untuk diexport')

    const rows = returnReport.retur.map(item => `
      <tr>
        <td>${escapeExcel(item.nomor_retur)}</td>
        <td>${escapeExcel(new Date(item.tanggal_retur).toLocaleDateString('id-ID'))}</td>
        <td>${escapeExcel(item.kode_transaksi)}</td>
        <td>${escapeExcel(item.nama_barang)}</td>
        <td>${Number(item.jumlah_retur || 0)}</td>
        <td>${escapeExcel(item.alasan_retur)}</td>
        <td>${escapeExcel(formatReturnMethod(item.metode_pengembalian_dana))}</td>
        <td>${escapeExcel(item.keterangan || '-')}</td>
      </tr>
    `).join('')

    const html = `
      <html>
        <head><meta charset="UTF-8"></head>
        <body>
          <table border="1">
            <tr><th colspan="8">Laporan Riwayat Retur Pelanggan Sultan Cell</th></tr>
            <tr><td colspan="8">Periode: ${escapeExcel(returnFilters.start_date)} sampai ${escapeExcel(returnFilters.end_date)}</td></tr>
            <tr><td colspan="8">Dicetak: ${escapeExcel(formatDateTime(new Date()))}</td></tr>
            <tr>
              <th>Nomor Retur</th>
              <th>Tanggal Retur</th>
              <th>Nomor Transaksi</th>
              <th>Nama Barang</th>
              <th>Jumlah Retur</th>
              <th>Alasan Retur</th>
              <th>Metode Pengembalian Dana</th>
              <th>Keterangan</th>
            </tr>
            ${rows}
          </table>
        </body>
      </html>
    `

    const blob = new Blob(['\ufeff', html], { type: 'application/vnd.ms-excel;charset=utf-8;' })
    const url = URL.createObjectURL(blob)
    const link = document.createElement('a')
    link.href = url
    link.download = `riwayat-retur-pelanggan-${returnFilters.start_date}-${returnFilters.end_date}.xls`
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    URL.revokeObjectURL(url)
    toast.success('Excel retur pelanggan berhasil dibuat')
  }

  const resetReport = async () => {
    if (data.transaksi.length === 0) return toast.error('Tidak ada transaksi untuk direset')
    setShowResetConfirm(true)
  }

  const submitResetReport = async () => {
    setResetting(true)
    try {
      const res = await api.delete('/laporan/penjualan/reset', {
        data: { start_date: startDate, end_date: endDate }
      })
      toast.success(`${res.data.deleted || 0} transaksi berhasil direset`)
      setShowResetConfirm(false)
      fetchLaporan()
    } catch (e) {
      toast.error(getApiErrorMessage(e, 'Gagal reset laporan'))
    } finally {
      setResetting(false)
    }
  }

  const openCancelDialog = (transaction) => {
    if (transaction.status === 'batal') return toast.error('Transaksi sudah batal')
    setCancelTarget(transaction)
    setCancelReason('')
    setCancelError('')
  }

  const closeCancelDialog = () => {
    if (canceling) return
    setCancelTarget(null)
    setCancelReason('')
    setCancelError('')
  }

  const submitCancelTransaction = async (event) => {
    event.preventDefault()
    if (!cancelTarget) return
    if (!cancelReason.trim()) {
      setCancelError('Alasan pembatalan wajib diisi.')
      return
    }

    setCanceling(true)
    try {
      await api.post(`/penjualan/${cancelTarget.id}/cancel`, { alasan: cancelReason.trim() })
      toast.success('Transaksi dibatalkan dan stok dikembalikan')
      setCancelTarget(null)
      setCancelReason('')
      setCancelError('')
      fetchLaporan()
    } catch (e) {
      toast.error(getApiErrorMessage(e, 'Gagal membatalkan transaksi'))
    } finally {
      setCanceling(false)
    }
  }

  const returTransaction = (transaction) => {
    if (transaction.status === 'batal') return toast.error('Transaksi batal tidak bisa diretur')
    if (!transaction.details?.length) return toast.error('Detail barang tidak tersedia')
    setReturnTransaction(transaction)
  }

  const submitCustomerReturn = async (payload) => {
    if (!returnTransaction) return
    setSavingReturn(true)
    try {
      await api.post(`/penjualan/${returnTransaction.id}/retur`, payload)
      toast.success('Retur berhasil dicatat dan stok dikembalikan')
      setReturnTransaction(null)
      fetchLaporan()
      fetchReturnHistory()
    } catch (e) {
      toast.error(getApiErrorMessage(e, 'Gagal mencatat retur'))
    } finally {
      setSavingReturn(false)
    }
  }

  const printTransactionReceipt = () => {
    window.setTimeout(() => window.print(), 80)
  }

  const formatReturnMethod = (value) => value === 'qris' ? 'QRIS' : value === 'tunai' ? 'Tunai' : '-'

  const filteredTransactions = data.transaksi.filter(transaction => {
    const itemText = transaction.details?.map(item => `${item.nama_barang} ${item.kode_barang}`).join(' ') || ''
    const keyword = `${transaction.kode_transaksi} ${itemText}`.toLowerCase()
    const matchSearch = keyword.includes(search.toLowerCase())
    const matchPayment = paymentFilter === 'semua' || transaction.metode_pembayaran === paymentFilter
    const matchStatus = statusFilter === 'semua' || transaction.status === statusFilter
    return matchSearch && matchPayment && matchStatus
  })
  const tunaiCount = filteredTransactions.filter(t => t.metode_pembayaran === 'tunai').length
  const qrisCount = filteredTransactions.filter(t => t.metode_pembayaran === 'qris').length
  const activeTransactions = filteredTransactions.filter(t => t.status === 'lunas')
  const filteredTotal = activeTransactions.reduce((sum, t) => sum + Number(t.total_harga || 0), 0)
  const averageSale = activeTransactions.length ? filteredTotal / activeTransactions.length : 0
  const getStatusClass = (status) => status === 'lunas' ? 'paid' : status === 'batal' ? 'cancelled' : 'pending'
  const getTransactionItems = (transaction) => transaction.details?.length
    ? transaction.details.map(item => `${item.nama_barang} (${item.jumlah}x)`).join(', ')
    : '-'

  return (
    <div className="report-page">
      <div className="report-print-area">
      <div className="page-heading report-heading">
        <div>
          <span>Laporan Kasir</span>
          <h1>Laporan Penjualan</h1>
          <p>Pantau transaksi penjualan dan riwayat retur pelanggan dalam satu halaman laporan.</p>
        </div>
        <div className="report-heading-actions">
          <div className="report-date-range">
            <CalendarDays size={18} />
            <span>{activeTab === 'retur' ? `${returnFilters.start_date} sampai ${returnFilters.end_date}` : `${startDate} sampai ${endDate}`}</span>
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
            {activeTab === 'transaksi' && (
              <button type="button" onClick={resetReport} disabled={resetting || loading} className="report-action-button reset">
                <RotateCcw size={17} />
                <span>{resetting ? 'Reset...' : 'Reset'}</span>
              </button>
            )}
          </div>
        </div>
      </div>

      <div className="report-tab-bar no-print">
        <button type="button" className={activeTab === 'transaksi' ? 'active' : ''} onClick={() => setActiveTab('transaksi')}>
          <ReceiptText size={17} />
          <span>Data Transaksi Penjualan</span>
        </button>
        <button type="button" className={activeTab === 'retur' ? 'active' : ''} onClick={() => setActiveTab('retur')}>
          <RotateCcw size={17} />
          <span>Riwayat Retur Pelanggan</span>
        </button>
      </div>

      {activeTab === 'transaksi' && (
      <>
      <section className="report-filter-panel">
        <label className="field-group">
          <span>Tanggal Mulai</span>
          <input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} />
        </label>
        <label className="field-group">
          <span>Tanggal Akhir</span>
          <input type="date" value={endDate} onChange={e => setEndDate(e.target.value)} />
        </label>
        <label className="field-group">
          <span>Cari Transaksi / Barang</span>
          <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Kode transaksi atau nama barang" />
        </label>
        <label className="field-group">
          <span>Metode Pembayaran</span>
          <select value={paymentFilter} onChange={e => setPaymentFilter(e.target.value)}><option value="semua">Semua</option><option value="tunai">Tunai</option><option value="qris">QRIS</option></select>
        </label>
        <label className="field-group">
          <span>Status</span>
          <select value={statusFilter} onChange={e => setStatusFilter(e.target.value)}><option value="semua">Semua</option><option value="lunas">Lunas</option><option value="pending">Pending</option><option value="batal">Batal</option></select>
        </label>
        <div className="field-group">
          <span>&nbsp;</span>
          <button type="button" className="report-action-button print"><Search size={17} />Filter Aktif</button>
        </div>
      </section>

      <div className="report-summary-grid">
        <div className="report-card primary">
          <div><TrendingUp size={24} /></div>
          <span>Total Penjualan</span>
          <strong>{formatRupiah(filteredTotal)}</strong>
        </div>
        <div className="report-card">
          <div><ReceiptText size={24} /></div>
          <span>Jumlah Transaksi</span>
          <strong>{filteredTransactions.length}</strong>
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
            <p>{loading ? 'Memuat data...' : `${filteredTransactions.length} transaksi ditemukan`}</p>
          </div>
        </div>

        <div className="report-table-wrap">
          <table className="report-table">
            <thead>
              <tr>
                <th>Kode</th>
                <th>Nama Barang</th>
                <th>Tanggal</th>
                <th>Pembayaran</th>
                <th>Status</th>
                <th>Total</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              {filteredTransactions.map(transaction => (
                <tr key={transaction.id}>
                  <td><span className="item-code">{transaction.kode_transaksi}</span></td>
                  <td>
                    <div className="report-item-list">
                      <strong>{getTransactionItems(transaction)}</strong>
                      <span>{transaction.details?.length || 0} item terjual</span>
                    </div>
                  </td>
                  <td>{new Date(transaction.tanggal).toLocaleDateString('id-ID')}</td>
                  <td><span className={`payment-pill ${transaction.metode_pembayaran}`}>{transaction.metode_pembayaran}</span></td>
                  <td><span className={`status-pill ${getStatusClass(transaction.status)}`}>{transaction.status}</span></td>
                  <td className="money-cell strong">{formatRupiah(transaction.total_harga)}</td>
                  <td>
                    <div className="table-actions">
                      <button type="button" className="table-action-button" onClick={() => setSelectedTransaction(transaction)}><Eye size={15} />Detail</button>
                      <button type="button" className="table-action-button" onClick={() => returTransaction(transaction)} disabled={transaction.status === 'batal'}><RotateCcw size={15} />Retur</button>
                      <button type="button" className="table-action-button danger" onClick={() => openCancelDialog(transaction)} disabled={transaction.status === 'batal'}><XCircle size={15} />Batal</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {!loading && filteredTransactions.length === 0 && (
            <div className="report-empty">
              <FileText size={42} />
              <p>Tidak ada data penjualan</p>
              <span>Coba ubah periode tanggal atau buat transaksi baru.</span>
            </div>
          )}
        </div>
      </section>
      </>
      )}

      {activeTab === 'retur' && (
      <>
      <div className="print-report-header">
        <img src={sultanCellLogo} alt="Logo Sultan Cell" />
        <div>
          <span>Sultan Cell</span>
          <h2>Laporan Riwayat Retur Pelanggan</h2>
          <p>Periode {returnFilters.start_date} sampai {returnFilters.end_date}</p>
        </div>
      </div>

      <section className="report-filter-panel return-history-filter-panel no-print">
        <label className="field-group">
          <span>Tanggal Mulai</span>
          <input type="date" value={returnFilters.start_date} onChange={e => setReturnFilters({ ...returnFilters, start_date: e.target.value })} />
        </label>
        <label className="field-group">
          <span>Tanggal Akhir</span>
          <input type="date" value={returnFilters.end_date} onChange={e => setReturnFilters({ ...returnFilters, end_date: e.target.value })} />
        </label>
        <label className="field-group">
          <span>Alasan Retur</span>
          <select value={returnFilters.alasan} onChange={e => setReturnFilters({ ...returnFilters, alasan: e.target.value })}>
            <option value="semua">Semua</option>
            {returnReport.filter_options.alasan?.map(option => <option key={option} value={option}>{option}</option>)}
          </select>
        </label>
        <label className="field-group">
          <span>Metode Dana</span>
          <select value={returnFilters.metode} onChange={e => setReturnFilters({ ...returnFilters, metode: e.target.value })}>
            <option value="semua">Semua</option>
            <option value="tunai">Tunai</option>
            <option value="qris">QRIS</option>
          </select>
        </label>
        <label className="field-group">
          <span>Pencarian</span>
          <input value={returnFilters.search} onChange={e => setReturnFilters({ ...returnFilters, search: e.target.value })} onKeyDown={e => e.key === 'Enter' && fetchReturnHistory()} placeholder="Nomor retur, transaksi, barang" />
        </label>
        <button type="button" onClick={fetchReturnHistory} className="filter-search-button"><Search size={17} />Cari</button>
      </section>

      <div className="brilink-summary-grid return-history-summary-grid">
        <div className="brilink-summary-card"><div className="summary-icon blue"><RotateCcw size={22} /></div><span>Total Retur</span><strong>{returnReport.total_retur}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><FileText size={22} /></div><span>Total Barang Retur</span><strong>{returnReport.total_barang_retur} pcs</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><WalletCards size={22} /></div><span>Pengembalian Tunai</span><strong>{returnReport.retur.filter(item => item.metode_pengembalian_dana === 'tunai').length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon purple"><WalletCards size={22} /></div><span>Pengembalian QRIS</span><strong>{returnReport.retur.filter(item => item.metode_pengembalian_dana === 'qris').length}</strong></div>
      </div>

      <section className="report-table-panel">
        <div className="report-table-header">
          <div>
            <h2>Riwayat Retur Pelanggan</h2>
            <p>{returnLoading ? 'Memuat data...' : `${returnReport.retur.length} retur pelanggan ditemukan`}</p>
          </div>
        </div>

        <div className="report-table-wrap">
          <table className="report-table return-history-table">
            <thead>
              <tr>
                <th>Nomor Retur</th>
                <th>Tanggal Retur</th>
                <th>Nomor Transaksi</th>
                <th>Nama Barang</th>
                <th>Jumlah Retur</th>
                <th>Alasan Retur</th>
                <th>Metode Pengembalian Dana</th>
                <th>Keterangan</th>
              </tr>
            </thead>
            <tbody>
              {returnReport.retur.map(item => (
                <tr key={item.id}>
                  <td><span className="item-code">{item.nomor_retur}</span></td>
                  <td>{new Date(item.tanggal_retur).toLocaleDateString('id-ID')}</td>
                  <td>{item.kode_transaksi}</td>
                  <td>
                    <div className="report-item-list">
                      <strong>{item.nama_barang}</strong>
                      <span>{item.kode_barang}</span>
                    </div>
                  </td>
                  <td>{item.jumlah_retur} pcs</td>
                  <td>{item.alasan_retur}</td>
                  <td><span className={`payment-pill ${item.metode_pengembalian_dana}`}>{formatReturnMethod(item.metode_pengembalian_dana)}</span></td>
                  <td>{item.keterangan || '-'}</td>
                </tr>
              ))}
            </tbody>
          </table>

          {!returnLoading && returnReport.retur.length === 0 && (
            <div className="report-empty">
              <RotateCcw size={42} />
              <p>Tidak ada retur pelanggan</p>
              <span>Coba ubah filter tanggal, alasan, metode dana, atau pencarian.</span>
            </div>
          )}
        </div>
      </section>
      </>
      )}
      </div>

      <Modal isOpen={Boolean(selectedTransaction)} onClose={() => setSelectedTransaction(null)} title="Detail Transaksi" size="sm">
        {selectedTransaction && (
          <div className="receipt-preview">
            <div className="receipt-print-area">
              <div className="receipt-store">
                <strong>SULTAN CELL</strong>
                <span>Konter HP & Agen BRILink</span>
                <span>Struk Transaksi Penjualan</span>
              </div>
              <div className="receipt-divider"></div>
              <div className="receipt-meta">
                <div><span>No</span><strong>{selectedTransaction.kode_transaksi}</strong></div>
                <div><span>Waktu</span><strong>{formatDateTime(selectedTransaction.created_at || selectedTransaction.tanggal)}</strong></div>
                <div><span>Kasir</span><strong>{selectedTransaction.kasir || 'Admin'}</strong></div>
                <div><span>Status</span><strong>{selectedTransaction.status}</strong></div>
                <div><span>Bayar</span><strong>{selectedTransaction.metode_pembayaran?.toUpperCase()}</strong></div>
              </div>
              <div className="receipt-divider"></div>
              <div className="receipt-items">
                {selectedTransaction.details?.map(item => (
                  <div key={item.id} className="receipt-item">
                    <div>
                      <strong>{item.nama_barang}</strong>
                      <span>{item.kode_barang}</span>
                    </div>
                    <p>{item.jumlah} x {formatRupiah(item.harga_satuan)}</p>
                    <b>{formatRupiah(item.subtotal)}</b>
                  </div>
                ))}
              </div>
              <div className="receipt-divider"></div>
              <div className="receipt-total-row"><span>Total</span><strong>{formatRupiah(selectedTransaction.total_harga)}</strong></div>
              <div className="receipt-total-row"><span>Bayar</span><strong>{formatRupiah(selectedTransaction.uang_bayar || selectedTransaction.total_harga)}</strong></div>
              <div className="receipt-total-row"><span>Kembali</span><strong>{formatRupiah(selectedTransaction.kembalian || 0)}</strong></div>
              {selectedTransaction.alasan_batal && <div className="receipt-note">Batal: {selectedTransaction.alasan_batal}</div>}
              <div className="receipt-footer">
                <p>Terima kasih sudah berbelanja</p>
                <span>Barang yang sudah dibeli harap dicek kembali.</span>
              </div>
            </div>
            <div className="receipt-actions no-print">
              <button type="button" className="secondary-button" onClick={() => setSelectedTransaction(null)}>Tutup</button>
              <button type="button" className="print-receipt-button" onClick={printTransactionReceipt}>
                <Printer size={18} />
                <span>Cetak Struk</span>
              </button>
            </div>
          </div>
        )}
      </Modal>

      <CustomerReturnModal
        open={Boolean(returnTransaction)}
        transaction={returnTransaction}
        loading={savingReturn}
        onClose={() => !savingReturn && setReturnTransaction(null)}
        onSubmit={submitCustomerReturn}
      />

      <Modal isOpen={Boolean(cancelTarget)} onClose={closeCancelDialog} title="Batalkan Transaksi" size="md">
        {cancelTarget && (
          <form className="cancel-transaction-form" onSubmit={submitCancelTransaction}>
            <div className="form-alert warning">
              Stok barang dari transaksi {cancelTarget.kode_transaksi} akan dikembalikan otomatis setelah pembatalan disimpan.
            </div>
            <label className="field-group">
              <span>Alasan Pembatalan</span>
              <Textarea
                rows={4}
                value={cancelReason}
                onChange={event => {
                  setCancelReason(event.target.value)
                  setCancelError('')
                }}
                placeholder="Contoh: pelanggan membatalkan pembelian"
              />
              {cancelError && <small className="field-error">{cancelError}</small>}
            </label>
            <div className="modal-form-actions">
              <Button type="button" variant="secondary" onClick={closeCancelDialog} disabled={canceling}>Batal</Button>
              <Button type="submit" className="danger" disabled={canceling}>{canceling ? 'Memproses...' : 'Batalkan Transaksi'}</Button>
            </div>
          </form>
        )}
      </Modal>

      <Modal isOpen={showResetConfirm} onClose={() => !resetting && setShowResetConfirm(false)} title="Reset Laporan Penjualan" size="sm">
        <div className="confirm-action-content">
          <div className="form-alert warning">
            Reset {data.transaksi.length} transaksi penjualan dari {startDate} sampai {endDate}? Data transaksi dan detail barang akan dihapus dari laporan.
          </div>
          <div className="modal-form-actions">
            <Button type="button" variant="secondary" onClick={() => setShowResetConfirm(false)} disabled={resetting}>Batal</Button>
            <Button type="button" className="danger" onClick={submitResetReport} disabled={resetting}>{resetting ? 'Memproses...' : 'Reset Laporan'}</Button>
          </div>
        </div>
      </Modal>
    </div>
  )
}
