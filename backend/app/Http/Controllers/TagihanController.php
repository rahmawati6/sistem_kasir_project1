<?php

namespace App\Http\Controllers;

use App\Models\PembayaranTagihan;
use App\Models\BiayaAdmin;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;

class TagihanController extends Controller
{
    public function index()
    {
        return response()->json(PembayaranTagihan::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'jenis_layanan' => 'required|in:pln,pdam,bpjs,indihome,angsuran,lainnya',
            'nomor_pelanggan' => 'required',
            'nama_pelanggan' => 'required',
            'jumlah_tagihan' => 'required|numeric|min:1',
        ]);

        $adminFee = BiayaAdmin::hitung('tagihan', (float) $request->jumlah_tagihan, 2500);

        $data = $request->all();
        $data['kode_transaksi'] = 'TAG-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $data['tanggal'] = Carbon::today();
        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $request->jumlah_tagihan + $adminFee;
        $data['kasir'] = 'admin';

        return response()->json(PembayaranTagihan::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(PembayaranTagihan::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $t = PembayaranTagihan::findOrFail($id);
        $t->update($request->all());
        return response()->json($t);
    }

    public function destroy($id)
    {
        PembayaranTagihan::findOrFail($id)->delete();
        return response()->json(['message' => 'Data tagihan berhasil dihapus']);
    }
}
