<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Barang;
use App\Models\BiayaAdmin;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        User::create([
            'name' => 'Admin Sultan Cell',
            'email' => 'admin',
            'password' => Hash::make('admin123'),
        ]);

        $barang = [
            ['kode_barang' => 'HP001', 'nama_barang' => 'iPhone 13', 'kategori' => 'HP', 'stok' => 10, 'harga_beli' => 8000000, 'harga_jual' => 9500000],
            ['kode_barang' => 'HP002', 'nama_barang' => 'Samsung S23', 'kategori' => 'HP', 'stok' => 8, 'harga_beli' => 9000000, 'harga_jual' => 10500000],
            ['kode_barang' => 'HP003', 'nama_barang' => 'Xiaomi 14', 'kategori' => 'HP', 'stok' => 12, 'harga_beli' => 5000000, 'harga_jual' => 6200000],
            ['kode_barang' => 'AK001', 'nama_barang' => 'Charger Type-C', 'kategori' => 'Aksesoris', 'stok' => 25, 'harga_beli' => 50000, 'harga_jual' => 85000],
            ['kode_barang' => 'AK002', 'nama_barang' => 'Softcase iPhone', 'kategori' => 'Aksesoris', 'stok' => 3, 'harga_beli' => 25000, 'harga_jual' => 50000],
            ['kode_barang' => 'AK003', 'nama_barang' => 'Tempered Glass', 'kategori' => 'Aksesoris', 'stok' => 30, 'harga_beli' => 10000, 'harga_jual' => 25000],
            ['kode_barang' => 'AK004', 'nama_barang' => 'Earphone Bluetooth', 'kategori' => 'Aksesoris', 'stok' => 15, 'harga_beli' => 75000, 'harga_jual' => 120000],
            ['kode_barang' => 'KR001', 'nama_barang' => 'Kartu Perdana Telkomsel', 'kategori' => 'Kartu', 'stok' => 50, 'harga_beli' => 5000, 'harga_jual' => 10000],
            ['kode_barang' => 'KR002', 'nama_barang' => 'Kartu Perdana XL', 'kategori' => 'Kartu', 'stok' => 2, 'harga_beli' => 5000, 'harga_jual' => 10000],
        ];

        foreach ($barang as $item) {
            Barang::create($item);
        }

        $rangeAdmin = [
            ['min' => 1, 'max' => 100000, 'biaya' => 2000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 5000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 10000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 15000],
            ['min' => 2000001, 'max' => null, 'biaya' => 20000],
        ];

        $biayaAdmin = [
            ['layanan' => 'transfer', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdmin],
            ['layanan' => 'tarik_tunai', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdmin],
            ['layanan' => 'setor_tunai', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdmin],
            ['layanan' => 'tagihan', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdmin],
            ['layanan' => 'pulsa', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdmin],
            ['layanan' => 'paket_data', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdmin],
        ];

        foreach ($biayaAdmin as $item) {
            BiayaAdmin::create($item);
        }
    }
}
