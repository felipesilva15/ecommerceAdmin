-- CREATE DATABASE

CREATE DATABASE IF NOT EXISTS DB_ECOMMERCE /*!40100 DEFAULT CHARACTER SET utf8 */;

USE DB_ECOMMERCE;



-- CREATE TABLES

CREATE TABLE IF NOT EXISTS TB_PERSONS (
  idperson 		int(11) NOT NULL AUTO_INCREMENT,
  desperson 	varchar(64) NOT NULL,
  desemail 		varchar(128) DEFAULT NULL,
  nrphone 		bigint(20) DEFAULT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (idperson)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_USERS (
  iduser 		int(11) NOT NULL AUTO_INCREMENT,
  idperson 		int(11) NOT NULL,
  deslogin 		varchar(64) NOT NULL,
  despassword 	varchar(256) NOT NULL,
  inadmin 		tinyint(4) NOT NULL DEFAULT '0',
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (iduser),
  KEY FK_USERS_PERSONS_IDX (idperson),
  CONSTRAINT FK_USERS_PERSONS FOREIGN KEY (idperson) REFERENCES TB_PERSONS (idperson) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_PRODUCTS (
  idproduct 	int(11) NOT NULL AUTO_INCREMENT,
  desproduct 	varchar(64) NOT NULL,
  vlprice 		decimal(10,2) NOT NULL,
  vlwidth 		decimal(10,2) NOT NULL,
  vlheight 		decimal(10,2) NOT NULL,
  vllength 		decimal(10,2) NOT NULL,
  vlweight 		decimal(10,2) NOT NULL,
  desurl 		varchar(128) NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idproduct)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_ADDRESSES (
  idaddress 	int(11) NOT NULL AUTO_INCREMENT,
  idperson 		int(11) NOT NULL,
  desaddress 	varchar(128) NOT NULL,
  descomplement varchar(32) DEFAULT NULL,
  descity 		varchar(32) NOT NULL,
  desstate 		varchar(32) NOT NULL,
  descountry 	varchar(32) NOT NULL,
  nrzipcode 	int(11) NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idaddress),
  KEY FK_ADDRESSES_PERSONS_IDX (idperson),
  CONSTRAINT FK_ADDRESSES_PERSONS FOREIGN KEY (idperson) REFERENCES TB_PERSONS (idperson) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_CARTS (
  idcart 		int(11) NOT NULL,
  dessessionid 	varchar(64) NOT NULL,
  iduser 		int(11) DEFAULT NULL,
  idaddress 	int(11) DEFAULT NULL,
  vlfreight 	decimal(10,2) DEFAULT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idcart),
  KEY FK_CARTS_USERS_IDX (iduser),
  KEY FK_CARTS_ADDRESSES_IDX (idaddress),
  CONSTRAINT FK_CARTS_ADDRESSES FOREIGN KEY (idaddress) REFERENCES TB_ADDRESSES (idaddress) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_CARTS_USERS FOREIGN KEY (iduser) REFERENCES TB_USERS (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_CARTSPRODUCTS (
  idcartproduct	int(11) NOT NULL AUTO_INCREMENT,
  idcart		int(11) NOT NULL,
  idproduct 	int(11) NOT NULL,
  dtremoved 	datetime NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idcartproduct),
  KEY FK_CARTSPRODUCTS_CARTS_IDX (idcart),
  KEY FK_CARTSPRODUCTS_PRODUCTS_IDX (idproduct),
  CONSTRAINT FK_CARTSPRODUCTS_CARTS FOREIGN KEY (idcart) REFERENCES TB_CARTS (idcart) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_CARTSPRODUCTS_PRODUCTS FOREIGN KEY (idproduct) REFERENCES TB_PRODUCTS (idproduct) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_CATEGORIES (
  idcategory 	int(11) NOT NULL AUTO_INCREMENT,
  descategory 	varchar(32) NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idcategory)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_ORDERSSTATUS (
  idstatus 		int(11) NOT NULL AUTO_INCREMENT,
  desstatus 	varchar(32) NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idstatus)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_ORDERS (
  idorder 		int(11) NOT NULL AUTO_INCREMENT,
  idcart 		int(11) NOT NULL,
  iduser 		int(11) NOT NULL,
  idstatus 		int(11) NOT NULL,
  vltotal 		decimal(10,2) NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idorder),
  KEY FK_ORDERS_CARTS_IDX (idcart),
  KEY FK_ORDERS_USERS_IDX (iduser),
  KEY FK_ORDERS_ORDERSSTATUS_IDX (idstatus),
  CONSTRAINT FK_ORDERS_CARTS FOREIGN KEY (idcart) REFERENCES TB_CARTS (idcart) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_ORDERS_ORDERSSTATUS FOREIGN KEY (idstatus) REFERENCES TB_ORDERSSTATUS (idstatus) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_ORDERS_USERS FOREIGN KEY (iduser) REFERENCES TB_USERS (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_PRODUCTSCATEGORIES (
  idcategory 	int(11) NOT NULL,
  idproduct 	int(11) NOT NULL,
  PRIMARY KEY (idcategory,idproduct),
  KEY FK_PRODUCTSCATEGORIES_PRODUCTS_IDX (idproduct),
  CONSTRAINT FK_PRODUCTSCATEGORIES_CATEGORIES FOREIGN KEY (idcategory) REFERENCES TB_CATEGORIES (idcategory) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_PRODUCTSCATEGORIES_PRODUCTS FOREIGN KEY (idproduct) REFERENCES TB_PRODUCTS (idproduct) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_USERSLOGS (
  idlog 		int(11) NOT NULL AUTO_INCREMENT,
  iduser 		int(11) NOT NULL,
  deslog 		varchar(128) NOT NULL,
  desip 		varchar(45) NOT NULL,
  desuseragent 	varchar(128) NOT NULL,
  dessessionid 	varchar(64) NOT NULL,
  desurl 		varchar(128) NOT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idlog),
  KEY FK_USERSLOGS_USERS_IDX (iduser),
  CONSTRAINT FK_USERSLOGS_USERS FOREIGN KEY (iduser) REFERENCES TB_USERS (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS TB_USERSPASSWORDSRECOVERIES (
  idrecovery 	int(11) NOT NULL AUTO_INCREMENT,
  iduser 		int(11) NOT NULL,
  desip 		varchar(45) NOT NULL,
  dtrecovery 	datetime DEFAULT NULL,
  dtregister 	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idrecovery),
  KEY FK_USERSPASSWORDSRECOVERIES_USERS_IDX (iduser),
  CONSTRAINT FK_USERSPASSWORDSRECOVERIES_USERS FOREIGN KEY (iduser) REFERENCES TB_USERS (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8;



-- CREATE PROCEDURES

DELIMITER ;;
CREATE PROCEDURE IF NOT EXISTS SP_USERSPASSWORDSRECOVERIES_CREATE(
	piduser INT,
	pdesip 	VARCHAR(45)
)
BEGIN
  
	INSERT INTO 
		TB_USERSPASSWORDSRECOVERIES 
			(iduser, desip)
		VALUES
			(piduser, pdesip);
    
    SELECT 
		* 
	FROM TB_USERSPASSWORDSRECOVERIES
    WHERE 
		idrecovery = LAST_INSERT_ID();
    
END ;;
DELIMITER ;

DELIMITER ;;

CREATE PROCEDURE IF NOT EXISTS SP_USERSUPDATE_SAVE(
	piduser 		INT,
	pdesperson 		VARCHAR(64), 
	pdeslogin 		VARCHAR(64), 
	pdespassword 	VARCHAR(256), 
	pdesemail 		VARCHAR(128), 
	pnrphone 		BIGINT, 
	pinadmin 		TINYINT
)
BEGIN
  
    DECLARE vidperson INT;
    
	SELECT 
		idperson 
	INTO vidperson
    FROM TB_USERS
    WHERE 
		iduser = piduser;
    
    UPDATE TB_PERSONS
    SET 
		desperson = pdesperson,
        desemail = pdesemail,
        nrphone = pnrphone
	WHERE 
		idperson = vidperson;
    
    UPDATE TB_USERS
    SET
		deslogin = pdeslogin,
        despassword = pdespassword,
        inadmin = pinadmin
	WHERE 
		iduser = piduser;
    
    SELECT 
		a.*,
		b.*
	FROM TB_USERS a 
	INNER JOIN TB_PERSONS b USING(idperson) 
	WHERE 
		a.iduser = piduser;
    
END ;;
DELIMITER ;

DELIMITER ;;

CREATE PROCEDURE IF NOT EXISTS SP_USERS_DELETE(
piduser	INT
)
BEGIN
  
    DECLARE vidperson INT;
    
	SELECT 
		idperson 
	INTO vidperson
    FROM TB_USERS
    WHERE 
		iduser = piduser;
    
    DELETE FROM TB_USERS WHERE iduser = piduser;
    DELETE FROM TB_PERSONS WHERE idperson = vidperson;
    
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE IF NOT EXISTS SP_USERS_SAVE(
	pdesperson 		VARCHAR(64), 
	pdeslogin 		VARCHAR(64), 
	pdespassword 	VARCHAR(256), 
	pdesemail 		VARCHAR(128), 
	pnrphone 		BIGINT, 
	pinadmin 		TINYINT
)
BEGIN
  
    DECLARE vidperson INT;
    
	INSERT INTO 
		TB_PERSONS 
			(desperson, desemail, nrphone)
		VALUES
			(pdesperson, pdesemail, pnrphone);
    
    SET vidperson = LAST_INSERT_ID();
    
    INSERT INTO 
		TB_USERS 
			(idperson, deslogin, despassword, inadmin)
		VALUES
			(vidperson, pdeslogin, pdespassword, pinadmin);
    
    SELECT 
		a.*,
		b.*
	FROM TB_USERS a 
	INNER JOIN TB_PERSONS b USING(idperson) 
	WHERE 
		a.iduser = LAST_INSERT_ID();
    
END ;;
DELIMITER ;



-- DELETE DEFAULT DATA

DELETE FROM TB_USERSPASSWORDSRECOVERIES WHERE idrecovery IN (1, 2, 3);

DELETE FROM TB_USERS WHERE iduser IN (1, 2);

DELETE FROM TB_PERSONS WHERE idperson IN (1, 2);

DELETE FROM TB_PRODUCTS WHERE idproduct IN (1, 2, 3);

DELETE FROM TB_ORDERSSTATUS WHERE idstatus IN (1, 2, 3, 4);



-- INSERTS

INSERT INTO 
	TB_PERSONS 
		(idperson, desperson, desemail, nrphone, dtregister)
	VALUES 
		(1, 'Felipe Silva', 'felipe.silva@ecommerceadmin.com.br', 2147483647, CURRENT_TIMESTAMP),
		(2, 'Suporte', 'suporte@ecommerceadmin.com.br', 1112345678, CURRENT_TIMESTAMP);

INSERT INTO 
	TB_USERS 
		(iduser, idperson, deslogin, despassword, inadmin, dtregister)
	VALUES 
		(1, 1, 'felipe.silva', '$2y$12$YlooCyNvyTji8bPRcrfNfOKnVMmZA9ViM2A3IpFjmrpIbp5ovNmga', 1, CURRENT_TIMESTAMP),
		(2, 2, 'suporte', '$2y$12$HFjgUm/mk1RzTy4ZkJaZBe0Mc/BA2hQyoUckvm.lFa6TesjtNpiMe', 1, CURRENT_TIMESTAMP);

INSERT INTO 
	TB_PRODUCTS 
		(idproduct, desproduct, vlprice, vlwidth, vlheight, vllength, vlweight, desurl, dtregister)
	VALUES 
		(1, 'Smartphone Android 7.0', 999.95, 75.00, 151.00, 80.00, 167.00, 'smartphone-android-7.0', CURRENT_TIMESTAMP),
		(2, 'SmartTV LED 4K', 3925.99, 917.00, 596.00, 288.00, 8600.00, 'smarttv-led-4k', CURRENT_TIMESTAMP),
		(3, 'Notebook 14\" 4GB 1TB', 1949.99, 345.00, 23.00, 30.00, 2000.00, 'notebook-14-4gb-1tb', CURRENT_TIMESTAMP);

INSERT INTO 
	TB_ORDERSSTATUS 
		(idstatus, desstatus, dtregister)
	VALUES 
		(1, 'Em Aberto', CURRENT_TIMESTAMP),
		(2, 'Aguardando Pagamento', CURRENT_TIMESTAMP),
		(3, 'Pago', CURRENT_TIMESTAMP),
		(4, 'Entregue', CURRENT_TIMESTAMP);

INSERT INTO 
	TB_USERSPASSWORDSRECOVERIES 
		(idrecovery, iduser, desip, dtrecovery, dtregister)
	VALUES 
		(1, 2, '127.0.0.1', NULL, CURRENT_TIMESTAMP),
		(2, 2, '127.0.0.1', '2017-03-15 13:33:45', CURRENT_TIMESTAMP),
		(3, 2, '127.0.0.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);