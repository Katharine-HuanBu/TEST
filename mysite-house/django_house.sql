/*
 Navicat Premium Data Transfer

 Source Server         : mysql8.0
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : django_house

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 24/01/2022 13:37:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_tools_dashboard_preferences
-- ----------------------------
DROP TABLE IF EXISTS `admin_tools_dashboard_preferences`;
CREATE TABLE `admin_tools_dashboard_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `dashboard_id` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_tools_dashboard_pr_user_id_dashboard_id_74da8e56_uniq` (`user_id`,`dashboard_id`),
  CONSTRAINT `admin_tools_dashboar_user_id_8f768e6c_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admin_tools_dashboard_preferences
-- ----------------------------
BEGIN;
INSERT INTO `admin_tools_dashboard_preferences` VALUES (1, '{}', 'dashboard', 1);
COMMIT;

-- ----------------------------
-- Table structure for admin_tools_menu_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `admin_tools_menu_bookmark`;
CREATE TABLE `admin_tools_menu_bookmark` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_tools_menu_bookmark_user_id_0382e410_fk_auth_user_id` (`user_id`),
  CONSTRAINT `admin_tools_menu_bookmark_user_id_0382e410_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admin_tools_menu_bookmark
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add bookmark', 1, 'add_bookmark');
INSERT INTO `auth_permission` VALUES (2, 'Can change bookmark', 1, 'change_bookmark');
INSERT INTO `auth_permission` VALUES (3, 'Can delete bookmark', 1, 'delete_bookmark');
INSERT INTO `auth_permission` VALUES (4, 'Can view bookmark', 1, 'view_bookmark');
INSERT INTO `auth_permission` VALUES (5, 'Can add dashboard preferences', 2, 'add_dashboardpreferences');
INSERT INTO `auth_permission` VALUES (6, 'Can change dashboard preferences', 2, 'change_dashboardpreferences');
INSERT INTO `auth_permission` VALUES (7, 'Can delete dashboard preferences', 2, 'delete_dashboardpreferences');
INSERT INTO `auth_permission` VALUES (8, 'Can view dashboard preferences', 2, 'view_dashboardpreferences');
INSERT INTO `auth_permission` VALUES (9, 'Can add log entry', 3, 'add_logentry');
INSERT INTO `auth_permission` VALUES (10, 'Can change log entry', 3, 'change_logentry');
INSERT INTO `auth_permission` VALUES (11, 'Can delete log entry', 3, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (12, 'Can view log entry', 3, 'view_logentry');
INSERT INTO `auth_permission` VALUES (13, 'Can add permission', 4, 'add_permission');
INSERT INTO `auth_permission` VALUES (14, 'Can change permission', 4, 'change_permission');
INSERT INTO `auth_permission` VALUES (15, 'Can delete permission', 4, 'delete_permission');
INSERT INTO `auth_permission` VALUES (16, 'Can view permission', 4, 'view_permission');
INSERT INTO `auth_permission` VALUES (17, 'Can add group', 5, 'add_group');
INSERT INTO `auth_permission` VALUES (18, 'Can change group', 5, 'change_group');
INSERT INTO `auth_permission` VALUES (19, 'Can delete group', 5, 'delete_group');
INSERT INTO `auth_permission` VALUES (20, 'Can view group', 5, 'view_group');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add content type', 7, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (26, 'Can change content type', 7, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (27, 'Can delete content type', 7, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (28, 'Can view content type', 7, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (29, 'Can add session', 8, 'add_session');
INSERT INTO `auth_permission` VALUES (30, 'Can change session', 8, 'change_session');
INSERT INTO `auth_permission` VALUES (31, 'Can delete session', 8, 'delete_session');
INSERT INTO `auth_permission` VALUES (32, 'Can view session', 8, 'view_session');
INSERT INTO `auth_permission` VALUES (33, 'Can add captcha store', 9, 'add_captchastore');
INSERT INTO `auth_permission` VALUES (34, 'Can change captcha store', 9, 'change_captchastore');
INSERT INTO `auth_permission` VALUES (35, 'Can delete captcha store', 9, 'delete_captchastore');
INSERT INTO `auth_permission` VALUES (36, 'Can view captcha store', 9, 'view_captchastore');
INSERT INTO `auth_permission` VALUES (37, 'Can add booth', 10, 'add_booth');
INSERT INTO `auth_permission` VALUES (38, 'Can change booth', 10, 'change_booth');
INSERT INTO `auth_permission` VALUES (39, 'Can delete booth', 10, 'delete_booth');
INSERT INTO `auth_permission` VALUES (40, 'Can view booth', 10, 'view_booth');
INSERT INTO `auth_permission` VALUES (41, 'Can add rent', 11, 'add_rent');
INSERT INTO `auth_permission` VALUES (42, 'Can change rent', 11, 'change_rent');
INSERT INTO `auth_permission` VALUES (43, 'Can delete rent', 11, 'delete_rent');
INSERT INTO `auth_permission` VALUES (44, 'Can view rent', 11, 'view_rent');
INSERT INTO `auth_permission` VALUES (45, 'Can add subscribe', 12, 'add_unsubscribe');
INSERT INTO `auth_permission` VALUES (46, 'Can change subscribe', 12, 'change_unsubscribe');
INSERT INTO `auth_permission` VALUES (47, 'Can delete subscribe', 12, 'delete_unsubscribe');
INSERT INTO `auth_permission` VALUES (48, 'Can view subscribe', 12, 'view_unsubscribe');
INSERT INTO `auth_permission` VALUES (49, 'Can add delay', 13, 'add_delay');
INSERT INTO `auth_permission` VALUES (50, 'Can change delay', 13, 'change_delay');
INSERT INTO `auth_permission` VALUES (51, 'Can delete delay', 13, 'delete_delay');
INSERT INTO `auth_permission` VALUES (52, 'Can view delay', 13, 'view_delay');
INSERT INTO `auth_permission` VALUES (53, 'Can add Statistics', 14, 'add_tongji');
INSERT INTO `auth_permission` VALUES (54, 'Can change Statistics', 14, 'change_tongji');
INSERT INTO `auth_permission` VALUES (55, 'Can delete Statistics', 14, 'delete_tongji');
INSERT INTO `auth_permission` VALUES (56, 'Can view Statistics', 14, 'view_tongji');
INSERT INTO `auth_permission` VALUES (57, 'Can add Statistics', 15, 'add_tongji');
INSERT INTO `auth_permission` VALUES (58, 'Can change Statistics', 15, 'change_tongji');
INSERT INTO `auth_permission` VALUES (59, 'Can delete Statistics', 15, 'delete_tongji');
INSERT INTO `auth_permission` VALUES (60, 'Can view Statistics', 15, 'view_tongji');
INSERT INTO `auth_permission` VALUES (61, 'Can add delay', 16, 'add_delay');
INSERT INTO `auth_permission` VALUES (62, 'Can change delay', 16, 'change_delay');
INSERT INTO `auth_permission` VALUES (63, 'Can delete delay', 16, 'delete_delay');
INSERT INTO `auth_permission` VALUES (64, 'Can view delay', 16, 'view_delay');
INSERT INTO `auth_permission` VALUES (65, 'Can add subscribe', 17, 'add_unsubscribe');
INSERT INTO `auth_permission` VALUES (66, 'Can change subscribe', 17, 'change_unsubscribe');
INSERT INTO `auth_permission` VALUES (67, 'Can delete subscribe', 17, 'delete_unsubscribe');
INSERT INTO `auth_permission` VALUES (68, 'Can view subscribe', 17, 'view_unsubscribe');
INSERT INTO `auth_permission` VALUES (69, 'Can add house', 18, 'add_house');
INSERT INTO `auth_permission` VALUES (70, 'Can change house', 18, 'change_house');
INSERT INTO `auth_permission` VALUES (71, 'Can delete house', 18, 'delete_house');
INSERT INTO `auth_permission` VALUES (72, 'Can view house', 18, 'view_house');
INSERT INTO `auth_permission` VALUES (73, 'Can add rent', 19, 'add_rent');
INSERT INTO `auth_permission` VALUES (74, 'Can change rent', 19, 'change_rent');
INSERT INTO `auth_permission` VALUES (75, 'Can delete rent', 19, 'delete_rent');
INSERT INTO `auth_permission` VALUES (76, 'Can view rent', 19, 'view_rent');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$150000$Wb107zUztzxA$IdOhE0axILAJcbkkVcCU9VCyoj+1cs9g8+NuElX5ClQ=', '2022-01-24 05:17:37.168995', 1, 'admin', '', '', 'admin@163.com', 1, 1, '2022-01-24 05:17:19.726968');
INSERT INTO `auth_user` VALUES (2, 'pbkdf2_sha256$150000$TcZEX12r2CC5$FqP5OoRPvN9K4O2M7QK2owYthDM2OBJQbJkR/k4PAYg=', '2022-01-24 05:28:52.241427', 0, 'user1', '', '', '', 0, 1, '2022-01-24 05:28:42.934371');
COMMIT;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for booth_booth
-- ----------------------------
DROP TABLE IF EXISTS `booth_booth`;
CREATE TABLE `booth_booth` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `picture` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `area` double NOT NULL,
  `price` double NOT NULL,
  `position` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of booth_booth
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for booth_delay
-- ----------------------------
DROP TABLE IF EXISTS `booth_delay`;
CREATE TABLE `booth_delay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `deadline` date NOT NULL,
  `rent_id` int NOT NULL,
  `months` int NOT NULL,
  `money` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booth_delay_rent_id_7316c26a` (`rent_id`),
  CONSTRAINT `booth_delay_rent_id_7316c26a_fk_booth_rent_id` FOREIGN KEY (`rent_id`) REFERENCES `booth_rent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of booth_delay
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for booth_rent
-- ----------------------------
DROP TABLE IF EXISTS `booth_rent`;
CREATE TABLE `booth_rent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `deadline` date NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `booth_id` int NOT NULL,
  `user_id` int NOT NULL,
  `months` int NOT NULL,
  `money` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booth_rent_booth_id_ea145d93_fk_booth_booth_id` (`booth_id`),
  KEY `booth_rent_user_id_ced5b2e2_fk_auth_user_id` (`user_id`),
  CONSTRAINT `booth_rent_booth_id_ea145d93_fk_booth_booth_id` FOREIGN KEY (`booth_id`) REFERENCES `booth_booth` (`id`),
  CONSTRAINT `booth_rent_user_id_ced5b2e2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of booth_rent
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for booth_tongji
-- ----------------------------
DROP TABLE IF EXISTS `booth_tongji`;
CREATE TABLE `booth_tongji` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of booth_tongji
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for booth_unsubscribe
-- ----------------------------
DROP TABLE IF EXISTS `booth_unsubscribe`;
CREATE TABLE `booth_unsubscribe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `rent_id` int NOT NULL,
  `is_from_delay` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rent_id` (`rent_id`),
  CONSTRAINT `booth_unsubscribe_rent_id_221eedbd_fk_booth_rent_id` FOREIGN KEY (`rent_id`) REFERENCES `booth_rent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of booth_unsubscribe
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for captcha_captchastore
-- ----------------------------
DROP TABLE IF EXISTS `captcha_captchastore`;
CREATE TABLE `captcha_captchastore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `response` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `hashkey` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of captcha_captchastore
-- ----------------------------
BEGIN;
INSERT INTO `captcha_captchastore` VALUES (1, 'VVWS', 'vvws', 'fbf0e722ca02c8766ab64ab251bebae2ca5d4afa', '2022-01-24 05:33:54.003050');
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` VALUES (1, '2022-01-24 05:23:20.295066', '1', 'test', 1, '[{\"added\": {}}]', 18, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (3, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (5, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (6, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (10, 'booth', 'booth');
INSERT INTO `django_content_type` VALUES (13, 'booth', 'delay');
INSERT INTO `django_content_type` VALUES (11, 'booth', 'rent');
INSERT INTO `django_content_type` VALUES (14, 'booth', 'tongji');
INSERT INTO `django_content_type` VALUES (12, 'booth', 'unsubscribe');
INSERT INTO `django_content_type` VALUES (9, 'captcha', 'captchastore');
INSERT INTO `django_content_type` VALUES (7, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (2, 'dashboard', 'dashboardpreferences');
INSERT INTO `django_content_type` VALUES (16, 'house', 'delay');
INSERT INTO `django_content_type` VALUES (18, 'house', 'house');
INSERT INTO `django_content_type` VALUES (19, 'house', 'rent');
INSERT INTO `django_content_type` VALUES (15, 'house', 'tongji');
INSERT INTO `django_content_type` VALUES (17, 'house', 'unsubscribe');
INSERT INTO `django_content_type` VALUES (1, 'menu', 'bookmark');
INSERT INTO `django_content_type` VALUES (8, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2022-01-24 05:11:50.536087');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2022-01-24 05:11:50.646395');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2022-01-24 05:11:50.806968');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2022-01-24 05:11:50.848864');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2022-01-24 05:11:50.858051');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2022-01-24 05:11:50.908962');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2022-01-24 05:11:50.934912');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2022-01-24 05:11:50.956971');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2022-01-24 05:11:50.967344');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2022-01-24 05:11:50.995119');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2022-01-24 05:11:50.997915');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2022-01-24 05:11:51.006206');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2022-01-24 05:11:51.046743');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2022-01-24 05:11:51.081501');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2022-01-24 05:11:51.098537');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2022-01-24 05:11:51.113737');
INSERT INTO `django_migrations` VALUES (17, 'booth', '0001_initial', '2022-01-24 05:11:51.140258');
INSERT INTO `django_migrations` VALUES (18, 'booth', '0002_auto_20210201_0802', '2022-01-24 05:11:51.220188');
INSERT INTO `django_migrations` VALUES (19, 'booth', '0003_booth_status', '2022-01-24 05:11:51.306270');
INSERT INTO `django_migrations` VALUES (20, 'booth', '0004_auto_20210202_1448', '2022-01-24 05:11:51.338951');
INSERT INTO `django_migrations` VALUES (21, 'booth', '0005_auto_20210203_0359', '2022-01-24 05:11:51.401778');
INSERT INTO `django_migrations` VALUES (22, 'booth', '0006_unsubscribe_is_from_delay', '2022-01-24 05:11:51.425020');
INSERT INTO `django_migrations` VALUES (23, 'booth', '0007_auto_20210309_0446', '2022-01-24 05:11:51.476832');
INSERT INTO `django_migrations` VALUES (24, 'booth', '0008_auto_20210309_0706', '2022-01-24 05:11:51.527847');
INSERT INTO `django_migrations` VALUES (25, 'booth', '0009_tongji', '2022-01-24 05:11:51.537490');
INSERT INTO `django_migrations` VALUES (26, 'captcha', '0001_initial', '2022-01-24 05:11:51.555509');
INSERT INTO `django_migrations` VALUES (27, 'dashboard', '0001_initial', '2022-01-24 05:11:51.600468');
INSERT INTO `django_migrations` VALUES (28, 'menu', '0001_initial', '2022-01-24 05:11:51.651363');
INSERT INTO `django_migrations` VALUES (29, 'sessions', '0001_initial', '2022-01-24 05:11:51.714921');
INSERT INTO `django_migrations` VALUES (30, 'house', '0001_initial', '2022-01-24 05:16:53.714983');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('9f5ojt0voitcc5hrm0ybc9ody1r1r9xx', 'NTYxMTE1NzdkZTEzMmE1YmZkMjdiYTEzMzYwYjJhZDI0NzAxYWJiYjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDYzNzYyNDJjNjk4ZjA3NmFmYjBjNWQxODVjMGE3NmNmZTQ3Njg1In0=', '2022-02-07 05:28:52.243979');
INSERT INTO `django_session` VALUES ('c670juwhqx602peir56fj861ojsgg9o9', 'Nzc3ZTUyMTI1YTViOWNkYmUzZTQwYzM4ZGJkODAzOTQ1MzA0YjY3ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNGIyNmI5ZDAzMTNlMGU3YzYxM2U2YmI3MWRmYjc4NTc2ZDI4YWQ3In0=', '2022-02-07 05:17:37.172838');
COMMIT;

-- ----------------------------
-- Table structure for house_delay
-- ----------------------------
DROP TABLE IF EXISTS `house_delay`;
CREATE TABLE `house_delay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `months` int NOT NULL,
  `deadline` date NOT NULL,
  `money` double NOT NULL,
  `rent_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `house_delay_rent_id_c993ed17_fk_house_rent_id` (`rent_id`),
  CONSTRAINT `house_delay_rent_id_c993ed17_fk_house_rent_id` FOREIGN KEY (`rent_id`) REFERENCES `house_rent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of house_delay
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for house_house
-- ----------------------------
DROP TABLE IF EXISTS `house_house`;
CREATE TABLE `house_house` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `picture` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `area` double NOT NULL,
  `price` double NOT NULL,
  `position` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of house_house
-- ----------------------------
BEGIN;
INSERT INTO `house_house` VALUES (1, 'test', 'houses/第2张-LSTM-模型图.png', 'test', 1, 114, 'left', '2022-01-24 05:23:20.293716', 'wait to rent', '2022-01-24 05:35:19.222539');
COMMIT;

-- ----------------------------
-- Table structure for house_rent
-- ----------------------------
DROP TABLE IF EXISTS `house_rent`;
CREATE TABLE `house_rent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `months` int NOT NULL,
  `deadline` date NOT NULL,
  `money` double NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `house_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `house_rent_house_id_5fcd7cf3_fk_house_house_id` (`house_id`),
  KEY `house_rent_user_id_0ae6f7c0_fk_auth_user_id` (`user_id`),
  CONSTRAINT `house_rent_house_id_5fcd7cf3_fk_house_house_id` FOREIGN KEY (`house_id`) REFERENCES `house_house` (`id`),
  CONSTRAINT `house_rent_user_id_0ae6f7c0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of house_rent
-- ----------------------------
BEGIN;
INSERT INTO `house_rent` VALUES (1, '2022-01-24 05:31:27.498247', 2, '2022-03-24', 228, 'unsubscribed', 1, 2);
COMMIT;

-- ----------------------------
-- Table structure for house_tongji
-- ----------------------------
DROP TABLE IF EXISTS `house_tongji`;
CREATE TABLE `house_tongji` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of house_tongji
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for house_unsubscribe
-- ----------------------------
DROP TABLE IF EXISTS `house_unsubscribe`;
CREATE TABLE `house_unsubscribe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_from_delay` tinyint(1) NOT NULL,
  `rent_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rent_id` (`rent_id`),
  CONSTRAINT `house_unsubscribe_rent_id_e7cad573_fk_house_rent_id` FOREIGN KEY (`rent_id`) REFERENCES `house_rent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of house_unsubscribe
-- ----------------------------
BEGIN;
INSERT INTO `house_unsubscribe` VALUES (1, '2022-01-24 05:35:01.358418', 'approve', '2022-01-24 05:35:01.358441', 0, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
