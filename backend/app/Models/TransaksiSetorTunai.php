<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransaksiSetorTunai extends Model
{
    protected $table = 'transaksi_setor_tunai';
    protected $fillable = [
        'kode_transaksi', 'tanggal', 'jenis_setoran', 'nomor_rekening_tujuan',
        'nama_pemilik_rekening', 'bank_tujuan', 'jenis_nasabah', 'jenis_kartu', 'nominal_setor', 'biaya_admin',
        'total_bayar', 'sumber_dana', 'keterangan', 'status', 'kasir'
    ];
    protected $casts = ['tanggal' => 'date'];
}
