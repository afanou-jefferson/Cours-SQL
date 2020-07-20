-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 20 juil. 2020 à 17:51
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
CREATE TABLE `article` (
  `id` int(10) NOT NULL,
  `ref` varchar(13) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `prix` decimal(7,2) NOT NULL,
  `id_Fournisseur` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`id`, `ref`, `designation`, `prix`, `id_Fournisseur`) VALUES
(1, 'A01', 'Perceuse P1', '74.99', 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm\r\n(sachet de 10)', '2.25', 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm\r\n(sachet de 10)', '4.45', 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm\r\n(sachet de 10)', '4.40', 3),
(5, 'A02', 'Meuleuse 125mm', '37.85', 1),
(6, 'D03', 'Boulon acier zingué 4 x\r\n40mm (sachet de 10)', '1.80', 3),
(7, 'A03', 'Perceuse à colonne', '185.25', 1);

-- --------------------------------------------------------

--
-- Structure de la table `bon`
--

DROP TABLE IF EXISTS `bon`;
CREATE TABLE `bon` (
  `id` int(10) NOT NULL,
  `numero` int(10) NOT NULL,
  `date_cmde` timestamp NOT NULL DEFAULT current_timestamp(),
  `delai` int(10) NOT NULL,
  `id_Fournisseur` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `bon`
--

INSERT INTO `bon` (`id`, `numero`, `date_cmde`, `delai`, `id_Fournisseur`) VALUES
(1, 1, '2020-07-20 15:45:20', 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `compo`
--

DROP TABLE IF EXISTS `compo`;
CREATE TABLE `compo` (
  `id` int(11) NOT NULL,
  `qte` int(11) NOT NULL,
  `id_Article` int(10) NOT NULL,
  `id_Bon` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `compo`
--

INSERT INTO `compo` (`id`, `qte`, `id_Article`, `id_Bon`) VALUES
(1, 3, 1, 1),
(2, 4, 5, 1),
(3, 1, 7, 1);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE `fournisseur` (
  `id` int(10) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`id`, `nom`) VALUES
(1, 'Française d\'Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Foreign_key_Fournisseur` (`id_Fournisseur`);

--
-- Index pour la table `bon`
--
ALTER TABLE `bon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Foreign_key_Fournisseur_Bon` (`id_Fournisseur`);

--
-- Index pour la table `compo`
--
ALTER TABLE `compo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Foreign_key_Bon` (`id_Bon`),
  ADD KEY `Foreign_Key_Article` (`id_Article`) USING BTREE;

--
-- Index pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `compo`
--
ALTER TABLE `compo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `Foreign_key_Fournisseur` FOREIGN KEY (`id_Fournisseur`) REFERENCES `fournisseur` (`id`);

--
-- Contraintes pour la table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `Foreign_key_Fournisseur_Bon` FOREIGN KEY (`id_Fournisseur`) REFERENCES `bon` (`id`);

--
-- Contraintes pour la table `compo`
--
ALTER TABLE `compo`
  ADD CONSTRAINT `Foreign_key_Article` FOREIGN KEY (`id_Article`) REFERENCES `article` (`id`),
  ADD CONSTRAINT `Foreign_key_Bon` FOREIGN KEY (`id_Bon`) REFERENCES `bon` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
