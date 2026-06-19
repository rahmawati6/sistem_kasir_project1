<?php

namespace App\Http\Controllers;

use App\Models\ActivityLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class BackupController extends Controller
{
    private array $tables = [
        'barang', 'transaksi_penjualan', 'detail_penjualan', 'pembayaran_qris', 'transaksi_transfer',
        'transaksi_tarik_tunai', 'transaksi_setor_tunai',
        'pembayaran_tagihan', 'transaksi_pulsa', 'transaksi_ewallet',
        'biaya_admin', 'biaya_admin_brilink', 'activity_logs', 'pengeluaran_toko',
        'retur_penjualan', 'retur_pelanggan', 'retur_supplier',
    ];

    private array $jsonColumns = [
        'pembayaran_qris' => ['payment_response'],
        'biaya_admin' => ['aturan_range'],
        'activity_logs' => ['properties'],
    ];

    private array $optionalRestoreTables = [
        'retur_supplier',
        'retur_pelanggan',
    ];

    public function download()
    {
        $payload = [
            'app' => 'Sultan Cell',
            'backup_at' => now()->toDateTimeString(),
            'tables' => [],
        ];

        foreach ($this->tables as $table) {
            if (Schema::hasTable($table)) {
                $payload['tables'][$table] = DB::table($table)->get();
            }
        }

        ActivityLog::record('Backup', 'download', 'Mengunduh backup data website');

        return response()->json($payload);
    }

    public function restore(Request $request)
    {
        $request->validate([
            'backup' => 'required|array',
            'confirm_text' => 'required|in:RESTORE SULTAN CELL',
        ]);

        $tables = $request->input('backup.tables');
        if (!is_array($tables)) {
            return response()->json(['message' => 'Format backup tidak valid.'], 422);
        }

        $existingTables = array_values(array_filter(
            $this->tables,
            fn(string $table) => Schema::hasTable($table)
        ));
        $missingTables = array_values(array_diff($existingTables, array_keys($tables), $this->optionalRestoreTables));

        if (!empty($missingTables)) {
            return response()->json([
                'message' => 'File backup tidak lengkap. Tabel berikut tidak ada: ' . implode(', ', $missingTables),
            ], 422);
        }

        DB::transaction(function () use ($tables) {
            $this->disableForeignKeyChecks();

            try {
                foreach (array_reverse($this->tables) as $table) {
                    if (Schema::hasTable($table) && array_key_exists($table, $tables)) {
                        DB::table($table)->truncate();
                    }
                }

                foreach ($this->tables as $table) {
                    if (!Schema::hasTable($table) || !array_key_exists($table, $tables)) {
                        continue;
                    }

                    $rows = json_decode(json_encode($tables[$table]), true) ?: [];
                    foreach (array_chunk($rows, 200) as $chunk) {
                        if (!empty($chunk)) {
                            DB::table($table)->insert($this->normalizeRowsForRestore($table, $chunk));
                        }
                    }
                }
            } finally {
                $this->enableForeignKeyChecks();
            }
        });

        ActivityLog::record('Backup', 'restore', 'Restore backup data website');

        return response()->json(['message' => 'Restore backup berhasil']);
    }

    private function normalizeRowsForRestore(string $table, array $rows): array
    {
        $jsonColumns = $this->jsonColumns[$table] ?? [];
        $tableColumns = array_flip(Schema::getColumnListing($table));

        return array_map(function (array $row) use ($jsonColumns, $tableColumns) {
            $row = array_intersect_key($row, $tableColumns);

            foreach ($jsonColumns as $column) {
                if (!array_key_exists($column, $row) || $row[$column] === null || is_string($row[$column])) {
                    continue;
                }

                $row[$column] = json_encode($row[$column]);
            }

            return $row;
        }, $rows);
    }

    private function disableForeignKeyChecks(): void
    {
        $driver = DB::connection()->getDriverName();

        if ($driver === 'mysql') {
            DB::statement('SET FOREIGN_KEY_CHECKS=0');
        } elseif ($driver === 'sqlite') {
            DB::statement('PRAGMA foreign_keys = OFF');
        }
    }

    private function enableForeignKeyChecks(): void
    {
        $driver = DB::connection()->getDriverName();

        if ($driver === 'mysql') {
            DB::statement('SET FOREIGN_KEY_CHECKS=1');
        } elseif ($driver === 'sqlite') {
            DB::statement('PRAGMA foreign_keys = ON');
        }
    }
}
