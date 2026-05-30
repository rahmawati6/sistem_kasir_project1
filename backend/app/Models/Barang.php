<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Barang extends Model
{
    protected $table = 'barang';
    protected $fillable = [
        'kode_barang', 'nama_barang', 'kategori', 'stok', 'harga_beli', 'harga_jual'
    ];
}
