<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transaksi_penjualan', function (Blueprint $table) {
            $table->id();
            $table->string('kode_transaksi')->unique();
            $table->date('tanggal');
            $table->enum('metode_pembayaran', ['tunai', 'qris']);
            $table->enum('status', ['pending', 'lunas', 'batal'])->default('pending');
            $table->decimal('total_harga', 15, 2);
            $table->decimal('uang_bayar', 15, 2)->nullable();
            $table->decimal('kembalian', 15, 2)->nullable();
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('transaksi_penjualan');
    }
};
