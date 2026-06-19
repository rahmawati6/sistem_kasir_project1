<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateReturSupplierRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'tanggal_retur' => 'required|date',
            'nama_supplier' => 'required|string|max:150',
            'barang_id' => 'required|exists:barang,id',
            'jumlah_retur' => 'required|integer|min:1',
            'alasan_retur' => 'required|string|min:3',
            'status_retur' => 'required|in:diproses,diterima,ditolak',
            'keterangan' => 'nullable|string',
        ];
    }
}
