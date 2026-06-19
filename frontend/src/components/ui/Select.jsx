import React from 'react'

export default function Select({ className = '', children, ...props }) {
  return <select className={`ui-select ${className}`.trim()} {...props}>{children}</select>
}
