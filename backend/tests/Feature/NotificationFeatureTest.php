<?php

namespace Tests\Feature;

use App\Models\Barang;
use App\Models\Notifikasi;
use App\Models\PembayaranQris;
use App\Models\TransaksiPenjualan;
use App\Models\User;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class NotificationFeatureTest extends TestCase
{
    public function test_bell_notification_endpoints_mark_read_and_protect_user_scope(): void
    {
        $user = User::factory()->create();
        $otherUser = User::factory()->create();
        Sanctum::actingAs($user);

        $own = Notifikasi::create([
            'user_id' => $user->id,
            'tipe' => 'stok_menipis',
            'judul' => 'Stok barang menipis',
            'pesan' => 'Stok barang test tersisa 5 pcs.',
            'referensi_tipe' => 'barang',
            'referensi_id' => 1,
            'url' => '/barang',
            'fingerprint' => 'test-own-notification',
        ]);
        $other = Notifikasi::create([
            'user_id' => $otherUser->id,
            'tipe' => 'stok_habis',
            'judul' => 'Stok barang habis',
            'pesan' => 'Stok barang lain habis.',
            'referensi_tipe' => 'barang',
            'referensi_id' => 2,
            'url' => '/barang',
            'fingerprint' => 'test-other-notification',
        ]);

        $this->getJson('/api/notifikasi')
            ->assertOk()
            ->assertJsonPath('unread_count', 1)
            ->assertJsonFragment(['id' => $own->id])
            ->assertJsonMissing(['id' => $other->id]);

        $this->getJson('/api/notifikasi/unread-count')
            ->assertOk()
            ->assertJsonPath('unread_count', 1);

        $this->patchJson('/api/notifikasi/'.$other->id.'/read')->assertNotFound();

        $this->patchJson('/api/notifikasi/'.$own->id.'/read')
            ->assertOk()
            ->assertJsonPath('id', $own->id);
        $this->assertNotNull($own->fresh()->dibaca_at);

        Notifikasi::create([
            'user_id' => $user->id,
            'tipe' => 'retur_supplier_status',
            'judul' => 'Status retur supplier berubah',
            'pesan' => 'Retur supplier berubah.',
            'referensi_tipe' => 'retur_supplier',
            'referensi_id' => 1,
            'url' => '/retur-supplier',
            'fingerprint' => 'test-read-all',
        ]);

        $this->patchJson('/api/notifikasi/read-all')
            ->assertOk()
            ->assertJsonPath('unread_count', 0);

        $this->assertSame(0, Notifikasi::where('user_id', $user->id)->whereNull('dibaca_at')->count());
        $this->assertNull($other->fresh()->dibaca_at);
    }

    public function test_stock_notifications_are_idempotent_and_can_reappear_after_normal_stock(): void
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $barang = Barang::create([
            'kode_barang' => 'NTFSTOK001',
            'nama_barang' => 'Barang Notifikasi Stok',
            'kategori' => 'Aksesoris',
            'stok' => 10,
            'harga_beli' => 1000,
            'harga_jual' => 2000,
        ]);

        $payload = [
            'kode_barang' => $barang->kode_barang,
            'nama_barang' => $barang->nama_barang,
            'kategori' => $barang->kategori,
            'harga_beli' => 1000,
            'harga_jual' => 2000,
        ];

        $this->putJson('/api/barang/'.$barang->id, $payload + ['stok' => 5])->assertOk();
        $this->putJson('/api/barang/'.$barang->id, $payload + ['stok' => 4])->assertOk();
        $this->assertSame(1, Notifikasi::where('user_id', $user->id)->where('referensi_tipe', 'barang')->where('referensi_id', $barang->id)->count());

        $this->putJson('/api/barang/'.$barang->id, $payload + ['stok' => 8])->assertOk();
        $this->assertSame(0, Notifikasi::where('user_id', $user->id)->where('referensi_tipe', 'barang')->where('referensi_id', $barang->id)->whereNull('dibaca_at')->count());

        $this->putJson('/api/barang/'.$barang->id, $payload + ['stok' => 5])->assertOk();
        $this->assertSame(2, Notifikasi::where('user_id', $user->id)->where('referensi_tipe', 'barang')->where('referensi_id', $barang->id)->count());
        $this->assertSame(1, Notifikasi::where('user_id', $user->id)->where('referensi_tipe', 'barang')->where('referensi_id', $barang->id)->whereNull('dibaca_at')->count());
    }

    public function test_qris_webhook_creates_notification_only_when_status_changes(): void
    {
        config(['services.midtrans.server_key' => 'dummy-sandbox-server-key']);
        $user = User::factory()->create();

        $sale = TransaksiPenjualan::create([
            'kode_transaksi' => 'NTF-TRX-001',
            'tanggal' => now()->toDateString(),
            'metode_pembayaran' => 'qris',
            'status' => 'lunas',
            'total_harga' => 15000,
            'uang_bayar' => 15000,
            'kembalian' => 0,
            'kasir' => 'admin',
        ]);
        PembayaranQris::create([
            'order_id' => 'NTF-QRIS-001',
            'transaksi_penjualan_id' => $sale->id,
            'nominal' => 15000,
            'status_pembayaran' => 'pending',
        ]);

        $payload = [
            'order_id' => 'NTF-QRIS-001',
            'status_code' => '200',
            'gross_amount' => '15000.00',
            'transaction_status' => 'settlement',
            'transaction_id' => 'NTF-MIDTRANS-001',
        ];
        $payload['signature_key'] = hash('sha512', $payload['order_id'].$payload['status_code'].$payload['gross_amount'].config('services.midtrans.server_key'));

        $this->postJson('/api/midtrans/notification', $payload)->assertOk();
        $this->postJson('/api/midtrans/notification', $payload)->assertOk();

        $this->assertSame(1, Notifikasi::where('user_id', $user->id)->where('tipe', 'qris_berhasil')->where('referensi_tipe', 'pembayaran_qris')->count());
    }
}
