任务一：创建数据库
CREATE DATABASE JingYongDB
CHARACTER SET utf8 COLLATE utf8_general_ci;

任务二：创建数据表并插入测试数据
CREATE TABLE Swordsmen(
sID INT(11) PRIMARY KEY,
sName VARCHAR(20) NOT NULL,
sGender CHAR(2) NOT NULL,
sBirthData DATE NOT NULL,
sBirthPlace VARCHAR(10) NOT NULL,
dID INT(11) NOT NULL,
dEnterDate DATE NOT NULL
);

INSERT INTO Swordsmen(sID,sName,sGender,sBirthData,sBirthPlace,dID,dEnterDate) VALUES
(1,'黄蓉','女','1208-11-16','桃花岛',1,'1224-11-16'),
(2,'鲁有脚','男','1205-11-16','山东',1,'1211-01-01'),
(3,'洪七公','男','1178-11-16','湖北',1,'1208-11-16'),
(4,'丘处机','男','1188-11-16','河北',2,'1211-01-01'),
(5,'孙不二','女','1189-11-16','河南',2,'1211-01-01'),
(6,'程英','女','1235-11-03','浙江',3,'1241-01-01'),
(7,'冯默凤','男','1200-11-01','浙江',3,'1211-09-21'),
(8,'朱子柳','男','1190-10-21','云南大理',4,'1200-01-01'),
(9,'武三通','男','1190-10-21','云南大理',4,'1200-01-01');

CREATE TABLE Department(
dID INT(11) PRIMARY KEY,
dName VARCHAR(15) NOT NULL,
dFounder VARCHAR(15) NOT NULL,
dChairman VARCHAR(15) NOT NULL,
dAdd VARCHAR(15) NOT NULL,
dFoundTime DATE NOT NULL,
dComment text NOT NULL
);

INSERT INTO Department(dID,dName,dFounder,dChairman,dAdd,dFoundTime,dComment) VALUES
(1,'丐帮','汪剑通','黄蓉','岳阳君山','0987-01-01','天下第一大帮'),
(2,'全真教','王重阳','丘处机','终南山','0987-01-01','道教主要流派之一'),
(3,'桃花岛','黄药师','黄药师','东海桃花岛','0987-01-01','擅长奇门遁甲之术'),
(4,'大理段氏','段思平','一灯大师','云南大理','0987-01-01','大理段氏，段氏一派是地处云南大理的皇室');

任务三：创建数据表间的关系及约束
根据物理模型，为表添加外健。
ALTER TABLE Swordsmen ADD 
CONSTRAINT fk_dID FOREIGN KEY(dID)
                  REFERENCES Department(dID);

任务四：
1)查询所有女性侠客的侠客基本信息
SELECT *
FROM Swordsmen
WHERE sGender='女';

2)查询“桃花岛”门派中所有侠客的侠客姓名
SELECT sName
FROM Swordsmen JOIN Department USING (dID)
WHERE dName='桃花岛';

3)统计“大理段氏”门派中的侠客数量
SELECT COUNT(*)
FROM Swordsmen JOIN Department USING (dID)
WHERE dName='大理段氏';

4)将门派表中“丐帮”的掌门人改为“鲁有脚”
UPDATE Department
SET dChairman='鲁有脚'
WHERE dName='丐帮';

5)创建视图用于查询侠客所属门派，列出侠客姓名，门派名称以及入门派时间
CREATE VIEW view_s
AS
SELECT sName,dName,dEnterDate
FROM Swordsmen JOIN Department USING (dID);

SELECT *
FROM view_s;

6)创建触发器当门派表中门派ID被更新时，侠客表中的门派ID相应的被更新
CREATE TRIGGER trigds
AFTER UPDATE
ON Department FOR EACH ROW
BEGIN
   UPDATE Swordsmen
   SET dID=new.dID
   WHERE dID=old.dID;
END;


