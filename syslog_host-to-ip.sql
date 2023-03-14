-- trigger for replacing hostnames with ips
-- 'Syslog'.'huawei' - table of correspondence for hostnames and ips
DROP TRIGGER IF EXISTS `Syslog`.`huawei_ip`;
DELIMITER //
	CREATE TRIGGER `Syslog`.`huawei_ip`
	BEFORE INSERT
	ON `Syslog`.`SystemEvents`
	FOR EACH ROW
	BEGIN
		IF (NEW.FromHost = (SELECT hostname FROM `Syslog`.`huawei` WHERE huawei.hostname=NEW.FromHost)) THEN
			SET NEW.FromHost = (SELECT ip FROM `Syslog`.`huawei` WHERE NEW.FromHost=huawei.hostname);
		END IF;
	END//
DELIMITER ;
