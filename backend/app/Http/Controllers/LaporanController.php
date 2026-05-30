<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TransaksiPenjualan;
use App\Models\PembayaranQris;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class LaporanController extends Controller
{
    public function penjualan(Request $request)
    {
        $startDate = $request->get('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->get('end_date', Carbon::now()->toDateString());

        $transaksi = TransaksiPenjualan::with('details')
            ->whereBetween('tanggal', [$startDate, $endDate])
            ->where('status', 'lunas')
            ->orderBy('tanggal', 'desc')
            ->get();

        $totalPenjualan = $transaksi->sum('total_harga');
        $totalTransaksi = $transaksi->count();

        $chartData = $transaksi->groupBy(fn($t) => $t->tanggal->format('Y-m-d'))
            ->map(fn($group, $date) => [
                'tanggal' => $date,
                'total' => $group->sum('total_harga'),
                'jumlah' => $group->count(),
            ])->values();

        return response()->json([
            'transaksi' => $transaksi,
            'total_penjualan' => $totalPenjualan,
            'total_transaksi' => $totalTransaksi,
            'chart_data' => $chartData,
        ]);
    }

    public function resetPenjualan(Request $request)
    {
        $request->validate([
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
        ]);

        $startDate = $request->start_date;
        $endDate = $request->end_date;

        $deleted = DB::transaction(function () use ($startDate, $endDate) {
            $ids = TransaksiPenjualan::whereBetween('tanggal', [$startDate, $endDate])->pluck('id');
            $count = $ids->count();

            if ($count === 0) {
                return 0;
            }

            PembayaranQris::whereIn('transaksi_penjualan_id', $ids)->delete();
            TransaksiPenjualan::whereIn('id', $ids)->delete();

            return $count;
        });

        return response()->json([
            'message' => 'Laporan penjualan berhasil direset',
            'deleted' => $deleted,
        ]);
    }
}
