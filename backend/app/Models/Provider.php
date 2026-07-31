<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Provider extends Model
{
    protected $fillable = [
        'nama_provider',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public const DEFAULT_PROVIDERS = [
        'BRILink Mobile',
        'BRIMO Agen',
        'Fastpay',
        'Payfazz',
        'Mitra Bukalapak',
        'Digipos',
        'Kiosbank',
        'Finnet',
    ];

    public static function ensureDefaults(): void
    {
        foreach (self::DEFAULT_PROVIDERS as $provider) {
            self::updateOrCreate(
                ['nama_provider' => $provider],
                ['is_active' => true]
            );
        }
    }
}
