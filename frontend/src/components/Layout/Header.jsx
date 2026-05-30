import React, { useEffect, useState } from 'react'
import { Bell, User, Calendar, Clock } from 'lucide-react'

export default function Header({ user }) {
  const [now, setNow] = useState(new Date())

  useEffect(() => {
    const timer = setInterval(() => setNow(new Date()), 1000)
    return () => clearInterval(timer)
  }, [])

  const today = now.toLocaleDateString('id-ID', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
  const time = now.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false }).replace(/\./g, ':')

  return (
    <header className="topbar">
      <div className="topbar-date">
        <Calendar size={20} />
        <span>{today}</span>
        <span className="topbar-time-divider"></span>
        <Clock size={18} />
        <span>{time}</span>
      </div>
      <div className="topbar-actions">
        <button className="notification-button" aria-label="Notifikasi">
          <Bell size={20} />
          <span></span>
        </button>
        <div className="user-chip">
          <div className="user-avatar">
            <User size={17} />
          </div>
          <div>
            <p>{user?.name || 'Admin'}</p>
            <span>Administrator</span>
          </div>
        </div>
      </div>
    </header>
  )
}
