<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pembayaran_qris', function (Blueprint $table) {
            $table->id();
            $table->string('order_id')->unique();
            $table->foreignId('transaksi_penjualan_id')->constrained('transaksi_penjualan');
            $table->decimal('nominal', 15, 2);
            $table->string('snap_token')->nullable();
            $table->enum('status_pembayaran', ['pending', 'settlement', 'expire', 'cancel'])->default('pending');
            $table->string('transaction_id')->nullable();
            $table->json('payment_response')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pembayaran_qris');
    }
};
