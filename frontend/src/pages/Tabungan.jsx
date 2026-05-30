import React, { useState, useEffect } from 'react'
import { PiggyBank, Plus, Users, TrendingUp } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const emptyForm = { nama_customer: '', nomor_hp: '', nominal: '', keterangan: '' }

export default function Tabungan() {
  const [data, setData] = useState([])
  const [showForm, setShowForm] = useState(false)
  const [loading, setLoading] = useState(false)
  const [form, setForm] = useState(emptyForm)

  useEffect(() => { fetchData() }, [])
  const fetchData = async () => { try { const res = await api.get('/tabungan'); setData(res.data) } catch (e) {} }

  const handleSubmit = async (e) => {
    e.preventDefault(); setLoading(true)
    try {
      await api.post('/tabungan', { ...form, nominal: parseFloat(form.nominal) })
      toast.success('Tabungan berhasil dicatat!')
      fetchData(); setShowForm(false); setForm(emptyForm)
    } catch (e) { toast.error(e.response?.data?.message || 'Gagal') } finally { setLoading(false) }
  }

  const totalNominal = data.reduce((sum, item) => sum + Number(item.nominal || 0), 0)
  const customers = new Set(data.map(item => item.nomor_hp).filter(Boolean)).size

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div><span>Layanan Pelanggan</span><h1>Tabungan Customer</h1><p>Catat setoran tabungan pelanggan dan pantau saldo setelah transaksi.</p></div>
        <button onClick={() => setShowForm(!showForm)} className="brilink-primary-button"><Plus size={19} /> Setoran Baru</button>
      </div>
      <div className="brilink-summary-grid">
        <div className="brilink-summary-card"><div className="summary-icon blue"><PiggyBank size={22} /></div><span>Total Setoran</span><strong>{data.length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><TrendingUp size={22} /></div><span>Nominal Masuk</span><strong>{formatRupiah(totalNominal)}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><Users size={22} /></div><span>Customer</span><strong>{customers}</strong></div>
      </div>

      {showForm && (
        <section className="brilink-form-card">
          <div className="brilink-section-title"><PiggyBank size={20} /><div><h2>Form Tabungan</h2><p>Tambah setoran tabungan pelanggan.</p></div></div>
          <form onSubmit={handleSubmit} className="brilink-form-grid">
            <label className="field-group"><span>Nama Customer</span><input type="text" value={form.nama_customer} onChange={e => setForm({ ...form, nama_customer: e.target.value })} required /></label>
            <label className="field-group"><span>No. HP</span><input type="text" value={form.nomor_hp} onChange={e => setForm({ ...form, nomor_hp: e.target.value })} required /></label>
            <label className="field-group"><span>Nominal</span><input type="number" value={form.nominal} onChange={e => setForm({ ...form, nominal: e.target.value })} required /></label>
            <label className="field-group"><span>Keterangan</span><input type="text" value={form.keterangan} onChange={e => setForm({ ...form, keterangan: e.target.value })} /></label>
            <div className="form-actions full"><button type="button" onClick={() => setShowForm(false)} className="secondary-button">Batal</button><button type="submit" disabled={loading} className="primary-action-button">{loading ? 'Memproses...' : 'Simpan Setoran'}</button></div>
          </form>
        </section>
      )}

      <section className="brilink-table-panel">
        <div className="brilink-table-header"><div><h2>Riwayat Tabungan</h2><p>{data.length} setoran tercatat</p></div></div>
        <div className="brilink-table-wrap">
          <table className="brilink-table">
            <thead><tr><th>Kode</th><th>Tanggal</th><th>Customer</th><th>Nominal</th><th>Saldo Sebelum</th><th>Saldo Sesudah</th><th>Status</th></tr></thead>
            <tbody>{data.map(t => (
              <tr key={t.id}>
                <td><span className="item-code">{t.kode_tabungan}</span></td><td>{new Date(t.tanggal).toLocaleDateString('id-ID')}</td>
                <td><div className="person-cell"><strong>{t.nama_customer}</strong><span>{t.nomor_hp}</span></div></td>
                <td className="money-cell plus">+{formatRupiah(t.nominal)}</td><td className="money-cell">{formatRupiah(t.saldo_sebelum)}</td><td className="money-cell strong">{formatRupiah(t.saldo_sesudah)}</td>
                <td><span className={`status-pill ${t.status === 'sukses' ? 'paid' : 'pending'}`}>{t.status}</span></td>
              </tr>
            ))}</tbody>
          </table>
          {data.length === 0 && <div className="brilink-empty"><PiggyBank size={42} /><p>Belum ada data tabungan</p><span>Setoran baru akan muncul di sini.</span></div>}
        </div>
      </section>
    </div>
  )
}
