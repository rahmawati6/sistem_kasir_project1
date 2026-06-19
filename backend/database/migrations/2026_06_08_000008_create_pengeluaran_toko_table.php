<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pengeluaran_toko', function (Blueprint $table) {
            $table->id();
            $table->date('tanggal');
            $table->string('kategori');
            $table->string('nama_pengeluaran');
            $table->decimal('nominal', 15, 2);
            $table->text('keterangan')->nullable();
            $table->string('kasir')->default('admin');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pengeluaran_toko');
    }
};
