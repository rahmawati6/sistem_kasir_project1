<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    private const UINT_MAX = 4294967295;

    private const BUSINESS_TABLES = [
        'users',
        'barang',
        'transaksi_penjualan',
        'detail_penjualan',
        'pembayaran_qris',
        'transaksi_transfer',
        'transaksi_tarik_tunai',
        'transaksi_setor_tunai',
        'pembayaran_tagihan',
        'transaksi_pulsa',
        'transaksi_ewallet',
        'biaya_admin',
        'biaya_admin_brilink',
        'providers',
        'pengeluaran_toko',
        'retur_penjualan',
        'retur_pelanggan',
        'retur_supplier',
        'activity_logs',
    ];

    /**
     * Only columns whose current length is 255 and must actually change are listed.
     * Columns already at their requested length are intentionally left untouched.
     */
    private const VARCHAR_TARGETS = [
        'users' => ['name' => 100, 'email' => 191],
        'barang' => ['kode_barang' => 50, 'nama_barang' => 150, 'kategori' => 100],
        'transaksi_penjualan' => ['kode_transaksi' => 50, 'kasir' => 100],
        'detail_penjualan' => ['kode_barang' => 50, 'nama_barang' => 150],
        'pembayaran_qris' => ['order_id' => 100, 'transaction_id' => 100],
        'transaksi_transfer' => [
            'kode_transaksi' => 50,
            'jenis_kartu' => 50,
            'jenis_transfer' => 50,
            'bank_tujuan' => 100,
            'nomor_rekening_tujuan' => 30,
            'nama_penerima' => 100,
            'kasir' => 100,
        ],
        'transaksi_tarik_tunai' => [
            'kode_transaksi' => 50,
            'jenis_kartu' => 50,
            'nomor_rekening' => 30,
            'nama_penerima' => 100,
            'nomor_hp' => 20,
            'kasir' => 100,
        ],
        'transaksi_setor_tunai' => [
            'kode_transaksi' => 50,
            'jenis_kartu' => 50,
            'nomor_rekening_tujuan' => 30,
            'nama_pemilik_rekening' => 100,
            'bank_tujuan' => 100,
            'sumber_dana' => 100,
            'kasir' => 100,
        ],
        'pembayaran_tagihan' => [
            'kode_transaksi' => 50,
            'jenis_kartu' => 50,
            'nomor_pelanggan' => 50,
            'nama_pelanggan' => 100,
            'kasir' => 100,
        ],
        'transaksi_pulsa' => [
            'kode_transaksi' => 50,
            'jenis_kartu' => 50,
            'operator' => 50,
            'nomor_tujuan' => 20,
            'produk' => 150,
            'kasir' => 100,
        ],
        'transaksi_ewallet' => [
            'kode_transaksi' => 50,
            'provider' => 100,
            'nomor_ewallet' => 30,
            'nama_customer' => 100,
            'kasir' => 100,
        ],
        'biaya_admin' => ['layanan' => 50],
        'pengeluaran_toko' => ['kategori' => 100, 'nama_pengeluaran' => 150, 'kasir' => 100],
        'retur_penjualan' => ['kode_retur' => 50, 'kasir' => 100],
        'retur_pelanggan' => [
            'nomor_retur' => 50,
            'kode_transaksi' => 50,
            'kode_barang' => 50,
            'nama_barang' => 150,
            'metode_pengembalian_dana' => 50,
        ],
        'retur_supplier' => [
            'nomor_retur' => 50,
            'nama_supplier' => 150,
            'kode_barang' => 50,
            'nama_barang' => 150,
            'kasir' => 100,
        ],
        'activity_logs' => ['user_name' => 100, 'module' => 50, 'action' => 50],
    ];

    private const FOREIGN_KEYS = [
        [
            'table' => 'detail_penjualan',
            'name' => 'detail_penjualan_transaksi_penjualan_id_foreign',
            'column' => 'transaksi_penjualan_id',
            'references_table' => 'transaksi_penjualan',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'CASCADE',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'detail_penjualan',
            'name' => 'detail_penjualan_barang_id_foreign',
            'column' => 'barang_id',
            'references_table' => 'barang',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'NO ACTION',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'pembayaran_qris',
            'name' => 'pembayaran_qris_transaksi_penjualan_id_foreign',
            'column' => 'transaksi_penjualan_id',
            'references_table' => 'transaksi_penjualan',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'NO ACTION',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_penjualan',
            'name' => 'retur_penjualan_transaksi_penjualan_id_foreign',
            'column' => 'transaksi_penjualan_id',
            'references_table' => 'transaksi_penjualan',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'CASCADE',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_penjualan',
            'name' => 'retur_penjualan_detail_penjualan_id_foreign',
            'column' => 'detail_penjualan_id',
            'references_table' => 'detail_penjualan',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'CASCADE',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_penjualan',
            'name' => 'retur_penjualan_barang_id_foreign',
            'column' => 'barang_id',
            'references_table' => 'barang',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'CASCADE',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_pelanggan',
            'name' => 'retur_pelanggan_transaksi_penjualan_id_foreign',
            'column' => 'transaksi_penjualan_id',
            'references_table' => 'transaksi_penjualan',
            'references_column' => 'id',
            'nullable' => true,
            'on_delete' => 'SET NULL',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_pelanggan',
            'name' => 'retur_pelanggan_detail_penjualan_id_foreign',
            'column' => 'detail_penjualan_id',
            'references_table' => 'detail_penjualan',
            'references_column' => 'id',
            'nullable' => true,
            'on_delete' => 'SET NULL',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_pelanggan',
            'name' => 'retur_pelanggan_barang_id_foreign',
            'column' => 'barang_id',
            'references_table' => 'barang',
            'references_column' => 'id',
            'nullable' => true,
            'on_delete' => 'SET NULL',
            'on_update' => 'NO ACTION',
        ],
        [
            'table' => 'retur_supplier',
            'name' => 'retur_supplier_barang_id_foreign',
            'column' => 'barang_id',
            'references_table' => 'barang',
            'references_column' => 'id',
            'nullable' => false,
            'on_delete' => 'NO ACTION',
            'on_update' => 'NO ACTION',
        ],
    ];

    private const REQUIRED_INDEXES = [
        ['table' => 'users', 'name' => 'users_email_unique', 'columns' => ['email'], 'unique' => true],
        ['table' => 'barang', 'name' => 'barang_kode_barang_unique', 'columns' => ['kode_barang'], 'unique' => true],
        ['table' => 'transaksi_penjualan', 'name' => 'transaksi_penjualan_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'pembayaran_qris', 'name' => 'pembayaran_qris_order_id_unique', 'columns' => ['order_id'], 'unique' => true],
        ['table' => 'transaksi_transfer', 'name' => 'transaksi_transfer_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'transaksi_tarik_tunai', 'name' => 'transaksi_tarik_tunai_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'transaksi_setor_tunai', 'name' => 'transaksi_setor_tunai_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'pembayaran_tagihan', 'name' => 'pembayaran_tagihan_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'transaksi_pulsa', 'name' => 'transaksi_pulsa_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'transaksi_ewallet', 'name' => 'transaksi_ewallet_kode_transaksi_unique', 'columns' => ['kode_transaksi'], 'unique' => true],
        ['table' => 'providers', 'name' => 'providers_nama_provider_unique', 'columns' => ['nama_provider'], 'unique' => true],
        ['table' => 'retur_penjualan', 'name' => 'retur_penjualan_kode_retur_unique', 'columns' => ['kode_retur'], 'unique' => true],
        ['table' => 'retur_pelanggan', 'name' => 'retur_pelanggan_nomor_retur_unique', 'columns' => ['nomor_retur'], 'unique' => true],
        ['table' => 'retur_supplier', 'name' => 'retur_supplier_nomor_retur_unique', 'columns' => ['nomor_retur'], 'unique' => true],
        ['table' => 'biaya_admin', 'name' => 'biaya_admin_layanan_jenis_nasabah_index', 'columns' => ['layanan', 'jenis_nasabah'], 'unique' => false],
        ['table' => 'biaya_admin_brilink', 'name' => 'biaya_admin_brilink_lookup', 'columns' => ['jenis_transaksi', 'jenis_nasabah', 'nominal_min'], 'unique' => false],
    ];

    public function up(): void
    {
        $this->preflight('up');
        $this->dropForeignKeys();
        $this->alterColumns('INT UNSIGNED NOT NULL AUTO_INCREMENT', 'INT UNSIGNED', true);
        $this->createForeignKeys();
        $this->assertFinalState('int unsigned', true);
    }

    public function down(): void
    {
        $this->preflight('down');
        $this->dropForeignKeys();
        $this->alterColumns('BIGINT UNSIGNED NOT NULL AUTO_INCREMENT', 'BIGINT UNSIGNED', false);
        $this->createForeignKeys();
        $this->assertFinalState('bigint unsigned', false);
    }

    private function preflight(string $direction): void
    {
        $this->assertMysql8();
        $this->assertTablesAndIdColumns($direction === 'up' ? 'bigint unsigned' : 'int unsigned');
        $this->assertIdCapacity();
        $this->assertVarcharColumns($direction === 'up');
        $this->assertIndexes();
        $this->assertForeignKeys($direction === 'up' ? 'bigint unsigned' : 'int unsigned');
    }

    private function assertMysql8(): void
    {
        if (DB::connection()->getDriverName() !== 'mysql') {
            throw new RuntimeException('Normalisasi skema hanya boleh dijalankan pada MySQL 8.');
        }

        $version = (string) DB::selectOne('SELECT VERSION() AS version')->version;
        if (stripos($version, 'mariadb') !== false || version_compare(preg_replace('/[^0-9.].*/', '', $version), '8.0.0', '<')) {
            throw new RuntimeException("Versi database tidak didukung: {$version}. Diperlukan MySQL 8 atau lebih baru.");
        }
    }

    private function assertTablesAndIdColumns(string $expectedType): void
    {
        foreach (self::BUSINESS_TABLES as $table) {
            $column = $this->columnMetadata($table, 'id');
            if (!$column) {
                throw new RuntimeException("Tabel atau primary key tidak ditemukan: {$table}.id");
            }

            if (strtolower($column->COLUMN_TYPE) !== $expectedType
                || $column->IS_NULLABLE !== 'NO'
                || $column->COLUMN_KEY !== 'PRI'
                || stripos((string) $column->EXTRA, 'auto_increment') === false) {
                throw new RuntimeException("Struktur {$table}.id tidak sesuai preflight. Aktual: {$column->COLUMN_TYPE}, nullable={$column->IS_NULLABLE}, key={$column->COLUMN_KEY}, extra={$column->EXTRA}");
            }
        }
    }

    private function assertIdCapacity(): void
    {
        foreach (self::BUSINESS_TABLES as $table) {
            $quotedTable = $this->quoteIdentifier($table);
            $maxId = DB::selectOne("SELECT MAX(`id`) AS value FROM {$quotedTable}")->value;
            if ($maxId !== null && (int) $maxId > self::UINT_MAX) {
                throw new RuntimeException("{$table}.id memiliki nilai {$maxId}, melebihi kapasitas INT UNSIGNED.");
            }

            $tableMetadata = DB::selectOne(
                'SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ?',
                [$table]
            );
            $nextId = $tableMetadata?->AUTO_INCREMENT;
            if ($nextId !== null && (int) $nextId > self::UINT_MAX) {
                throw new RuntimeException("AUTO_INCREMENT {$table} bernilai {$nextId}, melebihi kapasitas INT UNSIGNED.");
            }
        }

        foreach (self::FOREIGN_KEYS as $foreignKey) {
            $table = $foreignKey['table'];
            $column = $foreignKey['column'];
            $maxValue = DB::selectOne(
                'SELECT MAX('.$this->quoteIdentifier($column).') AS value FROM '.$this->quoteIdentifier($table)
            )->value;
            if ($maxValue !== null && (int) $maxValue > self::UINT_MAX) {
                throw new RuntimeException("{$table}.{$column} memiliki nilai {$maxValue}, melebihi kapasitas INT UNSIGNED.");
            }
        }
    }

    private function assertVarcharColumns(bool $beforeUp): void
    {
        foreach (self::VARCHAR_TARGETS as $table => $columns) {
            foreach ($columns as $column => $targetLength) {
                $metadata = $this->columnMetadata($table, $column);
                $expectedLength = $beforeUp ? 255 : $targetLength;

                if (!$metadata || strtolower($metadata->DATA_TYPE) !== 'varchar' || (int) $metadata->CHARACTER_MAXIMUM_LENGTH !== $expectedLength) {
                    $actual = $metadata ? "{$metadata->DATA_TYPE}({$metadata->CHARACTER_MAXIMUM_LENGTH})" : 'tidak ada';
                    throw new RuntimeException("Struktur {$table}.{$column} tidak sesuai preflight. Diharapkan VARCHAR({$expectedLength}), aktual {$actual}.");
                }

                if ($beforeUp) {
                    $maxLength = DB::selectOne(
                        'SELECT MAX(CHAR_LENGTH('.$this->quoteIdentifier($column).')) AS value FROM '.$this->quoteIdentifier($table)
                    )->value;
                    if ($maxLength !== null && (int) $maxLength > $targetLength) {
                        throw new RuntimeException("Data {$table}.{$column} sepanjang {$maxLength} karakter melebihi target VARCHAR({$targetLength}). Data tidak diubah.");
                    }
                }
            }
        }
    }

    private function assertIndexes(): void
    {
        foreach (self::REQUIRED_INDEXES as $index) {
            $rows = DB::select(
                'SELECT COLUMN_NAME, NON_UNIQUE FROM information_schema.STATISTICS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND INDEX_NAME = ? ORDER BY SEQ_IN_INDEX',
                [$index['table'], $index['name']]
            );
            $columns = array_map(fn ($row) => $row->COLUMN_NAME, $rows);
            $isUnique = isset($rows[0]) && (int) $rows[0]->NON_UNIQUE === 0;

            if ($columns !== $index['columns'] || $isUnique !== $index['unique']) {
                throw new RuntimeException("Index {$index['table']}.{$index['name']} tidak sesuai hasil audit.");
            }
        }
    }

    private function assertForeignKeys(string $expectedColumnType): void
    {
        foreach (self::FOREIGN_KEYS as $foreignKey) {
            $column = $this->columnMetadata($foreignKey['table'], $foreignKey['column']);
            if (!$column
                || strtolower($column->COLUMN_TYPE) !== $expectedColumnType
                || ($column->IS_NULLABLE === 'YES') !== $foreignKey['nullable']) {
                throw new RuntimeException("Kolom foreign key {$foreignKey['table']}.{$foreignKey['column']} tidak sesuai hasil audit.");
            }

            $actual = DB::selectOne(
                'SELECT k.REFERENCED_TABLE_NAME, k.REFERENCED_COLUMN_NAME, r.UPDATE_RULE, r.DELETE_RULE
                 FROM information_schema.KEY_COLUMN_USAGE k
                 JOIN information_schema.REFERENTIAL_CONSTRAINTS r
                   ON r.CONSTRAINT_SCHEMA = k.CONSTRAINT_SCHEMA AND r.CONSTRAINT_NAME = k.CONSTRAINT_NAME
                 WHERE k.CONSTRAINT_SCHEMA = DATABASE() AND k.TABLE_NAME = ? AND k.CONSTRAINT_NAME = ? AND k.COLUMN_NAME = ?',
                [$foreignKey['table'], $foreignKey['name'], $foreignKey['column']]
            );

            if (!$actual
                || $actual->REFERENCED_TABLE_NAME !== $foreignKey['references_table']
                || $actual->REFERENCED_COLUMN_NAME !== $foreignKey['references_column']
                || $actual->UPDATE_RULE !== $foreignKey['on_update']
                || $actual->DELETE_RULE !== $foreignKey['on_delete']) {
                throw new RuntimeException("Constraint {$foreignKey['name']} tidak sesuai hasil audit.");
            }
        }
    }

    private function dropForeignKeys(): void
    {
        foreach (self::FOREIGN_KEYS as $foreignKey) {
            DB::statement(
                'ALTER TABLE '.$this->quoteIdentifier($foreignKey['table']).
                ' DROP FOREIGN KEY '.$this->quoteIdentifier($foreignKey['name'])
            );
        }
    }

    private function alterColumns(string $idDefinition, string $foreignKeyDefinition, bool $up): void
    {
        $clausesByTable = [];

        foreach (self::BUSINESS_TABLES as $table) {
            $clausesByTable[$table][] = 'MODIFY COLUMN `id` '.$idDefinition;
        }

        foreach (self::FOREIGN_KEYS as $foreignKey) {
            $definition = $foreignKeyDefinition.($foreignKey['nullable'] ? ' NULL DEFAULT NULL' : ' NOT NULL');
            $clausesByTable[$foreignKey['table']][] = 'MODIFY COLUMN '.$this->quoteIdentifier($foreignKey['column']).' '.$definition;
        }

        foreach (self::VARCHAR_TARGETS as $table => $columns) {
            foreach ($columns as $column => $targetLength) {
                $clausesByTable[$table][] = $this->varcharClause($table, $column, $up ? $targetLength : 255);
            }
        }

        foreach (self::BUSINESS_TABLES as $table) {
            DB::statement(
                'ALTER TABLE '.$this->quoteIdentifier($table).' '.implode(', ', $clausesByTable[$table])
            );
        }
    }

    private function createForeignKeys(): void
    {
        foreach (self::FOREIGN_KEYS as $foreignKey) {
            DB::statement(
                'ALTER TABLE '.$this->quoteIdentifier($foreignKey['table']).
                ' ADD CONSTRAINT '.$this->quoteIdentifier($foreignKey['name']).
                ' FOREIGN KEY ('.$this->quoteIdentifier($foreignKey['column']).')'.
                ' REFERENCES '.$this->quoteIdentifier($foreignKey['references_table']).
                ' ('.$this->quoteIdentifier($foreignKey['references_column']).')'.
                ' ON DELETE '.$foreignKey['on_delete'].
                ' ON UPDATE '.$foreignKey['on_update']
            );
        }
    }

    private function assertFinalState(string $idType, bool $afterUp): void
    {
        $this->assertTablesAndIdColumns($idType);
        $this->assertVarcharColumns(!$afterUp);
        $this->assertIndexes();
        $this->assertForeignKeys($idType);
    }

    private function varcharClause(string $table, string $column, int $length): string
    {
        $metadata = $this->columnMetadata($table, $column);
        if (!$metadata) {
            throw new RuntimeException("Metadata {$table}.{$column} tidak ditemukan saat ALTER.");
        }

        $definition = 'MODIFY COLUMN '.$this->quoteIdentifier($column).' VARCHAR('.$length.')';
        if ($metadata->CHARACTER_SET_NAME) {
            $definition .= ' CHARACTER SET '.$metadata->CHARACTER_SET_NAME;
        }
        if ($metadata->COLLATION_NAME) {
            $definition .= ' COLLATE '.$metadata->COLLATION_NAME;
        }

        $definition .= $metadata->IS_NULLABLE === 'YES' ? ' NULL' : ' NOT NULL';
        if ($metadata->COLUMN_DEFAULT !== null) {
            $definition .= ' DEFAULT '.DB::connection()->getPdo()->quote((string) $metadata->COLUMN_DEFAULT);
        } elseif ($metadata->IS_NULLABLE === 'YES') {
            $definition .= ' DEFAULT NULL';
        }

        if ((string) $metadata->COLUMN_COMMENT !== '') {
            $definition .= ' COMMENT '.DB::connection()->getPdo()->quote((string) $metadata->COLUMN_COMMENT);
        }

        return $definition;
    }

    private function columnMetadata(string $table, string $column): ?object
    {
        return DB::selectOne(
            'SELECT COLUMN_TYPE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, COLUMN_DEFAULT,
                    COLUMN_KEY, EXTRA, CHARACTER_SET_NAME, COLLATION_NAME, COLUMN_COMMENT
             FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND COLUMN_NAME = ?',
            [$table, $column]
        );
    }

    private function quoteIdentifier(string $identifier): string
    {
        return '`'.str_replace('`', '``', $identifier).'`';
    }
};
