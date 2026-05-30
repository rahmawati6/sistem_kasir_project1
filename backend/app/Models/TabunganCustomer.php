<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TabunganCustomer extends Model
{
    protected $table = 'tabungan_customer';
    protected $fillable = [
        'kode_tabungan', 'tanggal', 'nama_customer', 'nomor_hp',
        'nominal', 'saldo_sebelum', 'saldo_sesudah', 'keterangan',
        'status', 'kasir'
    ];
    protected $casts = ['tanggal' => 'date'];
}
