
DROP TABLE IF EXISTS `Persons`;

/* Id_P 自动增长，从 6 开始 */
CREATE TABLE `Persons` (
	Id_P int NOT NULL AUTO_INCREMENT,
	LastName varchar(255),
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
  	PRIMARY KEY (`Id_P`)
) ENGINE=InnoDB AUTO_INCREMENT=6 CHARSET=utf8;

INSERT INTO Persons (`LastName`,`FirstName`,`Address`, `City`) VALUES ('Gates', 'Bill', 'Xuanwumen 10', 'Beijing');
INSERT INTO Persons (`LastName`,`FirstName`,`Address`, `City`) VALUES ('Adams', 'John', 'Xuanwumen 10', 'Oxford Street');
INSERT INTO Persons (`LastName`,`FirstName`,`Address`, `City`) VALUES ('Bush', 'George', 'Fifth Avenue', 'New York');

/*
您可以在表中创建索引，以便更加快速高效地查询数据。
用户无法看到索引，它们只能被用来加速搜索/查询。
注释：更新一个包含索引的表需要比更新一个没有索引的表更多的时间，
这是由于索引本身也需要更新。因此，理想的做法是仅仅在常常被搜索的列
（以及表）上面创建索引。
*/
CREATE INDEX PersonIndex ON Persons (LastName, FirstName);


DROP TABLE IF EXISTS `Orders`;

/*
设置外键
FOREIGN KEY (Id_P) REFERENCES Persons(Id_P)
*/
CREATE TABLE `Orders` (
	Id_O int NOT NULL AUTO_INCREMENT,
	OrderNo varchar(255),
	Id_P int,
	OrderPrice float,
	OrderDate date,
  	PRIMARY KEY (`Id_O`)  	
) ENGINE=InnoDB CHARSET=utf8;


INSERT INTO Orders (`OrderNo`, `Id_P`, `OrderPrice`, `OrderDate`)  
	VALUES ('111111', 2, 100.0, '2016-01-07');
INSERT INTO Orders (`OrderNo`, `Id_P`, `OrderPrice`, `OrderDate`)
	VALUES ('22222', 6, 1000.0, '2016-01-07');
INSERT INTO Orders (`OrderNo`, `Id_P`, `OrderPrice`, `OrderDate`)
	VALUES ('33333', 6, 500.88, '2016-01-07');
INSERT INTO Orders (`OrderNo`, `Id_P`, `OrderPrice`, `OrderDate`)
	VALUES ('44444', 7, 600, '2016-01-01');
INSERT INTO Orders (`OrderNo`, `Id_P`, `OrderPrice`, `OrderDate`)
	VALUES ('55555', 8, 300.13, '2016-01-07');

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
	P_ID int NOT NULL AUTO_INCREMENT,
	ProductName varchar(64),
	UnitPrice int,
	UnitsInStock int,
	UnitsOnOrder int,
	PRIMARY KEY (`P_ID`)  	
) ENGINE=InnoDB CHARSET=utf8;

INSERT INTO Products (`ProductName`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`) 
VALUES ('computer', 11, 3, 8);
INSERT INTO Products (`ProductName`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`) 
VALUES ('computer2', 11, 23, 95);
INSERT INTO Products (`ProductName`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`) 
VALUES ('printer', 23, 2, NULL);
INSERT INTO Products (`ProductName`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`)
VALUES ('printer2', 8, 0, NULL);
INSERT INTO Products (`ProductName`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`)
VALUES ('telephone', 4, 2, 4);