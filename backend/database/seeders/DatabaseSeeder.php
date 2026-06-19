<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Barang;
use App\Models\BiayaAdmin;
use App\Models\BiayaAdminBrilink;
use App\Models\ReturSupplier;
use Illuminate\Support\Facades\Schema;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(['email' => 'admin'], [
            'name' => 'Admin Sultan Cell',
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
            Barang::updateOrCreate(['kode_barang' => $item['kode_barang']], $item);
        }

        $rangeAdminInternal = [
            ['min' => 1, 'max' => 100000, 'biaya' => 2000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 5000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 10000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 15000],
            ['min' => 2000001, 'max' => null, 'biaya' => 20000],
        ];

        $rangeAdminEksternal = [
            ['min' => 1, 'max' => 100000, 'biaya' => 5000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 8000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 12000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 18000],
            ['min' => 2000001, 'max' => null, 'biaya' => 25000],
        ];

        $biayaAdmin = [
            ['layanan' => 'transfer', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
            ['layanan' => 'tarik_tunai', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
            ['layanan' => 'setor_tunai', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
            ['layanan' => 'tagihan', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
            ['layanan' => 'pulsa', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
            ['layanan' => 'paket_data', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
            ['layanan' => 'ewallet', 'jenis_biaya' => 'range', 'nilai' => 0, 'aturan_range' => $rangeAdminInternal],
        ];

        foreach ($biayaAdmin as $item) {
            BiayaAdmin::updateOrCreate(['layanan' => $item['layanan']], $item);
        }

        foreach ([
            ['jenis_nasabah' => 'internal', 'aturan_range' => $rangeAdminInternal],
            ['jenis_nasabah' => 'eksternal', 'aturan_range' => $rangeAdminEksternal],
        ] as $item) {
            BiayaAdmin::updateOrCreate(
                ['layanan' => 'brilink', 'jenis_nasabah' => $item['jenis_nasabah']],
                [
                    'jenis_biaya' => 'range',
                    'nilai' => 0,
                    'aturan_range' => $item['aturan_range'],
                    'is_active' => true,
                ]
            );
        }

        if (Schema::hasTable('biaya_admin_brilink')) {
            BiayaAdminBrilink::ensureDefaults();
        }

        if (Schema::hasTable('retur_supplier')) {
            $barangRetur = Barang::where('kode_barang', 'AK002')->first();
            if ($barangRetur) {
                ReturSupplier::updateOrCreate(
                    ['nomor_retur' => 'RET-' . now()->format('Ymd') . '-0001'],
                    [
                        'tanggal_retur' => now()->toDateString(),
                        'nama_supplier' => 'Supplier Contoh',
                        'barang_id' => $barangRetur->id,
                        'kode_barang' => $barangRetur->kode_barang,
                        'nama_barang' => $barangRetur->nama_barang,
                        'jumlah_retur' => 1,
                        'alasan_retur' => 'Contoh data retur supplier',
                        'status_retur' => 'diproses',
                        'keterangan' => 'Stok belum dikurangi sebelum status diterima.',
                        'stok_dikurangi' => false,
                        'kasir' => 'admin',
                    ]
                );
            }
        }
    }
}
