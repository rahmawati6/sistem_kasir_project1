<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tabungan_customer', function (Blueprint $table) {
            $table->id();
            $table->string('kode_tabungan')->unique();
            $table->date('tanggal');
            $table->string('nama_customer');
            $table->string('nomor_hp');
            $table->decimal('nominal', 15, 2);
            $table->decimal('saldo_sebelum', 15, 2)->default(0);
            $table->decimal('saldo_sesudah', 15, 2);
            $table->text('keterangan')->nullable();
            $table->enum('status', ['sukses', 'gagal'])->default('sukses');
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tabungan_customer');
    }
};
