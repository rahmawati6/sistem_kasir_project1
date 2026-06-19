import { parseNominalInput } from './nominalInput'

export const jenisNasabahOptions = [
  { value: 'internal', label: 'Nasabah Internal' },
  { value: 'eksternal', label: 'Nasabah Eksternal' },
]

export const getJenisKartuNasabah = (jenisNasabah) => (
  jenisNasabah === 'eksternal' ? 'Kartu Konter' : 'Kartu Nasabah'
)

export const getLabelJenisNasabah = (jenisNasabah) => (
  jenisNasabah === 'eksternal' ? 'Nasabah Eksternal' : 'Nasabah Internal'
)

export const rangeBiayaAdminNasabah = {
  internal: [
    { min: 1, max: 100000, biaya: 2000 },
    { min: 100001, max: 500000, biaya: 5000 },
    { min: 500001, max: 1000000, biaya: 10000 },
    { min: 1000001, max: 2000000, biaya: 15000 },
    { min: 2000001, max: Infinity, biaya: 20000 },
  ],
  eksternal: [
    { min: 1, max: 100000, biaya: 5000 },
    { min: 100001, max: 500000, biaya: 8000 },
    { min: 500001, max: 1000000, biaya: 12000 },
    { min: 1000001, max: 2000000, biaya: 18000 },
    { min: 2000001, max: Infinity, biaya: 25000 },
  ],
  ewallet: [
    { min: 1, max: 100000, biaya: 2000 },
    { min: 100001, max: 500000, biaya: 5000 },
    { min: 500001, max: 1000000, biaya: 10000 },
    { min: 1000001, max: 2000000, biaya: 15000 },
    { min: 2000001, max: Infinity, biaya: 20000 },
  ],
}

export const hitungBiayaAdminNasabah = (jenisNasabah, nominalInput) => {
  const nominal = parseNominalInput(nominalInput)
  const ranges = rangeBiayaAdminNasabah[jenisNasabah] || rangeBiayaAdminNasabah.internal

  return ranges.find(range => nominal >= range.min && nominal <= range.max)?.biaya || 0
}
