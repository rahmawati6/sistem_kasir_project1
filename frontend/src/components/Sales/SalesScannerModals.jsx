import React from 'react'
import { Barcode, ScanLine, X } from 'lucide-react'

export default function SalesScannerModals({
  scannerOpen,
  usbScannerOpen,
  scannerError,
  manualBarcode,
  onManualBarcodeChange,
  onSubmitBarcode,
  onCloseScanner,
  onCloseUsbScanner,
  videoRef,
}) {
  const handleSubmit = (event) => {
    event.preventDefault()
    onSubmitBarcode(manualBarcode)
    onManualBarcodeChange('')
  }

  return (
    <>
      {scannerOpen && (
        <div className="scanner-root">
          <div className="scanner-card">
            <div className="scanner-header">
              <div>
                <h2>Scan Barcode Produk</h2>
                <p>Arahkan kamera ke barcode atau QR kode produk.</p>
              </div>
              <button onClick={onCloseScanner} aria-label="Tutup scanner"><X size={20} /></button>
            </div>
            <div className="camera-frame">
              <video ref={videoRef} playsInline muted autoPlay></video>
              <div className="scan-line"><ScanLine size={34} /></div>
            </div>
            {scannerError && <div className="scanner-warning">{scannerError}</div>}
            <form onSubmit={handleSubmit} className="manual-barcode">
              <input value={manualBarcode} onChange={e => onManualBarcodeChange(e.target.value)} placeholder="Ketik kode barang manual, contoh HP001" />
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
              <button onClick={onCloseUsbScanner} aria-label="Tutup scanner USB"><X size={20} /></button>
            </div>
            <form onSubmit={handleSubmit} className="usb-scanner-form">
              <label className="field-group">
                <span>Kode dari Scanner USB</span>
                <input autoFocus value={manualBarcode} onChange={e => onManualBarcodeChange(e.target.value)} placeholder="Scan barcode dengan alat USB..." />
              </label>
              <button type="submit">
                <Barcode size={18} />
                <span>Tambah ke Keranjang</span>
              </button>
            </form>
          </div>
        </div>
      )}
    </>
  )
}
