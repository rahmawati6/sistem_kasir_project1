<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    private array $tables = [
        'transaksi_transfer',
        'transaksi_tarik_tunai',
        'transaksi_setor_tunai',
        'pembayaran_tagihan',
        'transaksi_pulsa',
    ];

    public function up(): void
    {
        foreach ($this->tables as $tableName) {
            Schema::table($tableName, function (Blueprint $table) {
                $table->enum('jenis_nasabah', ['internal', 'eksternal'])->default('internal')->after('tanggal');
                $table->string('jenis_kartu')->default('Kartu Nasabah')->after('jenis_nasabah');
            });
        }
    }

    public function down(): void
    {
        foreach ($this->tables as $tableName) {
            Schema::table($tableName, function (Blueprint $table) {
                $table->dropColumn(['jenis_nasabah', 'jenis_kartu']);
            });
        }
    }
};
