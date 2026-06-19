<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('retur_penjualan', function (Blueprint $table) {
            $table->id();
            $table->foreignId('transaksi_penjualan_id')->constrained('transaksi_penjualan')->cascadeOnDelete();
            $table->foreignId('detail_penjualan_id')->constrained('detail_penjualan')->cascadeOnDelete();
            $table->foreignId('barang_id')->constrained('barang')->cascadeOnDelete();
            $table->string('kode_retur')->unique();
            $table->integer('jumlah');
            $table->decimal('nilai_retur', 15, 2)->default(0);
            $table->text('alasan')->nullable();
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('retur_penjualan');
    }
};
