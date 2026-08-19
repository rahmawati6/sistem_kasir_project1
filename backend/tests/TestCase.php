<?php

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\DB;
use RuntimeException;

abstract class TestCase extends BaseTestCase
{
    use CreatesApplication, DatabaseTransactions;

    private const TEST_DATABASE = 'sistem_project1_test';

    protected function setUp(): void
    {
        $this->guardConfiguredDatabaseBeforeLaravelBoots();
        parent::setUp();

        $database = DB::connection()->getDatabaseName();
        if ($database !== self::TEST_DATABASE) {
            throw new RuntimeException("Automated test dibatalkan karena database aktif adalah {$database}, bukan ".self::TEST_DATABASE.'.');
        }
    }

    private function guardConfiguredDatabaseBeforeLaravelBoots(): void
    {
        $candidates = array_unique(array_filter([
            getenv('DB_DATABASE'),
            $_ENV['DB_DATABASE'] ?? null,
            $_SERVER['DB_DATABASE'] ?? null,
        ], fn ($value) => $value !== false && $value !== null && $value !== ''));

        foreach ($candidates as $database) {
            if ($database !== self::TEST_DATABASE) {
                throw new RuntimeException("Automated test dibatalkan sebelum Laravel boot karena DB_DATABASE adalah {$database}, bukan ".self::TEST_DATABASE.'.');
            }
        }

        $configCache = dirname(__DIR__).'/bootstrap/cache/config.php';
        if (is_file($configCache)) {
            $cachedConfig = require $configCache;
            $connection = $cachedConfig['database']['default'] ?? null;
            $cachedDatabase = $cachedConfig['database']['connections'][$connection]['database'] ?? null;
            if ($cachedDatabase !== self::TEST_DATABASE) {
                throw new RuntimeException('Automated test dibatalkan sebelum Laravel boot karena config cache tidak menunjuk ke database test.');
            }
        }
    }
}
