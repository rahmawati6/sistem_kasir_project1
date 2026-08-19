<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('notifikasi', function (Blueprint $table) {
            $table->unsignedInteger('id', true);
            $table->unsignedInteger('user_id');
            $table->string('tipe', 50);
            $table->string('judul', 150);
            $table->text('pesan');
            $table->string('referensi_tipe', 100)->nullable();
            $table->unsignedInteger('referensi_id')->nullable();
            $table->string('url', 255)->nullable();
            $table->string('fingerprint', 191);
            $table->timestamp('dibaca_at')->nullable();
            $table->timestamps();

            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->cascadeOnDelete();

            $table->unique(['user_id', 'fingerprint'], 'notifikasi_user_fingerprint_unique');
            $table->index(['user_id', 'dibaca_at', 'created_at'], 'notifikasi_user_read_created_index');
            $table->index(['referensi_tipe', 'referensi_id'], 'notifikasi_referensi_index');
            $table->index('tipe', 'notifikasi_tipe_index');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notifikasi');
    }
};
