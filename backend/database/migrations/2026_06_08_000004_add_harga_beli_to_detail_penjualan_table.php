<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('detail_penjualan', function (Blueprint $table) {
            if (!Schema::hasColumn('detail_penjualan', 'harga_beli_satuan')) {
                $table->decimal('harga_beli_satuan', 15, 2)->default(0)->after('harga_satuan');
            }
        });
    }

    public function down(): void
    {
        Schema::table('detail_penjualan', function (Blueprint $table) {
            if (Schema::hasColumn('detail_penjualan', 'harga_beli_satuan')) {
                $table->dropColumn('harga_beli_satuan');
            }
        });
    }
};
