import React from 'react'
import { Routes, Route, Navigate } from 'react-router-dom'
import { useAuth } from './hooks/useAuth'
import Layout from './components/Layout/Layout'
import Login from './pages/Login'
import Dashboard from './pages/Dashboard'
import DataBarang from './pages/DataBarang'
import TransaksiPenjualan from './pages/TransaksiPenjualan'
import LaporanPenjualan from './pages/LaporanPenjualan'
import Transfer from './pages/Transfer'
import TarikTunai from './pages/TarikTunai'
import SetorTunai from './pages/SetorTunai'
import Tabungan from './pages/Tabungan'
import PembayaranTagihan from './pages/PembayaranTagihan'
import PulsaPaketData from './pages/PulsaPaketData'
import RiwayatBrilink from './pages/RiwayatBrilink'
import PengaturanBiayaAdmin from './pages/PengaturanBiayaAdmin'

function PrivateRoute({ children }) {
  const { token } = useAuth()
  return token ? children : <Navigate to="/login" />
}

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/" element={<PrivateRoute><Layout /></PrivateRoute>}>
        <Route index element={<Navigate to="/dashboard" />} />
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="barang" element={<DataBarang />} />
        <Route path="transaksi-penjualan" element={<TransaksiPenjualan />} />
        <Route path="laporan-penjualan" element={<LaporanPenjualan />} />
        <Route path="transfer" element={<Transfer />} />
        <Route path="tarik-tunai" element={<TarikTunai />} />
        <Route path="setor-tunai" element={<SetorTunai />} />
        <Route path="tabungan" element={<Tabungan />} />
        <Route path="tagihan" element={<PembayaranTagihan />} />
        <Route path="pulsa" element={<PulsaPaketData />} />
        <Route path="riwayat-brilink" element={<RiwayatBrilink />} />
        <Route path="biaya-admin" element={<PengaturanBiayaAdmin />} />
      </Route>
      <Route path="*" element={<Navigate to="/login" />} />
    </Routes>
  )
}
