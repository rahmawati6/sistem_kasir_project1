<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::dropIfExists('stok_mutasi');
        Schema::dropIfExists('password_reset_codes');
    }

    public function down(): void
    {
        Schema::create('stok_mutasi', function (Blueprint $table) {
            $table->id();
            $table->foreignId('barang_id')->constrained('barang')->cascadeOnDelete();
            $table->enum('jenis', ['masuk', 'keluar']);
            $table->integer('jumlah');
            $table->string('keterangan')->nullable();
            $table->timestamps();
        });

        Schema::create('password_reset_codes', function (Blueprint $table) {
            $table->id();
            $table->string('username');
            $table->string('code', 12);
            $table->timestamp('expires_at');
            $table->boolean('used')->default(false);
            $table->timestamps();
        });
    }
};
