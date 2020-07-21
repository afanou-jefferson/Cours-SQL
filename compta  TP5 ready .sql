-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 20 juil. 2020 à 19:00
-- Version du serveur :  10.4.13-MariaDB
-- Version de PHP : 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `compta`
--
CREATE DATABASE IF NOT EXISTS `compta` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `compta`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `id_Article` int(10) NOT NULL,
  `ref` varchar(13) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `prix` decimal(7,2) NOT NULL,
  `id_Fournisseur` int(10) NOT NULL,
  PRIMARY KEY (`id_Article`),
  KEY `Foreign_key_Fournisseur` (`id_Fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`id_Article`, `ref`, `designation`, `prix`, `id_Fournisseur`) VALUES
(1, 'A01', 'Perceuse P1', '74.99', 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm\r\n(sachet de 10)', '2.25', 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm\r\n(sachet de 10)', '4.45', 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm\r\n(sachet de 10)', '4.40', 3),
(5, 'A02', 'Meuleuse 125mm', '37.85', 1),
(6, 'D03', 'Boulon acier zingué 4 x\r\n40mm (sachet de 10)', '1.80', 3),
(7, 'A03', 'Perceuse à colonne', '185.25', 1),
(8, 'D04', 'Coffret mêches à bois', '12.25', 3),
(9, 'F03', 'Coffret mêches plates', '6.25', 2),
(10, 'F04', 'Fraises d’encastrement', '8.14', 2);

-- --------------------------------------------------------

--
-- Structure de la table `bon`
--

DROP TABLE IF EXISTS `bon`;
CREATE TABLE IF NOT EXISTS `bon` (
  `id_bon` int(10) NOT NULL,
  `numero` int(10) NOT NULL,
  `date_cmde` timestamp NOT NULL DEFAULT current_timestamp(),
  `delai` int(10) NOT NULL,
  `id_Fournisseur` int(10) NOT NULL,
  PRIMARY KEY (`id_bon`),
  KEY `Foreign_key_Fournisseur_Bon` (`id_Fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `bon`
--

INSERT INTO `bon` (`id_bon`, `numero`, `date_cmde`, `delai`, `id_Fournisseur`) VALUES
(1, 1, '2019-02-08 08:30:00', 3, 1),
(2, 2, '2019-03-02 08:30:00', 5, 2),
(3, 3, '2019-04-03 15:30:00', 2, 3),
(4, 4, '2019-04-05 09:40:00', 2, 3),
(5, 5, '2019-05-15 12:45:00', 7, 2),
(6, 6, '2019-06-24 16:55:00', 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `compo`
--

DROP TABLE IF EXISTS `compo`;
CREATE TABLE IF NOT EXISTS `compo` (
  `id_Compo` int(11) NOT NULL AUTO_INCREMENT,
  `qte` int(11) NOT NULL,
  `id_Article` int(10) NOT NULL,
  `id_Bon` int(10) NOT NULL,
  PRIMARY KEY (`id_Compo`),
  KEY `Foreign_key_Bon` (`id_Bon`),
  KEY `Foreign_Key_Article` (`id_Article`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `compo`
--

INSERT INTO `compo` (`id_Compo`, `qte`, `id_Article`, `id_Bon`) VALUES
(1, 3, 1, 1),
(2, 4, 5, 1),
(3, 1, 7, 1),
(4, 25, 2, 2),
(5, 15, 3, 2),
(7, 8, 9, 2),
(8, 11, 10, 2),
(9, 25, 4, 3),
(10, 40, 6, 3),
(11, 15, 8, 3),
(12, 10, 4, 4),
(13, 15, 6, 4),
(14, 8, 8, 4),
(15, 17, 2, 5),
(16, 13, 3, 5),
(17, 9, 10, 5);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id_Fournisseur` int(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id_Fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`id_Fournisseur`, `nom`) VALUES
(1, 'Française d\'Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `FK_ARTICLE_FOU` FOREIGN KEY (`id_Fournisseur`) REFERENCES `fournisseur` (`id_Fournisseur`),
  ADD CONSTRAINT `Foreign_key_Fournisseur` FOREIGN KEY (`id_Fournisseur`) REFERENCES `fournisseur` (`id_Fournisseur`);

--
-- Contraintes pour la table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `FK_BON_FOU` FOREIGN KEY (`id_Fournisseur`) REFERENCES `fournisseur` (`id_Fournisseur`);

--
-- Contraintes pour la table `compo`
--
ALTER TABLE `compo`
  ADD CONSTRAINT `FK_COMPO_ART` FOREIGN KEY (`id_Article`) REFERENCES `article` (`id_Article`),
  ADD CONSTRAINT `FK_COMPO_BON` FOREIGN KEY (`id_Bon`) REFERENCES `bon` (`id_bon`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
