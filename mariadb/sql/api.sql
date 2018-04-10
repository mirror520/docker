--
-- 資料庫： `api`
--
CREATE DATABASE IF NOT EXISTS `api` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `api`;

-- --------------------------------------------------------

--
-- 資料表結構 `scope`
--

CREATE TABLE `scope` (
  `sid` int(10) UNSIGNED NOT NULL,
  `scope` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `scope`
--

INSERT INTO `scope` (`sid`, `scope`, `alias`) VALUES
(1, 'admin:redis', 'redis.admin'),
(2, 'writer:redis', 'redis.writer'),
(3, 'reader:redis', 'redis.reader'),
(4, 'admin:token', 'token.admin'),
(5, 'writer:token', 'token.writer'),
(6, 'reader:token', 'token.reader'),
(7, 'admin:users', 'users.admin'),
(8, 'writer:users', 'users.writer'),
(9, 'reader:users', 'users.reader'),
(10, 'admin:tccg', 'tccg.admin'),
(11, 'writer:tccg', 'tccg.writer'),
(12, 'reader:tccg', 'tccg.reader'),
(13, 'admin:seit', 'seit.admin'),
(14, 'writer:seit', 'seit.writer'),
(15, 'reader:seit', 'seit.reader');

-- --------------------------------------------------------

--
-- 資料表結構 `seit_institution`
--

CREATE TABLE `seit_institution` (
  `siid` int(10) UNSIGNED NOT NULL,
  `ssid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`seit_session`.`ssid`',
  `tiid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`tccg_institution`.`tiid`',
  `disabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `seit_institution`
--

INSERT INTO `seit_institution` (`siid`, `ssid`, `tiid`, `disabled`) VALUES
(1, 1, 1, 0),
(2, 1, 2, 0),
(3, 2, 1, 0),
(4, 2, 2, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `seit_institution_auth`
--

CREATE TABLE `seit_institution_auth` (
  `siid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`seit_institution`.`siid`',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`user`.`uid`'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `seit_mail`
--

CREATE TABLE `seit_mail` (
  `smid` int(10) UNSIGNED NOT NULL,
  `create_time` bigint(12) UNSIGNED NOT NULL DEFAULT 0,
  `delivery_time` bigint(12) UNSIGNED NOT NULL DEFAULT 0,
  `mail_status` enum('ready','delivered','failure','readed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ready',
  `test_status` enum('unknown','fail','correct') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `siid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`seit_institution`.`siid`',
  `tuid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`tccg_user`.`tuid`',
  `smtid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`seit_mail_template`.`smtid`'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `seit_mail_fail`
--

CREATE TABLE `seit_mail_fail` (
  `smid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`seit_mail`.`smid`',
  `fail_time` bigint(12) UNSIGNED NOT NULL DEFAULT 0,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `browser_name_platform` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `seit_mail_sender`
--

CREATE TABLE `seit_mail_sender` (
  `smsid` int(10) UNSIGNED NOT NULL,
  `sender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `addressor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `port` smallint(5) UNSIGNED NOT NULL DEFAULT 25,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `confirm_reading` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `seit_mail_template`
--

CREATE TABLE `seit_mail_template` (
  `smtid` int(10) UNSIGNED NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `smsid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`seit_mail_sender`.`smsid`'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `seit_mail_template`
--

INSERT INTO `seit_mail_template` (`smtid`, `subject`, `body`, `smsid`) VALUES
(1, '[秘書處] 社交工程演練先行檢測郵件，請務必開啟(開啟後即可關閉，無須進行其他動作)，謝謝。', '<img src=\"https://api.secret.taichung.gov.tw/v1/seit/images/{jwt}\"/><br/>如上方有出現「連結」或「請您顯示圖片」時，則切勿再點開。<br/>文檔科林管理師', 1);

-- --------------------------------------------------------

--
-- 資料表結構 `seit_session`
--

CREATE TABLE `seit_session` (
  `ssid` int(10) UNSIGNED NOT NULL,
  `session` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` year(4) NOT NULL DEFAULT 2018,
  `times` tinyint(3) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `seit_session`
--

INSERT INTO `seit_session` (`ssid`, `session`, `year`, `times`) VALUES
(1, '107年第1次演練前測', 2018, 1),
(2, '107年第2次演練前測', 2018, 2);

-- --------------------------------------------------------

--
-- 資料表結構 `tccg_department`
--

CREATE TABLE `tccg_department` (
  `tdid` int(10) UNSIGNED NOT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seq` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ou` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_tdid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`tccg_department`.`tdid`',
  `tiid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`tccg_institution`.`tiid`'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `tccg_department`
--

INSERT INTO `tccg_department` (`tdid`, `department`, `seq`, `ou`, `parent_tdid`, `tiid`) VALUES
(1, '市長室', 1, '000001', 0, 1),
(2, '林陵三副市長室', 2, '000003', 0, 1),
(3, '張光瑤副市長室', 3, '000002', 0, 1),
(4, '林依瑩副市長室', 4, '000009', 0, 1),
(5, '秘書長室', 5, '000004', 0, 1),
(6, '李副秘書長室', 6, '000006', 0, 1),
(7, '郭副秘書長室', 7, '000005', 0, 1),
(8, '參事技監辦公室', 8, '000007', 0, 1),
(9, '參議辦公室', 9, '000008', 0, 1),
(10, '府會聯絡小組', 10, '387000000AU100000', 0, 1),
(11, '小組本部', 1, 'U100001', 10, 1),
(12, '處本部', 1, '010001', 0, 2),
(13, '文檔科', 2, '010002', 0, 2),
(14, '總務科', 3, '010006', 0, 2),
(15, '公共關係科', 4, '010009', 0, 2),
(16, '國際事務科', 5, '010012', 0, 2),
(17, '機要科', 6, '010015', 0, 2),
(18, '廳舍管理科', 7, '010018', 0, 2),
(19, '採購管理科', 8, '010022', 0, 2),
(20, '人事室', 9, '010026', 0, 2),
(21, '會計室', 10, '010027', 0, 2),
(22, '政風室', 11, '010028', 0, 2),
(23, '文檔科第一股', 1, '010003', 13, 2),
(24, '文檔科第二股', 2, '010004', 13, 2),
(25, '總務科第一股', 1, '010007', 14, 2),
(26, '總務科第二股', 2, '010008', 14, 2),
(27, '總務科第三股', 3, '010029', 14, 2),
(28, '公共關係科第一股', 1, '010010', 15, 2),
(29, '公共關係科第二股', 2, '010011', 15, 2),
(30, '國際事務科第一股', 1, '010013', 16, 2),
(31, '國際事務科第二股', 2, '010014', 16, 2),
(32, '機要科第一股', 1, '010016', 17, 2),
(33, '機要科第二股', 2, '010017', 17, 2),
(34, '廳舍管理科第一股', 1, '010019', 18, 2),
(35, '廳舍管理科第二股', 2, '010020', 18, 2),
(36, '廳舍管理科第三股', 3, '010021', 18, 2),
(37, '採購管理科第一股', 1, '010023', 19, 2),
(38, '採購管理科第二股', 2, '010024', 19, 2),
(39, '採購管理科第三股', 3, '010025', 19, 2);

-- --------------------------------------------------------

--
-- 資料表結構 `tccg_institution`
--

CREATE TABLE `tccg_institution` (
  `tiid` int(10) UNSIGNED NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seq` int(10) NOT NULL DEFAULT 0,
  `dn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `tccg_institution`
--

INSERT INTO `tccg_institution` (`tiid`, `institution`, `seq`, `dn`) VALUES
(1, '府本部', 1, 'OU=387000000A,OU=Taichung,DC=tccg,DC=gov,DC=tw'),
(2, '秘書處', 2, 'OU=387010000A,OU=387000000A,OU=Taichung,DC=tccg,DC=gov,DC=tw');

-- --------------------------------------------------------

--
-- 資料表結構 `tccg_user`
--

CREATE TABLE `tccg_user` (
  `tuid` int(10) UNSIGNED NOT NULL,
  `account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` enum('male','female','unknown') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `role` enum('formal','contract','assistant','unknown') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `update_time` bigint(12) UNSIGNED NOT NULL DEFAULT 0,
  `disable_time` bigint(12) UNSIGNED NOT NULL DEFAULT 0,
  `dn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tdid` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `user`
--

CREATE TABLE `user` (
  `uid` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `user_auth_scope`
--

CREATE TABLE `user_auth_scope` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`user`.`uid`',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`scope`.`sid`'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `scope`
--
ALTER TABLE `scope`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `seit_institution`
--
ALTER TABLE `seit_institution`
  ADD PRIMARY KEY (`siid`) USING BTREE,
  ADD KEY `institution_ref_fk_session` (`ssid`),
  ADD KEY `institution_ref_fk_tccg_institution` (`tiid`);

--
-- 資料表索引 `seit_institution_auth`
--
ALTER TABLE `seit_institution_auth`
  ADD PRIMARY KEY (`siid`,`uid`),
  ADD KEY `institution_auth_fk_ref_user` (`uid`);

--
-- 資料表索引 `seit_mail`
--
ALTER TABLE `seit_mail`
  ADD PRIMARY KEY (`smid`),
  ADD KEY `mail_fk_ref_institution` (`siid`),
  ADD KEY `mail_fk_ref_mail_template` (`smtid`),
  ADD KEY `mail_fk_ref_user` (`tuid`);

--
-- 資料表索引 `seit_mail_fail`
--
ALTER TABLE `seit_mail_fail`
  ADD PRIMARY KEY (`smid`,`fail_time`);

--
-- 資料表索引 `seit_mail_sender`
--
ALTER TABLE `seit_mail_sender`
  ADD PRIMARY KEY (`smsid`);

--
-- 資料表索引 `seit_mail_template`
--
ALTER TABLE `seit_mail_template`
  ADD PRIMARY KEY (`smtid`),
  ADD KEY `mail_template_fk_ref_mail_sender` (`smsid`);

--
-- 資料表索引 `seit_session`
--
ALTER TABLE `seit_session`
  ADD PRIMARY KEY (`ssid`);

--
-- 資料表索引 `tccg_department`
--
ALTER TABLE `tccg_department`
  ADD PRIMARY KEY (`tdid`),
  ADD KEY `department_fk_ref_self` (`parent_tdid`),
  ADD KEY `department_fk_ref_institution` (`tiid`);

--
-- 資料表索引 `tccg_institution`
--
ALTER TABLE `tccg_institution`
  ADD PRIMARY KEY (`tiid`);

--
-- 資料表索引 `tccg_user`
--
ALTER TABLE `tccg_user`
  ADD PRIMARY KEY (`tuid`),
  ADD KEY `tccg_user_fk_ref_department` (`tdid`);

--
-- 資料表索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 資料表索引 `user_auth_scope`
--
ALTER TABLE `user_auth_scope`
  ADD PRIMARY KEY (`uid`,`sid`),
  ADD KEY `user_auth_scope_fk_ref_scope` (`sid`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `scope`
--
ALTER TABLE `scope`
  MODIFY `sid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用資料表 AUTO_INCREMENT `seit_institution`
--
ALTER TABLE `seit_institution`
  MODIFY `siid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表 AUTO_INCREMENT `seit_mail`
--
ALTER TABLE `seit_mail`
  MODIFY `smid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT `seit_mail_sender`
--
ALTER TABLE `seit_mail_sender`
  MODIFY `smsid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表 AUTO_INCREMENT `seit_mail_template`
--
ALTER TABLE `seit_mail_template`
  MODIFY `smtid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表 AUTO_INCREMENT `seit_session`
--
ALTER TABLE `seit_session`
  MODIFY `ssid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表 AUTO_INCREMENT `tccg_department`
--
ALTER TABLE `tccg_department`
  MODIFY `tdid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- 使用資料表 AUTO_INCREMENT `tccg_institution`
--
ALTER TABLE `tccg_institution`
  MODIFY `tiid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表 AUTO_INCREMENT `tccg_user`
--
ALTER TABLE `tccg_user`
  MODIFY `tuid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints `seit_institution`
--
ALTER TABLE `seit_institution`
  ADD CONSTRAINT `institution_ref_fk_session` FOREIGN KEY (`ssid`) REFERENCES `seit_session` (`ssid`),
  ADD CONSTRAINT `institution_ref_fk_tccg_institution` FOREIGN KEY (`tiid`) REFERENCES `tccg_institution` (`tiid`);

--
-- 資料表的 Constraints `seit_institution_auth`
--
ALTER TABLE `seit_institution_auth`
  ADD CONSTRAINT `institution_auth_fk_ref_institution` FOREIGN KEY (`siid`) REFERENCES `seit_institution` (`siid`),
  ADD CONSTRAINT `institution_auth_fk_ref_user` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`);

--
-- 資料表的 Constraints `seit_mail`
--
ALTER TABLE `seit_mail`
  ADD CONSTRAINT `mail_fk_ref_institution` FOREIGN KEY (`siid`) REFERENCES `seit_institution` (`siid`),
  ADD CONSTRAINT `mail_fk_ref_mail_template` FOREIGN KEY (`smtid`) REFERENCES `seit_mail_template` (`smtid`),
  ADD CONSTRAINT `mail_fk_ref_user` FOREIGN KEY (`tuid`) REFERENCES `tccg_user` (`tuid`);

--
-- 資料表的 Constraints `seit_mail_fail`
--
ALTER TABLE `seit_mail_fail`
  ADD CONSTRAINT `mail_fail_fk_ref_mail` FOREIGN KEY (`smid`) REFERENCES `seit_mail` (`smid`);

--
-- 資料表的 Constraints `seit_mail_template`
--
ALTER TABLE `seit_mail_template`
  ADD CONSTRAINT `mail_template_fk_ref_mail_sender` FOREIGN KEY (`smsid`) REFERENCES `seit_mail_sender` (`smsid`);

--
-- 資料表的 Constraints `tccg_department`
--
ALTER TABLE `tccg_department`
  ADD CONSTRAINT `department_fk_ref_institution` FOREIGN KEY (`tiid`) REFERENCES `tccg_institution` (`tiid`),
  ADD CONSTRAINT `department_fk_ref_self` FOREIGN KEY (`parent_tdid`) REFERENCES `tccg_department` (`tdid`);

--
-- 資料表的 Constraints `tccg_user`
--
ALTER TABLE `tccg_user`
  ADD CONSTRAINT `tccg_user_fk_ref_department` FOREIGN KEY (`tdid`) REFERENCES `tccg_department` (`tdid`);

--
-- 資料表的 Constraints `user_auth_scope`
--
ALTER TABLE `user_auth_scope`
  ADD CONSTRAINT `user_auth_scope_fk_ref_scope` FOREIGN KEY (`sid`) REFERENCES `scope` (`sid`),
  ADD CONSTRAINT `user_auth_scope_fk_ref_user` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`);
COMMIT;
