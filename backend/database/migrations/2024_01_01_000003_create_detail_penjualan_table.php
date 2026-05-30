<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('detail_penjualan', function (Blueprint $table) {
            $table->id();
            $table->foreignId('transaksi_penjualan_id')->constrained('transaksi_penjualan')->cascadeOnDelete();
            $table->foreignId('barang_id')->constrained('barang');
            $table->string('kode_barang');
            $table->string('nama_barang');
            $table->integer('jumlah');
            $table->decimal('harga_satuan', 15, 2);
            $table->decimal('subtotal', 15, 2);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('detail_penjualan');
    }
};
