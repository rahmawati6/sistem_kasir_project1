<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transaksi_transfer', function (Blueprint $table) {
            $table->id();
            $table->string('kode_transaksi')->unique();
            $table->date('tanggal');
            $table->string('jenis_transfer');
            $table->string('nomor_rekening_tujuan');
            $table->string('nama_penerima');
            $table->decimal('nominal_transfer', 15, 2);
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
        Schema::dropIfExists('transaksi_transfer');
    }
};
