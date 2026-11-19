
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色：student-学生，admin-管理员',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `status` int NOT NULL COMMENT '状态：0-禁用，1-正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

CREATE TABLE `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程代码',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT '课程简介',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：0-停用，1-正常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程信息';

CREATE TABLE `kb_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始文件名',
  `disk_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '磁盘文件名',
  `rel_path` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '相对 data/kb 的路径',
  `size` int NOT NULL COMMENT '字节数',
  `ext` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '扩展名',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_original_name` (`original_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='知识库文档';

CREATE TABLE `schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '学生ID',
  `class_date` date NOT NULL COMMENT '上课日期',
  `period` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '节次',
  `course_id` int NOT NULL COMMENT '课程ID',
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地点',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `fk_schedule_user` (`user_id`),
  KEY `fk_schedule_course` (`course_id`),
  CONSTRAINT `fk_schedule_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_schedule_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课表信息';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '$2b$12$ypJClLKejFCsyn2eltOco.YAmXory0HFjh7E/oHu9MBzDZZ6wYSSi', '管理员', 'admin', 'admin@system.cn', '13988776699', '/uploads/1790046856623_dc4830aa.jpg', 1, '2026-09-11 15:30:07', '2026-09-22 11:14:34');
INSERT INTO `users` VALUES (2, 'aaa', '$2a$10$phJ2k4sP5.c7T/LuXwzyTu/AlbbOFXblsAZEW6mIfh3koVxQ3Hhny', '小白', 'student', 'xiaobai@qq.com', '13899776688', '/uploads/1790046891012_452a9884.png', 1, '2026-09-09 16:56:41', '2026-09-22 11:14:52');
INSERT INTO `users` VALUES (3, 'bbb', '$2a$10$blJ4Qgbaqxm5jmUAWvuiRuKy/FiqbmFv.n1i0noM3pxUZrYhd2HNK', '小黑', 'student', 'xiaohei@163.com', '13799886699', '/uploads/1790046917012_b9ee534a.png', 1, '2026-09-22 11:15:00', '2026-09-22 11:15:30');

INSERT INTO `courses` (`id`, `name`, `code`, `description`, `status`, `create_time`, `update_time`) VALUES (1, '大学英语', 'ENG102', '听说读写综合训练', 1, '2026-11-12 14:24:23', '2026-11-12 14:34:00');
INSERT INTO `courses` (`id`, `name`, `code`, `description`, `status`, `create_time`, `update_time`) VALUES (2, '数据结构', 'DS101', '线性表、树、图与常用算法', 1, '2026-11-12 14:24:47', '2026-11-12 14:24:47');
INSERT INTO `courses` (`id`, `name`, `code`, `description`, `status`, `create_time`, `update_time`) VALUES (3, '高等数学', 'MATH101', '极限、导数与积分', 1, '2026-11-12 14:25:17', '2026-11-12 14:25:17');

INSERT INTO `kb_documents` (`id`, `original_name`, `disk_name`, `rel_path`, `size`, `ext`, `create_time`, `update_time`) VALUES (1, '数据结构课程说明.txt', '25f5df4356ff4f60b75c5eb3fc103cd7.txt', '25f5df4356ff4f60b75c5eb3fc103cd7.txt', 83, '.txt', '2026-11-17 18:18:54', '2026-11-17 18:18:54');
INSERT INTO `kb_documents` (`id`, `original_name`, `disk_name`, `rel_path`, `size`, `ext`, `create_time`, `update_time`) VALUES (2, '数据结构复习提纲.txt', 'acd0146059094889884c941414af804c.txt', 'acd0146059094889884c941414af804c.txt', 12, '.txt', '2026-11-17 18:32:17', '2026-11-17 18:32:17');
INSERT INTO `kb_documents` (`id`, `original_name`, `disk_name`, `rel_path`, `size`, `ext`, `create_time`, `update_time`) VALUES (3, '数据结构课程简介.md', 'd115df8239684cb982a0f29fb7c9c548.md', 'd115df8239684cb982a0f29fb7c9c548.md', 12, '.md', '2026-11-17 18:33:32', '2026-11-17 18:33:32');

INSERT INTO `schedules` (`id`, `user_id`, `class_date`, `period`, `course_id`, `location`, `create_time`, `update_time`) VALUES (1, 2, '2026-11-20', '1-2节', 3, '教学楼A103', '2026-11-12 17:28:17', '2026-11-12 17:32:27');
INSERT INTO `schedules` (`id`, `user_id`, `class_date`, `period`, `course_id`, `location`, `create_time`, `update_time`) VALUES (2, 2, '2026-11-20', '3-4节', 2, '教学楼B501', '2026-11-12 17:31:49', '2026-11-12 17:31:49');
INSERT INTO `schedules` (`id`, `user_id`, `class_date`, `period`, `course_id`, `location`, `create_time`, `update_time`) VALUES (3, 2, '2026-11-20', '5-6节', 1, '教学楼C306', '2026-11-12 17:32:21', '2026-11-12 17:32:21');


SET FOREIGN_KEY_CHECKS = 1;
