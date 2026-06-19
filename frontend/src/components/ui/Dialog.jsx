import React from 'react'
import Modal from '../Common/Modal'

export function Dialog({ open, onOpenChange, title, children, size = 'md' }) {
  return (
    <Modal isOpen={open} onClose={() => onOpenChange?.(false)} title={title} size={size}>
      {children}
    </Modal>
  )
}

export default Dialog
