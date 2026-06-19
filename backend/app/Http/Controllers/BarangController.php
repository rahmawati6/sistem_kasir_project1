<?php

namespace App\Http\Controllers;

use App\Models\Barang;
use App\Models\ActivityLog;
use App\Models\DetailPenjualan;
use Illuminate\Http\Request;

class BarangController extends Controller
{
    public function index()
    {
        return response()->json(Barang::orderBy('created_at', 'desc')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'kode_barang' => 'required|unique:barang',
            'nama_barang' => 'required',
            'kategori' => 'required',
            'stok' => 'required|integer|min:0',
            'harga_beli' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0',
        ]);

        $barang = Barang::create($data);
        ActivityLog::record('Barang', 'create', 'Menambah barang ' . $barang->nama_barang, $barang->toArray());
        return response()->json($barang, 201);
    }

    public function show($id)
    {
        return response()->json(Barang::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $barang = Barang::findOrFail($id);
        $data = $request->validate([
            'kode_barang' => 'required|unique:barang,kode_barang,' . $id,
            'nama_barang' => 'required',
            'kategori' => 'required',
            'stok' => 'required|integer|min:0',
            'harga_beli' => 'required|numeric|min:0',
            'harga_jual' => 'required|numeric|min:0',
        ]);
        $barang->update($data);
        ActivityLog::record('Barang', 'update', 'Memperbarui barang ' . $barang->nama_barang, $barang->toArray());
        return response()->json($barang);
    }

    public function destroy($id)
    {
        $barang = Barang::findOrFail($id);
        if (DetailPenjualan::where('barang_id', $barang->id)->exists()) {
            return response()->json([
                'message' => 'Barang sudah pernah dipakai transaksi, jadi tidak bisa dihapus agar laporan tetap aman.',
            ], 422);
        }

        $nama = $barang->nama_barang;
        $barang->delete();
        ActivityLog::record('Barang', 'delete', 'Menghapus barang ' . $nama);
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

    public function import(Request $request)
    {
        $data = $request->validate([
            'items' => 'required|array|min:1',
            'items.*.kode_barang' => 'required|string',
            'items.*.nama_barang' => 'required|string',
            'items.*.kategori' => 'required|string',
            'items.*.stok' => 'required|integer|min:0',
            'items.*.harga_beli' => 'required|numeric|min:0',
            'items.*.harga_jual' => 'required|numeric|min:0',
        ]);

        $created = 0;
        $updated = 0;

        foreach ($data['items'] as $item) {
            $barang = Barang::where('kode_barang', $item['kode_barang'])->first();
            if ($barang) {
                $barang->update($item);
                $updated++;
            } else {
                Barang::create($item);
                $created++;
            }
        }

        ActivityLog::record('Barang', 'import', "Import barang: {$created} baru, {$updated} diperbarui");

        return response()->json([
            'message' => 'Import barang berhasil',
            'created' => $created,
            'updated' => $updated,
        ]);
    }
}
