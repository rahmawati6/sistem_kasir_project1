<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('retur_supplier', function (Blueprint $table) {
            $table->id();
            $table->string('nomor_retur')->unique();
            $table->date('tanggal_retur');
            $table->string('nama_supplier');
            $table->foreignId('barang_id')->constrained('barang');
            $table->string('kode_barang');
            $table->string('nama_barang');
            $table->integer('jumlah_retur');
            $table->text('alasan_retur');
            $table->enum('status_retur', ['diproses', 'diterima', 'ditolak'])->default('diproses');
            $table->text('keterangan')->nullable();
            $table->boolean('stok_dikurangi')->default(false);
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('retur_supplier');
    }
};
