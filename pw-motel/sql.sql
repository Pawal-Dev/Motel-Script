CREATE TABLE `motel` (
  `id` int(11) NOT NULL,
  `owner` varchar(46) NOT NULL,
  `labelMotel` varchar(30) NOT NULL,
  `numberChambre` varchar(30) NOT NULL DEFAULT '0',
  `day` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `motel`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `motel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

CREATE TABLE `motel_parking` (
  `id` int(11) NOT NULL,
  `owner` varchar(46) NOT NULL,
  `labelMotel` varchar(30) NOT NULL,
  `vehicle` longtext NOT NULL,
  `plate` longtext NOT NULL,
  `numeroPlace` varchar(30) NOT NULL,
  `numeroChambre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `motel_parking`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `motel_parking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;


CREATE TABLE `motel_key` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) NOT NULL,
  `labelMotel` varchar(30) NOT NULL,
  `numberChambre` varchar(30) NOT NULL DEFAULT '0',
  `playerName` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `motel_outfit` (
  `id` int(11) NOT NULL,
  `tenuename` varchar(255) NOT NULL,
  `skin` longtext NOT NULL,
  `sexe` int(11) NOT NULL,
  `motelname` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `motel_outfit`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `motel_outfit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

ALTER TABLE `motel_key`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `motel_key`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

ALTER TABLE `users` ADD IF NOT EXISTS `chambreNumero` varchar(11) DEFAULT -1;
ALTER TABLE `users` ADD IF NOT EXISTS `motelName` longtext ;