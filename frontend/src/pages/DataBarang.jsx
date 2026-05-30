import React, { useState, useEffect, useRef } from 'react'
import { Plus, Search, Edit3, Trash2, Package, Boxes, AlertTriangle, Tags, Camera, Keyboard, ScanLine, X, Barcode } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import Modal from '../components/Common/Modal'
import toast from 'react-hot-toast'

const emptyForm = { kode_barang: '', nama_barang: '', kategori: '', stok: 0, harga_beli: 0, harga_jual: 0 }

export default function DataBarang() {
  const [barang, setBarang] = useState([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')
  const [modalOpen, setModalOpen] = useState(false)
  const [editData, setEditData] = useState(null)
  const [form, setForm] = useState(emptyForm)
  const [inputMode, setInputMode] = useState('manual')
  const [usbInputActive, setUsbInputActive] = useState(false)
  const [scannerActive, setScannerActive] = useState(false)
  const [scannerError, setScannerError] = useState('')
  const videoRef = useRef(null)
  const streamRef = useRef(null)
  const scanLoopRef = useRef(null)

  useEffect(() => { fetchBarang() }, [])

  useEffect(() => {
    if (modalOpen && inputMode === 'otomatis' && !editData) startScanner()
    return stopScanner
  }, [modalOpen, inputMode, editData])

  const fetchBarang = async () => {
    try {
      const res = await api.get('/barang')
      setBarang(res.data)
    } catch (e) {
    } finally {
      setLoading(false)
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    try {
      if (editData) await api.put(`/barang/${editData.id}`, form)
      else await api.post('/barang', form)
      fetchBarang()
      toast.success(editData ? 'Barang berhasil diperbarui' : 'Barang berhasil ditambahkan')
      closeModal()
    } catch (e) {
      toast.error(e.response?.data?.message || 'Gagal menyimpan')
    }
  }

  const handleDelete = async (id) => {
    if (!confirm('Hapus barang ini?')) return
    try {
      await api.delete(`/barang/${id}`)
      fetchBarang()
    } catch (e) {
      toast.error('Gagal menghapus')
    }
  }

  const openCreate = (mode = 'manual') => {
    setEditData(null)
    setInputMode(mode)
    setForm(emptyForm)
    setModalOpen(true)
  }

  const openEdit = (item) => {
    setEditData(item)
    setInputMode('manual')
    setForm(item)
    setModalOpen(true)
  }

  const closeModal = () => {
    setModalOpen(false)
    setEditData(null)
    setForm(emptyForm)
    setScannerActive(false)
    setScannerError('')
    stopScanner()
  }

  const startScanner = async () => {
    setScannerError('')
    setScannerActive(true)
    if (!navigator.mediaDevices?.getUserMedia) {
      setScannerError('Kamera tidak tersedia di browser ini. Kode barang bisa diketik manual sebagai cadangan.')
      return
    }

    try {
      const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' }, audio: false })
      streamRef.current = stream
      if (videoRef.current) {
        videoRef.current.srcObject = stream
        await videoRef.current.play()
      }
      runBarcodeDetector()
    } catch (e) {
      setScannerError('Izin kamera ditolak atau kamera tidak ditemukan. Kode barang bisa diketik manual sebagai cadangan.')
    }
  }

  const stopScanner = () => {
    if (scanLoopRef.current) cancelAnimationFrame(scanLoopRef.current)
    streamRef.current?.getTracks().forEach(track => track.stop())
    streamRef.current = null
    scanLoopRef.current = null
    setScannerActive(false)
  }

  const runBarcodeDetector = async () => {
    if (!('BarcodeDetector' in window)) {
      setScannerError('Scanner otomatis belum didukung browser ini. Kode barang bisa diketik manual sebagai cadangan.')
      return
    }

    const detector = new window.BarcodeDetector({ formats: ['code_128', 'code_39', 'ean_13', 'ean_8', 'qr_code'] })
    const scan = async () => {
      if (!videoRef.current || !modalOpen || inputMode !== 'otomatis') return
      try {
        const results = await detector.detect(videoRef.current)
        const code = results?.[0]?.rawValue
        if (code) {
          setForm(prev => ({ ...prev, kode_barang: code }))
          toast.success(`Kode barang terbaca: ${code}`)
          stopScanner()
          return
        }
      } catch (e) {}
      scanLoopRef.current = requestAnimationFrame(scan)
    }
    scan()
  }

  const filtered = barang.filter(b =>
    b.nama_barang.toLowerCase().includes(search.toLowerCase()) ||
    b.kode_barang.toLowerCase().includes(search.toLowerCase()) ||
    String(b.kategori || '').toLowerCase().includes(search.toLowerCase())
  )
  const lowStock = barang.filter(item => Number(item.stok) < 5).length
  const categories = new Set(barang.map(item => item.kategori).filter(Boolean)).size

  return (
    <div className="inventory-page">
      <div className="page-heading inventory-heading">
        <div>
          <span>Inventaris Toko</span>
          <h1>Data Barang</h1>
          <p>Kelola stok, kategori, harga beli, dan harga jual barang Sultan Cell.</p>
        </div>
        <button onClick={() => openCreate('manual')} className="inventory-add-button">
          <Plus size={19} />
          <span>Tambah Barang</span>
        </button>
      </div>

      <div className="inventory-summary">
        <div className="inventory-summary-card">
          <div className="summary-icon blue"><Boxes size={22} /></div>
          <div>
            <span>Total Barang</span>
            <strong>{barang.length}</strong>
          </div>
        </div>
        <div className="inventory-summary-card">
          <div className="summary-icon amber"><AlertTriangle size={22} /></div>
          <div>
            <span>Stok Menipis</span>
            <strong>{lowStock}</strong>
          </div>
        </div>
        <div className="inventory-summary-card">
          <div className="summary-icon green"><Tags size={22} /></div>
          <div>
            <span>Kategori</span>
            <strong>{categories}</strong>
          </div>
        </div>
      </div>

      <section className="inventory-panel">
        <div className="inventory-toolbar">
          <div>
            <h2>Daftar Barang</h2>
            <p>{filtered.length} barang ditampilkan</p>
          </div>
          <label className="inventory-search">
            <Search size={19} />
            <input type="text" placeholder="Cari kode, nama, atau kategori..." value={search} onChange={e => setSearch(e.target.value)} />
          </label>
        </div>

        <div className="inventory-table-wrap">
          <table className="inventory-table">
            <thead>
              <tr>
                <th>Kode</th>
                <th>Nama Barang</th>
                <th>Kategori</th>
                <th>Stok</th>
                <th>Harga Beli</th>
                <th>Harga Jual</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              {filtered.map(item => (
                <tr key={item.id}>
                  <td><span className="item-code">{item.kode_barang}</span></td>
                  <td>
                    <div className="item-name-cell">
                      <div className="item-avatar"><Package size={18} /></div>
                      <div>
                        <strong>{item.nama_barang}</strong>
                        <span>Margin {formatRupiah(Number(item.harga_jual) - Number(item.harga_beli))}</span>
                      </div>
                    </div>
                  </td>
                  <td><span className="category-pill">{item.kategori}</span></td>
                  <td><span className={`stock-pill ${Number(item.stok) < 5 ? 'low' : 'safe'}`}>{item.stok} pcs</span></td>
                  <td className="money-cell">{formatRupiah(item.harga_beli)}</td>
                  <td className="money-cell strong">{formatRupiah(item.harga_jual)}</td>
                  <td>
                    <div className="table-actions">
                      <button onClick={() => openEdit(item)} className="icon-action edit" aria-label={`Edit ${item.nama_barang}`}>
                        <Edit3 size={17} />
                      </button>
                      <button onClick={() => handleDelete(item.id)} className="icon-action delete" aria-label={`Hapus ${item.nama_barang}`}>
                        <Trash2 size={17} />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {!loading && filtered.length === 0 && (
            <div className="inventory-empty">
              <Package size={40} />
              <p>Tidak ada data barang</p>
              <span>Coba ubah kata kunci pencarian atau tambah barang baru.</span>
            </div>
          )}
        </div>
      </section>

      <Modal isOpen={modalOpen} onClose={closeModal} title={editData ? 'Edit Barang' : inputMode === 'otomatis' ? 'Input Barang Otomatis' : 'Input Barang Manual'} size="lg">
        <form onSubmit={handleSubmit} className="inventory-form">
          {!editData && (
            <div className="inventory-input-mode">
              <button type="button" onClick={() => { stopScanner(); setInputMode('manual') }} className={inputMode === 'manual' ? 'active' : ''}>
                <Keyboard size={18} />
                <span>Manual</span>
              </button>
              <button type="button" onClick={() => setInputMode('otomatis')} className={inputMode === 'otomatis' ? 'active' : ''}>
                <Camera size={18} />
                <span>Otomatis Kamera</span>
              </button>
            </div>
          )}

          {inputMode === 'otomatis' && !editData && (
            <div className="inventory-scanner-panel">
              <div className="inventory-scanner-header">
                <div>
                  <strong>Scan Kode Barang</strong>
                  <span>Arahkan kamera ke barcode. Nama barang tetap diketik manual.</span>
                </div>
                {scannerActive ? (
                  <button type="button" onClick={stopScanner}><X size={18} /> Stop</button>
                ) : (
                  <button type="button" onClick={startScanner}><Camera size={18} /> Scan</button>
                )}
              </div>
              <div className="inventory-camera-frame">
                <video ref={videoRef} playsInline muted></video>
                <div><ScanLine size={30} /></div>
              </div>
              {scannerError && <p className="inventory-scanner-warning">{scannerError}</p>}
            </div>
          )}

          <div className="form-grid two">
            <label className="field-group">
              <span>{inputMode === 'otomatis' && !editData ? 'Kode Barang dari Scan' : 'Kode Barang'}</span>
              <div className="barcode-input-row">
                <input type="text" autoFocus={usbInputActive} value={form.kode_barang} onChange={e => setForm({ ...form, kode_barang: e.target.value })} required />
                {!editData && (
                  <button type="button" onClick={() => { setUsbInputActive(true); toast.success('Scanner USB aktif. Klik/scan pada kolom kode barang.') }}>
                    <Barcode size={18} />
                    <span>Scanner USB</span>
                  </button>
                )}
              </div>
              {usbInputActive && <p className="scanner-help-text">Scanner USB aktif. Arahkan alat ke barcode, kode akan masuk ke kolom ini.</p>}
            </label>
            <label className="field-group">
              <span>Kategori</span>
              <select value={form.kategori} onChange={e => setForm({ ...form, kategori: e.target.value })} required>
                <option value="">Pilih kategori</option>
                <option>HP</option>
                <option>Aksesoris</option>
                <option>Kartu</option>
                <option>Lainnya</option>
              </select>
            </label>
          </div>

          <label className="field-group">
            <span>Nama Barang</span>
            <input type="text" value={form.nama_barang} onChange={e => setForm({ ...form, nama_barang: e.target.value })} required />
          </label>

          <div className="form-grid three">
            <label className="field-group">
              <span>Stok</span>
              <input type="number" value={form.stok} onChange={e => setForm({ ...form, stok: parseInt(e.target.value) || 0 })} required />
            </label>
            <label className="field-group">
              <span>Harga Beli</span>
              <input type="number" value={form.harga_beli} onChange={e => setForm({ ...form, harga_beli: parseFloat(e.target.value) || 0 })} required />
            </label>
            <label className="field-group">
              <span>Harga Jual</span>
              <input type="number" value={form.harga_jual} onChange={e => setForm({ ...form, harga_jual: parseFloat(e.target.value) || 0 })} required />
            </label>
          </div>

          <div className="form-actions">
            <button type="button" onClick={closeModal} className="secondary-button">Batal</button>
            <button type="submit" className="primary-action-button">Simpan Barang</button>
          </div>
        </form>
      </Modal>
    </div>
  )
}
