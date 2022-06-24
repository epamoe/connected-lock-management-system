-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Hôte : database-1.clb5mrb89pnl.us-east-1.rds.amazonaws.com
-- Généré le :  ven. 24 juin 2022 à 14:24
-- Version du serveur :  8.0.28
-- Version de PHP :  7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `lockify`
--

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add card', 7, 'add_card'),
(26, 'Can change card', 7, 'change_card'),
(27, 'Can delete card', 7, 'delete_card'),
(28, 'Can view card', 7, 'view_card'),
(29, 'Can add associate_passage_mode', 8, 'add_associate_passage_mode'),
(30, 'Can change associate_passage_mode', 8, 'change_associate_passage_mode'),
(31, 'Can delete associate_passage_mode', 8, 'delete_associate_passage_mode'),
(32, 'Can view associate_passage_mode', 8, 'view_associate_passage_mode'),
(33, 'Can add room', 9, 'add_room'),
(34, 'Can change room', 9, 'change_room'),
(35, 'Can delete room', 9, 'delete_room'),
(36, 'Can view room', 9, 'view_room'),
(37, 'Can add bluetooth', 10, 'add_bluetooth'),
(38, 'Can change bluetooth', 10, 'change_bluetooth'),
(39, 'Can delete bluetooth', 10, 'delete_bluetooth'),
(40, 'Can view bluetooth', 10, 'view_bluetooth'),
(41, 'Can add lock', 11, 'add_lock'),
(42, 'Can change lock', 11, 'change_lock'),
(43, 'Can delete lock', 11, 'delete_lock'),
(44, 'Can view lock', 11, 'view_lock'),
(45, 'Can add history', 12, 'add_history'),
(46, 'Can change history', 12, 'change_history'),
(47, 'Can delete history', 12, 'delete_history'),
(48, 'Can view history', 12, 'view_history'),
(49, 'Can add code', 13, 'add_code'),
(50, 'Can change code', 13, 'change_code'),
(51, 'Can delete code', 13, 'delete_code'),
(52, 'Can view code', 13, 'view_code'),
(53, 'Can add passage_mode', 14, 'add_passage_mode'),
(54, 'Can change passage_mode', 14, 'change_passage_mode'),
(55, 'Can delete passage_mode', 14, 'delete_passage_mode'),
(56, 'Can view passage_mode', 14, 'view_passage_mode'),
(57, 'Can add action', 15, 'add_action'),
(58, 'Can change action', 15, 'change_action'),
(59, 'Can delete action', 15, 'delete_action'),
(60, 'Can view action', 15, 'view_action'),
(61, 'Can add role', 16, 'add_role'),
(62, 'Can change role', 16, 'change_role'),
(63, 'Can delete role', 16, 'delete_role'),
(64, 'Can view role', 16, 'view_role'),
(65, 'Can add my user', 17, 'add_myuser'),
(66, 'Can change my user', 17, 'change_myuser'),
(67, 'Can delete my user', 17, 'delete_myuser'),
(68, 'Can view my user', 17, 'view_myuser'),
(69, 'Can add finger print', 18, 'add_fingerprint'),
(70, 'Can change finger print', 18, 'change_fingerprint'),
(71, 'Can delete finger print', 18, 'delete_fingerprint'),
(72, 'Can view finger print', 18, 'view_fingerprint'),
(73, 'Can add day', 19, 'add_day'),
(74, 'Can change day', 19, 'change_day'),
(75, 'Can delete day', 19, 'delete_day'),
(76, 'Can view day', 19, 'view_day'),
(77, 'Can add profile', 20, 'add_profile'),
(78, 'Can change profile', 20, 'change_profile'),
(79, 'Can delete profile', 20, 'delete_profile'),
(80, 'Can view profile', 20, 'view_profile');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'bcrypt$$2b$12$ff9/nieq3/s.hXZNcBn9weNH37fyDOnwLyE4dN0mIB/e8LgTjx2Ye', '2022-06-14 18:49:22.322124', 0, 'M. Atemfack', '', '', 'atem@gmail.com', 0, 1, '2022-06-02 06:33:16.174484'),
(2, 'bcrypt$$2b$12$w/quxY05Dd2NVsyxpuGBjO6RuKglpfryIejYRGwl3HWWDP6jU8oGu', '2022-06-14 18:53:53.907090', 1, 'Levinne Clemence', '', '', 'levinne@gmail.com', 0, 1, '2022-06-02 06:35:03.810017'),
(3, 'pbkdf2_sha256$320000$8AUdSSGsD1KVqN0yTViIc1$UBiUg1JT14DNs83keSl5B9i0N6snciIcZqZRGsUMe7A=', '2022-06-14 14:05:40.790374', 0, 'M. Atangana Bleriot', '', '', 'atenganaBP@gmail.com', 0, 1, '2022-06-02 06:36:12.233459'),
(4, '$2a$10$ZSgVPs2qxqdIuYjJCHCRlOElfDkcNXsbroekFJ9mzmda16J6ASZjG', NULL, 0, 'test', '6123457998', '', 'dylanabouma@gmail.com', 0, 1, '0000-00-00 00:00:00.000000'),
(8, 'pbkdf2_sha256$320000$LxwtYVNDx7XbXqczcGc6nt$z5ve62jGC67sl41hEGJXxnUnnrEyiKdkbjw6JsT6egs=', '2022-06-13 16:35:06.442156', 0, 'new usew9', '668515280', '', 'achaire.zogo@facsciences-uy1.cm', 0, 1, '0000-00-00 00:00:00.000000'),
(9, 'bcrypt$$2b$12$w/quxY05Dd2NVsyxpuGBjO6RuKglpfryIejYRGwl3HWWDP6jU8oGu', '2022-06-14 18:55:33.513133', 0, 'Manuella bande', '', '', 'bandemanou@gmail.com', 0, 1, '2022-06-13 15:23:42.881787'),
(10, 'pbkdf2_sha256$320000$Z3V7Qd2uqqiuLtoRSJQyEc$2PA5fD5Nx1ZWlOHPPKNLoCtWm9d0cU4XI9yY0qNpSjw=', NULL, 0, 'davila', '', '', 'davila@gmail.com', 0, 1, '2022-06-14 14:06:58.791666'),
(11, 'b\'$2b$12$5InZLY7vF6x61LQzl2Z05.xgxhPsX7zuRoW.znWvwtlTDoljkUxdS\'', NULL, 0, 'Lesly Laure', '', '', 'leslyL@gmail.com', 0, 1, '2022-06-14 16:23:38.733188'),
(12, '$2a$10$HSaD2sESSreo8L/2bmc51.jqrZlJY9kose.gV2Q3is5/Nx549dnq6', NULL, 0, 'michelle', '321456987', '', 'michellefotso2@gmail.com', 0, 1, '0000-00-00 00:00:00.000000'),
(13, '$2a$10$OI5vHSw7QTaF8LG8nJJMr.g.Z9ka0Dx5RmxYxRdGKLq8g14py98CK', NULL, 0, 'Joseph ', '698296881', '', 'josephtingang@gmail.com', 0, 1, '0000-00-00 00:00:00.000000');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(15, 'store', 'action'),
(8, 'store', 'associate_passage_mode'),
(10, 'store', 'bluetooth'),
(7, 'store', 'card'),
(13, 'store', 'code'),
(19, 'store', 'day'),
(18, 'store', 'fingerprint'),
(12, 'store', 'history'),
(11, 'store', 'lock'),
(17, 'store', 'myuser'),
(14, 'store', 'passage_mode'),
(20, 'store', 'profile'),
(16, 'store', 'role'),
(9, 'store', 'room');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-06-02 06:21:40.264453'),
(2, 'auth', '0001_initial', '2022-06-02 06:21:49.279542'),
(3, 'admin', '0001_initial', '2022-06-02 06:21:51.479334'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-06-02 06:21:51.543327'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-06-02 06:21:51.607323'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-06-02 06:21:52.348562'),
(7, 'auth', '0002_alter_permission_name_max_length', '2022-06-02 06:21:53.028516'),
(8, 'auth', '0003_alter_user_email_max_length', '2022-06-02 06:21:53.164486'),
(9, 'auth', '0004_alter_user_username_opts', '2022-06-02 06:21:53.236480'),
(10, 'auth', '0005_alter_user_last_login_null', '2022-06-02 06:21:55.172293'),
(11, 'auth', '0006_require_contenttypes_0002', '2022-06-02 06:21:55.444301'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2022-06-02 06:21:55.540260'),
(13, 'auth', '0008_alter_user_username_max_length', '2022-06-02 06:21:55.724244'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2022-06-02 06:21:55.844237'),
(15, 'auth', '0010_alter_group_name_max_length', '2022-06-02 06:21:56.004215'),
(16, 'auth', '0011_update_proxy_permissions', '2022-06-02 06:21:56.116214'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2022-06-02 06:21:56.252193'),
(18, 'sessions', '0001_initial', '2022-06-02 06:21:56.804140'),
(19, 'store', '0001_initial', '2022-06-02 06:23:34.871974'),
(20, 'store', '0002_remove_lock_room_alter_bluetooth_is_set_and_more', '2022-06-06 14:12:00.168938'),
(21, 'store', '0002_alter_myuser_user', '2022-06-13 20:34:49.271318'),
(22, 'store', '0003_profile', '2022-06-14 05:54:11.618945'),
(23, 'store', '0004_rename_staff_profile_myuser_alter_profile_image', '2022-06-14 06:39:20.379462'),
(24, 'store', '0005_alter_profile_image', '2022-06-14 06:41:24.454726'),
(25, 'store', '0006_myuser_image_delete_profile', '2022-06-14 09:25:02.715135'),
(26, 'store', '0007_alter_myuser_image', '2022-06-14 09:46:30.139292');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('17lezldvepu0sfyffjyfr9x95g5u8j5t', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179G:z4-LZV2sLKJWsHxxLl-bFzrJElPjJ8svBZoVS66g7k0', '2022-06-28 14:04:02.070295'),
('3au0otabfmkg7uqxy08xvwwnnoyjfvtw', '.eJxVjMsOwiAURP-FtSG8KS7d9xsIFy5SNZCUdmX8d2nShSazOnNm3sSHfSt-77j6JZErmcjll0GIT6xHkR6h3huNrW7rAvRQ6Nl2OreEr9vp_h2U0MtYs6BAZ3TJTExnCThiUEqFUahos3MyZp6zlRIZNyAissE5CM61AUs-XwDZODE:1o0n1u:n20IguItXDWfVJl8HgGekH6hqoNNr-g6Mo7_VSVlU1w', '2022-06-27 16:35:06.688680'),
('5rh91wbfi5jvnltteqvp4szy33roid8g', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o1798:zJY4CRUJO5LVRoUIF8Y99OQWabJWaopfHw3UEt7RIhk', '2022-06-28 14:03:54.832468'),
('9jxz9vr1jllpbf8fv0pokclg2n2eu8lt', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179F:AuHDL63JGyf2GPt_naTz2Pf71J1TFoEhCtyO3WU-e30', '2022-06-28 14:04:01.975351'),
('d11dxabuypddgm3if49bmb43gjhmifq8', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179A:XI0K0eD0BzVnt7rrKgPY1G1Mu22nJvEOa4-EjGUSLBg', '2022-06-28 14:03:56.982228'),
('fj6byhzvf4z94vi3rchlhw7jyxnlooll', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179A:XI0K0eD0BzVnt7rrKgPY1G1Mu22nJvEOa4-EjGUSLBg', '2022-06-28 14:03:56.621435'),
('frq5uudlh0mqraqpmzketigm2sql7try', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179G:z4-LZV2sLKJWsHxxLl-bFzrJElPjJ8svBZoVS66g7k0', '2022-06-28 14:04:02.858842'),
('il70cty1irlz6be4munsa92cs04mthyu', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179C:0BhQ29pffv26T7oGzsh6uP8N5NqR3loncIm2d646Obc', '2022-06-28 14:03:58.552323'),
('j3ezdgo1vvmg31a9w9yilteg16wsp3oy', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179C:0BhQ29pffv26T7oGzsh6uP8N5NqR3loncIm2d646Obc', '2022-06-28 14:03:58.700243'),
('ol7izxohfoxw9ddx4xne3rpqzsksqu6g', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179F:AuHDL63JGyf2GPt_naTz2Pf71J1TFoEhCtyO3WU-e30', '2022-06-28 14:04:01.909394'),
('row59raj3sq4t7447sftp7u1uwt1k69x', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o179G:z4-LZV2sLKJWsHxxLl-bFzrJElPjJ8svBZoVS66g7k0', '2022-06-28 14:04:02.855843'),
('uts2co9eat9jjqb7ssxyqjq1cs78r2xm', '.eJxVjDsOwyAQRO9CHSEwP5Myvc-AlmUJTiKQjF1FuXtsyUVSjTTvzbxZgG0tYeu0hDmxK5Ps8ttFwCfVA6QH1Hvj2Oq6zJEfCj9p51NL9Lqd7t9BgV72NUJMUpAYvYsWtPWCxiErkQG1pSiUkZqi3EPhoLwDRyBM9ijRqGws-3wB58c3vw:1o1794:cPBhrIAnHCYEeiKE_QQIChcAYxp-3CWPAyOSnziHhrI', '2022-06-28 14:03:50.178975');

-- --------------------------------------------------------

--
-- Structure de la table `store_action`
--

CREATE TABLE `store_action` (
  `id_action` int NOT NULL,
  `action_name` varchar(30) NOT NULL,
  `lock_id` int NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_action`
--

INSERT INTO `store_action` (`id_action`, `action_name`, `lock_id`, `user_id`) VALUES
(1, 'verrouiller', 1, 1),
(2, 'verrouiller', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `store_associate_passage_mode`
--

CREATE TABLE `store_associate_passage_mode` (
  `id` bigint NOT NULL,
  `day_id` int NOT NULL,
  `passage_mode_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `store_bluetooth`
--

CREATE TABLE `store_bluetooth` (
  `id` bigint NOT NULL,
  `description` varchar(30) NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `is_set` int NOT NULL,
  `lock_id` int NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_bluetooth`
--

INSERT INTO `store_bluetooth` (`id`, `description`, `start_date`, `end_date`, `is_set`, `lock_id`, `user_id`) VALUES
(1, 'envoie', '2022-12-06 08:00:00.000000', '2023-12-06 08:00:00.000000', 589, 1, 1),
(5, 'dylan', '2022-06-15 00:00:00.000000', '2022-06-23 00:00:00.000000', 0, 9, 8),
(6, 'for 111', '2022-06-22 15:19:00.000000', '2022-06-26 15:19:00.000000', 1, 10, 9);

-- --------------------------------------------------------

--
-- Structure de la table `store_card`
--

CREATE TABLE `store_card` (
  `id` bigint NOT NULL,
  `card` varchar(30) DEFAULT NULL,
  `description` varchar(30) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `is_set` int NOT NULL,
  `lock_id` int NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_card`
--

INSERT INTO `store_card` (`id`, `card`, `description`, `start_date`, `end_date`, `is_set`, `lock_id`, `user_id`) VALUES
(1, 'carte d\'acces', 'ouverture de la porte d\'entrée', '2000-12-06 08:00:00', '2030-12-06 08:00:00', 589, 1, 1),
(2, 'carte d\'acces test', 'test', '2022-06-06 15:40:00', '2022-07-06 16:35:00', 25, 9, 4),
(13, 'no set', 'dtikjj', '2022-06-23 05:52:00', '2022-06-26 05:52:00', 0, 10, 9),
(14, '3154770981', 'desc', '2022-06-23 09:19:00', '2022-06-27 09:19:00', 1, 10, 8);

-- --------------------------------------------------------

--
-- Structure de la table `store_code`
--

CREATE TABLE `store_code` (
  `id` bigint NOT NULL,
  `code` varchar(30) DEFAULT NULL,
  `description` varchar(30) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `is_set` int NOT NULL,
  `lock_id` int NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_code`
--

INSERT INTO `store_code` (`id`, `code`, `description`, `start_date`, `end_date`, `is_set`, `lock_id`, `user_id`) VALUES
(21, '147258', 'test', '2022-06-12 16:31:00', '2022-06-14 17:31:00', 1, 9, 4),
(30, '111111', 'dtfghg', '2022-06-14 00:00:00', '2022-06-23 00:00:00', 1, 9, 8),
(33, '123456', 'fhhtjjhg', '2022-06-21 16:03:00', '2022-06-25 16:03:00', 1, 10, 9),
(34, '159357', 'test', '2022-06-22 18:36:00', '2022-06-26 18:36:00', 1, 10, 8),
(36, '456789', 'dylan', '2022-06-23 09:18:00', '2022-06-29 09:18:00', 1, 10, 8);

-- --------------------------------------------------------

--
-- Structure de la table `store_day`
--

CREATE TABLE `store_day` (
  `id_day` int NOT NULL,
  `day_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_day`
--

INSERT INTO `store_day` (`id_day`, `day_name`) VALUES
(1, 'Lundi'),
(2, 'Mardi');

-- --------------------------------------------------------

--
-- Structure de la table `store_fingerprint`
--

CREATE TABLE `store_fingerprint` (
  `id` bigint NOT NULL,
  `fingerPrint` varchar(30) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `is_set` int NOT NULL,
  `lock_id` int NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_fingerprint`
--

INSERT INTO `store_fingerprint` (`id`, `fingerPrint`, `description`, `start_date`, `end_date`, `is_set`, `lock_id`, `user_id`) VALUES
(1, 'lesly', 'empreinte lesly', '2000-12-06 08:00:00.000000', '2030-12-06 08:00:00.000000', 589, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `store_history`
--

CREATE TABLE `store_history` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `action_id` int NOT NULL,
  `day_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_history`
--

INSERT INTO `store_history` (`id`, `created_at`, `action_id`, `day_id`) VALUES
(6, '2022-06-03 17:36:14.000000', 1, 1),
(7, '0000-00-00 00:00:00.000000', 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `store_lock`
--

CREATE TABLE `store_lock` (
  `id_lock` int NOT NULL,
  `lock_name` varchar(30) NOT NULL,
  `lock_mac` varchar(30) NOT NULL,
  `auto_lock_time` int NOT NULL,
  `lock_data` varchar(5000) NOT NULL,
  `lock_status` varchar(30) NOT NULL,
  `lock_percent` int NOT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_lock`
--

INSERT INTO `store_lock` (`id_lock`, `lock_name`, `lock_mac`, `auto_lock_time`, `lock_data`, `lock_status`, `lock_percent`, `user_id`) VALUES
(1, 'serrure porte 204', '255:255:255', 150, 'bureau', 'verrouille', 75, 2),
(9, 'lock', 'FD:21:98:41:C7:B2', 6, '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', '0', 99, 4),
(10, 'lockify', 'FA:A3:75:8D:83:74', 6, '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', '0', 97, 8);

-- --------------------------------------------------------

--
-- Structure de la table `store_myuser`
--

CREATE TABLE `store_myuser` (
  `id` bigint NOT NULL,
  `phone_number` int NOT NULL,
  `role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_myuser`
--

INSERT INTO `store_myuser` (`id`, `phone_number`, `role_id`, `user_id`, `image`) VALUES
(1, 670855884, 1, 2, 'default.png'),
(2, 12345667, 1, 3, 'default.png'),
(4, 668515280, 2, 8, 'default.png'),
(5, 654083708, 2, 9, 'default.png'),
(6, 657855884, 2, 10, 'default.png'),
(7, 675331249, 2, 11, 'default.png'),
(8, 657515280, 2, 4, 'phone.png'),
(9, 321456987, 2, 12, ''),
(10, 698296881, 2, 13, '');

-- --------------------------------------------------------

--
-- Structure de la table `store_passage_mode`
--

CREATE TABLE `store_passage_mode` (
  `id_passage_mode` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `status` varchar(30) NOT NULL,
  `locks_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `store_role`
--

CREATE TABLE `store_role` (
  `id_role` int NOT NULL,
  `role_name` varchar(30) NOT NULL,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `store_role`
--

INSERT INTO `store_role` (`id_role`, `role_name`, `description`) VALUES
(1, 'Administrateur', 'propriétaire de l\'entreprise'),
(2, 'Utilisateur', 'Employé');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Index pour la table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Index pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Index pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Index pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Index pour la table `store_action`
--
ALTER TABLE `store_action`
  ADD PRIMARY KEY (`id_action`),
  ADD KEY `store_action_lock_id_e0555e7e_fk_store_lock_id_lock` (`lock_id`),
  ADD KEY `store_action_user_id_a5f67e96_fk_store_myuser_id` (`user_id`);

--
-- Index pour la table `store_associate_passage_mode`
--
ALTER TABLE `store_associate_passage_mode`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_associate_passage_mode_day_id_c8d450dd_fk_store_day_id_day` (`day_id`),
  ADD KEY `store_associate_pass_passage_mode_id_8457fd12_fk_store_pas` (`passage_mode_id`);

--
-- Index pour la table `store_bluetooth`
--
ALTER TABLE `store_bluetooth`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_bluetooth_lock_id_d15ce6d4_fk_store_lock_id_lock` (`lock_id`),
  ADD KEY `store_bluetooth_user_id_62d8b22e_fk_store_myuser_id` (`user_id`);

--
-- Index pour la table `store_card`
--
ALTER TABLE `store_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_card_lock_id_0e9e32b6_fk_store_lock_id_lock` (`lock_id`),
  ADD KEY `store_card_user_id_b1bf2653_fk_store_myuser_id` (`user_id`);

--
-- Index pour la table `store_code`
--
ALTER TABLE `store_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_code_lock_id_47721d36_fk_store_lock_id_lock` (`lock_id`),
  ADD KEY `store_code_user_id_fca18ca4_fk_store_myuser_id` (`user_id`);

--
-- Index pour la table `store_day`
--
ALTER TABLE `store_day`
  ADD PRIMARY KEY (`id_day`);

--
-- Index pour la table `store_fingerprint`
--
ALTER TABLE `store_fingerprint`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_fingerprint_lock_id_0626c76b_fk_store_lock_id_lock` (`lock_id`),
  ADD KEY `store_fingerprint_user_id_c6ba27ba_fk_store_myuser_id` (`user_id`);

--
-- Index pour la table `store_history`
--
ALTER TABLE `store_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_history_action_id_4d4ba025_fk_store_action_id_action` (`action_id`),
  ADD KEY `store_history_day_id_2dbbbb09_fk_store_day_id_day` (`day_id`);

--
-- Index pour la table `store_lock`
--
ALTER TABLE `store_lock`
  ADD PRIMARY KEY (`id_lock`),
  ADD KEY `store_lock_user_id_3efb0608_fk_store_myuser_id` (`user_id`);

--
-- Index pour la table `store_myuser`
--
ALTER TABLE `store_myuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `store_myuser_role_id_66cbd584_fk_store_role_id_role` (`role_id`);

--
-- Index pour la table `store_passage_mode`
--
ALTER TABLE `store_passage_mode`
  ADD PRIMARY KEY (`id_passage_mode`),
  ADD KEY `store_passage_mode_locks_id_2c884d65_fk_store_lock_id_lock` (`locks_id`);

--
-- Index pour la table `store_role`
--
ALTER TABLE `store_role`
  ADD PRIMARY KEY (`id_role`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT pour la table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT pour la table `store_action`
--
ALTER TABLE `store_action`
  MODIFY `id_action` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `store_associate_passage_mode`
--
ALTER TABLE `store_associate_passage_mode`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `store_bluetooth`
--
ALTER TABLE `store_bluetooth`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `store_card`
--
ALTER TABLE `store_card`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT pour la table `store_code`
--
ALTER TABLE `store_code`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT pour la table `store_day`
--
ALTER TABLE `store_day`
  MODIFY `id_day` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `store_fingerprint`
--
ALTER TABLE `store_fingerprint`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `store_history`
--
ALTER TABLE `store_history`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `store_lock`
--
ALTER TABLE `store_lock`
  MODIFY `id_lock` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `store_myuser`
--
ALTER TABLE `store_myuser`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `store_passage_mode`
--
ALTER TABLE `store_passage_mode`
  MODIFY `id_passage_mode` int NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `store_role`
--
ALTER TABLE `store_role`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Contraintes pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Contraintes pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `store_action`
--
ALTER TABLE `store_action`
  ADD CONSTRAINT `store_action_lock_id_e0555e7e_fk_store_lock_id_lock` FOREIGN KEY (`lock_id`) REFERENCES `store_lock` (`id_lock`),
  ADD CONSTRAINT `store_action_user_id_a5f67e96_fk_store_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `store_myuser` (`id`);

--
-- Contraintes pour la table `store_associate_passage_mode`
--
ALTER TABLE `store_associate_passage_mode`
  ADD CONSTRAINT `store_associate_pass_passage_mode_id_8457fd12_fk_store_pas` FOREIGN KEY (`passage_mode_id`) REFERENCES `store_passage_mode` (`id_passage_mode`),
  ADD CONSTRAINT `store_associate_passage_mode_day_id_c8d450dd_fk_store_day_id_day` FOREIGN KEY (`day_id`) REFERENCES `store_day` (`id_day`);

--
-- Contraintes pour la table `store_bluetooth`
--
ALTER TABLE `store_bluetooth`
  ADD CONSTRAINT `store_bluetooth_lock_id_d15ce6d4_fk_store_lock_id_lock` FOREIGN KEY (`lock_id`) REFERENCES `store_lock` (`id_lock`),
  ADD CONSTRAINT `store_bluetooth_user_id_62d8b22e_fk_store_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `store_myuser` (`id`);

--
-- Contraintes pour la table `store_card`
--
ALTER TABLE `store_card`
  ADD CONSTRAINT `store_card_lock_id_0e9e32b6_fk_store_lock_id_lock` FOREIGN KEY (`lock_id`) REFERENCES `store_lock` (`id_lock`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `store_code`
--
ALTER TABLE `store_code`
  ADD CONSTRAINT `store_code_lock_id_47721d36_fk_store_lock_id_lock` FOREIGN KEY (`lock_id`) REFERENCES `store_lock` (`id_lock`),
  ADD CONSTRAINT `store_code_user_id_fca18ca4_fk_store_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `store_myuser` (`id`);

--
-- Contraintes pour la table `store_fingerprint`
--
ALTER TABLE `store_fingerprint`
  ADD CONSTRAINT `store_fingerprint_lock_id_0626c76b_fk_store_lock_id_lock` FOREIGN KEY (`lock_id`) REFERENCES `store_lock` (`id_lock`),
  ADD CONSTRAINT `store_fingerprint_user_id_c6ba27ba_fk_store_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `store_myuser` (`id`);

--
-- Contraintes pour la table `store_history`
--
ALTER TABLE `store_history`
  ADD CONSTRAINT `store_history_action_id_4d4ba025_fk_store_action_id_action` FOREIGN KEY (`action_id`) REFERENCES `store_action` (`id_action`),
  ADD CONSTRAINT `store_history_day_id_2dbbbb09_fk_store_day_id_day` FOREIGN KEY (`day_id`) REFERENCES `store_day` (`id_day`);

--
-- Contraintes pour la table `store_lock`
--
ALTER TABLE `store_lock`
  ADD CONSTRAINT `store_lock_user_id_3efb0608_fk_store_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `store_myuser` (`id`);

--
-- Contraintes pour la table `store_myuser`
--
ALTER TABLE `store_myuser`
  ADD CONSTRAINT `store_myuser_role_id_66cbd584_fk_store_role_id_role` FOREIGN KEY (`role_id`) REFERENCES `store_role` (`id_role`),
  ADD CONSTRAINT `store_myuser_user_id_cf805b6e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `store_passage_mode`
--
ALTER TABLE `store_passage_mode`
  ADD CONSTRAINT `store_passage_mode_locks_id_2c884d65_fk_store_lock_id_lock` FOREIGN KEY (`locks_id`) REFERENCES `store_lock` (`id_lock`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
