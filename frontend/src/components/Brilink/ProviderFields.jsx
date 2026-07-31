import React, { useEffect, useState } from 'react'
import api from '../../services/api'

export const FALLBACK_PROVIDER_OPTIONS = [
  'BRILink Mobile',
  'BRIMO Agen',
  'Fastpay',
  'Payfazz',
  'Mitra Bukalapak',
  'Digipos',
  'Kiosbank',
  'Finnet',
]

export const normalizeProvider = (form) => {
  if (form.provider !== 'Lainnya') return form.provider
  return (form.nama_provider || '').trim()
}

export default function ProviderFields({ form, setForm }) {
  const [providers, setProviders] = useState(FALLBACK_PROVIDER_OPTIONS)

  useEffect(() => {
    let mounted = true

    api.get('/providers')
      .then(res => {
        const options = Array.isArray(res.data)
          ? res.data.map(item => item.nama_provider).filter(Boolean)
          : []
        if (mounted && options.length > 0) setProviders(options)
      })
      .catch(() => {
        if (mounted) setProviders(FALLBACK_PROVIDER_OPTIONS)
      })

    return () => { mounted = false }
  }, [])

  const options = [...providers, 'Lainnya']

  return (
    <>
      <label className="field-group">
        <span>Provider</span>
        <select
          value={form.provider}
          onChange={e => setForm({ ...form, provider: e.target.value, nama_provider: '' })}
          required
        >
          {options.map(provider => (
            <option key={provider}>{provider}</option>
          ))}
        </select>
      </label>
      {form.provider === 'Lainnya' && (
        <label className="field-group">
          <span>Nama Provider</span>
          <input
            type="text"
            value={form.nama_provider || ''}
            onChange={e => setForm({ ...form, nama_provider: e.target.value })}
            required
            placeholder="Masukkan nama provider"
          />
        </label>
      )}
    </>
  )
}
