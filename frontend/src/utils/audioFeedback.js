export const playScanBeep = () => {
  const AudioContext = window.AudioContext || window.webkitAudioContext
  if (!AudioContext) return

  const ctx = new AudioContext()
  const oscillator = ctx.createOscillator()
  const gain = ctx.createGain()

  oscillator.type = 'square'
  oscillator.frequency.value = 1180
  gain.gain.setValueAtTime(0.0001, ctx.currentTime)
  gain.gain.exponentialRampToValueAtTime(0.08, ctx.currentTime + 0.01)
  gain.gain.exponentialRampToValueAtTime(0.0001, ctx.currentTime + 0.11)
  oscillator.connect(gain)
  gain.connect(ctx.destination)
  oscillator.start()
  oscillator.stop(ctx.currentTime + 0.12)
}
