<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PengeluaranToko extends Model
{
    protected $table = 'pengeluaran_toko';
    protected $fillable = [
        'tanggal', 'kategori', 'nama_pengeluaran', 'nominal', 'keterangan', 'kasir',
    ];
}
