--
-- alter oxremark
--
ALTER TABLE `oxremark` CHANGE `OXTYPE` `OXTYPE` ENUM( 'o', 'r', 'n', 'c', 'smx_mail', 'smx_notice' ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'r'