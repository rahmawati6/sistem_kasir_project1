<?php

use App\Models\BiayaAdmin;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('biaya_admin', function (Blueprint $table) {
            if (!Schema::hasColumn('biaya_admin', 'jenis_nasabah')) {
                $table->enum('jenis_nasabah', ['internal', 'eksternal'])->nullable()->after('layanan');
                $table->index(['layanan', 'jenis_nasabah']);
            }
        });

        foreach (['internal', 'eksternal'] as $jenisNasabah) {
            DB::table('biaya_admin')->updateOrInsert(
                ['layanan' => 'brilink', 'jenis_nasabah' => $jenisNasabah],
                [
                    'jenis_biaya' => 'range',
                    'nilai' => 0,
                    'aturan_range' => json_encode(BiayaAdmin::rangeNasabah($jenisNasabah)),
                    'is_active' => true,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            );
        }
    }

    public function down(): void
    {
        DB::table('biaya_admin')->where('layanan', 'brilink')->whereIn('jenis_nasabah', ['internal', 'eksternal'])->delete();

        Schema::table('biaya_admin', function (Blueprint $table) {
            if (Schema::hasColumn('biaya_admin', 'jenis_nasabah')) {
                $table->dropIndex(['layanan', 'jenis_nasabah']);
                $table->dropColumn('jenis_nasabah');
            }
        });
    }
};
