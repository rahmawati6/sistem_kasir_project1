<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('transaksi_penjualan', function (Blueprint $table) {
            if (!Schema::hasColumn('transaksi_penjualan', 'alasan_batal')) {
                $table->text('alasan_batal')->nullable()->after('kasir');
            }
            if (!Schema::hasColumn('transaksi_penjualan', 'dibatalkan_pada')) {
                $table->timestamp('dibatalkan_pada')->nullable()->after('alasan_batal');
            }
        });
    }

    public function down(): void
    {
        Schema::table('transaksi_penjualan', function (Blueprint $table) {
            if (Schema::hasColumn('transaksi_penjualan', 'dibatalkan_pada')) {
                $table->dropColumn('dibatalkan_pada');
            }
            if (Schema::hasColumn('transaksi_penjualan', 'alasan_batal')) {
                $table->dropColumn('alasan_batal');
            }
        });
    }
};
