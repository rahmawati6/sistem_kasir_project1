<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('biaya_admin', function (Blueprint $table) {
            if (!Schema::hasColumn('biaya_admin', 'aturan_range')) {
                $table->json('aturan_range')->nullable()->after('nilai');
            }
        });

        if (DB::connection()->getDriverName() === 'mysql') {
            DB::statement("ALTER TABLE biaya_admin MODIFY jenis_biaya ENUM('persen','nominal','range') NOT NULL");
        }

        $defaultRange = json_encode([
            ['min' => 1, 'max' => 100000, 'biaya' => 2000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 5000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 10000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 15000],
            ['min' => 2000001, 'max' => null, 'biaya' => 20000],
        ]);

        DB::table('biaya_admin')
            ->whereIn('layanan', ['transfer', 'tarik_tunai', 'setor_tunai', 'tagihan', 'pulsa', 'paket_data'])
            ->update([
                'jenis_biaya' => 'range',
                'nilai' => 0,
                'aturan_range' => $defaultRange,
            ]);
    }

    public function down(): void
    {
        if (DB::connection()->getDriverName() === 'mysql') {
            DB::statement("ALTER TABLE biaya_admin MODIFY jenis_biaya ENUM('persen','nominal') NOT NULL");
        }

        Schema::table('biaya_admin', function (Blueprint $table) {
            if (Schema::hasColumn('biaya_admin', 'aturan_range')) {
                $table->dropColumn('aturan_range');
            }
        });
    }
};
