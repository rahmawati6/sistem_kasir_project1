<?php

namespace App\Http\Controllers;

use App\Models\Barang;
use Illuminate\Http\Request;

class BarangController extends Controller
{
    public function index()
    {
        return response()->json(Barang::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'kode_barang' => 'required|unique:barang',
            'nama_barang' => 'required',
            'kategori' => 'required',
            'stok' => 'required|integer|min:0',
            'harga_beli' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0',
        ]);

        $barang = Barang::create($request->all());
        return response()->json($barang, 201);
    }

    public function show($id)
    {
        return response()->json(Barang::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $barang = Barang::findOrFail($id);
        $request->validate([
            'kode_barang' => 'required|unique:barang,kode_barang,' . $id,
            'nama_barang' => 'required',
            'kategori' => 'required',
            'stok' => 'required|integer|min:0',
            'harga_beli' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0',
        ]);
        $barang->update($request->all());
        return response()->json($barang);
    }

    public function destroy($id)
    {
        Barang::findOrFail($id)->delete();
        return response()->json(['message' => 'Barang berhasil dihapus']);
    }

    public function search(Request $request)
    {
        $query = Barang::query();
        if ($request->has('q')) {
            $query->where('kode_barang', 'like', "%{$request->q}%")
                  ->orWhere('nama_barang', 'like', "%{$request->q}%");
        }
        return response()->json($query->get());
    }
}
