<?php

namespace App\Http\Controllers;

use App\Models\TransaksiSetorTunai;
use App\Models\BiayaAdmin;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;

class SetorTunaiController extends Controller
{
    public function index()
    {
        return response()->json(TransaksiSetorTunai::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'jenis_setoran' => 'required|in:biasa,tabungan',
            'nominal_setor' => 'required|numeric|min:1',
        ]);

        $adminFee = BiayaAdmin::hitung('setor_tunai', (float) $request->nominal_setor, 5000);

        $data = $request->all();
        $data['kode_transaksi'] = 'ST-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $data['tanggal'] = Carbon::today();
        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $request->nominal_setor + $adminFee;
        $data['kasir'] = 'admin';

        return response()->json(TransaksiSetorTunai::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(TransaksiSetorTunai::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $s = TransaksiSetorTunai::findOrFail($id);
        $s->update($request->all());
        return response()->json($s);
    }

    public function destroy($id)
    {
        TransaksiSetorTunai::findOrFail($id)->delete();
        return response()->json(['message' => 'Transaksi setor tunai berhasil dihapus']);
    }
}
