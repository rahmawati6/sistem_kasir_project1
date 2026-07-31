<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PembayaranTagihan extends Model
{
    protected $table = 'pembayaran_tagihan';
    protected $fillable = [
        'kode_transaksi', 'tanggal', 'provider', 'jenis_layanan', 'nomor_pelanggan',
        'nama_pelanggan', 'jenis_nasabah', 'jenis_kartu', 'jumlah_tagihan', 'biaya_admin', 'total_bayar',
        'status', 'kasir'
    ];
    protected $casts = ['tanggal' => 'date'];
}
