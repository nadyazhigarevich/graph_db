Use master
Go
Drop Database if exists FamilyTree
Go
Create Database FamilyTree
Go
Use FamilyTree
Go
Create Table Person
(
 id Int Not Null Primary Key,
 name Nvarchar(50),
 sex Char(1) Not Null,
 birthDate date,
 deathDate date,
 isDead Bit,
 Constraint CK_Person_IsDead_DeathDate 
   Check ((isDead = 0 And deathDate Is Null) Or (isDead = 1)),
 Constraint CK_Person_BirthDate_DeathDate 
   Check ((birthDate Is Null or deathDate Is Null) or (birthDate <= deathDate))
) as Node
Go
Create Table Settlement
(
 id Int Not Null Primary Key,
 name Nvarchar(50) Not Null,
 district Nvarchar(50) Not Null
) as Node
Go
Create Table Cemetery
(
 id Int Not Null Primary Key,
 name Nvarchar(50) Not Null
) as Node
Go
Create Table IsParentOf (
  Constraint EC_IsParentOf 
    Connection (Person To Person) On Delete Cascade
) as Edge
Go
Create Table LivesIn (
  Constraint EC_LivesIn 
    Connection (Person To Settlement) On Delete Cascade
) as Edge
Go
Create Table RestsIn (
  PersonIsDead Bit Not Null
  , Constraint EC_RestsIn 
    Connection (Person To Cemetery) On Delete Cascade
  , Constraint CK_RestsIn 
    Check (PersonIsDead = 1)
) as Edge
Go
Create Table LocatedIn (
  Constraint EC_LocatedIn
    Connection (Cemetery To Settlement) On Delete Cascade
) as Edge
Go
Insert into Person (id, name, sex, birthDate, deathDate, isDead)
Values 
(1, N'�������', N'�', '2004-06-29', Null, 0),
(2, N'���������', N'�', '1978-04-24', Null, 0),
(3, N'������', N'�', '1974-01-29', Null, 0),
(4, N'�����', N'�', '2014-08-17', Null, 0),
(5, N'���������', N'�', '1954-05-22', Null, 0),
(6, N'���������', N'�', '1951-09-23', '2019-03-18', 1),
(7, N'����', N'�', '1947-11-11', '2008-02-27', 1),
(8, N'���������', N'�', '1942-03-26', '2021-07-01', 1),
(9, N'������', N'�', '1980-01-10', Null, 0),
(10, N'�����', N'�', '1981-01-07', Null, 0),
(11, N'����', N'�', '1926-04-04', '1996-10-14', 1),
(12, N'�����', N'�', '1930-11-22', '2008-11-22', 1),
(13, N'������', N'�', '1914-07-24', '1992-03-09', 1),
(14, N'����', N'�', '1912-07-23', '1985-06-06', 1),
(15, N'�������', N'�', Null, '1953', 1),
(16, N'����', N'�', '1928-01-20', '1996-05-26', 1),
(17, N'�����', N'�', '1965-06-14', Null, 0),
(18, N'��������', N'�', '1940-04-10', '1968-02-14', 1),
(19, N'��������', N'�', '1887', '1962', 1),
(20, N'�������', N'�', '1898', '1986', 1),
(21, N'������', N'�', '2008', Null, 0),  
(22, N'���������', N'�', Null, Null, 1),
(23, N'����', N'�', '2012-12-16', Null, 0),
(24, N'���������', N'�', '2019-01-06', Null, 0),
(25, N'������', N'�', '1866', '1954', 1)
Go
Insert into Settlement(id, name, district)
Values 
  (1, N'�. ����������', N'�������������'),
  (2, N'�. �������', N'���������'),
  (3, N'�. �������', N'���������'),
  (4, N'�. �������', N'�����������'),
  (5, N'�. ��������', N'�������'),
  (6, N'�. �������', N'�������'),
  (7, N'�. �������', N'�����������'),
  (8, N'�. �����', N'�������'),
  (9, N'�. ��������', N'�������'),
  (10, N'�. ������ ����', N'�������')
Go
Insert into Cemetery(id, name)
Values 
  (1, N'�������������'),
  (2, N'�������� �. ��������'),
  (3, N'�������� �. �������'),
  (4, N'�������������'),
  (5, N'�������� �. ������ ����'),
  (6, N'�������� �. �������'),
  (7, N'�������� �7'),
  (8, N'�������� �8'),
  (9, N'�������� �9'),
  (10, N'�������� �10')
Go
Insert into IsParentOf ($from_id, $to_id)
Values 
  ((Select $node_id From Person Where id = 2), (Select $node_id From Person Where id = 1)),
  ((Select $node_id From Person Where id = 3), (Select $node_id From Person Where id = 1)),
  ((Select $node_id From Person Where id = 2), (Select $node_id From Person Where id = 4)),
  ((Select $node_id From Person Where id = 3), (Select $node_id From Person Where id = 4)),
  ((Select $node_id From Person Where id = 5), (Select $node_id From Person Where id = 2)),
  ((Select $node_id From Person Where id = 6), (Select $node_id From Person Where id = 2)),
  ((Select $node_id From Person Where id = 7), (Select $node_id From Person Where id = 3)),
  ((Select $node_id From Person Where id = 8), (Select $node_id From Person Where id = 3)),
  ((Select $node_id From Person Where id = 5), (Select $node_id From Person Where id = 9)),
  ((Select $node_id From Person Where id = 6), (Select $node_id From Person Where id = 9)),
  ((Select $node_id From Person Where id = 7), (Select $node_id From Person Where id = 10)),
  ((Select $node_id From Person Where id = 8), (Select $node_id From Person Where id = 10)),
  ((Select $node_id From Person Where id = 11), (Select $node_id From Person Where id = 5)),
  ((Select $node_id From Person Where id = 12), (Select $node_id From Person Where id = 5)),
  ((Select $node_id From Person Where id = 13), (Select $node_id From Person Where id = 6)),
  ((Select $node_id From Person Where id = 14), (Select $node_id From Person Where id = 6)),
  ((Select $node_id From Person Where id = 15), (Select $node_id From Person Where id = 7)),
  ((Select $node_id From Person Where id = 16), (Select $node_id From Person Where id = 7)),
  ((Select $node_id From Person Where id = 8), (Select $node_id From Person Where id = 17)),
  ((Select $node_id From Person Where id = 18), (Select $node_id From Person Where id = 17)),
  ((Select $node_id From Person Where id = 19), (Select $node_id From Person Where id = 8)),
  ((Select $node_id From Person Where id = 20), (Select $node_id From Person Where id = 8)),
  ((Select $node_id From Person Where id = 9), (Select $node_id From Person Where id = 21)),
  ((Select $node_id From Person Where id = 22), (Select $node_id From Person Where id = 23)),
  ((Select $node_id From Person Where id = 10), (Select $node_id From Person Where id = 23)),
  ((Select $node_id From Person Where id = 10), (Select $node_id From Person Where id = 24)),
  ((Select $node_id From Person Where id = 25), (Select $node_id From Person Where id = 20))
Go
Insert into LivesIn ($from_id, $to_id)
Values 
  ((Select $node_id From Person Where id = 1), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 2), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 3), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 4), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 5), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 6), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 7), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 8), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 9), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 10), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 11), (Select $node_id From Settlement Where id = 2)),
  ((Select $node_id From Person Where id = 12), (Select $node_id From Settlement Where id = 3)),
  ((Select $node_id From Person Where id = 13), (Select $node_id From Settlement Where id = 4)),
  ((Select $node_id From Person Where id = 14), (Select $node_id From Settlement Where id = 4)),
  ((Select $node_id From Person Where id = 15), (Select $node_id From Settlement Where id = 5)),
  ((Select $node_id From Person Where id = 16), (Select $node_id From Settlement Where id = 5)),
  ((Select $node_id From Person Where id = 17), (Select $node_id From Settlement Where id = 6)),
  ((Select $node_id From Person Where id = 18), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 19), (Select $node_id From Settlement Where id = 7)),
  ((Select $node_id From Person Where id = 20), (Select $node_id From Settlement Where id = 7)),
  ((Select $node_id From Person Where id = 21), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 22), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 23), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 24), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Person Where id = 25), (Select $node_id From Settlement Where id = 8))
Go
Insert into RestsIn (PersonIsDead, $from_id, $to_id)
Values 
  (1, (Select $node_id From Person Where id = 6), (Select $node_id From Cemetery Where id = 2)),
  (1, (Select $node_id From Person Where id = 7), (Select $node_id From Cemetery Where id = 2)),
  (1, (Select $node_id From Person Where id = 8), (Select $node_id From Cemetery Where id = 2)),
  (1, (Select $node_id From Person Where id = 11), (Select $node_id From Cemetery Where id = 3)),
  (1, (Select $node_id From Person Where id = 12), (Select $node_id From Cemetery Where id = 3)),
  (1, (Select $node_id From Person Where id = 13), (Select $node_id From Cemetery Where id = 4)),
  (1, (Select $node_id From Person Where id = 14), (Select $node_id From Cemetery Where id = 4)),
  (1, (Select $node_id From Person Where id = 16), (Select $node_id From Cemetery Where id = 5)),
  (1, (Select $node_id From Person Where id = 18), (Select $node_id From Cemetery Where id = 1)),
  (1, (Select $node_id From Person Where id = 19), (Select $node_id From Cemetery Where id = 6)),
  (1, (Select $node_id From Person Where id = 20), (Select $node_id From Cemetery Where id = 6)),
  (1, (Select $node_id From Person Where id = 25), (Select $node_id From Cemetery Where id = 1))
Go
Insert into LocatedIn ($from_id, $to_id)
Values 
  ((Select $node_id From Cemetery Where id = 1), (Select $node_id From Settlement Where id = 1)),
  ((Select $node_id From Cemetery Where id = 2), (Select $node_id From Settlement Where id = 9)),
  ((Select $node_id From Cemetery Where id = 3), (Select $node_id From Settlement Where id = 2)),
  ((Select $node_id From Cemetery Where id = 4), (Select $node_id From Settlement Where id = 4)),
  ((Select $node_id From Cemetery Where id = 5), (Select $node_id From Settlement Where id = 10)),
  ((Select $node_id From Cemetery Where id = 6), (Select $node_id From Settlement Where id = 7)),
  ((Select $node_id From Cemetery Where id = 7), (Select $node_id From Settlement Where id = 3)),
  ((Select $node_id From Cemetery Where id = 8), (Select $node_id From Settlement Where id = 3)),
  ((Select $node_id From Cemetery Where id = 9), (Select $node_id From Settlement Where id = 3)),
  ((Select $node_id From Cemetery Where id = 10), (Select $node_id From Settlement Where id = 3))
Go
--MATCH
--1. ����� ����� ����
Select Person1.name as [parent name]
	   , Person2.name as [child name]
From Person as Person1
	 , IsParentOf
	 , Person as Person2
Where Match(Person1-(IsParentOf)->Person2)
	  And Person1.name = N'����'
Go
--2. ����� ���� ������������ �� ������������� ��������
Select Person1.name
From Person as Person1
	 , RestsIn
	 , Cemetery as c
Where Match(Person1-(RestsIn)->c)
	  And c.name = N'�������������'
Go
--3. ����� ������ ������
Select distinct Person1.name
	   , Person3.name as [sister name]
From Person as Person1
	 , isParentOf as Parent1
	 , Person as Person2
	 , isParentOf as Parent2
	 , Person as Person3
Where Match(Person1<-(Parent1)-Person2-(Parent2)->Person3)
	  And Person1.name = N'������'
	  And Person3.name <> Person1.name
	  And Person3.sex = '�'
Go
--4. ����� �������� ���� ���������� 1954 ���� �������� (�����, ��� ��������� ������������) ����� �������, � ������� ���� �������� �������� (�� Null)
Select Top(1) Person1.name as [parent name]
	   , Person2.name as [son name]
	   , Person2.birthDate as [child birthdate]
From Person as Person1
	 , IsParentOf
	 , Person as Person2
Where Match(Person1-(IsParentOf)->Person2)
	  And Person1.name = N'���������'
	  And Person1.birthDate >= '1954' 
	  And Person1.birthDate < '1955'
	  And Person2.sex = '�'
	  And Person2.birthDate is not Null
order by [child birthdate]
Go
--5. ����� ���� ������� � ����� � 1-� ��������� ��� �������
Select distinct Person1.name as PersonName
	   , Person2.name as [parent name]
	   , Person5.name as [cousin name]
From Person as Person1
	 , isParentOf as Parent1
	 , Person as Person2
	 , isParentOf as Parent2
	 , Person as Person3
	 , isParentOf as Parent3
	 , Person as Person4
	 , isParentOf as Parent4
	 , Person as Person5
Where Match(Person1<-(Parent1)-Person2<-(Parent2)-Person3-(Parent3)->Person4-(Parent4)->Person5)
	  And Person1.name = N'�������'
	  And Person4.name <> Person2.name
Go
--SHORTEST_PATH
--1. ����� ���� ������� ������� �������, ������� �� ���� �����
Select Person1.name
	   , Last_value(Person2.name) Within Group (Graph Path) As [ancestor]
	   , Last_value(Person2.birthDate) Within Group (Graph Path) As [ancestor's birthdate]
	   , Last_value(Person2.deathDate) Within Group (Graph Path) As [ancestor's deathdate]
From Person as Person1
	 , IsParentOf for path as p
	 , Person for path as Person2
Where Match(Shortest_path(Person1(<-(p)-Person2)+))
	  And Person1.name = N'�������'
Go
--2. ����� ���� ����� � ������ ���� �������� (������������� id �������� � ����� � ���������)
Select Person1.id
	   , Person1.name
	   , String_Agg(Person2.name, '->') Within Group (Graph Path) as [family line]
From Person as Person1
	 , IsParentOf for path as p
	 , Person for path as Person2
Where Match(Shortest_path(Person1(-(p)->Person2){1,2}))
	  And Person1.name = N'���������'
Go
