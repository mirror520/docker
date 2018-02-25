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
  `sid` tinyint(3) UNSIGNED NOT NULL,
  `scope` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的匯出資料 `scope`
--

INSERT INTO `scope` (`sid`, `scope`) VALUES
(1, 'admin:redis'),
(2, 'writer:redis'),
(3, 'reader:redis'),
(4, 'admin:token'),
(5, 'writer:token'),
(6, 'reader:token'),
(7, 'admin:users'),
(8, 'writer:users'),
(9, 'reader:users');

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
  `sid` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '`scope`.`sid`'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表索引 `scope`
--
ALTER TABLE `scope`
  ADD PRIMARY KEY (`sid`);

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
  ADD PRIMARY KEY (`uid`,`sid`);
