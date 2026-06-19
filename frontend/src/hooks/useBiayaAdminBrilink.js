import { useEffect, useState } from 'react'
import api from '../services/api'
import { parseNominalInput } from '../utils/nominalInput'
import { createFallbackBiayaAdminRows, isSameBiayaAdminGroup, sortBiayaAdminRanges } from '../utils/biayaAdminBrilink'

export function useBiayaAdminBrilink() {
  const [rows, setRows] = useState([])

  useEffect(() => {
    let active = true
    api.get('/biaya-admin')
      .then(res => {
        if (!active) return
        setRows(Array.isArray(res.data) ? res.data : res.data.data || [])
      })
      .catch(() => {
        if (active) setRows([])
      })

    return () => { active = false }
  }, [])

  const hitung = (jenisTransaksi, nominalInput, jenisNasabah = null) => {
    const nominal = parseNominalInput(nominalInput)
    const groupRows = rows
      .filter(row => isSameBiayaAdminGroup(row, jenisTransaksi, jenisNasabah))
      .filter(row => row.aktif !== false)
    const ranges = sortBiayaAdminRanges(
      groupRows.length ? groupRows : createFallbackBiayaAdminRows(jenisTransaksi, jenisNasabah)
    )

    return ranges.find(range => {
      const min = Number(range.nominal_min)
      const max = range.nominal_max === null || range.nominal_max === '' ? Infinity : Number(range.nominal_max)
      return nominal >= min && nominal <= max
    })?.biaya_admin || 0
  }

  return { hitung }
}
