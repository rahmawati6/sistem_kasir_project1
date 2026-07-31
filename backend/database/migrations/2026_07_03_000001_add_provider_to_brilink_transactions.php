<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        $tables = [
            'transaksi_transfer',
            'transaksi_tarik_tunai',
            'transaksi_setor_tunai',
            'pembayaran_tagihan',
            'transaksi_pulsa',
        ];

        foreach ($tables as $tableName) {
            if (Schema::hasTable($tableName) && !Schema::hasColumn($tableName, 'provider')) {
                Schema::table($tableName, function (Blueprint $table) {
                    $table->string('provider', 100)->default('BRILink Mobile')->after('tanggal');
                });
            }
        }

        if (Schema::hasTable('transaksi_ewallet') && !Schema::hasColumn('transaksi_ewallet', 'jenis_ewallet')) {
            Schema::table('transaksi_ewallet', function (Blueprint $table) {
                $table->string('jenis_ewallet', 100)->nullable()->after('provider');
            });

            DB::table('transaksi_ewallet')->whereNull('jenis_ewallet')->update([
                'jenis_ewallet' => DB::raw('provider'),
            ]);

            DB::table('transaksi_ewallet')
                ->whereIn('provider', ['DANA', 'OVO', 'GoPay', 'ShopeePay', 'LinkAja'])
                ->update(['provider' => 'BRILink Mobile']);
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('transaksi_ewallet') && Schema::hasColumn('transaksi_ewallet', 'jenis_ewallet')) {
            Schema::table('transaksi_ewallet', function (Blueprint $table) {
                $table->dropColumn('jenis_ewallet');
            });
        }

        $tables = [
            'transaksi_transfer',
            'transaksi_tarik_tunai',
            'transaksi_setor_tunai',
            'pembayaran_tagihan',
            'transaksi_pulsa',
        ];

        foreach ($tables as $tableName) {
            if (Schema::hasTable($tableName) && Schema::hasColumn($tableName, 'provider')) {
                Schema::table($tableName, function (Blueprint $table) {
                    $table->dropColumn('provider');
                });
            }
        }
    }
};
