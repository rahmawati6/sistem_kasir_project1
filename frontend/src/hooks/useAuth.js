import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../services/api'

export function useAuth() {
  const [token, setToken] = useState(localStorage.getItem('token'))
  const [user, setUser] = useState(null)
  const navigate = useNavigate()

  useEffect(() => { if (token) fetchUser() }, [token])

  const fetchUser = async () => {
    try {
      const res = await api.get('/me')
      setUser(res.data)
    } catch (e) {
      localStorage.removeItem('token')
      setToken(null)
    }
  }

  const login = async (username, password) => {
    try {
      const res = await api.post('/login', { username, password })
      localStorage.setItem('token', res.data.token)
      setToken(res.data.token)
      setUser(res.data.user)
      navigate('/dashboard')
      return { success: true }
    } catch (e) {
      return { success: false, message: e.response?.data?.message || 'Login gagal' }
    }
  }

  const logout = async () => {
    try { await api.post('/logout') } catch (e) {}
    localStorage.removeItem('token')
    setToken(null)
    setUser(null)
    navigate('/login')
  }

  return { token, user, login, logout }
}
