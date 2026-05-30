<?php

namespace App\Http\Controllers;

use App\Models\TransaksiTarikTunai;
use App\Models\BiayaAdmin;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;

class TarikTunaiController extends Controller
{
    public function index()
    {
        return response()->json(TransaksiTarikTunai::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'nomor_rekening' => 'required',
            'nama_penerima' => 'required',
            'nomor_hp' => 'required',
            'nominal_tarik' => 'required|numeric|min:1',
        ]);

        $adminFee = BiayaAdmin::hitung('tarik_tunai', (float) $request->nominal_tarik, 5000);

        $data = $request->all();
        $data['kode_transaksi'] = 'TT-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $data['tanggal'] = Carbon::today();
        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $request->nominal_tarik + $adminFee;
        $data['kasir'] = 'admin';

        return response()->json(TransaksiTarikTunai::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(TransaksiTarikTunai::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $t = TransaksiTarikTunai::findOrFail($id);
        $t->update($request->all());
        return response()->json($t);
    }

    public function destroy($id)
    {
        TransaksiTarikTunai::findOrFail($id)->delete();
        return response()->json(['message' => 'Transaksi tarik tunai berhasil dihapus']);
    }
}
