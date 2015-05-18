use Mentor20150506
--set nocount on
--set statistics time off
--set statistics io off
SET ANSI_NULL_DFLT_OFF ON -- All columns default to NOT NULL
GO
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Pgm') AND type in (N'U'))
--DROP TABLE dbo.Pgm
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Exercise') AND type in (N'U'))
--DROP TABLE dbo.Exercise
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Type') AND type in (N'U'))
--DROP TABLE dbo.Type
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Usr') AND type in (N'U'))
--DROP TABLE dbo.Usr
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Folder') AND type in (N'U'))
--DROP TABLE dbo.Folder
GO
--create schema Error authorization dbo
--GO
--create schema Pgm authorization dbo
--GO
--create schema Exercise authorization dbo
--GO
--create schema Type authorization dbo
--GO
--create schema Usr authorization dbo
--GO
--create schema Folder authorization dbo
--GO
--
-- CREATE
--

--CREATE TABLE Folder
--(FolderID Int Identity(100,1) Primary Key NONCLUSTERED
--,Folder_ParentID Int default 0
--,FolderName Varchar(512) default ''
--)
--GO
--CREATE UNIQUE CLUSTERED INDEX ParentFolderName ON Folder(Folder_ParentID,FolderName)

--INSERT INTO Folder(FolderName) VALUES('DarkShadaz.com')
--INSERT INTO Folder(FolderName) VALUES('PhillipSenn.com/DStelljes')
--GO
--CREATE TABLE dbo.Usr
--(UsrID Int Primary Key NONCLUSTERED Identity(200,1) 
--,ID UniqueIdentifier default newid()
--,FirstName varchar(128) default ''
--,UsrName varchar(512) default ''
--,UsrPass varchar(128) default '1'
--,Email varchar(512) default ''
--,Usr_FolderID Int default 0
--)
--GO
--ALTER TABLE Usr WITH CHECK
--ADD CONSTRAINT Usr_FolderID FOREIGN KEY(Usr_FolderID)
--REFERENCES Folder
--ON DELETE CASCADE;
--ALTER TABLE Usr CHECK CONSTRAINT Usr_FolderID
--GO
--INSERT INTO Usr(ID,FirstName,UsrName,Email,Usr_FolderID) VALUES('681A3EEF-2322-4F55-B8A1-7E296A9E4AE8','Sean','Sean Wilson','DarkShadaz@gmail.com',100)
--INSERT INTO Usr(ID,FirstName,UsrName,Email,Usr_FolderID) VALUES('8125E550-481E-4AF6-9EF2-28B16334BDD9','Dave','Dave Stelljes','dave.stelljes@gmail.com',101)
--INSERT INTO Usr(ID,FirstName,UsrName,Email,Usr_FolderID) VALUES('F2220A95-B738-465A-BB6E-CE59B7458C7D','Emmanuel','Emmanuel Omolaja','emmanuel.omolaja@my.lr.edu',0)
--INSERT INTO Folder(FolderName) VALUES('PhillipSenn.com/PSenn')
--INSERT INTO Usr(ID,UsrName,Email,FirstName,Usr_FolderID) VALUES('710CAEEC-807A-4F4C-BDE2-BC947F84FDF2','Phillip Senn','PhillipSenn@gmail.com','Phillip',Scope_Identity())
--GO
--CREATE TABLE Exercise
--(ExerciseID Int Identity(300,1) Primary Key NONCLUSTERED
--,Exercise_FolderID Int default 0
--,ExerciseName Varchar(512)
--)
--GO
--ALTER TABLE Exercise WITH CHECK
--ADD CONSTRAINT Exercise_FolderID FOREIGN KEY(Exercise_FolderID)
--REFERENCES Folder
--ON DELETE CASCADE;
--ALTER TABLE Exercise CHECK CONSTRAINT Exercise_FolderID
--GO
---- Subjective:
--CREATE UNIQUE CLUSTERED INDEX FolderIDExerciseName ON Exercise(Exercise_FolderID,ExerciseName)
--GO
--CREATE TABLE Type
--(TypeID Int Identity(400,1) Primary Key NONCLUSTERED
--,TypeName varchar(512)
--,TypeSort Int default 0
--)
--GO
--CREATE UNIQUE CLUSTERED INDEX TypeName ON Type(TypeName)
--GO
--insert into Type(TypeName,TypeSort) VALUES('Example',2) 
--INSERT INTO Type(TypeName,TypeSort) VALUES('Questions',3)
--INSERT INTO Type(TypeName,TypeSort) VALUES('Comments',4)
--insert into Type(TypeName) VALUES('HTMLDefault')
--insert into Type(TypeName) VALUES('CSSDefault')
--insert into Type(TypeName) VALUES('JavaScriptDefault')
--insert into Type(TypeName) VALUES('SQLDefault')
--insert into Type(TypeName) VALUES('cfscriptDefault')
--INSERT INTO Type(TypeName) VALUES('HTMLCode')
--INSERT INTO Type(TypeName) VALUES('CSSCode')
--INSERT INTO Type(TypeName) VALUES('JavaScriptCode')
--INSERT INTO Type(TypeName) VALUES('SQLCode')
--INSERT INTO Type(TypeName) VALUES('cfscriptCode')
--INSERT INTO Type(TypeName) VALUES('Options')
--insert into Type(TypeName) VALUES('Task')
--insert into Type(TypeName) VALUES('HTMLPaste')
--insert into Type(TypeName) VALUES('CSSPaste')
--insert into Type(TypeName) VALUES('JavaScriptPaste')
--insert into Type(TypeName) VALUES('SQLPaste')
--insert into Type(TypeName) VALUES('cfscriptPaste')
--GO
--CREATE TABLE Pgm
--(PgmID Int Identity(500,1) Primary Key NONCLUSTERED
--,Pgm_ExerciseID Int
--,Pgm_TypeID Int
--,PgmCode varchar(max) null
--)
--GO
--CREATE CLUSTERED INDEX ExerciseID ON Pgm(Pgm_ExerciseID,Pgm_TypeID)
--GO
--ALTER TABLE Pgm WITH CHECK
--ADD CONSTRAINT Pgm_ExerciseID FOREIGN KEY(Pgm_ExerciseID)
--REFERENCES Exercise
--ON DELETE CASCADE;
--ALTER TABLE Pgm CHECK CONSTRAINT Pgm_ExerciseID
--GO
--ALTER TABLE Pgm WITH CHECK
--ADD CONSTRAINT Pgm_TypeID FOREIGN KEY(Pgm_TypeID)
--REFERENCES Type
--ON DELETE CASCADE;
--ALTER TABLE Pgm CHECK CONSTRAINT Pgm_TypeID
--GO
--
-- Procs
--
IF OBJECT_ID ('Error.[get]', 'P' ) IS NOT NULL 
DROP PROCEDURE Error.[get]
GO
CREATE PROCEDURE Error.[get]
AS
SELECT -- ERROR_NUMBER() AS ErrorNumber -- @@Error
	 ERROR_SEVERITY() AS Severity
	,ERROR_STATE() AS StateName
	,ERROR_PROCEDURE() AS ProcName
	,ERROR_LINE() AS Line
	,ERROR_MESSAGE() AS Msg
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Folder.[get]') AND type in (N'P', N'PC'))
DROP PROC Folder.[get]
GO
CREATE PROC Folder.[get]
(@UsrID Int
,@FolderID Int
) AS
DECLARE @Folder_ParentID Int = 0
SELECT @Folder_ParentID = Folder_ParentID
FROM Folder
WHERE FolderID = @FolderID

SELECT FolderID,FolderName
FROM Folder
WHERE FolderID = @FolderID
IF @Folder_ParentID <> 0 BEGIN
	exec Folder.[get] @UsrID,@Folder_ParentID -- Recursive
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.[get]') AND type in (N'P', N'PC'))
DROP PROC Usr.[get]
GO
CREATE PROC Usr.[get]
(@UsrID Int -- session.Usr.UsrID
,@criteria Int
) AS
DECLARE @FolderID Int
SELECT @FolderID = Usr_FolderID
FROM Usr
WHERE UsrID = @criteria
SELECT UsrID,FirstName,UsrName,ID,Email
FROM Usr
WHERE UsrID = @criteria
exec Folder.[get] @UsrID,@FolderID
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.WhereID') AND type in (N'P', N'PC'))
DROP PROC Usr.WhereID
GO
CREATE PROC Usr.WhereID(@ID UniqueIdentifier) AS
DECLARE @UsrID Int
SELECT @UsrID = UsrID
FROM Usr
WHERE ID=@ID
exec Usr.[get] 0,@UsrID -- We don't know who is issueing the [get] command.
GO
exec Usr.[get] 0,200


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Folder.WhereParentID') AND type in (N'P', N'PC'))
DROP PROC Folder.WhereParentID
GO
CREATE PROC Folder.WhereParentID
(@UsrID Int
,@ParentID Int
) AS
SELECT FolderID,FolderName
FROM Folder
WHERE Folder_ParentID = @ParentID
ORDER BY FolderName
exec Folder.[get] @UsrID,@ParentID
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Exercise.WhereFolderID') AND type in (N'P', N'PC'))
DROP PROC Exercise.WhereFolderID
GO
CREATE PROC Exercise.WhereFolderID
(@UsrID Int
,@FolderID Int
) AS
SELECT ExerciseID,ExerciseName
FROM Exercise
WHERE Exercise_FolderID = @FolderID
exec Folder.[get] @UsrID,@FolderID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Folder.[Update]') AND type in (N'P', N'PC'))
DROP PROC Folder.[Update]
GO
CREATE PROC Folder.[Update]
(@UsrID Int
,@FolderID Int
,@FolderName varchar(max)
) AS
DECLARE @result Int
begin try
	UPDATE Folder 
	SET FolderName = @FolderName
	WHERE FolderID = @FolderID
end try
begin catch
	SET @result = @@Error
    exec Error.[get]
	return @result
end catch
GO
--DECLARE @response Int
--exec @response = Folder.[Update] 0,108,'B'
--print @response

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Folder.[Delete]') AND type in (N'P', N'PC'))
DROP PROC Folder.[Delete]
GO
CREATE PROC Folder.[Delete]
(@UsrID Int
,@FolderID Int
) AS
exec Folder.[get] @UsrID,@FolderID
DELETE FROM Folder 
WHERE FolderID = @FolderID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Exercise.[get]') AND type in (N'P', N'PC'))
DROP PROC Exercise.[get]
GO
CREATE PROC Exercise.[get]
(@UsrID Int
,@ExerciseID Int
) AS
DECLARE @FolderID Int
SELECT @FolderID = Exercise_FolderID
FROM Exercise
WHERE ExerciseID = @ExerciseID
SELECT ExerciseID,ExerciseName
FROM Exercise
WHERE ExerciseID = @ExerciseID
exec Folder.[get] @UsrID,@FolderID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Pgm.WhereExerciseID') AND type in (N'P', N'PC'))
DROP PROC Pgm.WhereExerciseID
GO
CREATE PROC Pgm.WhereExerciseID
(@UsrID Int
,@ExerciseID Int
) AS
SELECT PgmCode,TypeName
FROM Pgm
JOIN Type
ON Pgm_TypeID = TypeID
WHERE Pgm_ExerciseID = @ExerciseID
exec Exercise.[get] @UsrID,@ExerciseID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Exercise.[Merge]') AND type in (N'P', N'PC'))
DROP PROC Exercise.[Merge]
GO
CREATE PROC Exercise.[Merge]
(@UsrID Int
,@FolderID Int
,@ExerciseName varchar(max)
) AS
DECLARE @ExerciseID INT = 0
SELECT @ExerciseID = ExerciseID
FROM Exercise
WHERE Exercise_FolderID = @FolderID
AND ExerciseName = @ExerciseName
IF @ExerciseID = 0 BEGIN
	INSERT INTO Exercise(Exercise_FolderID,ExerciseName) VALUES(@FolderID,@ExerciseName)
	SELECT @ExerciseID = Scope_Identity()
END
SELECT ExerciseID = @ExerciseID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Exercise.[Update]') AND type in (N'P', N'PC'))
DROP PROC Exercise.[Update]
GO
CREATE PROC Exercise.[Update]
(@UsrID Int
,@ExerciseID Int
,@ExerciseName varchar(max)
) AS
UPDATE Exercise
SET ExerciseName = @ExerciseName
WHERE ExerciseID = @ExerciseID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Folder.Ancestry') AND type in (N'P', N'PC'))
DROP PROC Folder.Ancestry
GO
CREATE PROC Folder.Ancestry
(@UsrID Int
,@FolderID Int
) AS
with cte1 as(
	select 
		 Folder_ParentID
		,FolderName as cteFolderName -- This is returned to the outside
		,0 myLevel
	from Folder
	where FolderID = @FolderID -- this is the starting point you want in your recursion
	UNION ALL
	select
	 T.Folder_ParentID
	,T.FolderName
	,myLevel + 1
	from Folder T
	join cte1
	on CTE1.Folder_ParentID = T.FolderID -- this is the recursion
)
SELECT cteFolderName AS FolderName
FROM CTE1
WHERE Folder_ParentID <> 0
ORDER BY myLevel DESC
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Pgm.[Merge]') AND type in (N'P', N'PC'))
DROP PROC Pgm.[Merge]
GO
CREATE PROC Pgm.[Merge]
(@UsrID Int
,@ExerciseID Int
,@TypeID Int
,@PgmCode varchar(max)
) AS
DECLARE @PgmID Int = 0
SELECT @PgmID = PgmID
FROM Pgm
WHERE Pgm_ExerciseID = @ExerciseID
AND Pgm_TypeID = @TypeID
IF @PgmID = 0 BEGIN
	INSERT INTO Pgm(Pgm_ExerciseID,Pgm_TypeID) VALUES(@ExerciseID,@TypeID)
	SELECT @PgmID = Scope_Identity()
END
UPDATE Pgm 
SET PgmCode = @PgmCode
WHERE PgmID = @PgmID
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Pgm.SaveWhereTypeName') AND type in (N'P', N'PC'))
DROP PROC Pgm.SaveWhereTypeName
GO
CREATE PROC Pgm.SaveWhereTypeName
(@UsrID Int
,@ExerciseID Int
,@TypeName varchar(max)
,@PgmCode varchar(max)
) AS
DECLARE @TypeID Int
SELECT @TypeID = TypeID
FROM Type
WHERE TypeName = @TypeName
exec Pgm.[Merge] @UsrID,@ExerciseID,@TypeID,@PgmCode
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.[Where]') AND type in (N'P', N'PC'))
DROP PROC Usr.[Where]
GO
CREATE PROC Usr.[Where]
(@UsrID Int
) AS
SELECT UsrID,UsrName,FirstName,Email,ID
FROM Usr
ORDER BY UsrName
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.[Login]') AND type in (N'P', N'PC'))
DROP PROC Usr.[Login]
GO
CREATE PROC Usr.[Login]
(@Email varchar(255)
,@UsrPass varchar(128)
) AS
DECLARE @UsrID Int
DECLARE @FolderID Int
SELECT @UsrID = UsrID
	,@FolderID = Usr_FolderID
FROM Usr
WHERE Email = @Email
AND UsrPass = @UsrPass

SELECT UsrID,UsrName,FirstName,Email,ID
FROM Usr
WHERE UsrID = @UsrID
exec Folder.[get] @UsrID,@FolderID
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Vote') AND type in (N'U'))
DROP TABLE dbo.Vote
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Chad') AND type in (N'U'))
DROP TABLE dbo.Chad
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.P') AND type in (N'U'))
DROP TABLE dbo.P
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Tag') AND type in (N'U'))
DROP TABLE dbo.Tag
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ki') AND type in (N'U'))
DROP TABLE dbo.ki
GO
--create schema P authorization dbo
--GO
--create schema Vote authorization dbo
--GO
--create schema Chad authorization dbo
--GO
--create schema ki authorization dbo
--GO
--
-- CREATE
--

CREATE TABLE ki
(KeyID Int Identity(600,1) Primary Key NONCLUSTERED
,Key_ParentID Int default 0
,KeyName Varchar(512) default ''
,KeyDesc varchar(max) null
,KeyLink varchar(2000) default ''
,KeySort Int default 0
)
GO
CREATE CLUSTERED INDEX ParentKeyName ON ki(Key_ParentID,KeyName)
GO
DECLARE @KeyID Int
DECLARE @ParentID Int
INSERT INTO ki(KeyName) VALUES('HTML')
INSERT INTO ki(KeyName) VALUES('CSS')
INSERT INTO ki(KeyName) VALUES('Bootstrap')
INSERT INTO ki(KeyName) VALUES('SQL Server')
INSERT INTO ki(KeyName) VALUES('ColdFusion')
INSERT INTO ki(KeyName) VALUES('JavaScript')
INSERT INTO ki(KeyName) VALUES('jQuery')


SELECT @ParentID = KeyID FROM ki WHERE KeyName='HTML'
INSERT INTO ki(KeyName,Key_ParentID) VALUES('a',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('href',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('charset',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('coords',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('download',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('hreflang',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('media',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('name',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('rel',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('rev',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('shape',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('target',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('type',@KeyID)

SELECT @ParentID = KeyID FROM ki WHERE KeyName='SQL Server'
INSERT INTO ki(KeyName,Key_ParentID) VALUES('SELECT',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('FROM',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('TOP',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('*',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('ORDER BY',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('GROUP BY',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('HAVING',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('WHERE',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('COUNT()',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('SUM()',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('OVER',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('PARTITION',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('ROW_NUMBER()',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('JOIN',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('INNER JOIN',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('LEFT JOIN',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('RIGHT JOIN',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('AS',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('(SELECT',@KeyID) -- FROM (SELECT

INSERT INTO ki(KeyName,Key_ParentID) VALUES('CREATE TABLE',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Varchar(#)',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Varchar(max)',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Int',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Integer',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Decimal',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('default',@KeyID)

INSERT INTO ki(KeyName,Key_ParentID) VALUES('DROP TABLE',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('EXISTS',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('CREATE PROC',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('DROP PROC',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('ALTER TABLE',@ParentID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Add',@KeyID)
INSERT INTO ki(KeyName,Key_ParentID) VALUES('Drop',@KeyID)



INSERT INTO ki(KeyName,Key_ParentID) VALUES('INSERT INTO',@KeyID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('VALUES',@KeyID)



INSERT INTO ki(KeyName,Key_ParentID) VALUES('UPDATE',@KeyID)
SELECT @KeyID=Scope_Identity()
INSERT INTO ki(KeyName,Key_ParentID) VALUES('SET',@KeyID)

GO
CREATE TABLE Chad
(ChadID Int Identity(700,1) Primary Key NONCLUSTERED
,ChadName varchar(512)
,ChadSort Int
)
GO
INSERT INTO Chad(ChadName,ChadSort) VALUES('No Chad Yet',0) -- They've read it but not voted on it yet
INSERT INTO Chad(ChadName,ChadSort) VALUES('Always',1)
INSERT INTO Chad(ChadName,ChadSort) VALUES('Occasion',2)
INSERT INTO Chad(ChadName,ChadSort) VALUES('Rarely',3)
INSERT INTO Chad(ChadName,ChadSort) VALUES('Don''t know',4) -- They've read it and voted that they don't understand it
INSERT INTO Chad(ChadName,ChadSort) VALUES('Never',5)
GO
CREATE TABLE P
(PID Int Identity(800,1) Primary Key NONCLUSTERED
,P_KeyID Int
,P_TypeID Int
,PName varchar(max) null
)
GO
CREATE CLUSTERED INDEX UsrID ON P(P_KeyID,P_TypeID)
GO
ALTER TABLE P WITH CHECK
ADD CONSTRAINT KeyID FOREIGN KEY(P_KeyID)
REFERENCES ki
ON DELETE CASCADE;
ALTER TABLE P CHECK CONSTRAINT KeyID
GO
CREATE TABLE Vote
(VoteID Int Identity(900,1) Primary Key NONCLUSTERED
,Vote_UsrID Int
,Vote_KeyID Int
,Vote_ChadID Int
,VoteName varchar(max) null -- It can be null because Lucee treats null as ''
,VoteDate datetime2 default getdate()
)
GO
-- todo: Disambiguate if a keyword has two meanings within the same parent. Example: Music is an App so it would fall under Music and Apps.
CREATE TABLE Tag
(TagID Int Identity(1000,1) Primary Key NONCLUSTERED
,Tag_KeyID Int -- This key has these parents
,Tag_ParentID Int -- This is another KeyID
)
--
-- Procs
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.[get]') AND type in (N'P', N'PC'))
DROP PROC ki.[get]
GO
CREATE PROC ki.[get]
(@UsrID Int
,@KeyID Int
) AS
DECLARE @ParentID Int
SELECT @ParentID = Key_ParentID
FROM ki
WHERE KeyID = @KeyID
SELECT KeyID,KeyName,KeyDesc,KeyLink
	,Vote_ChadID AS ChadID
FROM ki
LEFT JOIN(
	SELECT Vote_KeyID,Vote_ChadID
	FROM Vote
	WHERE Vote_UsrID = @UsrID
) Vote
ON Vote_KeyID = KeyID
WHERE KeyID = @KeyID
IF @ParentID <> 0 BEGIN
	exec ki.[get] @UsrID,@ParentID
END
GO
exec ki.[get] 200,607


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.WhereParentID') AND type in (N'P', N'PC'))
DROP PROC ki.WhereParentID
GO
CREATE PROC ki.WhereParentID
(@UsrID Int
,@ParentID Int
) AS
SELECT KeyID,KeyName,KeyDesc,KeyLink
	,Children
FROM ki
LEFT JOIN(
	SELECT Key_ParentID AS Child_ParentID
		,COUNT(*) AS Children
	FROM ki
	GROUP BY Key_ParentID
) Child
ON Child_ParentID = KeyID
WHERE Key_ParentID = @ParentID
ORDER BY KeySort,KeyName
IF @ParentID <> 0 BEGIN
	exec ki.[get] @UsrID,@ParentID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'P.WhereKeyID') AND type in (N'P', N'PC'))
DROP PROC P.WhereKeyID
GO
CREATE PROC P.WhereKeyID
(@UsrID Int
,@KeyID Int -- a tag
) AS
SELECT PID,PName
	,TypeName
FROM P
JOIN Type
ON P_TypeID = TypeID
WHERE P_KeyID = @KeyID
ORDER BY PID
exec ki.WhereParentID @UsrID,@KeyID -- All the attributes whose parent is the a tag, because their parent will be the a tag itself.
GO
--exec P.WhereKeyID 0,@KeyID

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Chad.[Where]') AND type in (N'P', N'PC'))
DROP PROC Chad.[Where]
GO
CREATE PROC Chad.[Where]
(@UsrID Int
) AS
SELECT ChadID,ChadName,ChadSort
FROM Chad
ORDER BY ChadSort
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Type.[Where]') AND type in (N'P', N'PC'))
DROP PROC Type.[Where]
GO
CREATE PROC Type.[Where]
(@UsrID Int
) AS
SELECT TypeID,TypeName
FROM Type
ORDER BY TypeName
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'P.[Insert]') AND type in (N'P', N'PC'))
DROP PROC P.[Insert]
GO
CREATE PROC P.[Insert]
(@UsrID Int
,@KeyID Int
,@TypeID Int
,@PName varchar(max)
) AS
DECLARE @ChadID Int
SELECT @ChadID = ChadID
FROM Chad
WHERE ChadSort = 0
INSERT INTO P(P_KeyID,P_TypeID,PName) VALUES(@KeyID,@TypeID,@PName)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Type.Workbook') AND type in (N'P', N'PC'))
DROP PROC Type.Workbook
GO
CREATE PROC Type.Workbook
(@UsrID Int
) AS
SELECT TypeID,TypeName
FROM Type
WHERE TypeName IN('Questions','Comments','Example')
ORDER BY TypeSort,TypeName
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.UpdateWhereKeyID') AND type in (N'P', N'PC'))
DROP PROC Vote.UpdateWhereKeyID
GO
CREATE PROC Vote.UpdateWhereKeyID
(@UsrID Int
,@KeyID Int
,@ChadID Int
) AS
UPDATE Vote 
SET Vote_ChadID = @ChadID
FROM Vote
WHERE Vote_UsrID = @UsrID
AND Vote_KeyID = @KeyID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Type.[get]') AND type in (N'P', N'PC'))
DROP PROC Type.[get]
GO
CREATE PROC Type.[get]
(@UsrID Int
,@TypeID Int
) AS
SELECT TypeID,TypeName
FROM Type
WHERE TypeID = @TypeID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'P.[get]') AND type in (N'P', N'PC'))
DROP PROC P.[get]
GO
CREATE PROC P.[get]
(@UsrID Int
,@PID Int
) AS
DECLARE @KeyID Int
DECLARE @TypeID Int
SELECT @KeyID = P_KeyID
	,@TypeID = P_TypeID 
	FROM P
WHERE PID = @PID
SELECT PID,PName
FROM P
WHERE PID = @PID
exec Type.[get] @UsrID,@TypeID
exec ki.[get] @UsrID,@KeyID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.WhereKeyID') AND type in (N'P', N'PC'))
DROP PROC Vote.WhereKeyID
GO
CREATE PROC Vote.WhereKeyID
(@UsrID Int
,@KeyID Int
) AS
SELECT VoteID
FROM Vote
WHERE Vote_UsrID = @UsrID
AND Vote_KeyID = @KeyID
exec P.WhereKeyID @UsrID,@KeyID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Chad.[get]') AND type in (N'P', N'PC'))
DROP PROC Chad.[get]
GO
CREATE PROC Chad.[get]
(@UsrID Int
,@ChadID Int
) AS
SELECT ChadID,ChadName,ChadSort
FROM Chad
WHERE ChadID = @ChadID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.WhereUsrChadParentID') AND type in (N'P', N'PC'))
DROP PROC ki.WhereUsrChadParentID
GO
CREATE PROC ki.WhereUsrChadParentID
(@UsrID Int
,@criteria Int
,@ParentID Int
,@ChadID Int
) AS
SELECT KeyID
--	,COUNT(*) AS Paragraphs
FROM Vote
JOIN ki
ON Vote_KeyID = KeyID
WHERE Vote_UsrID = @criteria
AND Vote_ChadID = @ChadID
AND Key_ParentID = @ParentID
GROUP BY KeyID

exec Usr.[get] @UsrID,@criteria
exec Chad.[get] @UsrID,@ChadID
exec ki.[get] @UsrID,@ParentID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.WhereUsrIsNullForParentID') AND type in (N'P', N'PC'))
DROP PROC ki.WhereUsrIsNullForParentID
GO
CREATE PROC ki.WhereUsrIsNullForParentID
(@UsrID Int
,@Vote_UsrID Int
,@ParentID Int
) AS

SELECT KeyID,KeyName
FROM ki
LEFT JOIN Vote
ON Vote_UsrID = @Vote_UsrID
AND Vote_KeyID = KeyID
WHERE Key_ParentID = @ParentID
AND VoteID is null
exec Usr.[get] @UsrID,@Vote_UsrID
exec ki.[get] @UsrID,@ParentID
GO
exec ki.WhereUsrIsNullForParentID 0,


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.[get]') AND type in (N'P', N'PC'))
DROP PROC Vote.[get]
GO
CREATE PROC Vote.[get]
(@UsrID Int
,@VoteID Int
) AS
DECLARE @Vote_UsrID Int
DECLARE @KeyID Int
DECLARE @ChadID Int
SELECT @Vote_UsrID = Vote_UsrID
	,@KeyID = Vote_KeyID
	,@ChadID = Vote_ChadID
FROM Vote
WHERE VoteID = @VoteID
SELECT VoteID
FROM Vote
WHERE VoteID = @VoteID
exec Usr.[get] @UsrID,@Vote_UsrID
exec Chad.[get] @UsrID,@ChadID
exec ki.[get] @UsrID,@KeyID
GO
exec Vote.[get] 0,900

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.InsertDefault') AND type in (N'P', N'PC'))
DROP PROC Vote.InsertDefault
GO
CREATE PROC Vote.InsertDefault
(@UsrID Int
,@KeyID Int
) AS
DECLARE @VoteID Int = 0
SELECT @VoteID = VoteID
FROM Vote
WHERE Vote_UsrID = @UsrID
AND Vote_KeyID = @KeyID
IF @VoteID = 0 BEGIN
	DECLARE @ChadID Int
	SELECT @ChadID = ChadID
	FROM Chad
	WHERE ChadSort = 0

	INSERT INTO Vote(Vote_UsrID,Vote_KeyID,Vote_ChadID) VALUES(@UsrID,@KeyID,@ChadID)
END
exec Vote.[get] @UsrID,@KeyID
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'P.[Merge]') AND type in (N'P', N'PC'))
DROP PROC P.[Merge]
GO
CREATE PROC P.[Merge]
(@UsrID Int
,@KeyID Int
,@TypeID Int
,@PName varchar(max)
) AS
DECLARE @PID Int = 0
SELECT @PID = PID
FROM P
WHERE P_KeyID = @KeyID
AND P_TypeID = @TypeID
IF @PID = 0 BEGIN
	INSERT INTO P(P_KeyID,P_TypeID) VALUES(@KeyID,@TypeID)
	SELECT @PID = Scope_Identity()
END
UPDATE P
SET Pname = @PName
WHERE PID = @PID
exec P.[get] @UsrID,@PID
GO



--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Type.WhereTypeName') AND type in (N'P', N'PC'))
--DROP PROC Type.WhereTypeName
--GO
--CREATE PROC Type.WhereTypeName
--(@UsrID Int
--,@TypeName varchar(max)
--) AS
--SELECT TypeID
--FROM Type
--WHERE TypeName = @TypeName
--GO


--DECLARE @UsrID Int
--DECLARE @KeyID Int
--DECLARE @ChadID Int
--SELECT @UsrID = UsrID FROM Usr WHERE UsrName='Phillip Senn'
--SELECT @KeyID = KeyID FROM ki WHERE KeyName = 'A'
--SELECT @ChadID = ChadID FROM Chad WHERE ChadSort = 0
--exec P.[Insert] @UsrID,@KeyID,@TypeID,'Anchor tag'

--SELECT @KeyID = KeyID FROM ki WHERE KeyName = 'SELECT'
--SELECT @ChadID = ChadID FROM Chad WHERE ChadSort = 0
--exec P.[Insert] @UsrID,@KeyID,@TypeID,'The select statement'

--delete from Type
--set identity_insert Type ON
--INSERT INTO Type(TypeID,TypeName) 
--SELECT TypeID,TypeName
--FROM Mentor20150424..Type
--set identity_insert Type OFF

--delete from Folder
--set identity_insert Folder ON
--INSERT INTO Folder(FolderID,Folder_ParentID,FolderName) 
--SELECT FolderID,Folder_ParentID,FolderName
--FROM Mentor20150424..Folder
--set identity_insert Folder OFF

--delete from Usr
--set identity_insert Usr ON
--INSERT INTO Usr(UsrID,ID,FirstName,UsrName,Email,Usr_FolderID,UsrPass)
--SELECT UsrID,ID,FirstName,UsrName,Email,Usr_FolderID,UsrPass
--FROM Mentor20150424..Usr
--set identity_insert Usr OFF

--DELETE FROM Exercise
--set identity_insert Exercise ON
--INSERT INTO Exercise(ExerciseID,Exercise_FolderID,ExerciseName)
--SELECT ExerciseID,Exercise_FolderID,ExerciseName
--from Mentor20150424..Exercise
--set identity_insert Exercise OFF

--DELETE FROM Pgm
--set identity_insert Pgm ON
--INSERT INTO Pgm(PgmID,Pgm_ExerciseID,Pgm_TypeID,PgmCode)
--SELECT PgmID,Pgm_ExerciseID,Pgm_TypeID,PgmCode
--from Mentor20150424..pgm
--set identity_insert Pgm OFF

--delete from vote
--select *
--from vote
--join ki
--on vote_KeyID = KeyID
--join usr
--on vote_Usrid = usrid


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.WhereUsrParentID') AND type in (N'P', N'PC'))
DROP PROC Vote.WhereUsrParentID
GO
CREATE PROC Vote.WhereUsrParentID -- ChadID WHERE Key_ParentID= AND UsrID=
(@UsrID Int
,@Vote_UsrID Int
,@KeyID Int
) AS
SELECT KeyID,KeyName,KeyDesc
	,ChadID,ChadName
	,GrandChildren
FROM Ki
LEFT JOIN (
	SELECT Vote_KeyID,ChadID,ChadName
	FROM Vote
	JOIN Chad
	ON Vote_ChadID = ChadID
	WHERE Vote_UsrID = @Vote_UsrID
) Vote
ON Vote_KeyID = KeyID
LEFT JOIN(
	SELECT Key_ParentID AS Child_ParentID
		,COUNT(*) AS GrandChildren
	FROM ki
	GROUP BY Key_ParentID
) Child
ON Child_ParentID = KeyID
WHERE Key_ParentID = @KeyID
GO
exec Vote.WhereUsrParentID 0,203,603 -- 603 = SQL Server
exec Vote.WhereUsrParentID 0,203,607 -- 607 = a


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.ChildrenWhereUsrKeyChadSort') AND type in (N'P', N'PC'))
DROP PROC Vote.ChildrenWhereUsrKeyChadSort
GO
CREATE PROC Vote.ChildrenWhereUsrKeyChadSort -- All the children of this KeyID that have been voted this ChadSort by this UsrID
(@UsrID Int
,@Vote_UsrID Int
,@KeyID Int
,@ChadSort Int
) AS
--DECLARE @ChadID Int
--SELECT @ChadID = ChadID
--FROM Chad
--WHERE ChadSort = @ChadSort
SELECT KeyID,KeyName,GrandChildren
	,myChadID -- While we're at it, let's get this user's vote
FROM Vote
LEFT JOIN (
	SELECT
	 Vote_KeyID AS myKeyID
	,Vote_ChadID AS myChadID
	FROM Vote
	WHERE Vote_UsrID = @UsrID
) myVote
ON Vote_KeyID = myKeyID
JOIN ki
ON Vote_KeyID = KeyID
JOIN Chad
ON Vote_ChadID = ChadID
LEFT JOIN(
	SELECT Key_ParentID AS Child_ParentID
		,COUNT(*) AS GrandChildren
	FROM ki
	GROUP BY Key_ParentID
) Child
ON Child_ParentID = KeyID
WHERE Vote_UsrID = @Vote_UsrID
AND Key_ParentID = @KeyID
AND ChadSort = @ChadSort
-- exec Chad.[get] @UsrID,@ChadID
GO
exec Vote.ChildrenWhereUsrKeyChadSort 0,203,603,1 -- 603 = SQL Server
exec Vote.ChildrenWhereUsrKeyChadSort 0,203,600,1 -- 600 = HTML



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'P.WhereTypeNameKeyID') AND type in (N'P', N'PC'))
DROP PROC P.WhereTypeNameKeyID
GO
CREATE PROC P.WhereTypeNameKeyID
(@UsrID Int
,@TypeName varchar(max)
,@KeyID Int
) AS
DECLARE @PID INT
SELECT @PID = PID
FROM P
JOIN Type
ON P_TypeID = TypeID
WHERE TypeName = @TypeName
AND P_KeyID = @KeyID
exec P.[get] @UsrID,@PID
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.WhereKeyID') AND type in (N'P', N'PC'))
DROP PROC Usr.WhereKeyID
GO
CREATE PROC Usr.WhereKeyID
(@UsrID Int
,@KeyID Int
) AS
SELECT UsrID,UsrName
	,VoteName,VoteDate
FROM Usr
LEFT JOIN Vote
ON Vote_UsrID = UsrID
AND Vote_KeyID = @KeyID
GO






/*
select * from pselect * from vote JOIN Usr on Vote_UsrID =UsrID
select * from vote JOIN P ON Vote_PID = PID JOIN ki ON P_KeyID = KeyID join chad on Vote_ChadiD = ChadID
SELECT * FROM ki
select * from type
SELECT * FROM Chad
SELECT * FROM P
select * from Usr


select * from Usr
select * from Mentor20150424..Usr

order by usrid
select * from folder
select * from type
select * from exercise
select * from pgm

select * from Mentor20150424..pgm
select * from Mentor20150424..Folder
select * from Mentor20150424..Exercise
select * from vote

*/


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.WhereParentID_VoteIDIsNull') AND type in (N'P', N'PC'))
DROP PROC ki.WhereParentID_VoteIDIsNull
GO
CREATE PROC ki.WhereParentID_VoteIDIsNull -- This might be a duplicate of ki.WhereUsrIsNullForParentID, but I can't tell until I write it.
(@UsrID Int
,@Vote_UsrID Int
,@KeyID Int
) AS
SELECT KeyID,KeyName
	,Children
FROM ki
LEFT JOIN(
	SELECT Key_ParentID AS Child_ParentID
		,COUNT(*) AS Children
	FROM ki
	GROUP BY Key_ParentID
) Child
ON Child_ParentID = KeyID
LEFT JOIN Vote
ON Vote_UsrID = @Vote_UsrID
AND Vote_KeyID = KeyID
WHERE Key_ParentID = @KeyID
AND VoteID is null
exec ki.[get] @UsrID,@KeyID
GO
exec ki.WhereParentID_VoteIDIsNull 0,203,600



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Folder.[Merge]') AND type in (N'P', N'PC'))
DROP PROC Folder.[Merge]
GO
CREATE PROC Folder.[Merge]
(@UsrID Int
,@FolderName varchar(max)
,@ParentID Int
) AS
DECLARE @FolderID Int = 0
SELECT @FolderID = FolderID
FROM Folder
WHERE FolderName = @FolderName
AND Folder_ParentID = @ParentID
IF @FolderID = 0 BEGIN
	INSERT INTO Folder(FolderName,Folder_ParentID) VALUES(@FolderName,@ParentID)
	SELECT @FolderID = Scope_Identity()
END
exec Folder.[get] @UsrID,@FolderID
GO




IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.[Merge]') AND type in (N'P', N'PC'))
DROP PROC Usr.[Merge]
GO
CREATE PROC Usr.[Merge]
(@UsrID Int -- Admin
,@UsrName varchar(max)
,@FirstName varchar(max)
,@Email varchar(255)
,@UsrPass varchar(128)
,@FolderID Int
) AS
DECLARE @newUsrID Int = 0
SELECT @newUsrID = UsrID
FROM Usr
WHERE Email = @Email
IF @newUsrID = 0 BEGIN
	INSERT INTO Usr(Email,Usr_FolderID) VALUES(@Email,@FolderID)
	SELECT @newUsrID = Scope_Identity()
END
exec Usr.[Update] @newUsrID,@UsrName,@FirstName,@Email,@UsrPass,@FolderID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Usr.[Update]') AND type in (N'P', N'PC'))
DROP PROC Usr.[Update]
GO
CREATE PROC Usr.[Update]
(@UsrID Int
,@UsrName varchar(max)
,@FirstName varchar(max)
,@Email varchar(255)
,@UsrPass varchar(128)
,@FolderID Int
) AS
UPDATE Usr SET 
 UsrName = @UsrName
,FirstName = @FirstName
,Email = @Email
,Usr_FolderID = @FolderID
WHERE Usrid = @UsrID
IF @UsrPass <> '' BEGIN
	UPDATE Usr
	SET UsrPass = @UsrPass
	WHERE Usrid = @UsrID
END

exec Usr.[get] @UsrID,@UsrID
GO

select * from folder
order by folderid

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Vote.[Merge]') AND type in (N'P', N'PC'))
DROP PROC Vote.[Merge]
GO
CREATE PROC Vote.[Merge]
(@UsrID Int
,@KeyID Int
,@ChadID Int
-- ,@VoteName Not supplied via ajax
) AS
DECLARE @VoteID Int = 0
SELECT @VoteID = VoteID
FROM Vote
WHERE Vote_UsrID = @UsrID
AND Vote_KeyID = @KeyID
IF @VoteID = 0 BEGIN
	INSERT INTO Vote(Vote_UsrID,Vote_KeyID,Vote_ChadID) VALUES(@UsrID,@KeyID,@ChadID)
	SELECT @VoteID = Scope_Identity()
END
UPDATE Vote SET
 Vote_ChadID = @ChadID
,VoteDate = getdate()
WHERE VoteID = @VoteID
exec Vote.[get] @UsrID,@KeyID
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Chad.WhereChadSort') AND type in (N'P', N'PC'))
DROP PROC Chad.WhereChadSort
GO
CREATE PROC Chad.WhereChadSort
(@UsrID Int
,@ChadSort Int
) AS
DECLARE @ChadID Int = (
	SELECT ChadID
	FROM Chad
	WHERE ChadSort = @ChadSort
)
exec Chad.[get] @UsrID,@ChadID
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.[Merge]') AND type in (N'P', N'PC'))
DROP PROC ki.[Merge]
GO
CREATE PROC ki.[Merge]
(@UsrID Int
,@KeyName varchar(512)
,@KeyDesc varchar(max)
,@KeyLink varchar(2000)
,@ParentID Int
) AS
DECLARE @KeyID INT = 0
SELECT @KeyID = KeyID
FROM ki
WHERE Key_ParentID = @ParentID
AND KeyName = @KeyName
IF @KeyID = 0 BEGIN
	INSERT INTO ki(Key_ParentID,KeyName) VALUES(@ParentID,@KeyName)
	SELECT @KeyID = Scope_Identity()
	UPDATE ki 
	SET KeySort = @KeyID -- This could be max(KeySort)+1, but let's try it this way first to see if that gives any extra info,
	-- example: they sorted the list and then added a line item.
	WHERE KeyID = @KeyID
END
UPDATE ki SET
 KeyDesc = @KeyDesc
,KeyLink = @KeyLink
WHERE KeyID = @KeyID
-- SELECT KeyID = @KeyID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.[Update]') AND type in (N'P', N'PC'))
DROP PROC ki.[Update]
GO
CREATE PROC ki.[Update]
(@UsrID Int
,@KeyID Int
,@KeyName varchar(512)
,@KeyDesc varchar(max)
,@KeyLink varchar(2000)
) AS
UPDATE ki SET
 KeyName = @KeyName
,KeyDesc = @KeyDesc
,KeyLink = @KeyLink
WHERE KeyID = @KeyID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'P.MergeTypeNameKeyID') AND type in (N'P', N'PC'))
DROP PROC P.MergeTypeNameKeyID
GO
CREATE PROC P.MergeTypeNameKeyID
(@UsrID Int
,@TypeName varchar(512)
,@KeyID Int
,@PName varchar(max)
) AS
DECLARE @TypeID Int = (
	SELECT TypeID
	FROM Type
	WHERE TypeName = @TypeName
)
DECLARE @PID Int = 0
SELECT @PID = PID
FROM P
WHERE P_KeyID = @KeyID
AND P_TypeID = @TypeID
IF @PID = 0 BEGIN
	INSERT INTO P(P_KeyID,P_TypeID) VALUES(@KeyID,@TypeID)
	SELECT @PID = Scope_Identity()
END
UPDATE P
SET PName = @PName
WHERE PID = @PID
-- exec P.[get] @UsrID,@PID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ki.UpdateKeySort') AND type in (N'P', N'PC'))
DROP PROC ki.UpdateKeySort
GO
CREATE PROC ki.UpdateKeySort
(@UsrID Int
,@KeyID Int
,@KeySort Int
) AS
UPDATE ki
SET KeySort = @KeySort
WHERE KeyID = @KeyID
GO



select *
from vote
order by voteid desc

SELECT * FROM CHAD
SELECT * FROM Ki ORDER BY KeyID DESC
select * from vote
select * from type order by typeid

