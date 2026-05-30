<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TransaksiPenjualan;
use App\Models\DetailPenjualan;
use App\Models\Barang;
use Carbon\Carbon;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;

class PenjualanController extends Controller
{
    public function index()
    {
        return response()->json(
            TransaksiPenjualan::with('details')->orderBy('created_at', 'desc')->get()
        );
    }

    public function store(Request $request)
    {
        $request->validate([
            'items' => 'required|array|min:1',
            'metode_pembayaran' => 'required|in:tunai,qris',
            'uang_bayar' => 'required_if:metode_pembayaran,tunai|nullable|numeric'
        ]);

        $kodeTransaksi = 'TRX-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $totalHarga = collect($request->items)->sum(function($item) {
            return $item['harga_jual'] * $item['jumlah'];
        });

        $transaksi = TransaksiPenjualan::create([
            'kode_transaksi' => $kodeTransaksi,
            'tanggal' => Carbon::today(),
            'metode_pembayaran' => $request->metode_pembayaran,
            'status' => 'lunas',
            'total_harga' => $totalHarga,
            'uang_bayar' => $request->uang_bayar,
            'kembalian' => $request->uang_bayar ? $request->uang_bayar - $totalHarga : null,
            'kasir' => 'admin'
        ]);

        foreach ($request->items as $item) {
            DetailPenjualan::create([
                'transaksi_penjualan_id' => $transaksi->id,
                'barang_id' => $item['id'],
                'kode_barang' => $item['kode_barang'],
                'nama_barang' => $item['nama_barang'],
                'jumlah' => $item['jumlah'],
                'harga_satuan' => $item['harga_jual'],
                'subtotal' => $item['harga_jual'] * $item['jumlah']
            ]);

            $barang = Barang::find($item['id']);
            $barang->stok -= $item['jumlah'];
            $barang->save();
        }

        $transaksi->load('details');

        return response()->json([
            'transaksi' => $transaksi,
            'message' => 'Transaksi berhasil'
        ]);
    }

    public function qris(Request $request)
    {
        $request->validate([
            'items' => 'required|array|min:1',
        ]);

        $serverKey = config('services.midtrans.server_key');
        if (!$serverKey) {
            return response()->json([
                'message' => 'MIDTRANS_SERVER_KEY belum diisi di file .env backend.'
            ], 422);
        }

        $totalHarga = collect($request->items)->sum(function($item) {
            return $item['harga_jual'] * $item['jumlah'];
        });

        $orderId = 'QRIS-' . date('YmdHis') . '-' . strtoupper(Str::random(5));
        $baseUrl = rtrim(config('services.midtrans.base_url'), '/');
        $payload = [
            'payment_type' => 'qris',
            'transaction_details' => [
                'order_id' => $orderId,
                'gross_amount' => (int) round($totalHarga),
            ],
            'item_details' => collect($request->items)->map(function($item) {
                return [
                    'id' => (string) $item['kode_barang'],
                    'price' => (int) round($item['harga_jual']),
                    'quantity' => (int) $item['jumlah'],
                    'name' => substr($item['nama_barang'], 0, 50),
                ];
            })->values()->all(),
        ];

        $response = Http::withBasicAuth($serverKey, '')
            ->acceptJson()
            ->post($baseUrl . '/v2/charge', $payload);

        if (!$response->successful()) {
            return response()->json([
                'message' => $response->json('status_message') ?: 'Gagal membuat QRIS Midtrans.',
                'midtrans' => $response->json(),
            ], $response->status());
        }

        $body = $response->json();
        $qrisUrl = collect($body['actions'] ?? [])->firstWhere('name', 'generate-qr-code')['url'] ?? null;

        return response()->json([
            'order_id' => $orderId,
            'qris_url' => $qrisUrl,
            'gross_amount' => (int) round($totalHarga),
            'midtrans' => $body,
        ]);
    }

    public function invoice($id)
    {
        return response()->json(
            TransaksiPenjualan::with('details')->findOrFail($id)
        );
    }
}
