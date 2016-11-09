DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(10) DEFAULT NULL,
        KEY `id` (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
      LOCK TABLES `personal` WRITE;
      /*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` (`id`, `name`)
SELECT * FROM (SELECT 1, 'root@local') AS tmp
WHERE NOT EXISTS (
      SELECT `id` FROM `personal` WHERE `id` = 1
    ) LIMIT 1;
