<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransaksiTarikTunai extends Model
{
    protected $table = 'transaksi_tarik_tunai';
    protected $fillable = [
        'kode_transaksi', 'tanggal', 'provider', 'nomor_rekening', 'nama_penerima',
        'nomor_hp', 'jenis_nasabah', 'jenis_kartu', 'nominal_tarik', 'biaya_admin', 'total_bayar',
        'status', 'kasir'
    ];
    protected $casts = ['tanggal' => 'date'];
}
