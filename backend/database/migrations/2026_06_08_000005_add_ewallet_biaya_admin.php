<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $rangeAdmin = json_encode([
            ['min' => 1, 'max' => 100000, 'biaya' => 2000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 5000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 10000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 15000],
            ['min' => 2000001, 'max' => null, 'biaya' => 20000],
        ]);

        DB::table('biaya_admin')->updateOrInsert(
            ['layanan' => 'ewallet'],
            [
                'jenis_biaya' => 'range',
                'nilai' => 0,
                'aturan_range' => $rangeAdmin,
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        );
    }

    public function down(): void
    {
        DB::table('biaya_admin')->where('layanan', 'ewallet')->delete();
    }
};
