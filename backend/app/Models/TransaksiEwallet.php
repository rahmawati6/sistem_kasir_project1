<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransaksiEwallet extends Model
{
    protected $table = 'transaksi_ewallet';
    protected $fillable = [
        'kode_transaksi', 'tanggal', 'jenis_transaksi', 'provider', 'jenis_ewallet',
        'nomor_ewallet', 'nama_customer', 'nominal', 'biaya_admin',
        'total_bayar', 'keterangan', 'status', 'kasir',
    ];
}
