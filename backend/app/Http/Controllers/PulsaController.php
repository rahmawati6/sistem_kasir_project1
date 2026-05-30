<?php

namespace App\Http\Controllers;

use App\Models\TransaksiPulsa;
use App\Models\BiayaAdmin;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;

class PulsaController extends Controller
{
    public function index()
    {
        return response()->json(TransaksiPulsa::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'operator' => 'required',
            'jenis_layanan' => 'required|in:pulsa,paket_data',
            'nomor_tujuan' => 'required',
            'produk' => 'required',
            'harga' => 'required|numeric|min:1',
        ]);

        $layanan = $request->jenis_layanan === 'pulsa' ? 'pulsa' : 'paket_data';
        $adminFee = BiayaAdmin::hitung($layanan, (float) $request->harga, 1500);

        $data = $request->all();
        $data['kode_transaksi'] = 'PLS-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $data['tanggal'] = Carbon::today();
        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $request->harga + $adminFee;
        $data['kasir'] = 'admin';

        return response()->json(TransaksiPulsa::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(TransaksiPulsa::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $p = TransaksiPulsa::findOrFail($id);
        $p->update($request->all());
        return response()->json($p);
    }

    public function destroy($id)
    {
        TransaksiPulsa::findOrFail($id)->delete();
        return response()->json(['message' => 'Transaksi pulsa berhasil dihapus']);
    }
}
