<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\BarangController;
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\LaporanController;
use App\Http\Controllers\TransferController;
use App\Http\Controllers\TarikTunaiController;
use App\Http\Controllers\SetorTunaiController;
use App\Http\Controllers\TabunganCustomerController;
use App\Http\Controllers\TagihanController;
use App\Http\Controllers\PulsaController;
use App\Http\Controllers\BrilinkController;
use App\Http\Controllers\BiayaAdminController;

// Public routes
Route::post('/login', [AuthController::class, 'login']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);

    // Dashboard
    Route::get('/dashboard', [DashboardController::class, 'index']);

    // Barang
    Route::apiResource('barang', BarangController::class);
    Route::get('/barang-search', [BarangController::class, 'search']);

    // Penjualan
    Route::get('/penjualan', [PenjualanController::class, 'index']);
    Route::post('/penjualan', [PenjualanController::class, 'store']);
    Route::post('/penjualan/qris', [PenjualanController::class, 'qris']);
    Route::get('/penjualan/invoice/{id}', [PenjualanController::class, 'invoice']);

    // Laporan
    Route::get('/laporan/penjualan', [LaporanController::class, 'penjualan']);
    Route::delete('/laporan/penjualan/reset', [LaporanController::class, 'resetPenjualan']);

    // BRILink
    Route::apiResource('transfer', TransferController::class);
    Route::apiResource('tarik-tunai', TarikTunaiController::class);
    Route::apiResource('setor-tunai', SetorTunaiController::class);
    Route::apiResource('tabungan', TabunganCustomerController::class);
    Route::apiResource('tagihan', TagihanController::class);
    Route::apiResource('pulsa', PulsaController::class);

    // Riwayat BRILink
    Route::get('/riwayat-brilink', [BrilinkController::class, 'riwayat']);

    // Biaya Admin
    Route::get('/biaya-admin', [BiayaAdminController::class, 'index']);
    Route::put('/biaya-admin/{layanan}', [BiayaAdminController::class, 'update']);
});
