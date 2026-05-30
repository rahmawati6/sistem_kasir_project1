<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transaksi_pulsa', function (Blueprint $table) {
            $table->id();
            $table->string('kode_transaksi')->unique();
            $table->date('tanggal');
            $table->string('operator');
            $table->enum('jenis_layanan', ['pulsa', 'paket_data']);
            $table->string('nomor_tujuan');
            $table->string('produk');
            $table->decimal('harga', 15, 2);
            $table->decimal('biaya_admin', 15, 2)->default(0);
            $table->decimal('total_bayar', 15, 2);
            $table->enum('status', ['sukses', 'gagal'])->default('sukses');
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('transaksi_pulsa');
    }
};
