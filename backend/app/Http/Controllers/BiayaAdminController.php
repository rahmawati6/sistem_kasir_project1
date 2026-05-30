<?php

namespace App\Http\Controllers;

use App\Models\BiayaAdmin;
use Illuminate\Http\Request;

class BiayaAdminController extends Controller
{
    public function index()
    {
        return response()->json(BiayaAdmin::all());
    }

    public function update(Request $request, $layanan)
    {
        $request->validate([
            'jenis_biaya' => 'required|in:persen,nominal,range',
            'nilai' => 'required|numeric|min:0',
            'aturan_range' => 'nullable|array',
            'aturan_range.*.min' => 'required_with:aturan_range|numeric|min:0',
            'aturan_range.*.max' => 'nullable|numeric|min:0',
            'aturan_range.*.biaya' => 'required_with:aturan_range|numeric|min:0',
        ]);

        $biaya = BiayaAdmin::where('layanan', $layanan)->first();
        if (!$biaya) {
            return response()->json(['message' => 'Layanan tidak ditemukan'], 404);
        }

        $biaya->update([
            'jenis_biaya' => $request->jenis_biaya,
            'nilai' => $request->nilai,
            'aturan_range' => $request->jenis_biaya === 'range'
                ? ($request->aturan_range ?: BiayaAdmin::defaultRange())
                : null,
            'is_active' => $request->boolean('is_active', true),
        ]);
        return response()->json($biaya);
    }
}
