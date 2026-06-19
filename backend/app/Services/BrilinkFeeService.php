<?php

namespace App\Services;

use App\Models\BiayaAdminBrilink;

class BrilinkFeeService
{
    public static function withNasabahFee(array $data, string $jenisTransaksi, string $nominalField): array
    {
        $nominal = (float) $data[$nominalField];
        $adminFee = BiayaAdminBrilink::hitung($jenisTransaksi, $nominal, $data['jenis_nasabah']);

        $data['jenis_kartu'] = BiayaAdminBrilink::jenisKartuNasabah($data['jenis_nasabah']);
        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $nominal + $adminFee;

        return $data;
    }

    public static function withNominalFee(array $data, string $jenisTransaksi, string $nominalField): array
    {
        $nominal = (float) $data[$nominalField];
        $adminFee = BiayaAdminBrilink::hitung($jenisTransaksi, $nominal);

        $data['biaya_admin'] = $adminFee;
        $data['total_bayar'] = $nominal + $adminFee;

        return $data;
    }

    public static function adminFeeFrom(array $data): float
    {
        return (float) ($data['biaya_admin'] ?? 0);
    }
}
