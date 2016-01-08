
use shop;
SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo
FROM Persons, Orders
WHERE Persons.Id_P = Orders.Id_P;

SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo
FROM Persons
INNER JOIN Orders
ON Persons.Id_P=Orders.Id_P
ORDER BY Persons.LastName;

/*
LEFT JOIN 关键字会从左表 (table_name1) 那里返回所有的行，即使在右表 (table_name2) 中没有匹配的行。
现在，我们希望列出所有的人，以及他们的定购 - 如果有的话。
*/
SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo
FROM Persons
LEFT JOIN Orders
ON Persons.Id_P=Orders.Id_P
ORDER BY Persons.LastName;


/*
RIGHT JOIN 关键字会右表 (table_name2) 那里返回所有的行，即使在左表 (table_name1) 中没有匹配的行。
现在，我们希望列出所有的定单，以及定购它们的人 - 如果有的话。
*/
SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo
FROM Persons
RIGHT JOIN Orders
ON Persons.Id_P=Orders.Id_P
ORDER BY Persons.LastName;

/*
只要其中某个表存在匹配，FULL JOIN 关键字就会返回行。
现在，我们希望列出所有的人，以及他们的定单，以及所有的定单，以及定购它们的人。
*/
SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo
FROM Persons
FULL JOIN Orders
ON Persons.Id_P=Orders.Id_P
ORDER BY Persons.LastName;


/*
SELECT INTO 语句从一个表中选取数据，然后把数据插入另一个表中。
SELECT INTO 语句常用于创建表的备份复件或者用于对记录进行存档。

mysql 不支持 select into 语法
可以类似下面的语法
CREATE TABLE Persons_backup (SELECT LastName,FirstName FROM Persons);
*/
SELECT *
INTO Persons_backup
FROM Persons;

SELECT LastName,FirstName
INTO Persons_backup
FROM Persons;

CREATE TABLE Persons_backup (SELECT LastName,FirstName FROM Persons);



/*
们希望在表 "Persons" 中添加一个名为 "Birthday" 的新列。
*/
ALTER TABLE Persons ADD Birthday date;

-- mysql 无法修改列的类型
ALTER TABLE Persons ALTER COLUMN Birthday year;



ALTER TABLE Persons DROP COLUMN Birthday;


ALTER TABLE Orders ADD OrderDate date;
-- 修改列名，注意类型也得带上
ALTER TABLE Orders CHANGE OrderData OrderDate date;


/**
mysql 报错
*/
CREATE VIEW [AddressName CityName] AS
SELECT Address,City
FROM Persons;

CREATE VIEW person_view (AddressName, CityName) AS
SELECT Address,City
FROM Persons;

SELECT * FROM person_view;

-- DESCRIBE查看视图基本信息
DESCRIBE person_view;

DROP VIEW IF EXISTS person_view;

-- 我们必须使用 IS NULL 和 IS NOT NULL 操作符。
SELECT LastName,FirstName,Address FROM Persons
WHERE Address IS NULL;

SELECT LastName,FirstName,Address FROM Persons
WHERE Address IS NOT NULL;

-- 在下面的例子中，如果有 "UnitsOnOrder" 值是 NULL，那么结果是 NULL。
SELECT ProductName,UnitPrice*(UnitsInStock+UnitsOnOrder)
FROM Products


/*
SQL 函数
*/

SELECT AVG(UnitPrice) AS UnitPriceAvg FROM Products;
-- 找出 UnitPrice 高于平均值的商品名称
SELECT ProductName FROM Products WHERE UnitPrice>(SELECT AVG(UnitPrice) FROM Products);

-- COUNT(column_name) 函数返回指定列的值的数目（NULL 不计入）
SELECT count(UnitsOnOrder) FROM Products;
SELECT count(*) FROM Products;
-- COUNT(DISTINCT column_name) 函数返回指定列的不同值的数目：
SELECT count(DISTINCT UnitPrice) FROM Products;

-- MYSQL 不支持 first last 函数
SELECT first(UnitPrice) AS FirstUnitPrice FROM Products;
SELECT last(UnitPrice) AS FirstUnitPrice FROM Products;

SELECT MAX(UnitPrice) AS MaxUnitPrice FROM Products;
SELECT MIN(UnitPrice) AS MinUnitPrice FROM Products;
SELECT SUM(UnitPrice) AS SumUnitPrice FROM Products;

-- 统计 id 相同的人的总订单花费
SELECT Id_P, SUM(OrderPrice) FROM Orders GROUP BY Id_P;
-- 对一个以上的列应用 GROUP BY 语句, 注意是与的关系。即 id 相同的人且
-- 订单日期相同的为一组
SELECT Id_P, OrderDate, SUM(OrderPrice) FROM Orders GROUP BY Id_P, OrderDate;

SELECT Id_P, SUM(OrderPrice) FROM Orders GROUP BY Id_P;

-- 在 SQL 中增加 HAVING 子句原因是，WHERE 关键字无法与合计函数一起使用。
-- 查找订单总额超过 300 的用户
SELECT Id_P, SUM(OrderPrice) FROM Orders GROUP BY Id_P 
HAVING SUM(OrderPrice) > 300;

-- UCASE 函数把字段的值转换为大写。
-- LCASE 函数把字段的值转换为小写
SELECT UCASE(LastName),FirstName FROM Persons;
SELECT LCASE(LastName),FirstName FROM Persons;

/**
SELECT MID(column_name,start[,length]) FROM table_name
MID 函数用于从文本字段中提取字符。
start	必需。规定开始位置（起始值是 1）。
length	可选。要返回的字符数。如果省略，则 MID() 函数返回剩余文本。
*/
SELECT MID(City,1,3) as SmallCity FROM Persons;
-- MYSQL 不支持 len 函数
SELECT LEN(City) as LengthOfCity FROM Persons;


/**
ROUND 函数用于把数值字段舍入为指定的小数位数。
SELECT ROUND(column_name,decimals) FROM table_name
decimals	规定要返回的小数位数。
*/
SELECT Id_P, ROUND(OrderPrice) FROM Orders;
SELECT Id_P, ROUND(OrderPrice,1) FROM Orders;

-- NOW 函数返回当前的日期和时间。
SELECT ProductName, UnitPrice, Now() as PerDate FROM Products;
SELECT ProductName, UnitPrice, DATE_FORMAT(NOW(),'%m-%d-%Y') as PerDate FROM Products;

SELECT Id_P, DATE_FORMAT(OrderDate, '%m-%d-%Y') as PerDate FROM Orders;