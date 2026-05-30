<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TransaksiPenjualan;
use App\Models\Barang;
use App\Models\TransaksiTransfer;
use App\Models\TransaksiTarikTunai;
use App\Models\TransaksiSetorTunai;
use App\Models\PembayaranTagihan;
use App\Models\TransaksiPulsa;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index()
    {
        $today = Carbon::today();

        $totalPenjualanHariIni = TransaksiPenjualan::whereDate('tanggal', $today)
            ->where('status', 'lunas')
            ->sum('total_harga');

        $transferHariIni = TransaksiTransfer::whereDate('tanggal', $today)->count();
        $tarikTunaiHariIni = TransaksiTarikTunai::whereDate('tanggal', $today)->count();
        $setorTunaiHariIni = TransaksiSetorTunai::whereDate('tanggal', $today)->count();
        $tagihanHariIni = PembayaranTagihan::whereDate('tanggal', $today)->count();
        $pulsaHariIni = TransaksiPulsa::whereDate('tanggal', $today)->count();

        $totalTransaksiBrilink = $transferHariIni + $tarikTunaiHariIni + $setorTunaiHariIni + $tagihanHariIni + $pulsaHariIni;

        $totalAdminFee = TransaksiTransfer::whereDate('tanggal', $today)->sum('biaya_admin') +
                         TransaksiTarikTunai::whereDate('tanggal', $today)->sum('biaya_admin') +
                         TransaksiSetorTunai::whereDate('tanggal', $today)->sum('biaya_admin') +
                         PembayaranTagihan::whereDate('tanggal', $today)->sum('biaya_admin') +
                         TransaksiPulsa::whereDate('tanggal', $today)->sum('biaya_admin');

        $stokMenipis = Barang::where('stok', '<', 5)->get();

        $transaksiTerbaru = TransaksiPenjualan::with('details')
            ->orderBy('created_at', 'desc')
            ->limit(5)
            ->get();

        return response()->json([
            'total_penjualan_hari_ini' => $totalPenjualanHariIni,
            'total_transaksi_brilink' => $totalTransaksiBrilink,
            'total_keuntungan_admin' => $totalAdminFee,
            'stok_menipis' => $stokMenipis,
            'transaksi_terbaru' => $transaksiTerbaru,
        ]);
    }
}
