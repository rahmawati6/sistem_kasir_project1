<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pembayaran_tagihan', function (Blueprint $table) {
            $table->id();
            $table->string('kode_transaksi')->unique();
            $table->date('tanggal');
            $table->enum('jenis_layanan', ['pln', 'pdam', 'bpjs', 'indihome', 'angsuran', 'lainnya']);
            $table->string('nomor_pelanggan');
            $table->string('nama_pelanggan');
            $table->decimal('jumlah_tagihan', 15, 2);
            $table->decimal('biaya_admin', 15, 2)->default(0);
            $table->decimal('total_bayar', 15, 2);
            $table->enum('status', ['sukses', 'gagal'])->default('sukses');
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pembayaran_tagihan');
    }
};
