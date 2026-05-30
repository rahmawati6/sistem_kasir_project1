<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transaksi_setor_tunai', function (Blueprint $table) {
            $table->id();
            $table->string('kode_transaksi')->unique();
            $table->date('tanggal');
            $table->enum('jenis_setoran', ['biasa', 'tabungan']);
            $table->string('nomor_rekening_tujuan')->nullable();
            $table->string('nama_pemilik_rekening')->nullable();
            $table->string('bank_tujuan')->nullable();
            $table->decimal('nominal_setor', 15, 2);
            $table->decimal('biaya_admin', 15, 2)->default(0);
            $table->decimal('total_bayar', 15, 2);
            $table->string('sumber_dana')->nullable();
            $table->text('keterangan')->nullable();
            $table->enum('status', ['sukses', 'gagal'])->default('sukses');
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('transaksi_setor_tunai');
    }
};
