<?php

namespace App\Http\Controllers;

use App\Models\TransaksiTransfer;
use App\Models\BiayaAdmin;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;

class TransferController extends Controller
{
    public function index()
    {
        return response()->json(TransaksiTransfer::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'jenis_transfer' => 'required',
            'nomor_rekening_tujuan' => 'required',
            'nama_penerima' => 'required',
            'nominal_transfer' => 'required|numeric|min:1',
        ]);

        $adminFee = BiayaAdmin::hitung('transfer', (float) $request->nominal_transfer, 6500);

        $data = $request->all();
        $data['kode_transaksi'] = 'TRF-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $data['tanggal'] = Carbon::today();
        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $request->nominal_transfer + $adminFee;
        $data['kasir'] = 'admin';

        return response()->json(TransaksiTransfer::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(TransaksiTransfer::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $t = TransaksiTransfer::findOrFail($id);
        $t->update($request->all());
        return response()->json($t);
    }

    public function destroy($id)
    {
        TransaksiTransfer::findOrFail($id)->delete();
        return response()->json(['message' => 'Transaksi transfer berhasil dihapus']);
    }
}
