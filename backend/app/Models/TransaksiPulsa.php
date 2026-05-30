<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransaksiPulsa extends Model
{
    protected $table = 'transaksi_pulsa';
    protected $fillable = [
        'kode_transaksi', 'tanggal', 'operator', 'jenis_layanan',
        'nomor_tujuan', 'produk', 'harga', 'biaya_admin', 'total_bayar',
        'status', 'kasir'
    ];
    protected $casts = ['tanggal' => 'date'];
}
