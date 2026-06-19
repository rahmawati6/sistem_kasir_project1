<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::dropIfExists('tabungan_customer');
    }

    public function down(): void
    {
        // Tabel tabungan_customer sengaja tidak dibuat ulang karena fitur buku tabungan customer sudah dihapus dari scope.
    }
};
