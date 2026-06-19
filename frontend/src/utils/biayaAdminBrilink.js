import { getJenisKartuNasabah, getLabelJenisNasabah, rangeBiayaAdminNasabah } from './brilinkNasabah'

export const layananBiayaAdminBrilink = [
  { key: 'transfer', label: 'Transfer', usesNasabah: true },
  { key: 'tarik_tunai', label: 'Tarik Tunai', usesNasabah: true },
  { key: 'setor_tunai', label: 'Setor Tunai', usesNasabah: true },
  { key: 'tagihan', label: 'Pembayaran Tagihan', usesNasabah: true },
  { key: 'pulsa_paket_data', label: 'Pulsa & Paket Data', usesNasabah: true },
  { key: 'ewallet', label: 'Top Up / Cair E-Wallet', usesNasabah: false },
]

export const nasabahBiayaAdminSections = [
  { key: 'internal', title: 'Nasabah Internal', subtitle: 'Kartu Nasabah' },
  { key: 'eksternal', title: 'Nasabah Eksternal', subtitle: 'Kartu Konter' },
]

export const getLayananBiayaAdmin = (jenisTransaksi) => (
  layananBiayaAdminBrilink.find(layanan => layanan.key === jenisTransaksi)
)

export const usesNasabahBiayaAdmin = (jenisTransaksi) => (
  Boolean(getLayananBiayaAdmin(jenisTransaksi)?.usesNasabah)
)

export const getDefaultBiayaAdminRanges = (jenisTransaksi, jenisNasabah = null) => {
  if (!usesNasabahBiayaAdmin(jenisTransaksi)) return rangeBiayaAdminNasabah.ewallet
  return rangeBiayaAdminNasabah[jenisNasabah] || rangeBiayaAdminNasabah.internal
}

export const normalizeBiayaAdminRange = (range) => ({
  id: range.id,
  nominal_min: Number(range.nominal_min ?? range.min) || 0,
  nominal_max: range.nominal_max ?? (Number.isFinite(range.max) ? range.max : ''),
  biaya_admin: Number(range.biaya_admin ?? range.biaya) || 0,
  aktif: range.aktif ?? true,
})

export const createFallbackBiayaAdminRows = (jenisTransaksi, jenisNasabah = null) => (
  getDefaultBiayaAdminRanges(jenisTransaksi, jenisNasabah).map(range => ({
    ...normalizeBiayaAdminRange(range),
    jenis_transaksi: jenisTransaksi,
    jenis_nasabah: usesNasabahBiayaAdmin(jenisTransaksi) ? jenisNasabah : null,
    jenis_kartu: usesNasabahBiayaAdmin(jenisTransaksi) ? getJenisKartuNasabah(jenisNasabah) : null,
  }))
)

export const isSameBiayaAdminGroup = (row, jenisTransaksi, jenisNasabah = null) => (
  row.jenis_transaksi === jenisTransaksi
  && (jenisNasabah === null ? !row.jenis_nasabah : row.jenis_nasabah === jenisNasabah)
)

export const sortBiayaAdminRanges = (ranges) => (
  [...ranges].sort((a, b) => Number(a.nominal_min) - Number(b.nominal_min))
)

export const createBiayaAdminSection = (rows, jenisTransaksi, jenisNasabah = null) => {
  const sectionRows = sortBiayaAdminRanges(
    rows.filter(row => isSameBiayaAdminGroup(row, jenisTransaksi, jenisNasabah))
  )
  const sourceRows = sectionRows.length
    ? sectionRows
    : createFallbackBiayaAdminRows(jenisTransaksi, jenisNasabah)

  return {
    jenisTransaksi,
    jenisNasabah,
    ranges: sourceRows.map(normalizeBiayaAdminRange),
    title: jenisNasabah ? getLabelJenisNasabah(jenisNasabah) : 'Range E-Wallet',
    subtitle: jenisNasabah ? getJenisKartuNasabah(jenisNasabah) : 'Tanpa jenis nasabah dan kartu',
  }
}
