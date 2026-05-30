export function formatRupiah(angka) {
  if (angka === null || angka === undefined) return 'Rp 0'
  const number = typeof angka === 'string' ? parseFloat(angka) : angka
  return 'Rp ' + number.toLocaleString('id-ID')
}
