<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PembayaranQris extends Model
{
    protected $table = 'pembayaran_qris';
    protected $fillable = [
        'order_id', 'transaksi_penjualan_id', 'nominal',
        'snap_token', 'status_pembayaran', 'transaction_id', 'payment_response'
    ];

    protected $casts = [
        'payment_response' => 'array',
    ];

    public function transaksi()
    {
        return $this->belongsTo(TransaksiPenjualan::class, 'transaksi_penjualan_id');
    }
}
