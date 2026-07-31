<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    private array $defaultProviders = [
        'BRILink Mobile',
        'BRIMO Agen',
        'Fastpay',
        'Payfazz',
        'Mitra Bukalapak',
        'Digipos',
        'Kiosbank',
        'Finnet',
    ];

    public function up(): void
    {
        if (!Schema::hasTable('providers')) {
            Schema::create('providers', function (Blueprint $table) {
                $table->id();
                $table->string('nama_provider', 100)->unique();
                $table->boolean('is_active')->default(true);
                $table->timestamps();
            });
        }

        foreach ($this->defaultProviders as $index => $provider) {
            DB::table('providers')->updateOrInsert(
                ['nama_provider' => $provider],
                [
                    'is_active' => true,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            );
        }

        if (Schema::hasTable('retur_supplier')) {
            DB::table('retur_supplier')
                ->where('nama_supplier', 'Supplier Contoh')
                ->where('alasan_retur', 'Contoh data retur supplier')
                ->delete();
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('providers');
    }
};
