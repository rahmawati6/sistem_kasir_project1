import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import api, { getApiErrorMessage } from '../services/api'

const notifyAuthChanged = () => window.dispatchEvent(new Event('auth-token-changed'))

export function useAuth() {
  const [token, setToken] = useState(localStorage.getItem('token'))
  const [user, setUser] = useState(null)
  const navigate = useNavigate()

  useEffect(() => { if (token) fetchUser() }, [token])

  useEffect(() => {
    const syncToken = () => {
      const nextToken = localStorage.getItem('token')
      setToken(nextToken)
      if (!nextToken) setUser(null)
    }
    window.addEventListener('auth-token-changed', syncToken)
    window.addEventListener('storage', syncToken)

    return () => {
      window.removeEventListener('auth-token-changed', syncToken)
      window.removeEventListener('storage', syncToken)
    }
  }, [])

  const fetchUser = async () => {
    try {
      const res = await api.get('/me')
      setUser(res.data)
    } catch (e) {
      localStorage.removeItem('token')
      setToken(null)
      setUser(null)
      notifyAuthChanged()
    }
  }

  const login = async (username, password) => {
    try {
      const res = await api.post('/login', { username, password })
      localStorage.setItem('token', res.data.token)
      setToken(res.data.token)
      setUser(res.data.user)
      notifyAuthChanged()
      navigate('/dashboard')
      return { success: true }
    } catch (e) {
      return { success: false, message: getApiErrorMessage(e, 'Login gagal') }
    }
  }

  const logout = async () => {
    try { await api.post('/logout') } catch (e) {}
    localStorage.removeItem('token')
    setToken(null)
    setUser(null)
    notifyAuthChanged()
    navigate('/login')
  }

  return { token, user, login, logout }
}
