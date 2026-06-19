<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('transaksi_transfer', function (Blueprint $table) {
            if (!Schema::hasColumn('transaksi_transfer', 'bank_tujuan')) {
                $table->string('bank_tujuan')->nullable()->after('jenis_transfer');
            }
        });
    }

    public function down(): void
    {
        Schema::table('transaksi_transfer', function (Blueprint $table) {
            if (Schema::hasColumn('transaksi_transfer', 'bank_tujuan')) {
                $table->dropColumn('bank_tujuan');
            }
        });
    }
};
