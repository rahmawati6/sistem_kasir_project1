import React from 'react'

export default function Button({ className = '', variant = 'primary', children, ...props }) {
  return (
    <button className={`ui-button ${variant} ${className}`.trim()} {...props}>
      {children}
    </button>
  )
}
