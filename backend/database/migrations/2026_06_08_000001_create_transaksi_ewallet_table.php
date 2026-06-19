<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transaksi_ewallet', function (Blueprint $table) {
            $table->id();
            $table->string('kode_transaksi')->unique();
            $table->date('tanggal');
            $table->enum('jenis_transaksi', ['top_up', 'pencairan']);
            $table->string('provider');
            $table->string('nomor_ewallet');
            $table->string('nama_customer')->nullable();
            $table->decimal('nominal', 15, 2);
            $table->decimal('biaya_admin', 15, 2)->default(0);
            $table->decimal('total_bayar', 15, 2);
            $table->text('keterangan')->nullable();
            $table->enum('status', ['sukses', 'gagal', 'pending'])->default('sukses');
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('transaksi_ewallet');
    }
};
