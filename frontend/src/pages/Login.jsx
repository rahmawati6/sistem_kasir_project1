import React, { useState } from 'react'
import { useAuth } from '../hooks/useAuth'
import { LogIn, Eye, EyeOff, ShieldCheck, User, LockKeyhole, ReceiptText, WalletCards, Package, BarChart3 } from 'lucide-react'
import sultanCellLogoRound from '../assets/sultan-cell-logo-round.png'
import api, { getApiErrorMessage } from '../services/api'

export default function Login() {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [error, setError] = useState('')
  const [messageType, setMessageType] = useState('error')
  const [usernameError, setUsernameError] = useState('')
  const [passwordError, setPasswordError] = useState('')
  const [loading, setLoading] = useState(false)
  const [forgotAttempts, setForgotAttempts] = useState(0)
  const [showResetPassword, setShowResetPassword] = useState(false)
  const [newPassword, setNewPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [resetLoading, setResetLoading] = useState(false)
  const { login } = useAuth()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setUsernameError('')
    setPasswordError('')

    if (!username.trim()) {
      setUsernameError('Username wajib diisi.')
      setLoading(false)
      return
    }

    if (!password.trim()) {
      setPasswordError('Password wajib diisi.')
      setLoading(false)
      return
    }

    const result = await login(username, password)
    if (!result.success) {
      const nextAttempts = forgotAttempts + 1
      setForgotAttempts(nextAttempts)
      if (nextAttempts >= 3) {
        setShowResetPassword(true)
        setMessageType('error')
        setError('Sudah 3 kali gagal. Silakan buat password baru.')
      } else {
        const warning = `${result.message}. Percobaan ${nextAttempts}/3 sebelum reset password.`
        setUsernameError('Periksa kembali username.')
        setPasswordError(warning)
      }
    }
    setLoading(false)
  }

  const handleForgotPassword = () => {
    setUsernameError('')
    setPasswordError('')
    if (!username.trim()) {
      setUsernameError('Isi username dulu sebelum reset password.')
      return
    }

    const nextAttempts = forgotAttempts + 1
    setForgotAttempts(nextAttempts)
    if (nextAttempts >= 3) {
      setShowResetPassword(true)
      setMessageType('error')
      setError('Silakan buat password baru untuk akun ini.')
    } else {
      setMessageType('error')
      setError(`Permintaan lupa password tercatat ${nextAttempts}/3.`)
    }
  }

  const handleResetPassword = async (e) => {
    e.preventDefault()
    if (!username.trim()) {
      setMessageType('error')
      return setError('Username wajib diisi.')
    }
    if (newPassword.length < 6) {
      setMessageType('error')
      return setError('Password baru minimal 6 karakter.')
    }
    if (newPassword !== confirmPassword) {
      setMessageType('error')
      return setError('Konfirmasi password belum sama.')
    }

    setResetLoading(true)
    setError('')
    setUsernameError('')
    setPasswordError('')
    try {
      await api.post('/reset-password', {
        username,
        password: newPassword,
        password_confirmation: confirmPassword,
      })
      setPassword('')
      setNewPassword('')
      setConfirmPassword('')
      setForgotAttempts(0)
      setShowResetPassword(false)
      setMessageType('success')
      setError('Password berhasil diperbarui. Silakan login dengan password baru.')
    } catch (e) {
      setMessageType('error')
      setError(getApiErrorMessage(e, 'Gagal memperbarui password.'))
    } finally {
      setResetLoading(false)
    }
  }

  return (
    <main className="login-page">
      <section className="login-brand-panel">
        <div className="login-brand-lockup">
          <div className="brand-mark">
            <img src={sultanCellLogoRound} alt="Sultan Cell" />
          </div>
          <div>
            <h1>Sultan <span>Cell</span></h1>
            <p className="brand-kicker">Konter HP & Agen BRILink</p>
          </div>
        </div>

        <div className="login-copy">
          <h2>Sistem Operasional <span>Sultan Cell</span></h2>
          <p>Kelola kasir, stok barang, dan transaksi harian dengan lebih mudah dan rapi.</p>
        </div>

        <div className="login-feature-grid">
          <div className="login-feature-card">
            <div className="login-feature-icon blue"><ReceiptText size={23} /></div>
            <div>
              <strong>Penjualan</strong>
              <span>Transaksi kasir cepat dan mudah</span>
            </div>
          </div>
          <div className="login-feature-card">
            <div className="login-feature-icon green"><WalletCards size={23} /></div>
            <div>
              <strong>BRILink</strong>
              <span>Pengelolaan transfer, tarik tunai, setor tunai, tagihan</span>
            </div>
          </div>
          <div className="login-feature-card">
            <div className="login-feature-icon purple"><Package size={23} /></div>
            <div>
              <strong>Stok Barang</strong>
              <span>Kelola stok barang secara real-time</span>
            </div>
          </div>
          <div className="login-feature-card">
            <div className="login-feature-icon orange"><BarChart3 size={23} /></div>
            <div>
              <strong>Laporan</strong>
              <span>Laporan penjualan dan transaksi harian</span>
            </div>
          </div>
        </div>

        <p className="login-copyright login-copyright-left">© 2026 Sultan Cell - Konter HP & Agen BRILink</p>
      </section>

      <section className="login-form-panel" aria-label="Form login">
        <div className="login-card">
          <div className="login-welcome">
            <h2>Selamat Datang!</h2>
            <p>Silakan masuk untuk membuka dashboard operasional.</p>
          </div>

          <form onSubmit={showResetPassword ? handleResetPassword : handleSubmit} className="login-form" noValidate>
            {error && <div className={`form-error animate-fadeIn ${messageType === 'success' ? 'success' : ''}`}>{error}</div>}
            <label className="field-group">
              <span>Username</span>
              <div className={`input-with-icon ${usernameError ? 'has-error' : ''}`}>
                <User size={20} />
                <input type="text" value={username} onChange={e => { setUsername(e.target.value); setUsernameError('') }} placeholder="Masukkan username" required />
              </div>
              {usernameError && <p className="field-warning animate-fadeIn">{usernameError}</p>}
            </label>

            {showResetPassword ? (
              <>
                <label className="field-group">
                  <span>Password Baru</span>
                  <div className={`input-with-icon ${error ? 'has-error' : ''}`}>
                    <LockKeyhole size={19} />
                    <input type="password" value={newPassword} onChange={e => setNewPassword(e.target.value)} placeholder="Minimal 6 karakter" required />
                  </div>
                </label>
                <label className="field-group">
                  <span>Konfirmasi Password</span>
                  <div className={`input-with-icon ${error ? 'has-error' : ''}`}>
                    <LockKeyhole size={19} />
                    <input type="password" value={confirmPassword} onChange={e => setConfirmPassword(e.target.value)} placeholder="Ulangi password baru" required />
                  </div>
                </label>
                <button type="submit" disabled={resetLoading} className="primary-login-button">
                  <ShieldCheck size={19} />
                  {resetLoading ? 'Memperbarui...' : 'Perbarui Password'}
                </button>
                <button type="button" className="reset-cancel-button" onClick={() => { setShowResetPassword(false); setForgotAttempts(0); setError('') }}>
                  Kembali ke login
                </button>
              </>
            ) : (
              <>
                <label className="field-group">
                  <span>Password</span>
                  <div className={`password-field input-with-icon ${passwordError ? 'has-error' : ''}`}>
                    <LockKeyhole size={19} />
                    <input type={showPassword ? 'text' : 'password'} value={password} onChange={e => { setPassword(e.target.value); setPasswordError('') }} placeholder="Masukkan password" required />
                    <button type="button" onClick={() => setShowPassword(!showPassword)} aria-label={showPassword ? 'Sembunyikan password' : 'Tampilkan password'}>
                      {showPassword ? <EyeOff size={19} /> : <Eye size={19} />}
                    </button>
                  </div>
                  {passwordError && <p className="field-warning animate-fadeIn">{passwordError}</p>}
                </label>
                <div className="login-options">
                  <label>
                    <input type="checkbox" defaultChecked />
                    <span>Ingat saya</span>
                  </label>
                  <button type="button" onClick={handleForgotPassword}>Lupa password?</button>
                </div>
                <button type="submit" disabled={loading} className="primary-login-button">
                  <LogIn size={19} />
                  {loading ? 'Memproses...' : 'Masuk'}
                </button>
              </>
            )}
            <div className="login-divider"><span>atau</span></div>
            <div className="login-admin-note">
              <ShieldCheck size={18} />
              <span>Hanya admin yang dapat mengakses sistem.</span>
            </div>
          </form>

        </div>
      </section>
    </main>
  )
}
