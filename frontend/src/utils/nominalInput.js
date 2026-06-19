export const cleanNominalInput = (value) => String(value ?? '').replace(/[^\d]/g, '')

export const parseNominalInput = (value) => Number(cleanNominalInput(value) || 0)

export const formatNominalInput = (value) => {
  const cleaned = cleanNominalInput(value)
  if (!cleaned) return ''
  return new Intl.NumberFormat('id-ID').format(Number(cleaned))
}
