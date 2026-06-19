import React from 'react'
import { getJenisKartuNasabah, jenisNasabahOptions } from '../../utils/brilinkNasabah'

export default function NasabahKartuFields({ value, onChange }) {
  return (
    <>
      <label className="field-group">
        <span>Jenis Nasabah</span>
        <select value={value} onChange={e => onChange(e.target.value)}>
          {jenisNasabahOptions.map(option => <option key={option.value} value={option.value}>{option.label}</option>)}
        </select>
      </label>
      <label className="field-group">
        <span>Jenis Kartu</span>
        <input type="text" value={getJenisKartuNasabah(value)} readOnly />
      </label>
    </>
  )
}
