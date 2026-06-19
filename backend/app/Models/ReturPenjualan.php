<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReturPenjualan extends Model
{
    protected $table = 'retur_penjualan';
    protected $fillable = [
        'transaksi_penjualan_id', 'detail_penjualan_id', 'barang_id',
        'kode_retur', 'jumlah', 'nilai_retur', 'alasan', 'kasir',
    ];

    public function transaksi()
    {
        return $this->belongsTo(TransaksiPenjualan::class, 'transaksi_penjualan_id');
    }

    public function detail()
    {
        return $this->belongsTo(DetailPenjualan::class, 'detail_penjualan_id');
    }

    public function barang()
    {
        return $this->belongsTo(Barang::class);
    }
}
