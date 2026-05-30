import React, { useState, useEffect, useRef } from 'react'
import { Search, Plus, Trash2, Minus, ShoppingCart, Banknote, QrCode, Camera, ScanLine, X, CheckCircle2, ReceiptText, Printer, Barcode } from 'lucide-react'
import { formatRupiah } from '../utils/formatRupiah'
import api from '../services/api'
import Modal from '../components/Common/Modal'
import toast from 'react-hot-toast'

export default function TransaksiPenjualan() {
  const [cart, setCart] = useState([])
  const [searchTerm, setSearchTerm] = useState('')
  const [products, setProducts] = useState([])
  const [showPayment, setShowPayment] = useState(false)
  const [paymentMethod, setPaymentMethod] = useState('tunai')
  const [uangBayar, setUangBayar] = useState('')
  const [loading, setLoading] = useState(false)
  const [qrisLoading, setQrisLoading] = useState(false)
  const [qrisData, setQrisData] = useState(null)
  const [qrisError, setQrisError] = useState('')
  const [scannerOpen, setScannerOpen] = useState(false)
  const [usbScannerOpen, setUsbScannerOpen] = useState(false)
  const [scannerError, setScannerError] = useState('')
  const [manualBarcode, setManualBarcode] = useState('')
  const [lastReceipt, setLastReceipt] = useState(null)
  const [showReceipt, setShowReceipt] = useState(false)
  const videoRef = useRef(null)
  const streamRef = useRef(null)
  const scanLoopRef = useRef(null)
  const lastScanRef = useRef('')

  useEffect(() => { fetchProducts() }, [])

  useEffect(() => {
    if (scannerOpen) startScanner()
    return stopScanner
  }, [scannerOpen, products])

  useEffect(() => {
    document.body.classList.toggle('receipt-print-mode', Boolean(showReceipt && lastReceipt))
    return () => document.body.classList.remove('receipt-print-mode')
  }, [showReceipt, lastReceipt])

  const fetchProducts = async () => {
    try {
      const res = await api.get('/barang')
      setProducts(res.data)
    } catch (e) {}
  }

  const addToCart = (p) => {
    if (!p) return
    if (Number(p.stok) < 1) return toast.error('Stok habis')
    const existing = cart.find(i => i.id === p.id)
    if (existing) {
      if (existing.jumlah >= Number(p.stok)) return toast.error('Stok tidak cukup')
      setCart(cart.map(i => i.id === p.id ? { ...i, jumlah: i.jumlah + 1 } : i))
    } else {
      setCart([...cart, { ...p, jumlah: 1 }])
    }
  }

  const addByCode = (code) => {
    const cleanCode = String(code || '').trim().toLowerCase()
    if (!cleanCode) return
    const product = products.find(p => String(p.kode_barang).toLowerCase() === cleanCode)
    if (!product) return toast.error(`Produk ${code} tidak ditemukan`)
    addToCart(product)
    toast.success(`${product.nama_barang} masuk keranjang`)
  }

  const updateQty = (id, qty) => {
    if (qty < 1) return removeFromCart(id)
    const product = products.find(x => x.id === id)
    if (qty > Number(product?.stok)) return toast.error('Stok tidak cukup')
    setCart(cart.map(i => i.id === id ? { ...i, jumlah: qty } : i))
  }

  const removeFromCart = (id) => setCart(cart.filter(i => i.id !== id))
  const totalHarga = cart.reduce((sum, item) => sum + (Number(item.harga_jual) * item.jumlah), 0)
  const kembalian = uangBayar ? Number(uangBayar) - totalHarga : 0

  const formatReceiptDate = (value) => {
    return new Intl.DateTimeFormat('id-ID', {
      weekday: 'long',
      day: '2-digit',
      month: 'long',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: false
    }).format(new Date(value)).replace(/\./g, ':')
  }

  const printReceipt = () => {
    window.setTimeout(() => window.print(), 80)
  }

  const createMidtransQris = async () => {
    if (cart.length === 0) return
    setQrisLoading(true)
    setQrisError('')
    setQrisData(null)
    try {
      const res = await api.post('/penjualan/qris', {
        items: cart.map(i => ({
          id: i.id,
          kode_barang: i.kode_barang,
          nama_barang: i.nama_barang,
          harga_jual: Number(i.harga_jual),
          jumlah: i.jumlah
        }))
      })
      setQrisData(res.data)
    } catch (e) {
      setQrisError(e.response?.data?.message || 'Gagal membuat QRIS Midtrans')
    } finally {
      setQrisLoading(false)
    }
  }

  const playPaymentSuccessSound = () => {
    const AudioContext = window.AudioContext || window.webkitAudioContext
    if (!AudioContext) return
    const ctx = new AudioContext()
    const gain = ctx.createGain()
    gain.gain.value = 0.07
    gain.connect(ctx.destination)

    const notes = [660, 880, 1046]
    notes.forEach((frequency, index) => {
      const oscillator = ctx.createOscillator()
      oscillator.type = 'sine'
      oscillator.frequency.value = frequency
      oscillator.connect(gain)
      oscillator.start(ctx.currentTime + index * 0.09)
      oscillator.stop(ctx.currentTime + index * 0.09 + 0.12)
    })
  }

  const handleCheckout = async (method = paymentMethod) => {
    if (cart.length === 0) return toast.error('Keranjang kosong')
    if (method === 'tunai' && Number(uangBayar) < totalHarga) return toast.error('Uang bayar kurang')

    const receiptItems = cart.map(i => ({
      id: i.id,
      kode_barang: i.kode_barang,
      nama_barang: i.nama_barang,
      harga_jual: Number(i.harga_jual),
      jumlah: i.jumlah
    }))
    const receiptTotal = totalHarga
    const receiptPaid = method === 'tunai' ? Number(uangBayar) : receiptTotal

    setLoading(true)
    try {
      const res = await api.post('/penjualan', {
        items: receiptItems,
        metode_pembayaran: method,
        uang_bayar: method === 'tunai' ? receiptPaid : null
      })
      if (method === 'qris') playPaymentSuccessSound()
      toast.success(`Pembayaran ${method.toUpperCase()} berhasil: ${res.data.transaksi.kode_transaksi}`)
      setLastReceipt({
        kode_transaksi: res.data?.transaksi?.kode_transaksi || `TRX-${Date.now()}`,
        waktu: new Date().toISOString(),
        metode_pembayaran: method,
        items: receiptItems,
        total: Number(res.data?.transaksi?.total_harga || receiptTotal),
        uang_bayar: receiptPaid,
        kembalian: method === 'tunai' ? Math.max(receiptPaid - receiptTotal, 0) : 0
      })
      setShowReceipt(true)
      setCart([])
      setUangBayar('')
      setPaymentMethod('tunai')
      setShowPayment(false)
      fetchProducts()
    } catch (e) {
      toast.error('Gagal: ' + (e.response?.data?.message || e.message))
    } finally {
      setLoading(false)
    }
  }

  const startScanner = async () => {
    setScannerError('')
    if (!navigator.mediaDevices?.getUserMedia) {
      setScannerError('Kamera tidak tersedia di browser ini. Gunakan input barcode manual.')
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
      setScannerError('Izin kamera ditolak atau kamera tidak ditemukan. Gunakan input manual.')
    }
  }

  const stopScanner = () => {
    if (scanLoopRef.current) cancelAnimationFrame(scanLoopRef.current)
    streamRef.current?.getTracks().forEach(track => track.stop())
    streamRef.current = null
    scanLoopRef.current = null
    lastScanRef.current = ''
  }

  const runBarcodeDetector = async () => {
    if (!('BarcodeDetector' in window)) {
      setScannerError('Barcode scanner otomatis belum didukung browser ini. Gunakan input manual.')
      return
    }
    const detector = new window.BarcodeDetector({ formats: ['code_128', 'code_39', 'ean_13', 'ean_8', 'qr_code'] })
    const scan = async () => {
      if (!scannerOpen || !videoRef.current) return
      try {
        const results = await detector.detect(videoRef.current)
        const code = results?.[0]?.rawValue
        if (code && code !== lastScanRef.current) {
          lastScanRef.current = code
          addByCode(code)
          setScannerOpen(false)
          return
        }
      } catch (e) {}
      scanLoopRef.current = requestAnimationFrame(scan)
    }
    scan()
  }

  const filteredProducts = products.filter(p =>
    p.nama_barang.toLowerCase().includes(searchTerm.toLowerCase()) ||
    p.kode_barang.toLowerCase().includes(searchTerm.toLowerCase())
  )
  const productCount = filteredProducts.length
  const totalItems = cart.reduce((sum, item) => sum + item.jumlah, 0)

  return (
    <div className="sales-page">
      <div className="page-heading sales-heading">
        <div>
          <span>Kasir Penjualan</span>
          <h1>Transaksi Penjualan</h1>
          <p>Pilih produk, scan barcode dengan kamera, lalu selesaikan pembayaran tunai atau QRIS.</p>
        </div>
        <div className="sales-heading-actions">
          <button className="scan-open-button" onClick={() => setUsbScannerOpen(true)}>
            <Barcode size={19} />
            <span>Scanner USB</span>
          </button>
          <button className="scan-open-button secondary" onClick={() => setScannerOpen(true)}>
            <Camera size={19} />
            <span>Kamera</span>
          </button>
        </div>
      </div>

      <div className="sales-grid">
        <section className="product-panel">
          <div className="sales-toolbar">
            <label className="sales-search">
              <Search size={19} />
              <input type="text" placeholder="Cari produk dari nama atau kode..." value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
            </label>
            <span>{productCount} produk</span>
          </div>

          <div className="product-grid">
            {filteredProducts.map(product => (
              <button key={product.id} onClick={() => addToCart(product)} disabled={Number(product.stok) < 1} className={`product-card ${Number(product.stok) < 1 ? 'disabled' : ''}`}>
                <div className="product-card-top">
                  <div className="product-icon"><ShoppingCart size={18} /></div>
                  <span className={Number(product.stok) < 5 ? 'stock-mini low' : 'stock-mini'}>Stok {product.stok}</span>
                </div>
                <strong>{product.nama_barang}</strong>
                <span>{product.kode_barang}</span>
                <p>{formatRupiah(product.harga_jual)}</p>
              </button>
            ))}
          </div>
        </section>

        <aside className="cart-panel">
          <div className="cart-header">
            <div>
              <span>Keranjang</span>
              <h2>{totalItems} item</h2>
            </div>
            <ShoppingCart size={23} />
          </div>

          <div className="cart-list">
            {cart.length === 0 ? (
              <div className="cart-empty">
                <ShoppingCart size={42} />
                <p>Keranjang kosong</p>
                <span>Pilih produk atau scan barcode untuk mulai.</span>
              </div>
            ) : cart.map(item => (
              <div key={item.id} className="cart-item">
                <div className="cart-item-main">
                  <strong>{item.nama_barang}</strong>
                  <span>{formatRupiah(item.harga_jual)} x {item.jumlah}</span>
                </div>
                <div className="qty-control">
                  <button onClick={() => updateQty(item.id, item.jumlah - 1)}><Minus size={16} /></button>
                  <span>{item.jumlah}</span>
                  <button onClick={() => updateQty(item.id, item.jumlah + 1)}><Plus size={16} /></button>
                </div>
                <strong className="cart-subtotal">{formatRupiah(Number(item.harga_jual) * item.jumlah)}</strong>
                <button onClick={() => removeFromCart(item.id)} className="remove-cart"><Trash2 size={17} /></button>
              </div>
            ))}
          </div>

          <div className="cart-footer">
            <div className="cart-total">
              <span>Total Bayar</span>
              <strong>{formatRupiah(totalHarga)}</strong>
            </div>
            <button onClick={() => setShowPayment(true)} disabled={cart.length === 0} className="checkout-button">
              <ReceiptText size={19} />
              <span>Lanjut Pembayaran</span>
            </button>
          </div>
        </aside>
      </div>

      {scannerOpen && (
        <div className="scanner-root">
          <div className="scanner-card">
            <div className="scanner-header">
              <div>
                <h2>Scan Barcode Produk</h2>
                <p>Arahkan kamera ke barcode atau QR kode produk.</p>
              </div>
              <button onClick={() => setScannerOpen(false)} aria-label="Tutup scanner"><X size={20} /></button>
            </div>
            <div className="camera-frame">
              <video ref={videoRef} playsInline muted></video>
              <div className="scan-line"><ScanLine size={34} /></div>
            </div>
            {scannerError && <div className="scanner-warning">{scannerError}</div>}
            <form onSubmit={(e) => { e.preventDefault(); addByCode(manualBarcode); setManualBarcode('') }} className="manual-barcode">
              <input value={manualBarcode} onChange={e => setManualBarcode(e.target.value)} placeholder="Ketik kode barang manual, contoh HP001" />
              <button type="submit">Tambah</button>
            </form>
          </div>
        </div>
      )}

      {usbScannerOpen && (
        <div className="scanner-root">
          <div className="scanner-card usb-scanner-card">
            <div className="scanner-header">
              <div>
                <h2>Scanner Barcode USB</h2>
                <p>Colok alat scanner, klik input di bawah, lalu scan barcode produk. Biasanya alat akan mengetik kode otomatis dan menekan Enter.</p>
              </div>
              <button onClick={() => setUsbScannerOpen(false)} aria-label="Tutup scanner USB"><X size={20} /></button>
            </div>
            <form onSubmit={(e) => { e.preventDefault(); addByCode(manualBarcode); setManualBarcode('') }} className="usb-scanner-form">
              <label className="field-group">
                <span>Kode dari Scanner USB</span>
                <input autoFocus value={manualBarcode} onChange={e => setManualBarcode(e.target.value)} placeholder="Scan barcode dengan alat USB..." />
              </label>
              <button type="submit">
                <Barcode size={18} />
                <span>Tambah ke Keranjang</span>
              </button>
            </form>
          </div>
        </div>
      )}

      <Modal isOpen={showPayment} onClose={() => setShowPayment(false)} title="Pembayaran" size="lg">
        <div className="payment-layout">
          <div className="payment-summary">
            <span>Total Belanja</span>
            <strong>{formatRupiah(totalHarga)}</strong>
            <p>{totalItems} item dalam keranjang</p>
          </div>

          <div className="payment-methods">
            <button onClick={() => setPaymentMethod('tunai')} className={paymentMethod === 'tunai' ? 'active' : ''}>
              <Banknote size={20} />
              <span>Tunai</span>
            </button>
            <button onClick={() => { setPaymentMethod('qris'); createMidtransQris() }} className={paymentMethod === 'qris' ? 'active' : ''}>
              <QrCode size={20} />
              <span>QRIS</span>
            </button>
          </div>

          {paymentMethod === 'tunai' ? (
            <div className="cash-payment">
              <label className="field-group">
                <span>Uang Bayar</span>
                <input type="number" value={uangBayar} onChange={e => setUangBayar(e.target.value)} placeholder="0" autoFocus />
              </label>
              <div className="quick-cash">
                {[50000, 100000, 200000, 500000].map(value => (
                  <button key={value} onClick={() => setUangBayar(value.toString())}>{formatRupiah(value)}</button>
                ))}
              </div>
              <div className={`change-box ${kembalian >= 0 && uangBayar ? 'ready' : ''}`}>
                <span>Kembalian</span>
                <strong>{uangBayar ? formatRupiah(Math.max(kembalian, 0)) : 'Rp 0'}</strong>
              </div>
              <button onClick={() => handleCheckout('tunai')} disabled={loading || !uangBayar || Number(uangBayar) < totalHarga} className="confirm-payment-button">
                {loading ? 'Memproses...' : 'Konfirmasi Tunai'}
              </button>
            </div>
          ) : (
            <div className="qris-payment">
              <div className="qris-box">
                {qrisData?.qris_url ? (
                  <img src={qrisData.qris_url} alt="QRIS Midtrans" className="midtrans-qris-image" />
                ) : (
                  <div className="fake-qris">
                    <span></span><span></span><span></span><span></span>
                  </div>
                )}
                <div>
                  <h3>{qrisData?.order_id ? 'Midtrans QRIS Sandbox' : 'Sultan Cell QRIS'}</h3>
                  <p>{qrisData?.order_id ? `Order ID: ${qrisData.order_id}` : 'Scan QRIS ini dari aplikasi pembayaran pelanggan, lalu konfirmasi jika pembayaran sudah masuk.'}</p>
                </div>
              </div>
              {qrisLoading && <div className="qris-status"><QrCode size={20} /><span>Membuat QRIS Midtrans...</span></div>}
              {qrisError && <div className="scanner-warning">{qrisError}</div>}
              <div className="qris-status">
                <CheckCircle2 size={20} />
                <span>Suara sukses akan diputar setelah pembayaran QRIS dikonfirmasi.</span>
              </div>
              <button type="button" onClick={createMidtransQris} disabled={qrisLoading} className="secondary-button">
                {qrisLoading ? 'Memuat QRIS...' : 'Buat Ulang QRIS Midtrans'}
              </button>
              <button onClick={() => handleCheckout('qris')} disabled={loading} className="confirm-payment-button qris">
                {loading ? 'Memproses...' : 'Konfirmasi QRIS Sudah Dibayar'}
              </button>
            </div>
          )}
        </div>
      </Modal>

      <Modal isOpen={showReceipt} onClose={() => setShowReceipt(false)} title="Struk Pembayaran" size="sm">
        {lastReceipt && (
          <div className="receipt-preview">
            <div className="receipt-print-area">
              <div className="receipt-store">
                <strong>SULTAN CELL</strong>
                <span>Konter HP & Agen BRILink</span>
                <span>Kasir, stok barang, dan layanan BRILink</span>
              </div>

              <div className="receipt-divider"></div>

              <div className="receipt-meta">
                <div><span>No</span><strong>{lastReceipt.kode_transaksi}</strong></div>
                <div><span>Waktu</span><strong>{formatReceiptDate(lastReceipt.waktu)}</strong></div>
                <div><span>Kasir</span><strong>Admin</strong></div>
                <div><span>Bayar</span><strong>{lastReceipt.metode_pembayaran.toUpperCase()}</strong></div>
              </div>

              <div className="receipt-divider"></div>

              <div className="receipt-items">
                {lastReceipt.items.map(item => (
                  <div key={`${item.id}-${item.kode_barang}`} className="receipt-item">
                    <div>
                      <strong>{item.nama_barang}</strong>
                      <span>{item.kode_barang}</span>
                    </div>
                    <p>{item.jumlah} x {formatRupiah(item.harga_jual)}</p>
                    <b>{formatRupiah(item.harga_jual * item.jumlah)}</b>
                  </div>
                ))}
              </div>

              <div className="receipt-divider"></div>

              <div className="receipt-total-row">
                <span>Total</span>
                <strong>{formatRupiah(lastReceipt.total)}</strong>
              </div>
              <div className="receipt-total-row">
                <span>Bayar</span>
                <strong>{formatRupiah(lastReceipt.uang_bayar)}</strong>
              </div>
              <div className="receipt-total-row">
                <span>Kembali</span>
                <strong>{formatRupiah(lastReceipt.kembalian)}</strong>
              </div>

              <div className="receipt-footer">
                <p>Terima kasih sudah berbelanja</p>
                <span>Barang yang sudah dibeli harap dicek kembali.</span>
              </div>
            </div>

            <div className="receipt-actions no-print">
              <button type="button" className="secondary-button" onClick={() => setShowReceipt(false)}>Tutup</button>
              <button type="button" className="print-receipt-button" onClick={printReceipt}>
                <Printer size={18} />
                <span>Cetak Struk</span>
              </button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  )
}
