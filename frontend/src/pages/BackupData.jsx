import React, { useState } from 'react'
import { DatabaseBackup, Download, Upload } from 'lucide-react'
import api, { getApiErrorMessage } from '../services/api'
import toast from 'react-hot-toast'
import Modal from '../components/Common/Modal'

export default function BackupData() {
  const [loading, setLoading] = useState(false)
  const [restoreLoading, setRestoreLoading] = useState(false)
  const [backupFile, setBackupFile] = useState(null)
  const [confirmText, setConfirmText] = useState('')
  const [showRestoreConfirm, setShowRestoreConfirm] = useState(false)

  const downloadBackup = async () => {
    setLoading(true)
    try {
      const res = await api.get('/backup-data')
      const blob = new Blob([JSON.stringify(res.data, null, 2)], { type: 'application/json' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.download = `backup-sultan-cell-${new Date().toISOString().slice(0, 10)}.json`
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      URL.revokeObjectURL(url)
      toast.success('Backup data berhasil diunduh')
    } catch (e) {
      toast.error(getApiErrorMessage(e, 'Gagal membuat backup data'))
    } finally {
      setLoading(false)
    }
  }

  const restoreBackup = async (e) => {
    e.preventDefault()
    if (!backupFile) return toast.error('Pilih file backup dulu')
    if (confirmText !== 'RESTORE SULTAN CELL') return toast.error('Teks konfirmasi belum sesuai')
    setShowRestoreConfirm(true)
  }

  const submitRestoreBackup = async () => {
    if (!backupFile) return toast.error('Pilih file backup dulu')
    setRestoreLoading(true)
    try {
      const text = await backupFile.text()
      const backup = JSON.parse(text)
      await api.post('/backup-data/restore', { backup, confirm_text: confirmText })
      toast.success('Restore backup berhasil. Silakan refresh website.')
      setBackupFile(null)
      setConfirmText('')
      setShowRestoreConfirm(false)
    } catch (e) {
      if (e instanceof SyntaxError) {
        toast.error('File backup bukan JSON yang valid.')
        return
      }
      toast.error(getApiErrorMessage(e, 'Gagal restore backup'))
    } finally {
      setRestoreLoading(false)
    }
  }

  return (
    <div className="brilink-page">
      <div className="page-heading brilink-heading">
        <div><span>Keamanan Data</span><h1>Backup Data</h1><p>Unduh salinan data barang, transaksi, BRILink, biaya admin, stok, dan riwayat aktivitas.</p></div>
      </div>
      <section className="brilink-form-card">
        <div className="brilink-section-title"><DatabaseBackup size={22} /><div><h2>Backup JSON</h2><p>Simpan file backup di flashdisk atau cloud agar data toko punya cadangan.</p></div></div>
        <button type="button" onClick={downloadBackup} disabled={loading} className="primary-action-button">
          <Download size={18} />
          {loading ? 'Membuat Backup...' : 'Download Backup Data'}
        </button>
      </section>

      <section className="brilink-form-card">
        <div className="brilink-section-title"><Upload size={22} /><div><h2>Restore Backup</h2><p>Gunakan hanya jika ingin mengembalikan data dari file backup. Data lama akan diganti.</p></div></div>
        <form onSubmit={restoreBackup} className="brilink-form-grid">
          <label className="field-group full">
            <span>File Backup JSON</span>
            <input type="file" accept="application/json,.json" onChange={e => setBackupFile(e.target.files?.[0] || null)} />
          </label>
          <label className="field-group full">
            <span>Ketik RESTORE SULTAN CELL</span>
            <input value={confirmText} onChange={e => setConfirmText(e.target.value)} placeholder="RESTORE SULTAN CELL" />
          </label>
          <div className="form-actions full">
            <button type="submit" disabled={restoreLoading} className="report-action-button reset">
              <Upload size={18} />
              {restoreLoading ? 'Merestore...' : 'Restore Backup'}
            </button>
          </div>
        </form>
      </section>

      <Modal isOpen={showRestoreConfirm} onClose={() => !restoreLoading && setShowRestoreConfirm(false)} title="Restore Backup" size="sm">
        <div className="confirm-action-content">
          <div className="form-alert error">
            Restore backup akan mengganti data yang ada sekarang. Pastikan file backup sudah benar sebelum melanjutkan.
          </div>
          <div className="modal-form-actions">
            <button type="button" className="secondary-button" onClick={() => setShowRestoreConfirm(false)} disabled={restoreLoading}>Batal</button>
            <button type="button" className="ui-button danger" onClick={submitRestoreBackup} disabled={restoreLoading}>
              {restoreLoading ? 'Merestore...' : 'Restore Backup'}
            </button>
          </div>
        </div>
      </Modal>
    </div>
  )
}
