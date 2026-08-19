-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistem_project1_audit_restore_20260810
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
-- Current Database: `sistem_project1_audit_restore_20260810`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sistem_project1_audit_restore_20260810` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sistem_project1_audit_restore_20260810`;

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
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `properties` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,'admin','Backup','download','Mengunduh backup data website','[]','2026-06-07 20:54:50','2026-06-07 20:54:50'),(2,'admin','Barang','create','Menambah barang Case gambar aqua iPhone 11','{\"id\": 10, \"stok\": 10, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T08:32:50.000000Z\", \"harga_beli\": 20000, \"harga_jual\": 25000, \"updated_at\": \"2026-06-08T08:32:50.000000Z\", \"kode_barang\": \"8886008101053\", \"nama_barang\": \"Case gambar aqua iPhone 11\"}','2026-06-08 01:32:50','2026-06-08 01:32:50'),(3,'admin','Barang','create','Menambah barang Tempered Glass Kelontong Unik iPhone 14','{\"id\": 11, \"stok\": 10, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:22:05.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 75000, \"updated_at\": \"2026-06-08T12:22:05.000000Z\", \"kode_barang\": \"064036520222\", \"nama_barang\": \"Tempered Glass Kelontong Unik iPhone 14\"}','2026-06-08 05:22:05','2026-06-08 05:22:05'),(4,'admin','Barang','delete','Menghapus barang Tempered Glass','[]','2026-06-08 05:24:18','2026-06-08 05:24:18'),(5,'admin','Barang','create','Menambah barang Case iPhone 13/14 DIY','{\"id\": 12, \"stok\": 5, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:31:10.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 80000, \"updated_at\": \"2026-06-08T12:31:10.000000Z\", \"kode_barang\": \"8996410\", \"nama_barang\": \"Case iPhone 13/14 DIY\"}','2026-06-08 05:31:10','2026-06-08 05:31:10'),(6,'admin','Barang','delete','Menghapus barang Case gambar aqua iPhone 11','[]','2026-06-08 05:31:27','2026-06-08 05:31:27'),(7,'admin','Barang','delete','Menghapus barang Samsung S23','[]','2026-06-08 05:31:52','2026-06-08 05:31:52'),(8,'admin','Barang','update','Memperbarui barang iPhone 13','{\"id\": 1, \"stok\": 13, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 8000000, \"harga_jual\": 9500000, \"updated_at\": \"2026-06-08T12:32:55.000000Z\", \"kode_barang\": \"A2633\", \"nama_barang\": \"iPhone 13\"}','2026-06-08 05:32:55','2026-06-08 05:32:55'),(9,'admin','Barang','update','Memperbarui barang Tempered Glass iPhone 14','{\"id\": 11, \"stok\": 10, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:22:05.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 75000, \"updated_at\": \"2026-06-08T12:33:34.000000Z\", \"kode_barang\": \"064036520222\", \"nama_barang\": \"Tempered Glass iPhone 14\"}','2026-06-08 05:33:34','2026-06-08 05:33:34'),(10,'admin','Barang','update','Memperbarui barang Case iPhone 13/14','{\"id\": 12, \"stok\": 5, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:31:10.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 80000, \"updated_at\": \"2026-06-08T12:33:49.000000Z\", \"kode_barang\": \"8996410\", \"nama_barang\": \"Case iPhone 13/14\"}','2026-06-08 05:33:49','2026-06-08 05:33:49'),(11,'admin','Barang','update','Memperbarui barang Case iPhone 13/14','{\"id\": 12, \"stok\": 5, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:31:10.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 80000, \"updated_at\": \"2026-06-08T12:36:51.000000Z\", \"kode_barang\": \"CASE0001\", \"nama_barang\": \"Case iPhone 13/14\"}','2026-06-08 05:36:51','2026-06-08 05:36:51'),(12,'admin','Barang','update','Memperbarui barang Tempered Glass iPhone 14','{\"id\": 11, \"stok\": 10, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:22:05.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 75000, \"updated_at\": \"2026-06-08T12:37:11.000000Z\", \"kode_barang\": \"TG0001\", \"nama_barang\": \"Tempered Glass iPhone 14\"}','2026-06-08 05:37:11','2026-06-08 05:37:11'),(13,'admin','Barang','update','Memperbarui barang iPhone 13','{\"id\": 1, \"stok\": 13, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 8000000, \"harga_jual\": 9500000, \"updated_at\": \"2026-06-08T12:37:29.000000Z\", \"kode_barang\": \"HP0001\", \"nama_barang\": \"iPhone 13\"}','2026-06-08 05:37:29','2026-06-08 05:37:29'),(14,'admin','Barang','update','Memperbarui barang Case iPhone 13/14','{\"id\": 12, \"stok\": 5, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:31:10.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 80000, \"updated_at\": \"2026-06-08T12:52:23.000000Z\", \"kode_barang\": \"8996410\", \"nama_barang\": \"Case iPhone 13/14\"}','2026-06-08 05:52:23','2026-06-08 05:52:23'),(15,'admin','Barang','update','Memperbarui barang Tempered Glass KU iPhone 14','{\"id\": 11, \"stok\": 10, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:22:05.000000Z\", \"harga_beli\": 60000, \"harga_jual\": 75000, \"updated_at\": \"2026-06-08T12:53:31.000000Z\", \"kode_barang\": \"0064036520222\", \"nama_barang\": \"Tempered Glass KU iPhone 14\"}','2026-06-08 05:53:31','2026-06-08 05:53:31'),(16,'admin','Barang','update','Memperbarui barang iPhone 13','{\"id\": 1, \"stok\": 13, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 8000000, \"harga_jual\": 9000000, \"updated_at\": \"2026-06-08T12:53:50.000000Z\", \"kode_barang\": \"HP0001\", \"nama_barang\": \"iPhone 13\"}','2026-06-08 05:53:50','2026-06-08 05:53:50'),(17,'admin','Barang','create','Menambah barang Mouse wireless SEENDA','{\"id\": 13, \"stok\": 20, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:55:51.000000Z\", \"harga_beli\": 80000, \"harga_jual\": 93000, \"updated_at\": \"2026-06-08T12:55:51.000000Z\", \"kode_barang\": \"104024\", \"nama_barang\": \"Mouse wireless SEENDA\"}','2026-06-08 05:55:51','2026-06-08 05:55:51'),(18,'admin','Barang','update','Memperbarui barang Evercoss M6A','{\"id\": 3, \"stok\": 12, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 1000000, \"harga_jual\": 1600000, \"updated_at\": \"2026-06-08T12:57:43.000000Z\", \"kode_barang\": \"HP002\", \"nama_barang\": \"Evercoss M6A\"}','2026-06-08 05:57:43','2026-06-08 05:57:43'),(19,'admin','Barang','update','Memperbarui barang Evercoss M6A','{\"id\": 3, \"stok\": 12, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 1000000, \"harga_jual\": 1600000, \"updated_at\": \"2026-06-08T12:57:56.000000Z\", \"kode_barang\": \"HP0002\", \"nama_barang\": \"Evercoss M6A\"}','2026-06-08 05:57:56','2026-06-08 05:57:56'),(20,'admin','Barang','create','Menambah barang Tecno Spark 20','{\"id\": 14, \"stok\": 15, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T12:59:56.000000Z\", \"harga_beli\": 1200000, \"harga_jual\": 1800000, \"updated_at\": \"2026-06-08T12:59:56.000000Z\", \"kode_barang\": \"HP0003\", \"nama_barang\": \"Tecno Spark 20\"}','2026-06-08 05:59:56','2026-06-08 05:59:56'),(21,'admin','Barang','update','Memperbarui barang Evercoss M6A','{\"id\": 3, \"stok\": 12, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 1000000, \"harga_jual\": 1600000, \"updated_at\": \"2026-06-08T13:02:55.000000Z\", \"kode_barang\": \"HP00013\", \"nama_barang\": \"Evercoss M6A\"}','2026-06-08 06:02:55','2026-06-08 06:02:55'),(22,'admin','Barang','update','Memperbarui barang Tecno Spark 20','{\"id\": 14, \"stok\": 15, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T12:59:56.000000Z\", \"harga_beli\": 1200000, \"harga_jual\": 1800000, \"updated_at\": \"2026-06-08T13:03:05.000000Z\", \"kode_barang\": \"HP0002\", \"nama_barang\": \"Tecno Spark 20\"}','2026-06-08 06:03:05','2026-06-08 06:03:05'),(23,'admin','Barang','update','Memperbarui barang Evercoss M6A','{\"id\": 3, \"stok\": 12, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 1000000, \"harga_jual\": 1600000, \"updated_at\": \"2026-06-08T13:03:16.000000Z\", \"kode_barang\": \"HP0003\", \"nama_barang\": \"Evercoss M6A\"}','2026-06-08 06:03:16','2026-06-08 06:03:16'),(24,'admin','Barang','update','Memperbarui barang Charger Type-C Original Samsung 25W','{\"id\": 4, \"stok\": 23, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 150000, \"harga_jual\": 200000, \"updated_at\": \"2026-06-08T13:04:59.000000Z\", \"kode_barang\": \"CHR0001\", \"nama_barang\": \"Charger Type-C Original Samsung 25W\"}','2026-06-08 06:04:59','2026-06-08 06:04:59'),(25,'admin','Barang','update','Memperbarui barang Softcase iPhone Clear Premium','{\"id\": 5, \"stok\": 3, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 25000, \"harga_jual\": 50000, \"updated_at\": \"2026-06-08T13:06:56.000000Z\", \"kode_barang\": \"CASE0001\", \"nama_barang\": \"Softcase iPhone Clear Premium\"}','2026-06-08 06:06:56','2026-06-08 06:06:56'),(26,'admin','Barang','update','Memperbarui barang Softcase iPhone Clear Premium','{\"id\": 5, \"stok\": 3, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 50000, \"harga_jual\": 60000, \"updated_at\": \"2026-06-08T13:07:11.000000Z\", \"kode_barang\": \"CASE0001\", \"nama_barang\": \"Softcase iPhone Clear Premium\"}','2026-06-08 06:07:11','2026-06-08 06:07:11'),(27,'admin','Barang','create','Menambah barang Softcase iPhone Clear Standard','{\"id\": 15, \"stok\": 8, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T13:08:23.000000Z\", \"harga_beli\": 25000, \"harga_jual\": 50000, \"updated_at\": \"2026-06-08T13:08:23.000000Z\", \"kode_barang\": \"CASE0002\", \"nama_barang\": \"Softcase iPhone Clear Standard\"}','2026-06-08 06:08:23','2026-06-08 06:08:23'),(28,'admin','Barang','update','Memperbarui barang Softcase iPhone Clear Standard','{\"id\": 15, \"stok\": 8, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T13:08:23.000000Z\", \"harga_beli\": 25000, \"harga_jual\": 35000, \"updated_at\": \"2026-06-08T13:08:46.000000Z\", \"kode_barang\": \"CASE0002\", \"nama_barang\": \"Softcase iPhone Clear Standard\"}','2026-06-08 06:08:46','2026-06-08 06:08:46'),(29,'admin','Barang','update','Memperbarui barang Earphone Bluetooth Samsung Galaxy Buds FE','{\"id\": 7, \"stok\": 15, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 75000, \"harga_jual\": 120000, \"updated_at\": \"2026-06-08T13:11:34.000000Z\", \"kode_barang\": \"EB0001\", \"nama_barang\": \"Earphone Bluetooth Samsung Galaxy Buds FE\"}','2026-06-08 06:11:34','2026-06-08 06:11:34'),(30,'admin','Barang','update','Memperbarui barang Earphone Bluetooth Samsung Galaxy Buds FE','{\"id\": 7, \"stok\": 15, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 250000, \"harga_jual\": 500000, \"updated_at\": \"2026-06-08T13:12:17.000000Z\", \"kode_barang\": \"EB0001\", \"nama_barang\": \"Earphone Bluetooth Samsung Galaxy Buds FE\"}','2026-06-08 06:12:17','2026-06-08 06:12:17'),(31,'admin','Barang','create','Menambah barang Kartu Perdana Indosat','{\"id\": 16, \"stok\": 10, \"kategori\": \"Kartu\", \"created_at\": \"2026-06-08T13:13:30.000000Z\", \"harga_beli\": 5000, \"harga_jual\": 10000, \"updated_at\": \"2026-06-08T13:13:30.000000Z\", \"kode_barang\": \"KR0003\", \"nama_barang\": \"Kartu Perdana Indosat\"}','2026-06-08 06:13:30','2026-06-08 06:13:30'),(32,'admin','Barang','update','Memperbarui barang Kartu Perdana Telkomsel','{\"id\": 8, \"stok\": 49, \"kategori\": \"Kartu\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 5000, \"harga_jual\": 10000, \"updated_at\": \"2026-06-08T13:22:16.000000Z\", \"kode_barang\": \"KR0001\", \"nama_barang\": \"Kartu Perdana Telkomsel\"}','2026-06-08 06:22:16','2026-06-08 06:22:16'),(33,'admin','Barang','update','Memperbarui barang Kartu Perdana XL','{\"id\": 9, \"stok\": 2, \"kategori\": \"Kartu\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 5000, \"harga_jual\": 10000, \"updated_at\": \"2026-06-08T13:22:27.000000Z\", \"kode_barang\": \"KR0002\", \"nama_barang\": \"Kartu Perdana XL\"}','2026-06-08 06:22:27','2026-06-08 06:22:27'),(34,'admin','Barang','create','Menambah barang Realme C2','{\"id\": 17, \"stok\": 5, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T13:27:59.000000Z\", \"harga_beli\": 1300000, \"harga_jual\": 1800000, \"updated_at\": \"2026-06-08T13:27:59.000000Z\", \"kode_barang\": \"HP00013\", \"nama_barang\": \"Realme C2\"}','2026-06-08 06:27:59','2026-06-08 06:27:59'),(35,'admin','Barang','update','Memperbarui barang Tecno Spark 20','{\"id\": 14, \"stok\": 15, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T12:59:56.000000Z\", \"harga_beli\": 1200000, \"harga_jual\": 1700000, \"updated_at\": \"2026-06-08T13:28:11.000000Z\", \"kode_barang\": \"HP0002\", \"nama_barang\": \"Tecno Spark 20\"}','2026-06-08 06:28:11','2026-06-08 06:28:11'),(36,'admin','Barang','update','Memperbarui barang Evercoss M6A','{\"id\": 3, \"stok\": 12, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 1000000, \"harga_jual\": 1600000, \"updated_at\": \"2026-06-08T13:28:35.000000Z\", \"kode_barang\": \"HP0005\", \"nama_barang\": \"Evercoss M6A\"}','2026-06-08 06:28:35','2026-06-08 06:28:35'),(37,'admin','Barang','update','Memperbarui barang Realme C2','{\"id\": 17, \"stok\": 5, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T13:27:59.000000Z\", \"harga_beli\": 1300000, \"harga_jual\": 1800000, \"updated_at\": \"2026-06-08T13:28:49.000000Z\", \"kode_barang\": \"HP0003\", \"nama_barang\": \"Realme C2\"}','2026-06-08 06:28:49','2026-06-08 06:28:49'),(38,'admin','Barang','update','Memperbarui barang Realme C2','{\"id\": 17, \"stok\": 5, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T13:27:59.000000Z\", \"harga_beli\": 1300000, \"harga_jual\": 1800000, \"updated_at\": \"2026-06-08T13:30:22.000000Z\", \"kode_barang\": \"HP0004\", \"nama_barang\": \"Realme C2\"}','2026-06-08 06:30:22','2026-06-08 06:30:22'),(39,'admin','Barang','create','Menambah barang Realme C35','{\"id\": 18, \"stok\": 4, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T13:31:10.000000Z\", \"harga_beli\": 2100000, \"harga_jual\": 2500000, \"updated_at\": \"2026-06-08T13:31:10.000000Z\", \"kode_barang\": \"HP0003\", \"nama_barang\": \"Realme C35\"}','2026-06-08 06:31:10','2026-06-08 06:31:10'),(40,'admin','Barang','update','Memperbarui barang Evercoss M6A','{\"id\": 3, \"stok\": 12, \"kategori\": \"HP\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 1000000, \"harga_jual\": 1300000, \"updated_at\": \"2026-06-08T13:31:48.000000Z\", \"kode_barang\": \"HP0005\", \"nama_barang\": \"Evercoss M6A\"}','2026-06-08 06:31:48','2026-06-08 06:31:48'),(41,'admin','Barang','update','Memperbarui barang Realme C2','{\"id\": 17, \"stok\": 5, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T13:27:59.000000Z\", \"harga_beli\": 1300000, \"harga_jual\": 1700000, \"updated_at\": \"2026-06-08T13:32:26.000000Z\", \"kode_barang\": \"HP0004\", \"nama_barang\": \"Realme C2\"}','2026-06-08 06:32:26','2026-06-08 06:32:26'),(42,'admin','Barang','update','Memperbarui barang Realme C2','{\"id\": 17, \"stok\": 5, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T13:27:59.000000Z\", \"harga_beli\": 1300000, \"harga_jual\": 1600000, \"updated_at\": \"2026-06-08T13:32:53.000000Z\", \"kode_barang\": \"HP0004\", \"nama_barang\": \"Realme C2\"}','2026-06-08 06:32:53','2026-06-08 06:32:53'),(43,'admin','Barang','update','Memperbarui barang Tecno Spark 20','{\"id\": 14, \"stok\": 15, \"kategori\": \"HP\", \"created_at\": \"2026-06-08T12:59:56.000000Z\", \"harga_beli\": 1200000, \"harga_jual\": 1500000, \"updated_at\": \"2026-06-08T13:33:24.000000Z\", \"kode_barang\": \"HP0002\", \"nama_barang\": \"Tecno Spark 20\"}','2026-06-08 06:33:24','2026-06-08 06:33:24'),(44,'admin','E-Wallet','create','Mencatat transaksi e-wallet EWL-20260609-NNMV4','{\"id\": 1, \"kasir\": \"admin\", \"status\": \"sukses\", \"nominal\": 350000, \"tanggal\": \"2026-06-09\", \"provider\": \"ShopeePay\", \"created_at\": \"2026-06-09T12:26:43.000000Z\", \"keterangan\": \"Top up Shopeepay\", \"updated_at\": \"2026-06-09T12:26:43.000000Z\", \"biaya_admin\": 5000, \"total_bayar\": 355000, \"nama_customer\": \"Aulia Rahmawati\", \"nomor_ewallet\": \"081410756149\", \"kode_transaksi\": \"EWL-20260609-NNMV4\", \"jenis_transaksi\": \"top_up\"}','2026-06-09 05:26:43','2026-06-09 05:26:43'),(45,'admin','Retur Supplier','create','Admin membuat retur supplier Mouse wireless SEENDA sebanyak 3 unit.','{\"id\": 1, \"kasir\": \"admin\", \"barang_id\": 13, \"created_at\": \"2026-06-17T03:33:39.000000Z\", \"keterangan\": null, \"updated_at\": \"2026-06-17T03:33:39.000000Z\", \"kode_barang\": \"104024\", \"nama_barang\": \"Mouse wireless SEENDA\", \"nomor_retur\": \"RET-20260617-0001\", \"alasan_retur\": \"Tidak Berfungsi Dengan Baik\", \"jumlah_retur\": 3, \"status_retur\": \"diproses\", \"nama_supplier\": \"Supplier Aksesoris\", \"tanggal_retur\": \"2026-06-17T00:00:00.000000Z\"}','2026-06-16 20:33:39','2026-06-16 20:33:39'),(46,'admin','Retur Supplier','update','Admin mengubah status retur menjadi Diterima.','{\"id\": 1, \"kasir\": \"admin\", \"barang_id\": 13, \"created_at\": \"2026-06-17T03:33:39.000000Z\", \"keterangan\": null, \"updated_at\": \"2026-06-17T03:34:10.000000Z\", \"kode_barang\": \"104024\", \"nama_barang\": \"Mouse wireless SEENDA\", \"nomor_retur\": \"RET-20260617-0001\", \"alasan_retur\": \"Tidak Berfungsi Dengan Baik\", \"jumlah_retur\": 3, \"status_retur\": \"diterima\", \"nama_supplier\": \"Supplier Aksesoris\", \"tanggal_retur\": \"2026-06-17T00:00:00.000000Z\", \"stok_dikurangi\": true}','2026-06-16 20:34:10','2026-06-16 20:34:10'),(47,'admin','Retur Supplier','update','Admin mengubah status retur menjadi Ditolak.','{\"id\": 1, \"kasir\": \"admin\", \"barang_id\": 13, \"created_at\": \"2026-06-17T03:33:39.000000Z\", \"keterangan\": null, \"updated_at\": \"2026-06-17T03:34:19.000000Z\", \"kode_barang\": \"104024\", \"nama_barang\": \"Mouse wireless SEENDA\", \"nomor_retur\": \"RET-20260617-0001\", \"alasan_retur\": \"Tidak Berfungsi Dengan Baik\", \"jumlah_retur\": 3, \"status_retur\": \"ditolak\", \"nama_supplier\": \"Supplier Aksesoris\", \"tanggal_retur\": \"2026-06-17T00:00:00.000000Z\", \"stok_dikurangi\": false}','2026-06-16 20:34:19','2026-06-16 20:34:19'),(48,'admin','Retur Supplier','update','Admin mengubah status retur menjadi Diterima.','{\"id\": 1, \"kasir\": \"admin\", \"barang_id\": 13, \"created_at\": \"2026-06-17T03:33:39.000000Z\", \"keterangan\": null, \"updated_at\": \"2026-06-17T03:34:27.000000Z\", \"kode_barang\": \"104024\", \"nama_barang\": \"Mouse wireless SEENDA\", \"nomor_retur\": \"RET-20260617-0001\", \"alasan_retur\": \"Tidak Berfungsi Dengan Baik\", \"jumlah_retur\": 3, \"status_retur\": \"diterima\", \"nama_supplier\": \"Supplier Aksesoris\", \"tanggal_retur\": \"2026-06-17T00:00:00.000000Z\", \"stok_dikurangi\": true}','2026-06-16 20:34:27','2026-06-16 20:34:27'),(49,'admin','Barang','update','Memperbarui barang Mouse wireless SEENDA','{\"id\": 13, \"stok\": 20, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-06-08T12:55:51.000000Z\", \"harga_beli\": 80000, \"harga_jual\": 93000, \"updated_at\": \"2026-06-17T04:05:15.000000Z\", \"kode_barang\": \"104024\", \"nama_barang\": \"Mouse wireless SEENDA\"}','2026-06-16 21:05:15','2026-06-16 21:05:15'),(50,'admin','Barang','update','Memperbarui barang Softcase iPhone Clear Premium','{\"id\": 5, \"stok\": 8, \"kategori\": \"Aksesoris\", \"created_at\": \"2026-05-22T11:08:37.000000Z\", \"harga_beli\": 50000, \"harga_jual\": 60000, \"updated_at\": \"2026-06-17T04:05:36.000000Z\", \"kode_barang\": \"CASE0001\", \"nama_barang\": \"Softcase iPhone Clear Premium\"}','2026-06-16 21:05:36','2026-06-16 21:05:36'),(51,'admin','Retur Supplier','create','Admin membuat retur supplier Softcase iPhone Clear Standard sebanyak 2 unit.','{\"id\": 2, \"kasir\": \"admin\", \"barang_id\": 15, \"created_at\": \"2026-06-18T03:03:27.000000Z\", \"keterangan\": null, \"updated_at\": \"2026-06-18T03:03:27.000000Z\", \"kode_barang\": \"CASE0002\", \"nama_barang\": \"Softcase iPhone Clear Standard\", \"nomor_retur\": \"RET-20260618-0001\", \"alasan_retur\": \"Mulai Menguning Casenya\", \"jumlah_retur\": 2, \"status_retur\": \"diproses\", \"nama_supplier\": \"Supplier Aksesoris\", \"tanggal_retur\": \"2026-06-18T00:00:00.000000Z\"}','2026-06-17 20:03:27','2026-06-17 20:03:27'),(52,'admin','Penjualan','create','Mencatat transaksi penjualan TRX-20260618-XRO2PI','{\"id\": 6, \"kasir\": \"admin\", \"status\": \"lunas\", \"details\": [{\"id\": 11, \"jumlah\": 1, \"subtotal\": \"1600000.00\", \"barang_id\": 17, \"created_at\": \"2026-06-18T05:44:32.000000Z\", \"updated_at\": \"2026-06-18T05:44:32.000000Z\", \"kode_barang\": \"HP0004\", \"nama_barang\": \"Realme C2\", \"harga_satuan\": \"1600000.00\", \"harga_beli_satuan\": \"1300000.00\", \"transaksi_penjualan_id\": 6}], \"tanggal\": \"2026-06-18T00:00:00.000000Z\", \"kembalian\": \"0.00\", \"created_at\": \"2026-06-18T05:44:32.000000Z\", \"uang_bayar\": \"1600000.00\", \"updated_at\": \"2026-06-18T05:44:32.000000Z\", \"total_harga\": \"1600000.00\", \"alasan_batal\": null, \"kode_transaksi\": \"TRX-20260618-XRO2PI\", \"dibatalkan_pada\": null, \"metode_pembayaran\": \"qris\"}','2026-06-17 22:44:32','2026-06-17 22:44:32'),(63,'admin','E-Wallet','create','Mencatat transaksi e-wallet EWL-20260630-29YUZ','{\"id\": 3, \"kasir\": \"admin\", \"status\": \"sukses\", \"nominal\": 50000, \"tanggal\": \"2026-06-30\", \"provider\": \"DANA\", \"created_at\": \"2026-06-30T15:21:39.000000Z\", \"keterangan\": \"-\", \"updated_at\": \"2026-06-30T15:21:39.000000Z\", \"biaya_admin\": 2000, \"total_bayar\": 52000, \"nama_customer\": \"Intan\", \"nomor_ewallet\": \"085384061798\", \"kode_transaksi\": \"EWL-20260630-29YUZ\", \"jenis_transaksi\": \"top_up\"}','2026-06-30 08:21:39','2026-06-30 08:21:39'),(64,'admin','Pulsa','create','Admin menambahkan transaksi BRILink Pulsa/Paket Data sebesar Rp80.000 dengan biaya admin Rp5.000','{\"id\": 1, \"harga\": 80000, \"kasir\": \"admin\", \"produk\": \"Paket Data 80.000\", \"tanggal\": \"2026-07-03T00:00:00.000000Z\", \"operator\": \"Telkomsel\", \"provider\": \"Fastpay\", \"created_at\": \"2026-07-03T10:03:48.000000Z\", \"updated_at\": \"2026-07-03T10:03:48.000000Z\", \"biaya_admin\": 5000, \"jenis_kartu\": \"Kartu Konter\", \"total_bayar\": 85000, \"nomor_tujuan\": \"081510726158\", \"jenis_layanan\": \"pulsa\", \"jenis_nasabah\": \"eksternal\", \"kode_transaksi\": \"PLS-20260703-UA5YMS\"}','2026-07-03 03:03:48','2026-07-03 03:03:48'),(65,'admin','Penjualan','create','Mencatat transaksi penjualan TRX-20260718-GQ78O5','{\"id\": 10, \"kasir\": \"admin\", \"status\": \"lunas\", \"details\": [{\"id\": 15, \"jumlah\": 1, \"subtotal\": \"25000.00\", \"barang_id\": 27, \"created_at\": \"2026-07-18T08:40:06.000000Z\", \"updated_at\": \"2026-07-18T08:40:06.000000Z\", \"kode_barang\": \"AK003\", \"nama_barang\": \"Tempered Glass\", \"harga_satuan\": \"25000.00\", \"harga_beli_satuan\": \"10000.00\", \"transaksi_penjualan_id\": 10}], \"tanggal\": \"2026-07-18T00:00:00.000000Z\", \"kembalian\": \"0.00\", \"created_at\": \"2026-07-18T08:40:06.000000Z\", \"uang_bayar\": \"25000.00\", \"updated_at\": \"2026-07-18T08:40:06.000000Z\", \"total_harga\": \"25000.00\", \"alasan_batal\": null, \"kode_transaksi\": \"TRX-20260718-GQ78O5\", \"dibatalkan_pada\": null, \"metode_pembayaran\": \"qris\"}','2026-07-18 01:40:06','2026-07-18 01:40:06'),(66,'admin','Penjualan','create','Mencatat transaksi penjualan TRX-20260718-VJQJ1F','{\"id\": 11, \"kasir\": \"admin\", \"status\": \"lunas\", \"details\": [{\"id\": 16, \"jumlah\": 1, \"subtotal\": \"10000.00\", \"barang_id\": 29, \"created_at\": \"2026-07-18T09:28:12.000000Z\", \"updated_at\": \"2026-07-18T09:28:12.000000Z\", \"kode_barang\": \"KR001\", \"nama_barang\": \"Kartu Perdana Telkomsel\", \"harga_satuan\": \"10000.00\", \"harga_beli_satuan\": \"5000.00\", \"transaksi_penjualan_id\": 11}], \"tanggal\": \"2026-07-18T00:00:00.000000Z\", \"kembalian\": \"0.00\", \"created_at\": \"2026-07-18T09:28:12.000000Z\", \"uang_bayar\": \"10000.00\", \"updated_at\": \"2026-07-18T09:28:12.000000Z\", \"total_harga\": \"10000.00\", \"alasan_batal\": null, \"kode_transaksi\": \"TRX-20260718-VJQJ1F\", \"dibatalkan_pada\": null, \"metode_pembayaran\": \"qris\"}','2026-07-18 02:28:12','2026-07-18 02:28:12'),(67,'admin','Retur Supplier','create','Admin membuat retur supplier Kartu Perdana Indosat sebanyak 2 unit.','{\"id\": 5, \"kasir\": \"admin\", \"barang_id\": 16, \"created_at\": \"2026-07-28T14:09:33.000000Z\", \"keterangan\": \"reject\", \"updated_at\": \"2026-07-28T14:09:33.000000Z\", \"kode_barang\": \"KR0003\", \"nama_barang\": \"Kartu Perdana Indosat\", \"nomor_retur\": \"RET-20260728-0001\", \"alasan_retur\": \"barang rusak\", \"jumlah_retur\": 2, \"status_retur\": \"diproses\", \"nama_supplier\": \"supplier kartu\", \"tanggal_retur\": \"2026-07-28T00:00:00.000000Z\"}','2026-07-28 07:09:33','2026-07-28 07:09:33'),(68,'admin','Retur Supplier','update','Admin mengubah status menjadi Diterima.','{\"id\": 5, \"kasir\": \"admin\", \"barang_id\": 16, \"created_at\": \"2026-07-28T14:09:33.000000Z\", \"keterangan\": \"reject\", \"updated_at\": \"2026-07-28T14:10:39.000000Z\", \"kode_barang\": \"KR0003\", \"nama_barang\": \"Kartu Perdana Indosat\", \"nomor_retur\": \"RET-20260728-0001\", \"alasan_retur\": \"barang rusak\", \"jumlah_retur\": 2, \"status_retur\": \"diterima\", \"nama_supplier\": \"supplier kartu\", \"tanggal_retur\": \"2026-07-28T00:00:00.000000Z\", \"stok_dikurangi\": true}','2026-07-28 07:10:39','2026-07-28 07:10:39'),(69,'admin','Transfer','create','Admin menambahkan transaksi BRILink Transfer sebesar Rp150.000 dengan biaya admin Rp8.000','{\"id\": 5, \"kasir\": \"admin\", \"tanggal\": \"2026-07-31T00:00:00.000000Z\", \"provider\": \"BRILink Mobile\", \"created_at\": \"2026-07-31T13:09:37.000000Z\", \"updated_at\": \"2026-07-31T13:09:37.000000Z\", \"bank_tujuan\": \"BRI\", \"biaya_admin\": 8000, \"jenis_kartu\": \"Kartu Konter\", \"total_bayar\": 158000, \"jenis_nasabah\": \"eksternal\", \"nama_penerima\": \"Yanto\", \"jenis_transfer\": \"Sesama BRI\", \"kode_transaksi\": \"TRF-20260731-ZAHR5Z\", \"nominal_transfer\": 150000, \"nomor_rekening_tujuan\": \"0028057678\"}','2026-07-31 06:09:37','2026-07-31 06:09:37'),(70,'admin','Setor Tunai','create','Admin menambahkan transaksi BRILink Setor Tunai sebesar Rp200.000 dengan biaya admin Rp8.000','{\"id\": 2, \"kasir\": \"admin\", \"tanggal\": \"2026-07-31T00:00:00.000000Z\", \"provider\": \"BRILink Mobile\", \"created_at\": \"2026-07-31T13:27:06.000000Z\", \"keterangan\": null, \"updated_at\": \"2026-07-31T13:27:06.000000Z\", \"bank_tujuan\": \"BRI\", \"biaya_admin\": 8000, \"jenis_kartu\": \"Kartu Konter\", \"sumber_dana\": null, \"total_bayar\": 208000, \"jenis_nasabah\": \"eksternal\", \"jenis_setoran\": \"biasa\", \"nominal_setor\": 200000, \"kode_transaksi\": \"ST-20260731-ZOF7EQ\", \"nama_pemilik_rekening\": \"Ardani\", \"nomor_rekening_tujuan\": \"758801004681613\"}','2026-07-31 06:27:06','2026-07-31 06:27:06'),(71,'admin','Pembayaran Tagihan','create','Admin menambahkan transaksi BRILink Pembayaran Tagihan sebesar Rp100.000 dengan biaya admin Rp2.000','{\"id\": 2, \"kasir\": \"admin\", \"tanggal\": \"2026-07-31T00:00:00.000000Z\", \"provider\": \"BRILink Mobile\", \"created_at\": \"2026-07-31T13:30:54.000000Z\", \"updated_at\": \"2026-07-31T13:30:54.000000Z\", \"biaya_admin\": 2000, \"jenis_kartu\": \"Kartu Nasabah\", \"total_bayar\": 102000, \"jenis_layanan\": \"indihome\", \"jenis_nasabah\": \"internal\", \"jumlah_tagihan\": 100000, \"kode_transaksi\": \"TAG-20260731-7TTXCI\", \"nama_pelanggan\": \"Kasih\", \"nomor_pelanggan\": \"81310684159\"}','2026-07-31 06:30:54','2026-07-31 06:30:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barang`
--

LOCK TABLES `barang` WRITE;
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
INSERT INTO `barang` VALUES (1,'HP0001','iPhone 13','HP',13,8000000.00,9000000.00,'2026-05-22 04:08:37','2026-06-08 05:53:50'),(3,'HP0005','Evercoss M6A','HP',12,1000000.00,1300000.00,'2026-05-22 04:08:37','2026-06-08 06:31:48'),(4,'CHR0001','Charger Type-C Original Samsung 25W','Aksesoris',23,150000.00,200000.00,'2026-05-22 04:08:37','2026-06-08 06:04:59'),(5,'CASE0001','Softcase iPhone Clear Premium','Aksesoris',8,50000.00,60000.00,'2026-05-22 04:08:37','2026-06-16 21:05:36'),(7,'EB0001','Earphone Bluetooth Samsung Galaxy Buds FE','Aksesoris',15,250000.00,500000.00,'2026-05-22 04:08:37','2026-06-08 06:12:17'),(8,'KR0001','Kartu Perdana Telkomsel','Kartu',49,5000.00,10000.00,'2026-05-22 04:08:37','2026-06-08 06:22:16'),(9,'KR0002','Kartu Perdana XL','Kartu',2,5000.00,10000.00,'2026-05-22 04:08:37','2026-06-08 06:22:27'),(11,'0064036520222','Tempered Glass KU iPhone 14','Aksesoris',10,60000.00,75000.00,'2026-06-08 05:22:05','2026-06-08 05:53:31'),(12,'8996410','Case iPhone 13/14','Aksesoris',5,60000.00,80000.00,'2026-06-08 05:31:10','2026-06-08 05:52:23'),(13,'104024','Mouse wireless SEENDA','Aksesoris',20,80000.00,93000.00,'2026-06-08 05:55:51','2026-06-16 21:05:15'),(14,'HP0002','Tecno Spark 20','HP',15,1200000.00,1500000.00,'2026-06-08 05:59:56','2026-06-08 06:33:24'),(15,'CASE0002','Softcase iPhone Clear Standard','Aksesoris',8,25000.00,35000.00,'2026-06-08 06:08:23','2026-06-08 06:08:46'),(16,'KR0003','Kartu Perdana Indosat','Kartu',8,5000.00,10000.00,'2026-06-08 06:13:30','2026-07-28 07:10:39'),(17,'HP0004','Realme C2','HP',4,1300000.00,1600000.00,'2026-06-08 06:27:59','2026-06-17 22:44:32'),(18,'HP0003','Realme C35','HP',4,2100000.00,2500000.00,'2026-06-08 06:31:10','2026-06-08 06:31:10'),(22,'HP001','iPhone 13','HP',10,8000000.00,9500000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19'),(23,'HP002','Samsung S23','HP',8,9000000.00,10500000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19'),(24,'HP003','Xiaomi 14','HP',12,5000000.00,6200000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19'),(25,'AK001','Charger Type-C','Aksesoris',25,50000.00,85000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19'),(26,'AK002','Softcase iPhone','Aksesoris',3,25000.00,50000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19'),(27,'AK003','Tempered Glass','Aksesoris',29,10000.00,25000.00,'2026-06-30 08:05:19','2026-07-18 01:40:06'),(28,'AK004','Earphone Bluetooth','Aksesoris',15,75000.00,120000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19'),(29,'KR001','Kartu Perdana Telkomsel','Kartu',49,5000.00,10000.00,'2026-06-30 08:05:19','2026-07-18 02:28:12'),(30,'KR002','Kartu Perdana XL','Kartu',2,5000.00,10000.00,'2026-06-30 08:05:19','2026-06-30 08:05:19');
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
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_biaya` enum('persen','nominal','range') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai` decimal(15,2) NOT NULL,
  `aturan_range` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `biaya_admin_layanan_jenis_nasabah_index` (`layanan`,`jenis_nasabah`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biaya_admin`
--

LOCK TABLES `biaya_admin` WRITE;
/*!40000 ALTER TABLE `biaya_admin` DISABLE KEYS */;
INSERT INTO `biaya_admin` VALUES (1,'transfer',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-05-22 04:08:37','2026-07-03 03:06:50'),(2,'tarik_tunai',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-05-22 04:08:37','2026-07-03 03:06:50'),(3,'setor_tunai',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-05-22 04:08:37','2026-07-03 03:06:50'),(4,'tagihan',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-05-22 04:08:37','2026-07-03 03:06:50'),(5,'pulsa',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-05-22 04:08:37','2026-07-03 03:06:50'),(6,'paket_data',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-05-22 04:08:37','2026-07-03 03:06:50'),(7,'ewallet',NULL,'range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-06-07 16:27:29','2026-07-03 03:06:50'),(8,'brilink','internal','range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 2000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 5000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 10000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 15000}, {\"max\": null, \"min\": 2000001, \"biaya\": 20000}]',1,'2026-06-16 05:02:01','2026-07-03 03:06:50'),(9,'brilink','eksternal','range',0.00,'[{\"max\": 100000, \"min\": 1, \"biaya\": 5000}, {\"max\": 500000, \"min\": 100001, \"biaya\": 8000}, {\"max\": 1000000, \"min\": 500001, \"biaya\": 12000}, {\"max\": 2000000, \"min\": 1000001, \"biaya\": 18000}, {\"max\": null, \"min\": 2000001, \"biaya\": 25000}]',1,'2026-06-16 05:02:01','2026-07-03 03:06:50');
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
  `jenis_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `biaya_admin_brilink` VALUES (1,'transfer','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(2,'transfer','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(3,'transfer','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(4,'transfer','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(5,'transfer','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(6,'transfer','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(7,'transfer','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(8,'transfer','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(9,'transfer','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(10,'transfer','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(11,'tarik_tunai','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(12,'tarik_tunai','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(13,'tarik_tunai','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(14,'tarik_tunai','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(15,'tarik_tunai','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(16,'tarik_tunai','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(17,'tarik_tunai','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(18,'tarik_tunai','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(19,'tarik_tunai','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(20,'tarik_tunai','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(21,'setor_tunai','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(22,'setor_tunai','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(23,'setor_tunai','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(24,'setor_tunai','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(25,'setor_tunai','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(26,'setor_tunai','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(27,'setor_tunai','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(28,'setor_tunai','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(29,'setor_tunai','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(30,'setor_tunai','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(31,'tagihan','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(32,'tagihan','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(33,'tagihan','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(34,'tagihan','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(35,'tagihan','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(36,'tagihan','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(37,'tagihan','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(38,'tagihan','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(39,'tagihan','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(40,'tagihan','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(41,'pulsa_paket_data','internal','Kartu Nasabah',1.00,100000.00,2000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(42,'pulsa_paket_data','internal','Kartu Nasabah',100001.00,500000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(43,'pulsa_paket_data','internal','Kartu Nasabah',500001.00,1000000.00,10000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(44,'pulsa_paket_data','internal','Kartu Nasabah',1000001.00,2000000.00,15000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(45,'pulsa_paket_data','internal','Kartu Nasabah',2000001.00,NULL,20000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(46,'pulsa_paket_data','eksternal','Kartu Konter',1.00,100000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(47,'pulsa_paket_data','eksternal','Kartu Konter',100001.00,500000.00,8000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(48,'pulsa_paket_data','eksternal','Kartu Konter',500001.00,1000000.00,12000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(49,'pulsa_paket_data','eksternal','Kartu Konter',1000001.00,2000000.00,18000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(50,'pulsa_paket_data','eksternal','Kartu Konter',2000001.00,NULL,25000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(51,'ewallet',NULL,NULL,1.00,100000.00,2000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(52,'ewallet',NULL,NULL,100001.00,500000.00,5000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(53,'ewallet',NULL,NULL,500001.00,1000000.00,10000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(54,'ewallet',NULL,NULL,1000001.00,2000000.00,15000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08'),(55,'ewallet',NULL,NULL,2000001.00,NULL,20000.00,1,'2026-06-16 06:08:08','2026-06-16 06:08:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_penjualan`
--

LOCK TABLES `detail_penjualan` WRITE;
/*!40000 ALTER TABLE `detail_penjualan` DISABLE KEYS */;
INSERT INTO `detail_penjualan` VALUES (6,1,1,'HP001','iPhone 13',1,9500000.00,0.00,9500000.00,'2026-06-09 06:08:21','2026-06-09 06:08:21'),(7,2,4,'AK001','Charger Type-C',1,85000.00,0.00,85000.00,'2026-06-09 06:08:21','2026-06-09 06:08:21'),(8,3,1,'HP001','iPhone 13',1,9500000.00,0.00,9500000.00,'2026-06-09 06:08:21','2026-06-09 06:08:21'),(9,4,9,'KR002','Kartu Perdana XL',1,10000.00,0.00,10000.00,'2026-06-09 06:08:21','2026-06-09 06:08:21'),(10,5,8,'KR001','Kartu Perdana Telkomsel',1,10000.00,0.00,10000.00,'2026-06-09 06:08:21','2026-06-09 06:08:21'),(11,6,17,'HP0004','Realme C2',1,1600000.00,1300000.00,1600000.00,'2026-06-17 22:44:32','2026-06-17 22:44:32'),(15,10,27,'AK003','Tempered Glass',1,25000.00,10000.00,25000.00,'2026-07-18 01:40:06','2026-07-18 01:40:06'),(16,11,29,'KR001','Kartu Perdana Telkomsel',1,10000.00,5000.00,10000.00,'2026-07-18 02:28:12','2026-07-18 02:28:12');
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
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2024_01_01_000001_create_barang_table',1),(6,'2024_01_01_000002_create_transaksi_penjualan_table',1),(7,'2024_01_01_000003_create_detail_penjualan_table',1),(8,'2024_01_01_000004_create_pembayaran_qris_table',1),(9,'2024_01_01_000005_create_transaksi_transfer_table',1),(10,'2024_01_01_000006_create_transaksi_tarik_tunai_table',1),(11,'2024_01_01_000007_create_transaksi_setor_tunai_table',1),(12,'2024_01_01_000008_create_tabungan_customer_table',1),(13,'2024_01_01_000009_create_pembayaran_tagihan_table',1),(14,'2024_01_01_000010_create_transaksi_pulsa_table',1),(15,'2024_01_01_000011_create_biaya_admin_table',1),(16,'2026_05_23_000001_add_range_to_biaya_admin_table',2),(17,'2026_06_08_000001_create_transaksi_ewallet_table',3),(18,'2026_06_08_000002_create_stok_mutasi_table',3),(19,'2026_06_08_000003_create_activity_logs_table',3),(20,'2026_06_08_000004_add_harga_beli_to_detail_penjualan_table',3),(21,'2026_06_08_000005_add_ewallet_biaya_admin',3),(22,'2026_06_08_000006_add_cancel_columns_to_transaksi_penjualan',4),(23,'2026_06_08_000007_create_retur_penjualan_table',4),(24,'2026_06_08_000008_create_pengeluaran_toko_table',4),(25,'2026_06_08_000009_create_password_reset_codes_table',4),(26,'2026_06_08_000010_drop_unused_tables',5),(27,'2026_06_08_000011_backfill_harga_beli_satuan_detail_penjualan',6),(28,'2026_06_08_000002_add_bank_tujuan_to_transaksi_transfer_table',7),(29,'2026_06_08_000003_add_jenis_mutasi_to_tabungan_customer_table',8),(30,'2026_06_09_000001_drop_tabungan_customer_table',9),(31,'2026_06_16_000001_add_jenis_nasabah_to_brilink_transactions',10),(32,'2026_06_16_000002_create_retur_supplier_table',10),(33,'2026_06_16_000003_add_jenis_nasabah_to_biaya_admin_table',11),(34,'2026_06_16_000004_create_biaya_admin_brilink_table',12),(35,'2026_06_17_000001_create_retur_pelanggan_table',13),(36,'2026_07_03_000001_add_provider_to_brilink_transactions',14),(37,'2026_07_03_000002_create_providers_table',15),(40,'2026_08_10_000001_normalize_business_ids_and_varchar_lengths',16);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `snap_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pembayaran` enum('pending','settlement','expire','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pembayaran_qris_order_id_unique` (`order_id`),
  KEY `pembayaran_qris_transaksi_penjualan_id_foreign` (`transaksi_penjualan_id`),
  CONSTRAINT `pembayaran_qris_transaksi_penjualan_id_foreign` FOREIGN KEY (`transaksi_penjualan_id`) REFERENCES `transaksi_penjualan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembayaran_qris`
--

LOCK TABLES `pembayaran_qris` WRITE;
/*!40000 ALTER TABLE `pembayaran_qris` DISABLE KEYS */;
INSERT INTO `pembayaran_qris` VALUES (1,'QRIS-20260618054219-SNTXB',6,1600000.00,NULL,'settlement',NULL,'{\"source\": \"manual_status_check\", \"confirmed_at\": \"2026-06-18T05:44:32.154985Z\"}','2026-06-17 22:44:32','2026-06-17 22:44:32'),(2,'QRIS-20260718083726-HLOBA',10,25000.00,NULL,'settlement',NULL,'{\"source\": \"manual_status_check\", \"confirmed_at\": \"2026-07-18T08:40:06.316357Z\"}','2026-07-18 01:40:06','2026-07-18 01:40:06'),(3,'QRIS-20260718092743-ZQNWH',11,10000.00,NULL,'settlement',NULL,'{\"source\": \"manual_status_check\", \"confirmed_at\": \"2026-07-18T09:28:12.354944Z\"}','2026-07-18 02:28:12','2026-07-18 02:28:12');
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
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `jenis_layanan` enum('pln','pdam','bpjs','indihome','angsuran','lainnya') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_pelanggan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_pelanggan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_tagihan` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `status` enum('sukses','gagal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pembayaran_tagihan_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembayaran_tagihan`
--

LOCK TABLES `pembayaran_tagihan` WRITE;
/*!40000 ALTER TABLE `pembayaran_tagihan` DISABLE KEYS */;
INSERT INTO `pembayaran_tagihan` VALUES (1,'TAG-20260609-2Y1YD4','2026-06-09','BRILink Mobile','internal','Kartu Nasabah','pln','123456789012','Puji',150000.00,5000.00,155000.00,'sukses','admin','2026-06-09 05:25:47','2026-06-09 05:25:47'),(2,'TAG-20260731-7TTXCI','2026-07-31','BRILink Mobile','internal','Kartu Nasabah','indihome','81310684159','Kasih',100000.00,2000.00,102000.00,'sukses','admin','2026-07-31 06:30:54','2026-07-31 06:30:54');
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
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (21,'App\\Models\\User',1,'auth_token','0e4bcb897629474523112d0a33309ea43d6462f4252e565230207c481d479a68','[\"*\"]','2026-05-22 22:15:36',NULL,'2026-05-22 22:15:29','2026-05-22 22:15:36'),(22,'App\\Models\\User',1,'auth_token','bc3736d367851e5476cec558fb415becca44ff2c1864e33d467818780761adda','[\"*\"]','2026-05-22 22:21:13',NULL,'2026-05-22 22:15:46','2026-05-22 22:21:13'),(26,'App\\Models\\User',1,'auth_token','fed22d6d5650092746f4915190da1dedd05c2586a3c11f46830d65d956292ffe','[\"*\"]','2026-05-23 01:25:13',NULL,'2026-05-23 00:14:12','2026-05-23 01:25:13'),(31,'App\\Models\\User',1,'auth_token','e3fb9546a0cd36285f7169443d337fd0944b784395c91960015544e207a45a08','[\"*\"]','2026-06-02 20:32:28',NULL,'2026-06-02 20:23:20','2026-06-02 20:32:28'),(33,'App\\Models\\User',1,'auth_token','2c49d2696d8775e9f70d9e46b7ceeb0badfadd68f48ba2a52cdfd45139d9ceab','[\"*\"]','2026-06-02 22:00:25',NULL,'2026-06-02 21:34:10','2026-06-02 22:00:25'),(35,'App\\Models\\User',1,'auth_token','3528fd11738ac6a0bc9c0b0f03fa161d72488d781ec3c6b5f0b96d15e1c4a62d','[\"*\"]','2026-06-07 15:27:13',NULL,'2026-06-05 04:29:17','2026-06-07 15:27:13'),(37,'App\\Models\\User',1,'auth_token','2b1ddaa80234adb86df4f1f7169e29ce934ab8ce06472cd05108fa26432b3929','[\"*\"]','2026-06-07 18:00:19',NULL,'2026-06-07 17:15:24','2026-06-07 18:00:19'),(38,'App\\Models\\User',1,'auth_token','8d5c4102b682e34c7dea8f816926944491f0acd109f9a96419658dac93447baf','[\"*\"]','2026-06-07 18:05:54',NULL,'2026-06-07 18:05:36','2026-06-07 18:05:54'),(39,'App\\Models\\User',1,'auth_token','c56763c2af63e70bd0f2f5bb869ae08b096190359b9bf6381004499bed2296b4','[\"*\"]','2026-06-08 04:40:53',NULL,'2026-06-07 19:22:00','2026-06-08 04:40:53'),(41,'App\\Models\\User',1,'auth_token','c6149a1912b59af31936858096a5fecc8a7b7deeb103aba2f1374e2b8329003c','[\"*\"]','2026-06-07 20:08:03',NULL,'2026-06-07 20:06:51','2026-06-07 20:08:03'),(43,'App\\Models\\User',1,'auth_token','7138d5af8a101178a0a64413bb0eaa3e9fb0ee461f1b839551dda02a4ace6159','[\"*\"]','2026-06-07 22:45:26',NULL,'2026-06-07 21:37:24','2026-06-07 22:45:26'),(44,'App\\Models\\User',1,'auth_token','d8481a3e5a15e7ba5aca6a16cff226ab322bf2b8f1689d2ab2a245d3ff40c2ff','[\"*\"]','2026-06-08 04:50:43',NULL,'2026-06-08 00:30:29','2026-06-08 04:50:43'),(46,'App\\Models\\User',1,'auth_token','f501aeaa6e99302eda3e0e27c4ffb9ac8eb91609d3360578fe615e53975bd835','[\"*\"]','2026-06-08 04:51:39',NULL,'2026-06-08 04:51:17','2026-06-08 04:51:39'),(47,'App\\Models\\User',1,'auth_token','4dda1e9d3e419311bb7926758551292fe3e835f9a6e1f9d8a0dba988c92a98f0','[\"*\"]','2026-06-08 04:51:54',NULL,'2026-06-08 04:51:42','2026-06-08 04:51:54'),(48,'App\\Models\\User',1,'auth_token','654680d7526be5a4019415ca1c75526280552b07613b99c1f59b457b7e3791a6','[\"*\"]','2026-06-08 21:03:17',NULL,'2026-06-08 04:51:59','2026-06-08 21:03:17'),(51,'App\\Models\\User',1,'auth_token','b9b43eeec0ab120185bc1c6720267dafbbaa3ee2e4f7989c54cb94d87976e077','[\"*\"]','2026-06-08 23:18:59',NULL,'2026-06-08 23:18:49','2026-06-08 23:18:59'),(52,'App\\Models\\User',1,'auth_token','94a4a37f609396ef6df8039545b71592bef4d104455b7f033ccb32be7042f813','[\"*\"]','2026-06-16 05:28:33',NULL,'2026-06-09 04:21:09','2026-06-16 05:28:33'),(53,'App\\Models\\User',1,'auth_token','9faf2a2f238c8b7e6b05e8130af489ea67746425d8a8015eb6842c593ead71f2','[\"*\"]','2026-06-15 00:36:14',NULL,'2026-06-14 21:37:55','2026-06-15 00:36:14'),(54,'App\\Models\\User',1,'auth_token','1271b8e2d220c3946ed4efac0600652fce1ac7f465f32e08be91a20aaf42075b','[\"*\"]','2026-06-17 20:00:18',NULL,'2026-06-15 19:40:57','2026-06-17 20:00:18'),(55,'App\\Models\\User',1,'auth_token','181121bd2d91775213557b3003ac28066f5cc84e504a9c67bc2311180703a6b2','[\"*\"]','2026-06-16 05:06:05',NULL,'2026-06-16 05:06:05','2026-06-16 05:06:05'),(56,'App\\Models\\User',1,'auth_token','ce689a78dfcb6d0dbd935fc189088502cffa22ee76235ddfb3fb07ee6685ccad','[\"*\"]','2026-06-16 19:49:13',NULL,'2026-06-16 05:30:14','2026-06-16 19:49:13'),(57,'App\\Models\\User',1,'auth_token','350d165e90f9f3291911c4fe4f592332861a5d06ce584f28dd850228b578fe09','[\"*\"]','2026-06-16 06:08:54',NULL,'2026-06-16 06:08:54','2026-06-16 06:08:54'),(58,'App\\Models\\User',1,'auth_token','3748e2f992b5c0b6450b0b1b39b64991210677aebc3e3ec53a6ba682b823b28b','[\"*\"]','2026-06-16 06:24:39',NULL,'2026-06-16 06:24:39','2026-06-16 06:24:39'),(59,'App\\Models\\User',1,'auth_token','d5339d5b3cc634b5a25c5a1b6771b21ac68bf31e3dace2b9a477e119c9705e19','[\"*\"]','2026-06-18 19:13:15',NULL,'2026-06-16 19:49:12','2026-06-18 19:13:15'),(60,'App\\Models\\User',1,'auth_token','607d284b6d0321574b9ed41e5a200d7a368d6a6a20b0ace554704735eb50532f','[\"*\"]','2026-06-16 20:53:26',NULL,'2026-06-16 20:52:16','2026-06-16 20:53:26'),(63,'App\\Models\\User',1,'auth_token','0bf620e3ab9dd2bcf1ed6c5731965a8000b90564048767d27861a5381086b90e','[\"*\"]','2026-06-17 21:50:22',NULL,'2026-06-17 21:17:10','2026-06-17 21:50:22'),(64,'App\\Models\\User',1,'auth_token','8cc45b21d13d9c76c8ebca3f4e7d03e6912b86ade4972a9a2fcb5b38f921beba','[\"*\"]','2026-06-18 07:51:30',NULL,'2026-06-17 21:50:24','2026-06-18 07:51:30'),(65,'App\\Models\\User',1,'auth_token','4e02b003cb7ec7c0d16fbdfad9ee2d9db8b97d357d0cac57b554c4cb0ee1ca9f','[\"*\"]','2026-06-17 22:04:23',NULL,'2026-06-17 22:04:13','2026-06-17 22:04:23'),(66,'App\\Models\\User',1,'auth_token','f4dc56bfc4d86b854225ec4cf99945cb71c7007304cca88ac59bbee488f70833','[\"*\"]','2026-06-17 22:31:28',NULL,'2026-06-17 22:31:22','2026-06-17 22:31:28'),(68,'App\\Models\\User',1,'auth_token','0c5760793b82a5a905a38e7b979568789e551e9cd9dfe69e1685e43a7a7e138e','[\"*\"]','2026-06-18 17:06:04',NULL,'2026-06-18 17:05:58','2026-06-18 17:06:04'),(69,'App\\Models\\User',1,'auth_token','c957dd0ea3dc4865c9eaae95e6fa6e493d323084046d862c452cb6ec52745010','[\"*\"]','2026-06-18 17:07:47',NULL,'2026-06-18 17:07:26','2026-06-18 17:07:47'),(70,'App\\Models\\User',1,'auth_token','00686f8a16fcd637a417556629969a000e88dfb99408931ffe33aa18eb911aca','[\"*\"]','2026-06-18 17:08:55',NULL,'2026-06-18 17:08:43','2026-06-18 17:08:55'),(71,'App\\Models\\User',1,'auth_token','572ac36a6bf4bab858b56f531e37e5c10b36eabc1fa02a94ff4032ef9acac750','[\"*\"]','2026-06-18 17:10:46',NULL,'2026-06-18 17:10:42','2026-06-18 17:10:46'),(72,'App\\Models\\User',1,'auth_token','e326dc4bbaaa9b24b32cebfe765f46d1c882dadc521416eee22783c7de85c8d2','[\"*\"]','2026-06-18 17:11:22',NULL,'2026-06-18 17:11:16','2026-06-18 17:11:22'),(73,'App\\Models\\User',1,'auth_token','3497858eed2d063b1fbb9c0b8da9ac469481bc1ac02f651bd6e24f0470653ba3','[\"*\"]','2026-06-18 19:24:01',NULL,'2026-06-18 19:23:13','2026-06-18 19:24:01'),(74,'App\\Models\\User',1,'auth_token','34ec4b548908cb991a15cfc14ccb71b405dfa986baba9a53c00421e26fc1ca41','[\"*\"]','2026-08-02 23:31:22',NULL,'2026-06-30 08:06:48','2026-08-02 23:31:22'),(76,'App\\Models\\User',1,'auth_token','0669bb91c19b332bd405d61ed8d169597399df5bc5be5febd07149d0f411c697','[\"*\"]','2026-07-14 07:35:43',NULL,'2026-07-03 02:09:02','2026-07-14 07:35:43'),(78,'App\\Models\\User',1,'auth_token','84452087bb602f497ca6127bc7de84a719240c58dab7d63748d3c2dbcd1ce59e','[\"*\"]','2026-07-17 23:48:42',NULL,'2026-07-14 22:09:29','2026-07-17 23:48:42'),(79,'App\\Models\\User',1,'auth_token','08490e8d9188ce80dd66341430006aeec6393801ca262bcc99f513dea290a66c','[\"*\"]','2026-07-18 02:28:13',NULL,'2026-07-18 01:04:32','2026-07-18 02:28:13'),(80,'App\\Models\\User',1,'auth_token','db9f4b5b8e5ad5532623871f12bd34e689fabb271ba29e2d3d7b874287cbf61e','[\"*\"]','2026-07-23 22:30:52',NULL,'2026-07-23 22:30:36','2026-07-23 22:30:52'),(81,'App\\Models\\User',1,'auth_token','c5dd875116e6fb2576a9fa8a721da82c309f450d2b2c914f0e214916046868f3','[\"*\"]','2026-08-01 00:53:25',NULL,'2026-07-28 06:49:33','2026-08-01 00:53:25'),(84,'App\\Models\\User',1,'auth_token','d059e7aa36c5b2f9075a3a298f31c1c9c6bab1af167362b433480ef2692da9e5','[\"*\"]','2026-08-01 02:19:00',NULL,'2026-08-01 01:15:08','2026-08-01 02:19:00'),(85,'App\\Models\\User',1,'auth_token','24824cb674d852f13efb9a8fdfad1621a1fbf06aa2580c1105cd1a848447720a','[\"*\"]','2026-08-01 08:32:56',NULL,'2026-08-01 05:39:11','2026-08-01 08:32:56'),(86,'App\\Models\\User',1,'auth_token','2504a46cef9ea1851be9959d05a38d8604189ba299189280b6796180608287d2','[\"*\"]','2026-08-02 05:37:08',NULL,'2026-08-01 21:43:42','2026-08-02 05:37:08'),(87,'App\\Models\\User',1,'auth_token','f7e1dd355cc22bae308eede53d0721f6499f599223de7803276f510f35b2fabd','[\"*\"]','2026-08-02 07:19:41',NULL,'2026-08-02 05:37:16','2026-08-02 07:19:41');
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
  `nama_provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `providers` VALUES (1,'BRILink Mobile',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(2,'BRIMO Agen',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(3,'Fastpay',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(4,'Payfazz',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(5,'Mitra Bukalapak',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(6,'Digipos',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(7,'Kiosbank',1,'2026-07-03 03:06:50','2026-07-03 03:06:50'),(8,'Finnet',1,'2026-07-03 03:06:50','2026-07-03 03:06:50');
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
  `nomor_retur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaksi_penjualan_id` int unsigned DEFAULT NULL,
  `detail_penjualan_id` int unsigned DEFAULT NULL,
  `barang_id` int unsigned DEFAULT NULL,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_dibeli` int NOT NULL,
  `jumlah_retur` int NOT NULL,
  `alasan_retur` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `metode_pengembalian_dana` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tanggal_retur` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `retur_pelanggan_nomor_retur_unique` (`nomor_retur`),
  KEY `retur_pelanggan_transaksi_penjualan_id_foreign` (`transaksi_penjualan_id`),
  KEY `retur_pelanggan_detail_penjualan_id_foreign` (`detail_penjualan_id`),
  KEY `retur_pelanggan_barang_id_foreign` (`barang_id`),
  CONSTRAINT `retur_pelanggan_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE SET NULL,
  CONSTRAINT `retur_pelanggan_detail_penjualan_id_foreign` FOREIGN KEY (`detail_penjualan_id`) REFERENCES `detail_penjualan` (`id`) ON DELETE SET NULL,
  CONSTRAINT `retur_pelanggan_transaksi_penjualan_id_foreign` FOREIGN KEY (`transaksi_penjualan_id`) REFERENCES `transaksi_penjualan` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `alasan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  `nomor_retur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_retur` date NOT NULL,
  `nama_supplier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `barang_id` int unsigned NOT NULL,
  `kode_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_retur` int NOT NULL,
  `alasan_retur` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_retur` enum('diproses','diterima','ditolak') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'diproses',
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `stok_dikurangi` tinyint(1) NOT NULL DEFAULT '0',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `retur_supplier_nomor_retur_unique` (`nomor_retur`),
  KEY `retur_supplier_barang_id_foreign` (`barang_id`),
  CONSTRAINT `retur_supplier_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retur_supplier`
--

LOCK TABLES `retur_supplier` WRITE;
/*!40000 ALTER TABLE `retur_supplier` DISABLE KEYS */;
INSERT INTO `retur_supplier` VALUES (1,'RET-20260617-0001','2026-06-17','Supplier Aksesoris',13,'104024','Mouse wireless SEENDA',3,'Tidak Berfungsi Dengan Baik','diterima',NULL,1,'admin','2026-06-16 20:33:39','2026-06-16 20:34:27'),(2,'RET-20260618-0001','2026-06-18','Supplier Aksesoris',15,'CASE0002','Softcase iPhone Clear Standard',2,'Mulai Menguning Casenya','diproses',NULL,0,'admin','2026-06-17 20:03:27','2026-06-17 20:03:27'),(5,'RET-20260728-0001','2026-07-28','supplier kartu',16,'KR0003','Kartu Perdana Indosat',2,'barang rusak','diterima','reject',1,'admin','2026-07-28 07:09:33','2026-07-28 07:10:39');
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
  `jenis_transaksi` enum('top_up','pencairan') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_ewallet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_ewallet` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_customer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('sukses','gagal','pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_ewallet_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_ewallet`
--

LOCK TABLES `transaksi_ewallet` WRITE;
/*!40000 ALTER TABLE `transaksi_ewallet` DISABLE KEYS */;
INSERT INTO `transaksi_ewallet` VALUES (1,'EWL-20260609-NNMV4','2026-06-09','top_up','BRILink Mobile','ShopeePay','081410756149','Aulia Rahmawati',350000.00,5000.00,355000.00,'Top up Shopeepay','sukses','admin','2026-06-09 05:26:43','2026-06-09 05:26:43'),(3,'EWL-20260630-29YUZ','2026-06-30','top_up','BRILink Mobile','DANA','085384061798','Intan',50000.00,2000.00,52000.00,'-','sukses','admin','2026-06-30 08:21:39','2026-06-30 08:21:39');
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
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `metode_pembayaran` enum('tunai','qris') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','lunas','batal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `total_harga` decimal(15,2) NOT NULL,
  `uang_bayar` decimal(15,2) DEFAULT NULL,
  `kembalian` decimal(15,2) DEFAULT NULL,
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `alasan_batal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dibatalkan_pada` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_penjualan_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_penjualan`
--

LOCK TABLES `transaksi_penjualan` WRITE;
/*!40000 ALTER TABLE `transaksi_penjualan` DISABLE KEYS */;
INSERT INTO `transaksi_penjualan` VALUES (1,'TRX-20260523-OKNXTX','2026-05-23','tunai','lunas',9500000.00,10000000.00,500000.00,'admin',NULL,NULL,'2026-05-22 21:29:03','2026-05-22 21:29:03'),(2,'TRX-20260523-TBKI8F','2026-05-23','tunai','lunas',85000.00,85000.00,0.00,'admin',NULL,NULL,'2026-05-22 21:47:11','2026-05-22 21:47:11'),(3,'TRX-20260523-HNTGSV','2026-05-23','tunai','lunas',9500000.00,10000000.00,500000.00,'admin',NULL,NULL,'2026-05-23 00:08:11','2026-05-23 00:08:11'),(4,'TRX-20260601-VL5D6Y','2026-06-01','qris','lunas',10000.00,NULL,NULL,'admin',NULL,NULL,'2026-05-31 21:23:39','2026-05-31 21:23:39'),(5,'TRX-20260603-KLTBIF','2026-06-03','qris','lunas',10000.00,NULL,NULL,'admin',NULL,NULL,'2026-06-02 21:37:00','2026-06-02 21:37:00'),(6,'TRX-20260618-XRO2PI','2026-06-18','qris','lunas',1600000.00,1600000.00,0.00,'admin',NULL,NULL,'2026-06-17 22:44:32','2026-06-17 22:44:32'),(10,'TRX-20260718-GQ78O5','2026-07-18','qris','lunas',25000.00,25000.00,0.00,'admin',NULL,NULL,'2026-07-18 01:40:06','2026-07-18 01:40:06'),(11,'TRX-20260718-VJQJ1F','2026-07-18','qris','lunas',10000.00,10000.00,0.00,'admin',NULL,NULL,'2026-07-18 02:28:12','2026-07-18 02:28:12');
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
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `operator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_layanan` enum('pulsa','paket_data') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_tujuan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `produk` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `status` enum('sukses','gagal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_pulsa_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_pulsa`
--

LOCK TABLES `transaksi_pulsa` WRITE;
/*!40000 ALTER TABLE `transaksi_pulsa` DISABLE KEYS */;
INSERT INTO `transaksi_pulsa` VALUES (1,'PLS-20260703-UA5YMS','2026-07-03','Fastpay','eksternal','Kartu Konter','Telkomsel','pulsa','081510726158','Pulsa 80.000',80000.00,5000.00,85000.00,'sukses','admin','2026-07-03 03:03:48','2026-07-03 03:03:48');
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
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `jenis_setoran` enum('biasa','tabungan') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_rekening_tujuan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_pemilik_rekening` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_tujuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nominal_setor` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `sumber_dana` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('sukses','gagal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_setor_tunai_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_setor_tunai`
--

LOCK TABLES `transaksi_setor_tunai` WRITE;
/*!40000 ALTER TABLE `transaksi_setor_tunai` DISABLE KEYS */;
INSERT INTO `transaksi_setor_tunai` VALUES (1,'ST-20260609-4NRQZE','2026-06-09','BRILink Mobile','internal','Kartu Nasabah','tabungan','749901004671634','Budi','BRI',200000.00,5000.00,205000.00,'Tunai Nasabah','Setoran tabungan','sukses','admin','2026-06-09 05:24:17','2026-06-09 05:24:17'),(2,'ST-20260731-ZOF7EQ','2026-07-31','BRILink Mobile','eksternal','Kartu Konter','biasa','758801004681613','Ardani','BRI',200000.00,8000.00,208000.00,NULL,NULL,'sukses','admin','2026-07-31 06:27:06','2026-07-31 06:27:06');
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
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `nomor_rekening` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_penerima` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_hp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal_tarik` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `status` enum('sukses','gagal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_tarik_tunai_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_tarik_tunai`
--

LOCK TABLES `transaksi_tarik_tunai` WRITE;
/*!40000 ALTER TABLE `transaksi_tarik_tunai` DISABLE KEYS */;
INSERT INTO `transaksi_tarik_tunai` VALUES (1,'TT-20260609-332IYU','2026-06-09','BRILink Mobile','internal','Kartu Nasabah','7401730625','Rahma','081928766159',100000.00,2000.00,102000.00,'sukses','admin','2026-06-09 04:57:51','2026-06-09 04:57:51');
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
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRILink Mobile',
  `jenis_nasabah` enum('internal','eksternal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `jenis_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kartu Nasabah',
  `jenis_transfer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_tujuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_rekening_tujuan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_penerima` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal_transfer` decimal(15,2) NOT NULL,
  `biaya_admin` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_bayar` decimal(15,2) NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('sukses','gagal','pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sukses',
  `kasir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_transfer_kode_transaksi_unique` (`kode_transaksi`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi_transfer`
--

LOCK TABLES `transaksi_transfer` WRITE;
/*!40000 ALTER TABLE `transaksi_transfer` DISABLE KEYS */;
INSERT INTO `transaksi_transfer` VALUES (2,'TRF-20260609-RU34UJ','2026-06-09','BRILink Mobile','internal','Kartu Nasabah','Antar Bank','BCA','0026057679','Riyan',500000.00,5000.00,505000.00,NULL,'sukses','admin','2026-06-09 04:55:24','2026-06-09 04:55:24'),(5,'TRF-20260731-ZAHR5Z','2026-07-31','BRILink Mobile','eksternal','Kartu Konter','Sesama BRI','BRI','0028057678','Yanto',150000.00,8000.00,158000.00,NULL,'sukses','admin','2026-07-31 06:09:37','2026-07-31 06:09:37');
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
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin Sultan Cell','admin',NULL,'$2y$12$C7g8Of1ioBDv/uBa1SNafes37lTpd1sFoHutJ4w1eDOYa94BFS7XC',NULL,'2026-05-22 04:08:37','2026-07-03 03:06:50');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sistem_project1_audit_restore_20260810'
--

--
-- Dumping routines for database 'sistem_project1_audit_restore_20260810'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-17 10:45:28
