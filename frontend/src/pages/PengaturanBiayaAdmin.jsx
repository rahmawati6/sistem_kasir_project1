import React, { useState, useEffect } from 'react'
import { Settings, Save, SlidersHorizontal, ReceiptText, ToggleRight } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import toast from 'react-hot-toast'

const defaultRange = [
  { min: 1, max: 100000, biaya: 2000 },
  { min: 100001, max: 500000, biaya: 5000 },
  { min: 500001, max: 1000000, biaya: 10000 },
  { min: 1000001, max: 2000000, biaya: 15000 },
  { min: 2000001, max: '', biaya: 20000 },
]

export default function PengaturanBiayaAdmin() {
  const [data, setData] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => { fetchData() }, [])

  const fetchData = async () => {
    try {
      const res = await api.get('/biaya-admin')
      setData(res.data)
    } catch (e) {
    } finally {
      setLoading(false)
    }
  }

  const handleUpdate = async (item) => {
    try {
      await api.put(`/biaya-admin/${item.layanan}`, {
        jenis_biaya: item.jenis_biaya,
        nilai: item.nilai,
        aturan_range: item.jenis_biaya === 'range' ? normalizeRanges(item.aturan_range) : null,
        is_active: item.is_active
      })
      toast.success(`Biaya admin ${layananLabels[item.layanan] || item.layanan} berhasil diperbarui`)
    } catch (e) {
      toast.error('Gagal memperbarui')
    }
  }

  const updateItem = (index, field, value) => {
    const newData = [...data]
    newData[index][field] = value
    if (field === 'jenis_biaya' && value === 'range' && !newData[index].aturan_range?.length) {
      newData[index].aturan_range = defaultRange
      newData[index].nilai = 0
    }
    setData(newData)
  }

  const updateRange = (itemIndex, rangeIndex, field, value) => {
    const newData = [...data]
    const ranges = [...(newData[itemIndex].aturan_range?.length ? newData[itemIndex].aturan_range : defaultRange)]
    ranges[rangeIndex] = { ...ranges[rangeIndex], [field]: value }
    newData[itemIndex].aturan_range = ranges
    setData(newData)
  }

  const normalizeRanges = (ranges = defaultRange) => {
    return ranges.map(range => ({
      min: Number(range.min) || 0,
      max: range.max === '' || range.max === null ? null : Number(range.max),
      biaya: Number(range.biaya) || 0,
    }))
  }

  const formatRangeText = (range) => {
    const min = formatRupiah(range.min)
    const max = range.max ? formatRupiah(range.max) : 'ke atas'
    return `${min} - ${max}`
  }

  const layananLabels = {
    transfer: 'Transfer',
    tarik_tunai: 'Tarik Tunai',
    setor_tunai: 'Setor Tunai',
    tagihan: 'Tagihan',
    pulsa: 'Pulsa',
    paket_data: 'Paket Data'
  }

  const activeCount = data.filter(item => item.is_active).length
  const nominalCount = data.filter(item => item.jenis_biaya === 'nominal').length
  const persenCount = data.filter(item => item.jenis_biaya === 'persen').length
  const rangeCount = data.filter(item => item.jenis_biaya === 'range').length

  if (loading) return <div className="dashboard-loading"><div></div><span>Memuat biaya admin...</span></div>

  return (
    <div className="admin-fee-page">
      <div className="page-heading admin-fee-heading">
        <div>
          <span>Pengaturan BRILink</span>
          <h1>Biaya Admin</h1>
          <p>Atur biaya administrasi setiap layanan dengan nominal tetap, persentase, atau range bertingkat.</p>
        </div>
      </div>

      <div className="admin-fee-summary">
        <div className="brilink-summary-card"><div className="summary-icon blue"><Settings size={22} /></div><span>Total Layanan</span><strong>{data.length}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon green"><ToggleRight size={22} /></div><span>Layanan Aktif</span><strong>{activeCount}</strong></div>
        <div className="brilink-summary-card"><div className="summary-icon amber"><ReceiptText size={22} /></div><span>Nominal / Persen / Range</span><strong>{nominalCount} / {persenCount} / {rangeCount}</strong></div>
      </div>

      <section className="admin-fee-grid">
        {data.map((item, index) => {
          const label = layananLabels[item.layanan] || item.layanan
          const ranges = item.aturan_range?.length ? item.aturan_range : defaultRange
          const displayValue = item.jenis_biaya === 'nominal'
            ? formatRupiah(item.nilai)
            : item.jenis_biaya === 'persen'
              ? `${item.nilai}%`
              : `${ranges.length} range aktif`
          return (
            <article key={item.id} className={`admin-fee-card ${item.is_active ? 'active' : 'inactive'}`}>
              <div className="admin-fee-card-top">
                <div className="admin-fee-icon"><SlidersHorizontal size={21} /></div>
                <div>
                  <h2>{label}</h2>
                  <p>{item.is_active ? 'Biaya aktif digunakan' : 'Biaya sedang nonaktif'}</p>
                </div>
                <label className="admin-switch" aria-label={`Aktifkan ${label}`}>
                  <input type="checkbox" checked={item.is_active} onChange={e => updateItem(index, 'is_active', e.target.checked)} />
                  <span></span>
                </label>
              </div>

              <div className="admin-fee-current">
                <span>Biaya saat ini</span>
                <strong>{displayValue}</strong>
              </div>

              <div className="admin-fee-fields">
                <label className="field-group">
                  <span>Jenis Biaya</span>
                  <select value={item.jenis_biaya} onChange={e => updateItem(index, 'jenis_biaya', e.target.value)}>
                    <option value="nominal">Nominal (Rp)</option>
                    <option value="persen">Persentase (%)</option>
                    <option value="range">Range Bertingkat</option>
                  </select>
                </label>
                {item.jenis_biaya !== 'range' && (
                  <label className="field-group">
                    <span>{item.jenis_biaya === 'persen' ? 'Nilai Persentase' : 'Nilai Nominal'}</span>
                    <input type="number" value={item.nilai} onChange={e => updateItem(index, 'nilai', parseFloat(e.target.value) || 0)} />
                  </label>
                )}
              </div>

              {item.jenis_biaya === 'range' && (
                <div className="admin-range-list">
                  <div className="admin-range-title">
                    <strong>Aturan Range Bertingkat</strong>
                    <span>Biaya admin dipilih sesuai nominal transaksi.</span>
                  </div>
                  {ranges.map((range, rangeIndex) => (
                    <div key={rangeIndex} className="admin-range-row">
                      <label>
                        <span>Dari</span>
                        <input type="number" value={range.min} onChange={e => updateRange(index, rangeIndex, 'min', e.target.value)} />
                      </label>
                      <label>
                        <span>Sampai</span>
                        <input type="number" value={range.max ?? ''} placeholder="Ke atas" onChange={e => updateRange(index, rangeIndex, 'max', e.target.value)} />
                      </label>
                      <label>
                        <span>Admin</span>
                        <input type="number" value={range.biaya} onChange={e => updateRange(index, rangeIndex, 'biaya', e.target.value)} />
                      </label>
                      <p>{formatRangeText(range)} = {formatRupiah(range.biaya)}</p>
                    </div>
                  ))}
                </div>
              )}

              <button onClick={() => handleUpdate(item)} className="admin-save-button">
                <Save size={17} />
                <span>Simpan Perubahan</span>
              </button>
            </article>
          )
        })}
      </section>
    </div>
  )
}
