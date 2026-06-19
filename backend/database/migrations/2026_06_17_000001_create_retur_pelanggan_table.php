<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('retur_pelanggan', function (Blueprint $table) {
            $table->id();
            $table->string('nomor_retur')->unique();
            $table->foreignId('transaksi_penjualan_id')->nullable()->constrained('transaksi_penjualan')->nullOnDelete();
            $table->foreignId('detail_penjualan_id')->nullable()->constrained('detail_penjualan')->nullOnDelete();
            $table->foreignId('barang_id')->nullable()->constrained('barang')->nullOnDelete();
            $table->string('kode_transaksi');
            $table->string('kode_barang');
            $table->string('nama_barang');
            $table->integer('jumlah_dibeli');
            $table->integer('jumlah_retur');
            $table->string('alasan_retur');
            $table->string('metode_pengembalian_dana');
            $table->text('keterangan')->nullable();
            $table->date('tanggal_retur');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('retur_pelanggan');
    }
};
