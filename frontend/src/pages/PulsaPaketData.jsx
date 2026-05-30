import React, { useState, useEffect } from 'react'
import { Smartphone, Plus, Wifi, WalletCards } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const emptyForm = { operator: 'Telkomsel', jenis_layanan: 'pulsa', nomor_tujuan: '', produk: '', harga: '' }

export default function PulsaPaketData() {
  const [data, setData] = useState([])
  const [showForm, setShowForm] = useState(false)
  const [loading, setLoading] = useState(false)
  const [form, setForm] = useState(emptyForm)

  useEffect(() => { fetchData() }, [])
  const fetchData = async () => { try { const res = await api.get('/pulsa'); setData(res.data) } catch (e) {} }

  const handleSubmit = async (e) => {
    e.preventDefault(); setLoading(true)
    try {
      await api.post('/pulsa', { ...form, harga: parseFloat(form.harga) })
      toast.success('Transaksi pulsa berhasil!')
      fetchData(); setShowForm(false); setForm(emptyForm)
    } catch (e) { toast.error(e.response?.data?.message || 'Gagal') } finally { setLoading(false) }
  }

  const totalHarga = data.reduce((sum, item) => sum + Number(item.harga || 0), 0)
  const totalBayar = data.reduce((sum, item) => sum + Number(item.total_bayar || 0), 0)

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div><span>Layanan Seluler</span><h1>Pulsa & Paket Data</h1><p>Catat transaksi pulsa dan paket data untuk semua operator utama.</p></div>
        <button onClick={() => setShowForm(!showForm)} className="brilink-primary-button"><Plus size={19} /> Transaksi Baru</button>
      </div>
      <div className="brilink-summary-grid">
        <div className="brilink-summary-card"><div className="summary-icon blue"><Smartphone size={22} /></div><span>Total Transaksi</span><strong>{data.length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><Wifi size={22} /></div><span>Harga Produk</span><strong>{formatRupiah(totalHarga)}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><WalletCards size={22} /></div><span>Total Bayar</span><strong>{formatRupiah(totalBayar)}</strong></div>
      </div>

      {showForm && (
        <section className="brilink-form-card">
          <div className="brilink-section-title"><Smartphone size={20} /><div><h2>Form Pulsa / Paket Data</h2><p>Pilih operator, jenis layanan, dan produk yang dibeli.</p></div></div>
          <form onSubmit={handleSubmit} className="brilink-form-grid">
            <label className="field-group"><span>Operator</span><select value={form.operator} onChange={e => setForm({ ...form, operator: e.target.value })}><option>Telkomsel</option><option>Indosat</option><option>XL</option><option>Tri</option><option>Smartfren</option></select></label>
            <label className="field-group"><span>Jenis</span><select value={form.jenis_layanan} onChange={e => setForm({ ...form, jenis_layanan: e.target.value })}><option value="pulsa">Pulsa</option><option value="paket_data">Paket Data</option></select></label>
            <label className="field-group"><span>Nomor Tujuan</span><input type="text" value={form.nomor_tujuan} onChange={e => setForm({ ...form, nomor_tujuan: e.target.value })} required /></label>
            <label className="field-group"><span>Produk</span><input type="text" value={form.produk} onChange={e => setForm({ ...form, produk: e.target.value })} required placeholder="cth: Pulsa 50rb" /></label>
            <label className="field-group"><span>Harga</span><input type="number" value={form.harga} onChange={e => setForm({ ...form, harga: e.target.value })} required /></label>
            <div className="form-actions full"><button type="button" onClick={() => setShowForm(false)} className="secondary-button">Batal</button><button type="submit" disabled={loading} className="primary-action-button">{loading ? 'Memproses...' : 'Simpan Transaksi'}</button></div>
          </form>
        </section>
      )}

      <section className="brilink-table-panel">
        <div className="brilink-table-header"><div><h2>Riwayat Pulsa & Data</h2><p>{data.length} transaksi tercatat</p></div></div>
        <div className="brilink-table-wrap">
          <table className="brilink-table">
            <thead><tr><th>Kode</th><th>Tanggal</th><th>Operator</th><th>Jenis</th><th>Nomor</th><th>Produk</th><th>Harga</th><th>Total</th></tr></thead>
            <tbody>{data.map(t => (
              <tr key={t.id}>
                <td><span className="item-code">{t.kode_transaksi}</span></td><td>{new Date(t.tanggal).toLocaleDateString('id-ID')}</td><td><strong>{t.operator}</strong></td><td><span className={`service-pill ${t.jenis_layanan === 'pulsa' ? 'green' : 'blue'}`}>{t.jenis_layanan}</span></td>
                <td>{t.nomor_tujuan}</td><td>{t.produk}</td><td className="money-cell">{formatRupiah(t.harga)}</td><td className="money-cell strong">{formatRupiah(t.total_bayar)}</td>
              </tr>
            ))}</tbody>
          </table>
          {data.length === 0 && <div className="brilink-empty"><Smartphone size={42} /><p>Belum ada transaksi pulsa</p><span>Transaksi baru akan muncul di sini.</span></div>}
        </div>
      </section>
    </div>
  )
}
