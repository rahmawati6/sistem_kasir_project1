-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistem_project1_concurrency_audit_20260810
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `sistem_project1_concurrency_audit_20260810`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sistem_project1_concurrency_audit_20260810` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sistem_project1_concurrency_audit_20260810`;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `properties` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,'system','Penjualan','create','Mencatat transaksi penjualan TRX-20260810-111111111111','{\"id\": 1, \"kasir\": \"admin\", \"status\": \"lunas\", \"details\": [{\"id\": 1, \"jumlah\": 1, \"subtotal\": \"15000.00\", \"barang_id\": 1, \"created_at\": \"2026-08-10T07:00:46.000000Z\", \"updated_at\": \"2026-08-10T07:00:46.000000Z\", \"kode_barang\": \"CONC-ONE\", \"nama_barang\": \"Stok Terakhir\", \"harga_satuan\": \"15000.00\", \"harga_beli_satuan\": \"10000.00\", \"transaksi_penjualan_id\": 1}], \"tanggal\": \"2026-08-10T00:00:00.000000Z\", \"kembalian\": \"5000.00\", \"created_at\": \"2026-08-10T07:00:46.000000Z\", \"request_id\": \"11111111-1111-4111-8111-111111111111\", \"uang_bayar\": \"20000.00\", \"updated_at\": \"2026-08-10T07:00:46.000000Z\", \"total_harga\": \"15000.00\", \"alasan_batal\": null, \"kode_transaksi\": \"TRX-20260810-111111111111\", \"dibatalkan_pada\": null, \"metode_pembayaran\": \"tunai\"}','2026-08-10 00:00:46','2026-08-10 00:00:46');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barang`
--

DROP TABLE IF EXISTS `barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stok` int NOT NULL DEFAULT '0',
  `harga_beli` decimal(15,2) NOT NULL,
  `harga_jual` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barang_kode_barang_unique` (`kode_barang`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barang`
--

LOCK TABLES `barang` WRITE;
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
INSERT INTO `barang` VALUES (1,'CONC-ONE','Stok Terakhir','Audit',0,10000.00,15000.00,'2026-08-10 07:00:43','2026-08-10 00:00:46');
/*!40000 ALTER TABLE `barang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biaya_admin`
--

DROP TABLE IF EXISTS `biaya_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biaya_admin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `layanan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_biaya` enum('persen','nominal','range') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai` decimal(15,2) NOT NULL,
  `aturan_range` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `biaya_admin_layanan_jenis_nasabah_index` (`layanan`,`jenis_nasabah`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biaya_admin`
--

LOCK TABLES `biaya_admin` WRITE;
/*!40000 ALTER TABLE `biaya_admin` DISABLE KEYS */;
INSERT INTO `biaya_admin` VALUES (1,'ewallet',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(2,'brilink','internal','range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(3,'brilink','eksternal','range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 5000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 8000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 12000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 18000}, {\"max\": null, \"min\": 2000001, \"biaya\": 25000}]',1,'2026-08-10 00:00:04','2026-08-10 00:00:04');
/*!40000 ALTER TABLE `biaya_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biaya_admin_brilink`
--

DROP TABLE IF EXISTS `biaya_admin_brilink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biaya_admin_brilink` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `jenis_transaksi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kartu` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nominal_min` decimal(15,2) NOT NULL,
  `nominal_max` decimal(15,2) DEFAULT NULL,
  `biaya_admin` decimal(15,2) NOT NULL,
  `aktif` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `biaya_admin_brilink_lookup` (`jenis_transaksi`,`jenis_nasabah`,`nominal_min`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biaya_admin_brilink`
--

LOCK TABLES `biaya_admin_brilink` WRITE;
/*!40000 ALTER TABLE `biaya_admin_brilink` DISABLE KEYS */;
INSERT INTO `biaya_admin_brilink` VALUES (1,'transfer','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(2,'transfer','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(3,'transfer','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(4,'transfer','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(5,'transfer','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(6,'transfer','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(7,'transfer','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(8,'transfer','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(9,'transfer','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(10,'transfer','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(11,'tarik_tunai','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(12,'tarik_tunai','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(13,'tarik_tunai','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(14,'tarik_tunai','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(15,'tarik_tunai','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(16,'tarik_tunai','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(17,'tarik_tunai','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(18,'tarik_tunai','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(19,'tarik_tunai','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(20,'tarik_tunai','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(21,'setor_tunai','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(22,'setor_tunai','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(23,'setor_tunai','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(24,'setor_tunai','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(25,'setor_tunai','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(26,'setor_tunai','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(27,'setor_tunai','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(28,'setor_tunai','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(29,'setor_tunai','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(30,'setor_tunai','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(31,'tagihan','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(32,'tagihan','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(33,'tagihan','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(34,'tagihan','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(35,'tagihan','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(36,'tagihan','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(37,'tagihan','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(38,'tagihan','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(39,'tagihan','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(40,'tagihan','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(41,'pulsa_paket_data','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(42,'pulsa_paket_data','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(43,'pulsa_paket_data','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(44,'pulsa_paket_data','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(45,'pulsa_paket_data','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(46,'pulsa_paket_data','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(47,'pulsa_paket_data','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(48,'pulsa_paket_data','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(49,'pulsa_paket_data','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(50,'pulsa_paket_data','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(51,'ewallet',NULL,NULL,1.00,100000.00,2000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(52,'ewallet',NULL,NULL,100001.00,500000.00,5000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(53,'ewallet',NULL,NULL,500001.00,1000000.00,10000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(54,'ewallet',NULL,NULL,1000001.00,2000000.00,15000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(55,'ewallet',NULL,NULL,2000001.00,NULL,20000.00,1,'2026-08-10 00:00:04','2026-08-10 00:00:04');
/*!40000 ALTER TABLE `biaya_admin_brilink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_penjualan`
--

DROP TABLE IF EXISTS `detail_penjualan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_penjualan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaksi_penjualan_id` int unsigned NOT NULL,
  `barang_id` int unsigned NOT NULL,
  `kode_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int NOT NULL,
  `harga_satuan` decimal(15,2) NOT NULL,
  `harga_beli_satuan` decimal(15,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_penjualan_transaksi_penjualan_id_foreign` (`transaksi_penjualan_id`),
  KEY `detail_penjualan_barang_id_foreign` (`barang_id`),
  CONSTRAINT `detail_penjualan_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`),
  CONSTRAINT `detail_penjualan_transaksi_penjualan_id_foreign` FOREIGN KEY (`transaksi_penjualan_id`) REFERENCES `transaksi_penjualan` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_penjualan`
--

LOCK TABLES `detail_penjualan` WRITE;
/*!40000 ALTER TABLE `detail_penjualan` DISABLE KEYS */;
INSERT INTO `detail_penjualan` VALUES (1,1,1,'CONC-ONE','Stok Terakhir',1,15000.00,10000.00,15000.00,'2026-08-10 00:00:46','2026-08-10 00:00:46');
/*!40000 ALTER TABLE `detail_penjualan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2024_01_01_000001_create_barang_table',1),(6,'2024_01_01_000002_create_transaksi_penjualan_table',1),(7,'2024_01_01_000003_create_detail_penjualan_table',1),(8,'2024_01_01_000004_create_pembayaran_qris_table',1),(9,'2024_01_01_000005_create_transaksi_transfer_table',1),(10,'2024_01_01_000006_create_transaksi_tarik_tunai_table',1),(11,'2024_01_01_000007_create_transaksi_setor_tunai_table',1),(12,'2024_01_01_000009_create_pembayaran_tagihan_table',1),(13,'2024_01_01_000010_create_transaksi_pulsa_table',1),(14,'2024_01_01_000011_create_biaya_admin_table',1),(15,'2026_05_23_000001_add_range_to_biaya_admin_table',1),(16,'2026_06_08_000001_create_transaksi_ewallet_table',1),(17,'2026_06_08_000002_add_bank_tujuan_to_transaksi_transfer_table',1),(18,'2026_06_08_000003_create_activity_logs_table',1),(19,'2026_06_08_000004_add_harga_beli_to_detail_penjualan_table',1),(20,'2026_06_08_000005_add_ewallet_biaya_admin',1),(21,'2026_06_08_000006_add_cancel_columns_to_transaksi_penjualan',1),(22,'2026_06_08_000007_create_retur_penjualan_table',1),(23,'2026_06_08_000008_create_pengeluaran_toko_table',1),(24,'2026_06_08_000010_drop_unused_tables',1),(25,'2026_06_08_000011_backfill_harga_beli_satuan_detail_penjualan',1),(26,'2026_06_09_000001_drop_tabungan_customer_table',1),(27,'2026_06_16_000001_add_jenis_nasabah_to_brilink_transactions',1),(28,'2026_06_16_000002_create_retur_supplier_table',1),(29,'2026_06_16_000003_add_jenis_nasabah_to_biaya_admin_table',1),(30,'2026_06_16_000004_create_biaya_admin_brilink_table',1),(31,'2026_06_17_000001_create_retur_pelanggan_table',1),(32,'2026_07_03_000001_add_provider_to_brilink_transactions',1),(33,'2026_07_03_000002_create_providers_table',1),(34,'2026_08_10_000001_normalize_business_ids_and_varchar_lengths',1),(35,'2026_08_10_000002_harden_transaction_idempotency',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pembayaran_qris`
--

DROP TABLE IF EXISTS `pembayaran_qris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pembayaran_qris` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaksi_penjualan_id` int unsigned NOT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `snap_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pembayaran` enum('pending','settlement','expire','cancel') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pembayaran_qris_order_id_unique` (`order_id`),
  UNIQUE KEY `pembayaran_qris_sale_unique` (`transaksi_penjualan_id`),
  UNIQUE KEY `pembayaran_qris_transaction_id_unique` (`transaction_id`),
  CONSTRAINT `pembayaran_qris_transaksi_penjualan_id_foreign` FOREIGN KEY (`transaksi_penjualan_id`) REFERENCES `transaksi_penjualan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembayaran_qris`
--

LOCK TABLES `pembayaran_qris` WRITE;
/*!40000 ALTER TABLE `pembayaran_qris` DISABLE KEYS */;
/*!40000 ALTER TABLE `pembayaran_qris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pembayaran_tagihan`
--

DROP TABLE IF EXISTS `pembayaran_tagihan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pembayaran_tagihan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `jenis_layanan` enum('pln','pdam','bpjs','indihome','angsuran','lainnya') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_pelanggan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_pelanggan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_tagihan` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `status` enum('sukses','gagal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pembayaran_tagihan_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembayaran_tagihan`
--

LOCK TABLES `pembayaran_tagihan` WRITE;
/*!40000 ALTER TABLE `pembayaran_tagihan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pembayaran_tagihan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengeluaran_toko`
--

DROP TABLE IF EXISTS `pengeluaran_toko`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengeluaran_toko` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `kategori` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_pengeluaran` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengeluaran_toko`
--

LOCK TABLES `pengeluaran_toko` WRITE;
/*!40000 ALTER TABLE `pengeluaran_toko` DISABLE KEYS */;
/*!40000 ALTER TABLE `pengeluaran_toko` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `providers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nama_provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `providers_nama_provider_unique` (`nama_provider`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,'BRILink Mobile',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(2,'BRIMO Agen',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(3,'Fastpay',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(4,'Payfazz',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(5,'Mitra Bukalapak',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(6,'Digipos',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(7,'Kiosbank',1,'2026-08-10 00:00:04','2026-08-10 00:00:04'),(8,'Finnet',1,'2026-08-10 00:00:04','2026-08-10 00:00:04');
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retur_pelanggan`
--

DROP TABLE IF EXISTS `retur_pelanggan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retur_pelanggan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `request_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_retur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaksi_penjualan_id` int unsigned DEFAULT NULL,
  `detail_penjualan_id` int unsigned DEFAULT NULL,
  `barang_id` int unsigned DEFAULT NULL,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_dibeli` int NOT NULL,
  `jumlah_retur` int NOT NULL,
  `alasan_retur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metode_pengembalian_dana` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `tanggal_retur` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `retur_pelanggan_nomor_retur_unique` (`nomor_retur`),
  UNIQUE KEY `retur_pelanggan_request_id_unique` (`request_id`),
  KEY `retur_pelanggan_transaksi_penjualan_id_foreign` (`transaksi_penjualan_id`),
  KEY `retur_pelanggan_detail_penjualan_id_foreign` (`detail_penjualan_id`),
  KEY `retur_pelanggan_barang_id_foreign` (`barang_id`),
  CONSTRAINT `retur_pelanggan_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE SET NULL,
  CONSTRAINT `retur_pelanggan_detail_penjualan_id_foreign` FOREIGN KEY (`detail_penjualan_id`) REFERENCES `detail_penjualan` (`id`) ON DELETE SET NULL,
  CONSTRAINT `retur_pelanggan_transaksi_penjualan_id_foreign` FOREIGN KEY (`transaksi_penjualan_id`) REFERENCES `transaksi_penjualan` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retur_pelanggan`
--

LOCK TABLES `retur_pelanggan` WRITE;
/*!40000 ALTER TABLE `retur_pelanggan` DISABLE KEYS */;
/*!40000 ALTER TABLE `retur_pelanggan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retur_penjualan`
--

DROP TABLE IF EXISTS `retur_penjualan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retur_penjualan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaksi_penjualan_id` int unsigned NOT NULL,
  `detail_penjualan_id` int unsigned NOT NULL,
  `barang_id` int unsigned NOT NULL,
  `kode_retur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int NOT NULL,
  `nilai_retur` decimal(15,2) NOT NULL DEFAULT '0.00',
  `alasan` text COLLATE utf8mb4_unicode_ci,
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `retur_penjualan_kode_retur_unique` (`kode_retur`),
  KEY `retur_penjualan_transaksi_penjualan_id_foreign` (`transaksi_penjualan_id`),
  KEY `retur_penjualan_detail_penjualan_id_foreign` (`detail_penjualan_id`),
  KEY `retur_penjualan_barang_id_foreign` (`barang_id`),
  CONSTRAINT `retur_penjualan_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE,
  CONSTRAINT `retur_penjualan_detail_penjualan_id_foreign` FOREIGN KEY (`detail_penjualan_id`) REFERENCES `detail_penjualan` (`id`) ON DELETE CASCADE,
  CONSTRAINT `retur_penjualan_transaksi_penjualan_id_foreign` FOREIGN KEY (`transaksi_penjualan_id`) REFERENCES `transaksi_penjualan` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retur_penjualan`
--

LOCK TABLES `retur_penjualan` WRITE;
/*!40000 ALTER TABLE `retur_penjualan` DISABLE KEYS */;
/*!40000 ALTER TABLE `retur_penjualan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retur_supplier`
--

DROP TABLE IF EXISTS `retur_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retur_supplier` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `request_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_retur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_retur` date NOT NULL,
  `nama_supplier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `barang_id` int unsigned NOT NULL,
  `kode_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_retur` int NOT NULL,
  `alasan_retur` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_retur` enum('diproses','diterima','ditolak') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'diproses',
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `stok_dikurangi` tinyint(1) NOT NULL DEFAULT '0',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `retur_supplier_nomor_retur_unique` (`nomor_retur`),
  UNIQUE KEY `retur_supplier_request_id_unique` (`request_id`),
  KEY `retur_supplier_barang_id_foreign` (`barang_id`),
  CONSTRAINT `retur_supplier_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retur_supplier`
--

LOCK TABLES `retur_supplier` WRITE;
/*!40000 ALTER TABLE `retur_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `retur_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi_ewallet`
--

DROP TABLE IF EXISTS `transaksi_ewallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi_ewallet` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `jenis_transaksi` enum('top_up','pencairan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_ewallet` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_ewallet` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_customer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `status` enum('sukses','gagal','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_ewallet_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_ewallet`
--

LOCK TABLES `transaksi_ewallet` WRITE;
/*!40000 ALTER TABLE `transaksi_ewallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_ewallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi_penjualan`
--

DROP TABLE IF EXISTS `transaksi_penjualan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi_penjualan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `request_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `metode_pembayaran` enum('tunai','qris') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','lunas','batal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `total_harga` decimal(15,2) NOT NULL,
  `uang_bayar` decimal(15,2) DEFAULT NULL,
  `kembalian` decimal(15,2) DEFAULT NULL,
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `alasan_batal` text COLLATE utf8mb4_unicode_ci,
  `dibatalkan_pada` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_penjualan_kode_transaksi_unique` (`kode_transaksi`),
  UNIQUE KEY `transaksi_penjualan_request_id_unique` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_penjualan`
--

LOCK TABLES `transaksi_penjualan` WRITE;
/*!40000 ALTER TABLE `transaksi_penjualan` DISABLE KEYS */;
INSERT INTO `transaksi_penjualan` VALUES (1,'11111111-1111-4111-8111-111111111111','TRX-20260810-111111111111','2026-08-10','tunai','lunas',15000.00,20000.00,5000.00,'admin',NULL,NULL,'2026-08-10 00:00:46','2026-08-10 00:00:46');
/*!40000 ALTER TABLE `transaksi_penjualan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi_pulsa`
--

DROP TABLE IF EXISTS `transaksi_pulsa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi_pulsa` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `operator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_layanan` enum('pulsa','paket_data') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_tujuan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `produk` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `status` enum('sukses','gagal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_pulsa_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_pulsa`
--

LOCK TABLES `transaksi_pulsa` WRITE;
/*!40000 ALTER TABLE `transaksi_pulsa` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_pulsa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi_setor_tunai`
--

DROP TABLE IF EXISTS `transaksi_setor_tunai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi_setor_tunai` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `jenis_setoran` enum('biasa','tabungan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_rekening_tujuan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_pemilik_rekening` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_tujuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nominal_setor` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `sumber_dana` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `status` enum('sukses','gagal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_setor_tunai_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_setor_tunai`
--

LOCK TABLES `transaksi_setor_tunai` WRITE;
/*!40000 ALTER TABLE `transaksi_setor_tunai` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_setor_tunai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi_tarik_tunai`
--

DROP TABLE IF EXISTS `transaksi_tarik_tunai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi_tarik_tunai` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `nomor_rekening` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_penerima` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_hp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal_tarik` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `status` enum('sukses','gagal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_tarik_tunai_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_tarik_tunai`
--

LOCK TABLES `transaksi_tarik_tunai` WRITE;
/*!40000 ALTER TABLE `transaksi_tarik_tunai` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_tarik_tunai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaksi_transfer`
--

DROP TABLE IF EXISTS `transaksi_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi_transfer` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `jenis_transfer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_tujuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_rekening_tujuan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_penerima` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal_transfer` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `status` enum('sukses','gagal','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_transfer_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_transfer`
--

LOCK TABLES `transaksi_transfer` WRITE;
/*!40000 ALTER TABLE `transaksi_transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sistem_project1_concurrency_audit_20260810'
--

--
-- Dumping routines for database 'sistem_project1_concurrency_audit_20260810'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-17 10:45:29
