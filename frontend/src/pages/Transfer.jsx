import React, { useState, useEffect } from 'react'
import { Send, Plus, Landmark, WalletCards } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const emptyForm = { jenis_transfer: 'Sesama BRI', nomor_rekening_tujuan: '', nama_penerima: '', nominal_transfer: '', keterangan: '' }

export default function Transfer() {
  const [data, setData] = useState([])
  const [showForm, setShowForm] = useState(false)
  const [loading, setLoading] = useState(false)
  const [form, setForm] = useState(emptyForm)

  useEffect(() => { fetchData() }, [])
  const fetchData = async () => { try { const res = await api.get('/transfer'); setData(res.data) } catch (e) {} }

  const handleSubmit = async (e) => {
    e.preventDefault(); setLoading(true)
    try {
      await api.post('/transfer', { ...form, nominal_transfer: parseFloat(form.nominal_transfer) })
      toast.success('Transfer berhasil dicatat!')
      fetchData(); setShowForm(false); setForm(emptyForm)
    } catch (e) { toast.error(e.response?.data?.message || 'Gagal') } finally { setLoading(false) }
  }

  const totalNominal = data.reduce((sum, item) => sum + Number(item.nominal_transfer || 0), 0)
  const totalAdmin = data.reduce((sum, item) => sum + Number(item.biaya_admin || 0), 0)

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div>
          <span>Layanan BRILink</span>
          <h1>Transfer</h1>
          <p>Catat transaksi transfer sesama BRI, antar bank, dan e-wallet.</p>
        </div>
        <button onClick={() => setShowForm(!showForm)} className="brilink-primary-button"><Plus size={19} /> Transaksi Baru</button>
      </div>

      <div className="brilink-summary-grid">
        <div className="brilink-summary-card"><div className="summary-icon blue"><Send size={22} /></div><span>Total Transaksi</span><strong>{data.length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><WalletCards size={22} /></div><span>Nominal Transfer</span><strong>{formatRupiah(totalNominal)}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><Landmark size={22} /></div><span>Admin Fee</span><strong>{formatRupiah(totalAdmin)}</strong></div>
      </div>

      {showForm && (
        <section className="brilink-form-card">
          <div className="brilink-section-title"><Send size={20} /><div><h2>Form Transfer</h2><p>Masukkan detail penerima dan nominal transfer.</p></div></div>
          <form onSubmit={handleSubmit} className="brilink-form-grid">
            <label className="field-group"><span>Jenis Transfer</span><select value={form.jenis_transfer} onChange={e => setForm({ ...form, jenis_transfer: e.target.value })}><option>Sesama BRI</option><option>Antar Bank</option><option>E-Wallet</option></select></label>
            <label className="field-group"><span>No. Rekening Tujuan</span><input type="text" value={form.nomor_rekening_tujuan} onChange={e => setForm({ ...form, nomor_rekening_tujuan: e.target.value })} required /></label>
            <label className="field-group"><span>Nama Penerima</span><input type="text" value={form.nama_penerima} onChange={e => setForm({ ...form, nama_penerima: e.target.value })} required /></label>
            <label className="field-group"><span>Nominal Transfer</span><input type="number" value={form.nominal_transfer} onChange={e => setForm({ ...form, nominal_transfer: e.target.value })} required /></label>
            <label className="field-group full"><span>Keterangan</span><input type="text" value={form.keterangan} onChange={e => setForm({ ...form, keterangan: e.target.value })} /></label>
            <div className="form-actions full"><button type="button" onClick={() => setShowForm(false)} className="secondary-button">Batal</button><button type="submit" disabled={loading} className="primary-action-button">{loading ? 'Memproses...' : 'Simpan Transfer'}</button></div>
          </form>
        </section>
      )}

      <section className="brilink-table-panel">
        <div className="brilink-table-header"><div><h2>Riwayat Transfer</h2><p>{data.length} transaksi tercatat</p></div></div>
        <div className="brilink-table-wrap">
          <table className="brilink-table">
            <thead><tr><th>Kode</th><th>Tanggal</th><th>Jenis</th><th>Penerima</th><th>Nominal</th><th>Admin</th><th>Total</th><th>Status</th></tr></thead>
            <tbody>{data.map(t => (
              <tr key={t.id}>
                <td><span className="item-code">{t.kode_transaksi}</span></td>
                <td>{new Date(t.tanggal).toLocaleDateString('id-ID')}</td>
                <td><span className="service-pill blue">{t.jenis_transfer}</span></td>
                <td><div className="person-cell"><strong>{t.nama_penerima}</strong><span>{t.nomor_rekening_tujuan}</span></div></td>
                <td className="money-cell">{formatRupiah(t.nominal_transfer)}</td>
                <td className="money-cell admin">{formatRupiah(t.biaya_admin)}</td>
                <td className="money-cell strong">{formatRupiah(t.total_bayar)}</td>
                <td><span className={`status-pill ${t.status === 'sukses' ? 'paid' : 'pending'}`}>{t.status}</span></td>
              </tr>
            ))}</tbody>
          </table>
          {data.length === 0 && <div className="brilink-empty"><Send size={42} /><p>Belum ada transaksi transfer</p><span>Transaksi baru akan muncul di sini.</span></div>}
        </div>
      </section>
    </div>
  )
}
