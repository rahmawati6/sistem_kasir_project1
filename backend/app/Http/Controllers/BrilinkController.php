<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TransaksiTransfer;
use App\Models\TransaksiTarikTunai;
use App\Models\TransaksiSetorTunai;
use App\Models\PembayaranTagihan;
use App\Models\TransaksiPulsa;

class BrilinkController extends Controller
{
    public function riwayat(Request $request)
    {
        $startDate = $request->get('start_date', now()->startOfMonth()->toDateString());
        $endDate = $request->get('end_date', now()->toDateString());
        $jenis = $request->get('jenis', 'semua');

        $data = [];

        if ($jenis === 'semua' || $jenis === 'transfer') {
            $transfers = TransaksiTransfer::whereBetween('tanggal', [$startDate, $endDate])->get()
                ->map(fn($t) => array_merge($t->toArray(), ['jenis' => 'Transfer']));
            $data = array_merge($data, $transfers->toArray());
        }

        if ($jenis === 'semua' || $jenis === 'tarik_tunai') {
            $tarik = TransaksiTarikTunai::whereBetween('tanggal', [$startDate, $endDate])->get()
                ->map(fn($t) => array_merge($t->toArray(), ['jenis' => 'Tarik Tunai']));
            $data = array_merge($data, $tarik->toArray());
        }

        if ($jenis === 'semua' || $jenis === 'setor_tunai') {
            $setor = TransaksiSetorTunai::whereBetween('tanggal', [$startDate, $endDate])->get()
                ->map(fn($t) => array_merge($t->toArray(), ['jenis' => 'Setor Tunai']));
            $data = array_merge($data, $setor->toArray());
        }

        if ($jenis === 'semua' || $jenis === 'tagihan') {
            $tagihan = PembayaranTagihan::whereBetween('tanggal', [$startDate, $endDate])->get()
                ->map(fn($t) => array_merge($t->toArray(), ['jenis' => 'Tagihan']));
            $data = array_merge($data, $tagihan->toArray());
        }

        if ($jenis === 'semua' || $jenis === 'pulsa') {
            $pulsa = TransaksiPulsa::whereBetween('tanggal', [$startDate, $endDate])->get()
                ->map(fn($t) => array_merge($t->toArray(), ['jenis' => 'Pulsa']));
            $data = array_merge($data, $pulsa->toArray());
        }

        usort($data, fn($a, $b) => strtotime($b['created_at']) - strtotime($a['created_at']));

        return response()->json([
            'data' => $data,
            'total_admin' => collect($data)->sum('biaya_admin'),
            'total_transaksi' => count($data),
        ]);
    }
}
