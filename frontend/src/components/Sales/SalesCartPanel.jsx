import React from 'react'
import { Minus, Plus, ReceiptText, ShoppingCart, Trash2 } from 'lucide-react'
import { formatRupiah } from '../../utils/formatRupiah'

export default function SalesCartPanel({
  cart,
  totalHarga,
  totalItems,
  onCheckout,
  onRemove,
  onUpdateQty,
}) {
  return (
    <aside className="cart-panel">
      <div className="cart-header">
        <div>
          <span>Keranjang</span>
          <h2>{totalItems} item</h2>
        </div>
        <ShoppingCart size={23} />
      </div>

      <div className="cart-list">
        {cart.length === 0 ? (
          <div className="cart-empty">
            <ShoppingCart size={42} />
            <p>Keranjang kosong</p>
            <span>Pilih produk atau scan barcode untuk mulai.</span>
          </div>
        ) : cart.map(item => (
          <div key={item.id} className="cart-item">
            <div className="cart-item-main">
              <strong>{item.nama_barang}</strong>
              <span>{formatRupiah(item.harga_jual)} x {item.jumlah}</span>
            </div>
            <div className="qty-control">
              <button onClick={() => onUpdateQty(item.id, item.jumlah - 1)}><Minus size={16} /></button>
              <span>{item.jumlah}</span>
              <button onClick={() => onUpdateQty(item.id, item.jumlah + 1)}><Plus size={16} /></button>
            </div>
            <strong className="cart-subtotal">{formatRupiah(Number(item.harga_jual) * item.jumlah)}</strong>
            <button onClick={() => onRemove(item.id)} className="remove-cart"><Trash2 size={17} /></button>
          </div>
        ))}
      </div>

      <div className="cart-footer">
        <div className="cart-total">
          <span>Total Bayar</span>
          <strong>{formatRupiah(totalHarga)}</strong>
        </div>
        <button onClick={onCheckout} disabled={cart.length === 0} className="checkout-button">
          <ReceiptText size={19} />
          <span>Lanjut Pembayaran</span>
        </button>
      </div>
    </aside>
  )
}
