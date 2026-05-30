<?php

namespace App\Http\Controllers;

use App\Models\TabunganCustomer;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;

class TabunganCustomerController extends Controller
{
    public function index()
    {
        return response()->json(TabunganCustomer::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_customer' => 'required',
            'nomor_hp' => 'required',
            'nominal' => 'required|numeric|min:1',
        ]);

        $lastTabungan = TabunganCustomer::where('nomor_hp', $request->nomor_hp)
            ->orderBy('created_at', 'desc')->first();
        $saldoSebelum = $lastTabungan ? $lastTabungan->saldo_sesudah : 0;

        $data = $request->all();
        $data['kode_tabungan'] = 'TAB-' . date('Ymd') . '-' . strtoupper(Str::random(6));
        $data['tanggal'] = Carbon::today();
        $data['saldo_sebelum'] = $saldoSebelum;
        $data['saldo_sesudah'] = $saldoSebelum + $request->nominal;
        $data['kasir'] = 'admin';

        return response()->json(TabunganCustomer::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(TabunganCustomer::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $t = TabunganCustomer::findOrFail($id);
        $t->update($request->all());
        return response()->json($t);
    }

    public function destroy($id)
    {
        TabunganCustomer::findOrFail($id)->delete();
        return response()->json(['message' => 'Data tabungan berhasil dihapus']);
    }
}
