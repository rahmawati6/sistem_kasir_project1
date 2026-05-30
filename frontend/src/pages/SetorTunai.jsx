import React, { useState, useEffect } from 'react'
import { HandCoins, Plus, Landmark, ReceiptText } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const emptyForm = { jenis_setoran: 'biasa', nomor_rekening_tujuan: '', nama_pemilik_rekening: '', bank_tujuan: '', nominal_setor: '', sumber_dana: '', keterangan: '' }

export default function SetorTunai() {
  const [data, setData] = useState([])
  const [showForm, setShowForm] = useState(false)
  const [loading, setLoading] = useState(false)
  const [form, setForm] = useState(emptyForm)

  useEffect(() => { fetchData() }, [])
  const fetchData = async () => { try { const res = await api.get('/setor-tunai'); setData(res.data) } catch (e) {} }

  const handleSubmit = async (e) => {
    e.preventDefault(); setLoading(true)
    try {
      await api.post('/setor-tunai', { ...form, nominal_setor: parseFloat(form.nominal_setor) })
      toast.success('Setor tunai berhasil!')
      fetchData(); setShowForm(false); setForm(emptyForm)
    } catch (e) { toast.error(e.response?.data?.message || 'Gagal') } finally { setLoading(false) }
  }

  const totalNominal = data.reduce((sum, item) => sum + Number(item.nominal_setor || 0), 0)
  const totalAdmin = data.reduce((sum, item) => sum + Number(item.biaya_admin || 0), 0)

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div><span>Layanan BRILink</span><h1>Setor Tunai</h1><p>Catat setoran tunai ke rekening tujuan, bank, dan sumber dana pelanggan.</p></div>
        <button onClick={() => setShowForm(!showForm)} className="brilink-primary-button"><Plus size={19} /> Transaksi Baru</button>
      </div>
      <div className="brilink-summary-grid">
        <div className="brilink-summary-card"><div className="summary-icon blue"><HandCoins size={22} /></div><span>Total Setoran</span><strong>{data.length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><Landmark size={22} /></div><span>Nominal Setor</span><strong>{formatRupiah(totalNominal)}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><ReceiptText size={22} /></div><span>Admin Fee</span><strong>{formatRupiah(totalAdmin)}</strong></div>
      </div>

      {showForm && (
        <section className="brilink-form-card">
          <div className="brilink-section-title"><HandCoins size={20} /><div><h2>Form Setor Tunai</h2><p>Lengkapi tujuan rekening dan nominal setoran.</p></div></div>
          <form onSubmit={handleSubmit} className="brilink-form-grid">
            <label className="field-group"><span>Jenis Setoran</span><select value={form.jenis_setoran} onChange={e => setForm({ ...form, jenis_setoran: e.target.value })}><option value="biasa">Biasa</option><option value="tabungan">Tabungan</option></select></label>
            <label className="field-group"><span>No. Rekening Tujuan</span><input type="text" value={form.nomor_rekening_tujuan} onChange={e => setForm({ ...form, nomor_rekening_tujuan: e.target.value })} /></label>
            <label className="field-group"><span>Nama Pemilik Rekening</span><input type="text" value={form.nama_pemilik_rekening} onChange={e => setForm({ ...form, nama_pemilik_rekening: e.target.value })} /></label>
            <label className="field-group"><span>Bank Tujuan</span><input type="text" value={form.bank_tujuan} onChange={e => setForm({ ...form, bank_tujuan: e.target.value })} /></label>
            <label className="field-group"><span>Nominal Setor</span><input type="number" value={form.nominal_setor} onChange={e => setForm({ ...form, nominal_setor: e.target.value })} required /></label>
            <label className="field-group"><span>Sumber Dana</span><input type="text" value={form.sumber_dana} onChange={e => setForm({ ...form, sumber_dana: e.target.value })} /></label>
            <label className="field-group full"><span>Keterangan</span><input type="text" value={form.keterangan} onChange={e => setForm({ ...form, keterangan: e.target.value })} /></label>
            <div className="form-actions full"><button type="button" onClick={() => setShowForm(false)} className="secondary-button">Batal</button><button type="submit" disabled={loading} className="primary-action-button">{loading ? 'Memproses...' : 'Simpan Setoran'}</button></div>
          </form>
        </section>
      )}

      <section className="brilink-table-panel">
        <div className="brilink-table-header"><div><h2>Riwayat Setor Tunai</h2><p>{data.length} transaksi tercatat</p></div></div>
        <div className="brilink-table-wrap">
          <table className="brilink-table">
            <thead><tr><th>Kode</th><th>Tanggal</th><th>Jenis</th><th>Pemilik Rekening</th><th>Nominal</th><th>Total</th><th>Status</th></tr></thead>
            <tbody>{data.map(t => (
              <tr key={t.id}>
                <td><span className="item-code">{t.kode_transaksi}</span></td><td>{new Date(t.tanggal).toLocaleDateString('id-ID')}</td><td><span className="service-pill green">{t.jenis_setoran}</span></td>
                <td><div className="person-cell"><strong>{t.nama_pemilik_rekening || '-'}</strong><span>{t.nomor_rekening_tujuan || t.bank_tujuan || '-'}</span></div></td>
                <td className="money-cell">{formatRupiah(t.nominal_setor)}</td><td className="money-cell strong">{formatRupiah(t.total_bayar)}</td>
                <td><span className={`status-pill ${t.status === 'sukses' ? 'paid' : 'pending'}`}>{t.status}</span></td>
              </tr>
            ))}</tbody>
          </table>
          {data.length === 0 && <div className="brilink-empty"><HandCoins size={42} /><p>Belum ada data setor tunai</p><span>Transaksi baru akan muncul di sini.</span></div>}
        </div>
      </section>
    </div>
  )
}
