<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasColumn('detail_penjualan', 'harga_beli_satuan')) {
            return;
        }

        DB::table('detail_penjualan')
            ->join('barang', 'barang.id', '=', 'detail_penjualan.barang_id')
            ->where(function ($query) {
                $query->whereNull('detail_penjualan.harga_beli_satuan')
                    ->orWhere('detail_penjualan.harga_beli_satuan', 0);
            })
            ->update([
                'detail_penjualan.harga_beli_satuan' => DB::raw('barang.harga_beli'),
            ]);
    }

    public function down(): void
    {
        // Backfill data lama tidak dibalik supaya histori modal transaksi tetap terjaga.
    }
};
