import React from 'react'
import { X } from 'lucide-react'

export default function Modal({ isOpen, onClose, title, children, size = 'md' }) {
  if (!isOpen) return null
  const sizes = { sm: 'modal-sm', md: 'modal-md', lg: 'modal-lg', xl: 'modal-xl' }
  return (
    <div className="modal-root">
      <div className="modal-backdrop" onClick={onClose} />
      <div className={`modal-dialog ${sizes[size]}`}>
        <div className="modal-header">
          <h2>{title}</h2>
          <button onClick={onClose} aria-label="Tutup modal"><X size={20} /></button>
        </div>
        <div className="modal-body">{children}</div>
      </div>
    </div>
  )
}
