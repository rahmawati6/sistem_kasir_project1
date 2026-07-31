<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransaksiTransfer extends Model
{
    protected $table = 'transaksi_transfer';
    protected $fillable = [
        'kode_transaksi', 'tanggal', 'provider', 'jenis_transfer', 'bank_tujuan', 'nomor_rekening_tujuan',
        'nama_penerima', 'jenis_nasabah', 'jenis_kartu', 'nominal_transfer', 'biaya_admin', 'total_bayar',
        'keterangan', 'status', 'kasir'
    ];
    protected $casts = ['tanggal' => 'date'];
}
