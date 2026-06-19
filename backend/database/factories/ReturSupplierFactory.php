<?php

namespace Database\Factories;

use App\Models\Barang;
use App\Models\ReturSupplier;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<ReturSupplier>
 */
class ReturSupplierFactory extends Factory
{
    protected $model = ReturSupplier::class;

    public function definition(): array
    {
        $barang = Barang::query()->inRandomOrder()->first() ?? Barang::create([
            'kode_barang' => 'RETFACT' . $this->faker->unique()->numberBetween(100, 999),
            'nama_barang' => 'Barang Retur Contoh',
            'kategori' => 'Aksesoris',
            'stok' => 10,
            'harga_beli' => 10000,
            'harga_jual' => 15000,
        ]);
        $tanggal = $this->faker->dateTimeBetween('-1 month', 'now');

        return [
            'nomor_retur' => 'RET-' . $tanggal->format('Ymd') . '-' . str_pad((string) $this->faker->unique()->numberBetween(1, 9999), 4, '0', STR_PAD_LEFT),
            'tanggal_retur' => $tanggal->format('Y-m-d'),
            'nama_supplier' => $this->faker->company(),
            'barang_id' => $barang->id,
            'kode_barang' => $barang->kode_barang,
            'nama_barang' => $barang->nama_barang,
            'jumlah_retur' => $this->faker->numberBetween(1, 3),
            'alasan_retur' => $this->faker->randomElement(['Barang rusak', 'Salah kirim', 'Kemasan tidak sesuai']),
            'status_retur' => $this->faker->randomElement(['diproses', 'diterima', 'ditolak']),
            'keterangan' => $this->faker->optional()->sentence(),
            'stok_dikurangi' => false,
            'kasir' => 'admin',
        ];
    }
}
