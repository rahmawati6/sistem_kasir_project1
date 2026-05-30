import React, { useState, useEffect } from 'react'
import { History, Filter, ReceiptText, WalletCards } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'

const toInputDate = (date) => {
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

export default function RiwayatBrilink() {
  const [data, setData] = useState({ data: [], total_admin: 0, total_transaksi: 0 })
  const [startDate, setStartDate] = useState(toInputDate(new Date(new Date().getFullYear(), new Date().getMonth(), 1)))
  const [endDate, setEndDate] = useState(toInputDate(new Date()))
  const [jenis, setJenis] = useState('semua')

  useEffect(() => { fetchData() }, [startDate, endDate, jenis])
  const fetchData = async () => {
    try {
      const res = await api.get(`/riwayat-brilink?start_date=${startDate}&end_date=${endDate}&jenis=${jenis}`)
      setData(res.data)
    } catch (e) {}
  }

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div><span>Monitoring BRILink</span><h1>Riwayat BRILink</h1><p>Gabungan transaksi transfer, tarik tunai, setor tunai, tagihan, pulsa, dan tabungan.</p></div>
        <div className="report-date-range"><History size={18} /><span>{startDate} sampai {endDate}</span></div>
      </div>

      <section className="brilink-filter-panel">
        <label className="field-group"><span>Tanggal Mulai</span><input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} /></label>
        <label className="field-group"><span>Tanggal Akhir</span><input type="date" value={endDate} onChange={e => setEndDate(e.target.value)} /></label>
        <label className="field-group"><span>Jenis Layanan</span><select value={jenis} onChange={e => setJenis(e.target.value)}><option value="semua">Semua</option><option value="transfer">Transfer</option><option value="tarik_tunai">Tarik Tunai</option><option value="setor_tunai">Setor Tunai</option><option value="tagihan">Tagihan</option><option value="pulsa">Pulsa</option></select></label>
      </section>

      <div className="brilink-summary-grid two">
        <div className="brilink-summary-card"><div className="summary-icon blue"><ReceiptText size={22} /></div><span>Total Transaksi</span><strong>{data.total_transaksi}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><WalletCards size={22} /></div><span>Total Keuntungan Admin</span><strong>{formatRupiah(data.total_admin)}</strong></div>
      </div>

      <section className="brilink-table-panel">
        <div className="brilink-table-header"><div><h2>Semua Riwayat</h2><p>{data.data.length} data ditampilkan</p></div><Filter size={20} /></div>
        <div className="brilink-table-wrap">
          <table className="brilink-table">
            <thead><tr><th>Kode</th><th>Tanggal</th><th>Jenis</th><th>Admin Fee</th><th>Status</th></tr></thead>
            <tbody>{data.data.map((t, index) => (
              <tr key={index}>
                <td><span className="item-code">{t.kode_transaksi || t.kode_tabungan}</span></td>
                <td>{new Date(t.tanggal).toLocaleDateString('id-ID')}</td>
                <td><span className="service-pill blue">{t.jenis}</span></td>
                <td className="money-cell admin">{formatRupiah(t.biaya_admin)}</td>
                <td><span className={`status-pill ${t.status === 'sukses' ? 'paid' : 'pending'}`}>{t.status}</span></td>
              </tr>
            ))}</tbody>
          </table>
          {data.data.length === 0 && <div className="brilink-empty"><History size={42} /><p>Tidak ada data</p><span>Coba ubah periode atau jenis layanan.</span></div>}
        </div>
      </section>
    </div>
  )
}
