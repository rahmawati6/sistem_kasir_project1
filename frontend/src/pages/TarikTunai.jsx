import React, { useState, useEffect } from 'react'
import { Wallet, Plus, Banknote, ReceiptText } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const emptyForm = { nomor_rekening: '', nama_penerima: '', nomor_hp: '', nominal_tarik: '' }

export default function TarikTunai() {
  const [data, setData] = useState([])
  const [showForm, setShowForm] = useState(false)
  const [loading, setLoading] = useState(false)
  const [form, setForm] = useState(emptyForm)

  useEffect(() => { fetchData() }, [])
  const fetchData = async () => { try { const res = await api.get('/tarik-tunai'); setData(res.data) } catch (e) {} }

  const handleSubmit = async (e) => {
    e.preventDefault(); setLoading(true)
    try {
      await api.post('/tarik-tunai', { ...form, nominal_tarik: parseFloat(form.nominal_tarik) })
      toast.success('Tarik tunai berhasil!')
      fetchData(); setShowForm(false); setForm(emptyForm)
    } catch (e) { toast.error(e.response?.data?.message || 'Gagal') } finally { setLoading(false) }
  }

  const totalNominal = data.reduce((sum, item) => sum + Number(item.nominal_tarik || 0), 0)
  const totalAdmin = data.reduce((sum, item) => sum + Number(item.biaya_admin || 0), 0)

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div><span>Layanan BRILink</span><h1>Tarik Tunai</h1><p>Catat tarik tunai pelanggan lengkap dengan nomor rekening dan biaya admin.</p></div>
        <button onClick={() => setShowForm(!showForm)} className="brilink-primary-button"><Plus size={19} /> Transaksi Baru</button>
      </div>
      <div className="brilink-summary-grid">
        <div className="brilink-summary-card"><div className="summary-icon blue"><Wallet size={22} /></div><span>Total Transaksi</span><strong>{data.length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><Banknote size={22} /></div><span>Nominal Tarik</span><strong>{formatRupiah(totalNominal)}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><ReceiptText size={22} /></div><span>Admin Fee</span><strong>{formatRupiah(totalAdmin)}</strong></div>
      </div>

      {showForm && (
        <section className="brilink-form-card">
          <div className="brilink-section-title"><Wallet size={20} /><div><h2>Form Tarik Tunai</h2><p>Isi data penerima dan nominal penarikan.</p></div></div>
          <form onSubmit={handleSubmit} className="brilink-form-grid">
            <label className="field-group"><span>No. Rekening</span><input type="text" value={form.nomor_rekening} onChange={e => setForm({ ...form, nomor_rekening: e.target.value })} required /></label>
            <label className="field-group"><span>Nama Penerima</span><input type="text" value={form.nama_penerima} onChange={e => setForm({ ...form, nama_penerima: e.target.value })} required /></label>
            <label className="field-group"><span>No. HP</span><input type="text" value={form.nomor_hp} onChange={e => setForm({ ...form, nomor_hp: e.target.value })} required /></label>
            <label className="field-group"><span>Nominal Tarik</span><input type="number" value={form.nominal_tarik} onChange={e => setForm({ ...form, nominal_tarik: e.target.value })} required /></label>
            <div className="form-actions full"><button type="button" onClick={() => setShowForm(false)} className="secondary-button">Batal</button><button type="submit" disabled={loading} className="primary-action-button">{loading ? 'Memproses...' : 'Simpan Tarik Tunai'}</button></div>
          </form>
        </section>
      )}

      <section className="brilink-table-panel">
        <div className="brilink-table-header"><div><h2>Riwayat Tarik Tunai</h2><p>{data.length} transaksi tercatat</p></div></div>
        <div className="brilink-table-wrap">
          <table className="brilink-table">
            <thead><tr><th>Kode</th><th>Tanggal</th><th>Penerima</th><th>Nominal</th><th>Admin</th><th>Total</th><th>Status</th></tr></thead>
            <tbody>{data.map(t => (
              <tr key={t.id}>
                <td><span className="item-code">{t.kode_transaksi}</span></td><td>{new Date(t.tanggal).toLocaleDateString('id-ID')}</td>
                <td><div className="person-cell"><strong>{t.nama_penerima}</strong><span>{t.nomor_rekening}</span></div></td>
                <td className="money-cell">{formatRupiah(t.nominal_tarik)}</td><td className="money-cell admin">{formatRupiah(t.biaya_admin)}</td><td className="money-cell strong">{formatRupiah(t.total_bayar)}</td>
                <td><span className={`status-pill ${t.status === 'sukses' ? 'paid' : 'pending'}`}>{t.status}</span></td>
              </tr>
            ))}</tbody>
          </table>
          {data.length === 0 && <div className="brilink-empty"><Wallet size={42} /><p>Belum ada data tarik tunai</p><span>Transaksi baru akan muncul di sini.</span></div>}
        </div>
      </section>
    </div>
  )
}
