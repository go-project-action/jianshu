CREATE DATABASE IF NOT EXISTS `jianshu` DEFAULT CHARACTER SET utf8mb4;


USE `jianshu`;

CREATE TABLE IF NOT EXISTS `js_website_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '网站名称',
  `domain` varchar(63) NOT NULL DEFAULT '' COMMENT '网站域名',
  `favicon` varchar(127) NOT NULL DEFAULT '' COMMENT '自定义favicon',
  `logo` varchar(127) NOT NULL DEFAULT '' COMMENT '自定义logo',
  `start_year` int unsigned NOT NULL DEFAULT 0 COMMENT '网站运营开始年份',
  `slogan` varchar(127) NOT NULL DEFAULT '' COMMENT '网站 slogan，在页脚最后',
  `beian` varchar(63) NOT NULL DEFAULT '' COMMENT '网站备案信息',
  `seo_keywords` varchar(63) NOT NULL DEFAULT '' COMMENT '页面 seo 通用 keywords',
  `seo_description` varchar(255) NOT NULL DEFAULT '' COMMENT '页面 seo 通用 description',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网站配置信息';

CREATE TABLE `js_article` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `sn` varchar(32) NOT NULL DEFAULT '' COMMENT '文章序号，程序生成',
  `title` varchar(127) NOT NULL DEFAULT '' COMMENT '文章标题',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章作者 UID',
  `cover` varchar(255) NOT NULL DEFAULT '' COMMENT '文章封面图',
  `content` longtext NOT NULL COMMENT '内容，markdown 格式',
  `tags` varchar(50) NOT NULL DEFAULT '' COMMENT '文章 tag，逗号分隔',
  `words` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '字数',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态：0-未审核;1-已上线;2-下线(审核拒绝);3-用户删除',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`),
  UNIQUE KEY `sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

CREATE TABLE `js_article_ex` (
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章aid',
  `view_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览数',
  `cmt_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `zan_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '赞数',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章扩展表';

CREATE TABLE `js_comment` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章aid',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论用户uid',
  `content` varchar(4094) NOT NULL DEFAULT '' COMMENT '评论内容',
  `zan_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '赞数',
  `floor` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '第几楼',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-未审核;1-已上线;2-下线(审核拒绝);3-用户删除',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `uq_aidfloor` (`aid`,`floor`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

CREATE TABLE `js_comment_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `cid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论cid',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复uid',
  `content` varchar(4094) NOT NULL DEFAULT '' COMMENT '回复内容',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-未审核;1-已上线;2-下线(审核拒绝);3-用户删除',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论回复表';

CREATE TABLE `js_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `username` varchar(31) NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(63) NOT NULL DEFAULT '' COMMENT '注册邮箱',
  `passcode` char(12) NOT NULL DEFAULT '' COMMENT '加密随机数',
  `passwd` char(32) NOT NULL DEFAULT '' COMMENT 'md5密码',
  `nickname` varchar(31) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(127) NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别:0-男;1-女;2-保密',
  `introduce` varchar(1022) NOT NULL DEFAULT '' COMMENT '个人简介',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态。1-正常;2-禁发文;3-冻结',
  `is_root` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否超级用户，不限制权限，1-是',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

CREATE TABLE `js_user_count` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户uid',
  `fans_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝数',
  `follow_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注数（关注其他用户）',
  `article_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章数',
  `words` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '字数',
  `zan_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被赞数',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户计数表';

CREATE TABLE `js_user_follow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `fuid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注uid（粉丝uid）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_uid_fuid` (`uid`,`fuid`),
  KEY `idx_fuid` (`fuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

CREATE TABLE `js_zan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞用户uid',
  `objtype` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '被赞对象类型,0-文章;1-评论',
  `objid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被赞对象id，属主',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_u_obj` (`uid`,`objtype`,`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='赞表';
