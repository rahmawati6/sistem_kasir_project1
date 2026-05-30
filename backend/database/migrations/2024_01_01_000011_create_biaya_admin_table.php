<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('biaya_admin', function (Blueprint $table) {
            $table->id();
            $table->string('layanan');
            $table->enum('jenis_biaya', ['persen', 'nominal', 'range']);
            $table->decimal('nilai', 15, 2);
            $table->json('aturan_range')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('biaya_admin');
    }
};
