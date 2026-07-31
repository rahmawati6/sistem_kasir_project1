import React, { Suspense, lazy } from 'react'
import { Routes, Route, Navigate } from 'react-router-dom'
import { useAuth } from './hooks/useAuth'
import Layout from './components/Layout/Layout'

const Login = lazy(() => import('./pages/Login'))
const Dashboard = lazy(() => import('./pages/Dashboard'))
const DataBarang = lazy(() => import('./pages/DataBarang'))
const TransaksiPenjualan = lazy(() => import('./pages/TransaksiPenjualan'))
const LaporanPenjualan = lazy(() => import('./pages/LaporanPenjualan'))
const ReturSupplier = lazy(() => import('./pages/ReturSupplier'))
const ReturBarangPelanggan = lazy(() => import('./pages/ReturBarangPelanggan'))
const Transfer = lazy(() => import('./pages/Transfer'))
const TarikTunai = lazy(() => import('./pages/TarikTunai'))
const SetorTunai = lazy(() => import('./pages/SetorTunai'))
const PembayaranTagihan = lazy(() => import('./pages/PembayaranTagihan'))
const PulsaPaketData = lazy(() => import('./pages/PulsaPaketData'))
const EWallet = lazy(() => import('./pages/EWallet'))
const RiwayatBrilink = lazy(() => import('./pages/RiwayatBrilink'))
const PengaturanBiayaAdmin = lazy(() => import('./pages/PengaturanBiayaAdmin'))
const PengeluaranToko = lazy(() => import('./pages/PengeluaranToko'))
const Pengaturan = lazy(() => import('./pages/Pengaturan'))

function PrivateRoute({ children }) {
  const { token } = useAuth()
  return token ? children : <Navigate to="/login" />
}

function PageLoader() {
  return <div className="dashboard-loading"><div></div><span>Memuat halaman...</span></div>
}

export default function App() {
  return (
    <Suspense fallback={<PageLoader />}>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/" element={<PrivateRoute><Layout /></PrivateRoute>}>
          <Route index element={<Navigate to="/dashboard" />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="barang" element={<DataBarang />} />
          <Route path="transaksi-penjualan" element={<TransaksiPenjualan />} />
          <Route path="laporan-penjualan" element={<LaporanPenjualan />} />
          <Route path="retur-supplier" element={<ReturSupplier />} />
          <Route path="retur-barang-pelanggan" element={<ReturBarangPelanggan />} />
          <Route path="transfer" element={<Transfer />} />
          <Route path="tarik-tunai" element={<TarikTunai />} />
          <Route path="setor-tunai" element={<SetorTunai />} />
          <Route path="tagihan" element={<PembayaranTagihan />} />
          <Route path="pulsa" element={<PulsaPaketData />} />
          <Route path="ewallet" element={<EWallet />} />
          <Route path="riwayat-brilink" element={<RiwayatBrilink />} />
          <Route path="biaya-admin" element={<PengaturanBiayaAdmin />} />
          <Route path="pengaturan" element={<Pengaturan />} />
          <Route path="backup-data" element={<Navigate to="/pengaturan" replace />} />
          <Route path="riwayat-aktivitas" element={<Navigate to="/pengaturan" replace />} />
          <Route path="pengeluaran-toko" element={<PengeluaranToko />} />
        </Route>
        <Route path="*" element={<Navigate to="/login" />} />
      </Routes>
    </Suspense>
  )
}
