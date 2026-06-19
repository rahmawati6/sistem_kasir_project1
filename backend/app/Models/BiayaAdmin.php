<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BiayaAdmin extends Model
{
    protected $table = 'biaya_admin';
    protected $fillable = ['layanan', 'jenis_nasabah', 'jenis_biaya', 'nilai', 'aturan_range', 'is_active'];

    protected $casts = [
        'aturan_range' => 'array',
        'is_active' => 'boolean',
    ];

    public static function hitung(string $layanan, float $nominal, float $default = 0): float
    {
        $biaya = self::where('layanan', $layanan)->where('is_active', true)->first();

        if (!$biaya) {
            return $default;
        }

        if ($biaya->jenis_biaya === 'persen') {
            return round($nominal * ((float) $biaya->nilai / 100));
        }

        if ($biaya->jenis_biaya === 'range') {
            return self::hitungRange($nominal, $biaya->aturan_range, $default);
        }

        return (float) $biaya->nilai;
    }

    public static function defaultRange(): array
    {
        return self::rangeNasabahInternal();
    }

    public static function jenisKartuNasabah(string $jenisNasabah): string
    {
        return $jenisNasabah === 'eksternal' ? 'Kartu Konter' : 'Kartu Nasabah';
    }

    public static function hitungNasabah(string $jenisNasabah, float $nominal): float
    {
        $jenisNasabah = $jenisNasabah === 'eksternal' ? 'eksternal' : 'internal';
        $biaya = self::query()
            ->where('layanan', 'brilink')
            ->where('jenis_nasabah', $jenisNasabah)
            ->where('is_active', true)
            ->first();

        $ranges = $biaya?->aturan_range ?: self::rangeNasabah($jenisNasabah);

        return self::hitungRange($nominal, $ranges, 0);
    }

    public static function rangeNasabah(string $jenisNasabah): array
    {
        return $jenisNasabah === 'eksternal'
            ? self::rangeNasabahEksternal()
            : self::rangeNasabahInternal();
    }

    public static function rangeNasabahInternal(): array
    {
        return [
            ['min' => 1, 'max' => 100000, 'biaya' => 2000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 5000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 10000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 15000],
            ['min' => 2000001, 'max' => null, 'biaya' => 20000],
        ];
    }

    public static function rangeNasabahEksternal(): array
    {
        return [
            ['min' => 1, 'max' => 100000, 'biaya' => 5000],
            ['min' => 100001, 'max' => 500000, 'biaya' => 8000],
            ['min' => 500001, 'max' => 1000000, 'biaya' => 12000],
            ['min' => 1000001, 'max' => 2000000, 'biaya' => 18000],
            ['min' => 2000001, 'max' => null, 'biaya' => 25000],
        ];
    }

    private static function hitungRange(float $nominal, ?array $rules, float $default): float
    {
        $ranges = count($rules ?? []) ? $rules : self::defaultRange();

        usort($ranges, fn($a, $b) => (float) ($a['min'] ?? 0) <=> (float) ($b['min'] ?? 0));

        foreach ($ranges as $range) {
            $min = (float) ($range['min'] ?? 0);
            $maxValue = $range['max'] ?? null;
            $max = $maxValue === null || $maxValue === '' ? null : (float) $maxValue;
            $fee = (float) ($range['biaya'] ?? 0);

            if ($nominal >= $min && ($max === null || $nominal <= $max)) {
                return $fee;
            }
        }

        return (float) $default;
    }
}
