import React from 'react'

export default function Textarea({ className = '', ...props }) {
  return <textarea className={`ui-textarea ${className}`.trim()} {...props} />
}
