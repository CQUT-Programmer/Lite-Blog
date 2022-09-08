/*
 Navicat Premium Data Transfer

 Source Server         : dcm
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : lite_blog

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 08/09/2022 11:28:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for info_article
-- ----------------------------
DROP TABLE IF EXISTS `info_article`;
CREATE TABLE `info_article`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文章标题',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '文章封面',
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '文章摘要',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文章内容',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  `status_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '状态ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_status`(`status_id`) USING BTREE,
  CONSTRAINT `article_status` FOREIGN KEY (`status_id`) REFERENCES `info_status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '博客文章信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_category
-- ----------------------------
DROP TABLE IF EXISTS `info_category`;
CREATE TABLE `info_category`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '别名',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `category_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章分类信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_comment
-- ----------------------------
DROP TABLE IF EXISTS `info_comment`;
CREATE TABLE `info_comment`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '评论内容',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '评论信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_file
-- ----------------------------
DROP TABLE IF EXISTS `info_file`;
CREATE TABLE `info_file`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '原始文件名',
  `bucket` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '桶',
  `url` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '文件访问url',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '文件类型，即后缀',
  `upload_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '上传时间',
  `uploader` bigint(0) UNSIGNED NOT NULL COMMENT '操作员',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `access` int(0) NULL DEFAULT NULL COMMENT '访问权限，1是公有，0是私有',
  `version` int(0) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `file_id_uindex`(`id`) USING BTREE,
  INDEX `file_upload`(`uploader`) USING BTREE,
  CONSTRAINT `file_upload` FOREIGN KEY (`uploader`) REFERENCES `info_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_label
-- ----------------------------
DROP TABLE IF EXISTS `info_label`;
CREATE TABLE `info_label`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '别名',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '标签信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_share
-- ----------------------------
DROP TABLE IF EXISTS `info_share`;
CREATE TABLE `info_share`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分享的内容',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '动态信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_status
-- ----------------------------
DROP TABLE IF EXISTS `info_status`;
CREATE TABLE `info_status`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '别名',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章状态信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_sys_api
-- ----------------------------
DROP TABLE IF EXISTS `info_sys_api`;
CREATE TABLE `info_sys_api`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `simple_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '接口名称',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '完整名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '接口URL',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '请求类型',
  `permission_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '访问权限',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否启用',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 158 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '系统API信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_sys_controller
-- ----------------------------
DROP TABLE IF EXISTS `info_sys_controller`;
CREATE TABLE `info_sys_controller`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '模块url',
  `simple_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名称',
  `package_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '包名',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '完整名称',
  `permission_id` int(0) NULL DEFAULT NULL COMMENT '权限ID',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否启用',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '乐观锁',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '系统controller信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `info_sys_permission`;
CREATE TABLE `info_sys_permission`  (
  `code` int(0) NOT NULL COMMENT '权限代码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '权限描述',
  `created_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '乐观锁',
  PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户权限信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for info_user
-- ----------------------------
DROP TABLE IF EXISTS `info_user`;
CREATE TABLE `info_user`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户密码',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户头像',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '昵称',
  `gender` int(0) NOT NULL COMMENT '性别',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户的自我介绍',
  `birth` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '出生日期',
  `company` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所属公司',
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '职业',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除,0代表未删除，1代表已删除',
  `permission_id` int(0) NULL DEFAULT 0 COMMENT '用户权限',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role`(`permission_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_article_category
-- ----------------------------
DROP TABLE IF EXISTS `relation_article_category`;
CREATE TABLE `relation_article_category`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `article_id` bigint(0) UNSIGNED NOT NULL COMMENT '文件ID',
  `category_id` bigint(0) UNSIGNED NOT NULL COMMENT '分类ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `category_article_id_uindex`(`id`) USING BTREE,
  INDEX `articleKey`(`article_id`) USING BTREE,
  INDEX `categoryKey`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章-分类关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_article_draft
-- ----------------------------
DROP TABLE IF EXISTS `relation_article_draft`;
CREATE TABLE `relation_article_draft`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `article_id` bigint(0) UNSIGNED NOT NULL COMMENT '模块ID',
  `draft_id` bigint(0) UNSIGNED NOT NULL COMMENT 'URLID',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章-草稿关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_article_user
-- ----------------------------
DROP TABLE IF EXISTS `relation_article_user`;
CREATE TABLE `relation_article_user`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `article_id` bigint(0) UNSIGNED NOT NULL COMMENT '文章ID',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article`(`article_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章-用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_category_label
-- ----------------------------
DROP TABLE IF EXISTS `relation_category_label`;
CREATE TABLE `relation_category_label`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_id` bigint(0) UNSIGNED NOT NULL COMMENT '模块ID',
  `label_id` bigint(0) UNSIGNED NOT NULL COMMENT 'URLID',
  `created_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `relation_category_label_fk_categoryKey`(`category_id`) USING BTREE,
  INDEX `relation_category_label_fk_labelKey`(`label_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '分类-标签关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_comment_article
-- ----------------------------
DROP TABLE IF EXISTS `relation_comment_article`;
CREATE TABLE `relation_comment_article`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `comment_id` bigint(0) UNSIGNED NOT NULL COMMENT '评论ID',
  `article_id` bigint(0) UNSIGNED NOT NULL COMMENT '文章ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `comment_article_id_uindex`(`id`) USING BTREE,
  INDEX `commentKey`(`comment_id`) USING BTREE,
  INDEX `c_artilceKey`(`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '评论-文章关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_comment_reply
-- ----------------------------
DROP TABLE IF EXISTS `relation_comment_reply`;
CREATE TABLE `relation_comment_reply`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `comment_id` bigint(0) UNSIGNED NOT NULL COMMENT '评论ID',
  `reply_id` bigint(0) UNSIGNED NOT NULL COMMENT '回复ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `replyKey`(`reply_id`) USING BTREE,
  INDEX `reply_commentKey`(`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '评论-回复关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_comment_user
-- ----------------------------
DROP TABLE IF EXISTS `relation_comment_user`;
CREATE TABLE `relation_comment_user`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `comment_id` bigint(0) UNSIGNED NOT NULL COMMENT '评论ID',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `comment_user_id_uindex`(`id`) USING BTREE,
  INDEX `user_commentKey`(`comment_id`) USING BTREE,
  INDEX `comment_userKey`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '评论-动态关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_label_article
-- ----------------------------
DROP TABLE IF EXISTS `relation_label_article`;
CREATE TABLE `relation_label_article`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `label_id` bigint(0) UNSIGNED NOT NULL COMMENT '标签ID',
  `article_id` bigint(0) UNSIGNED NOT NULL COMMENT '文章ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `label_article_id_uindex`(`id`) USING BTREE,
  INDEX `labelKey`(`label_id`) USING BTREE,
  INDEX `label_articleKey`(`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '标签-文章关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_share_user
-- ----------------------------
DROP TABLE IF EXISTS `relation_share_user`;
CREATE TABLE `relation_share_user`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键iD',
  `share_id` bigint(0) UNSIGNED NOT NULL COMMENT '分享ID',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shareKey`(`share_id`) USING BTREE,
  INDEX `share_userKey`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户-动态信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_sys_api_controller
-- ----------------------------
DROP TABLE IF EXISTS `relation_sys_api_controller`;
CREATE TABLE `relation_sys_api_controller`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `controller_id` bigint(0) UNSIGNED NOT NULL COMMENT 'Ctrl ID',
  `api_id` bigint(0) UNSIGNED NOT NULL COMMENT 'API ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `controller_key`(`controller_id`) USING BTREE,
  INDEX `api_key`(`api_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 230 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'API-Controller关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_user_fans
-- ----------------------------
DROP TABLE IF EXISTS `relation_user_fans`;
CREATE TABLE `relation_user_fans`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `fans_id` bigint(0) UNSIGNED NOT NULL COMMENT '粉丝ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除\r\n',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user`(`user_id`) USING BTREE,
  INDEX `fans`(`fans_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户-粉丝关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relation_user_label
-- ----------------------------
DROP TABLE IF EXISTS `relation_user_label`;
CREATE TABLE `relation_user_label`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `label_id` bigint(0) UNSIGNED NOT NULL COMMENT '标签ID',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` int(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `version` int(0) NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `label_userKey`(`user_id`) USING BTREE,
  INDEX `user_labelKey`(`label_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户-标签关系表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
