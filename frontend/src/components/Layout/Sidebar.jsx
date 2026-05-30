import React from 'react'
import { NavLink } from 'react-router-dom'
import { LayoutDashboard, Package, ShoppingCart, FileText, Send, Wallet, HandCoins, Receipt, Smartphone, History, Settings, LogOut, ChevronLeft, ChevronRight, PiggyBank } from 'lucide-react'
import sultanCellLogo from '../../assets/sultan-cell-logo-round.png'

const menuItems = [
  { path: '/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
  { path: '/barang', icon: Package, label: 'Data Barang' },
  { path: '/transaksi-penjualan', icon: ShoppingCart, label: 'Transaksi Penjualan' },
  { path: '/laporan-penjualan', icon: FileText, label: 'Laporan Penjualan' },
  { divider: true, label: 'LAYANAN BRILINK' },
  { path: '/transfer', icon: Send, label: 'Transfer' },
  { path: '/tarik-tunai', icon: Wallet, label: 'Tarik Tunai' },
  { path: '/setor-tunai', icon: HandCoins, label: 'Setor Tunai' },
  { path: '/tabungan', icon: PiggyBank, label: 'Tabungan' },
  { path: '/tagihan', icon: Receipt, label: 'Pembayaran Tagihan' },
  { path: '/pulsa', icon: Smartphone, label: 'Pulsa & Paket Data' },
  { path: '/riwayat-brilink', icon: History, label: 'Riwayat BRILink' },
  { divider: true, label: 'PENGATURAN' },
  { path: '/biaya-admin', icon: Settings, label: 'Biaya Admin' },
]

export default function Sidebar({ isOpen, toggleSidebar, onLogout }) {
  return (
    <aside className={`app-sidebar ${isOpen ? 'sidebar-open' : 'sidebar-closed'}`}>
      <div className="sidebar-brand">
        {isOpen && (
          <div className="sidebar-brand-lockup">
            <div className="sidebar-logo">
              <img src={sultanCellLogo} alt="Sultan Cell" />
            </div>
            <div>
              <span>Sultan Cell</span>
              <p>Agen BRILink</p>
            </div>
          </div>
        )}
        <button onClick={toggleSidebar} className="sidebar-toggle" aria-label={isOpen ? 'Tutup sidebar' : 'Buka sidebar'}>
          {isOpen ? <ChevronLeft size={20} /> : <ChevronRight size={20} />}
        </button>
      </div>
      <nav className="sidebar-nav">
        {menuItems.map((item, index) => {
          if (item.divider) return (
            <div key={index} className="sidebar-divider">
              <div />
              {isOpen && <p>{item.label}</p>}
            </div>
          )
          return (
            <NavLink key={item.path} to={item.path}
              className={({ isActive }) => `sidebar-link ${isActive ? 'active' : ''}`}>
              <item.icon size={20} />
              {isOpen && <span>{item.label}</span>}
            </NavLink>
          )
        })}
      </nav>
      <div className="sidebar-footer">
        <button onClick={onLogout} className="logout-button">
          <LogOut size={20} />
          {isOpen && <span>Logout</span>}
        </button>
      </div>
    </aside>
  )
}
