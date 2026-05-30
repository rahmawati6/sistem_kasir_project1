import React, { useState } from 'react'
import { Outlet } from 'react-router-dom'
import Sidebar from './Sidebar'
import Header from './Header'
import { useAuth } from '../../hooks/useAuth'

export default function Layout() {
  const [sidebarOpen, setSidebarOpen] = useState(true)
  const { user, logout } = useAuth()
  return (
    <div className="app-shell">
      <Sidebar isOpen={sidebarOpen} toggleSidebar={() => setSidebarOpen(!sidebarOpen)} onLogout={logout} />
      <div className="app-content">
        <Header user={user} />
        <main className="app-main">
          <div className="page-transition"><Outlet /></div>
        </main>
      </div>
    </div>
  )
}
