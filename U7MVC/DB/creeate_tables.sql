/*
create database RabbitClub
go;
use RabbitClub;
go
*/

IF NOT EXISTS ( SELECT NULL FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Members' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'dbo')
	BEGIN
		CREATE TABLE [dbo].[Members] (
			[MemberID] [INT] CONSTRAINT pk__Members_MemberID PRIMARY KEY,
			[MemberName] [NVARCHAR] (200),
			[MemberNumber] [NVARCHAR] (10),

			[City] [NVARCHAR] (50),
			[Address] [NVARCHAR] (200),
			[PostBox] [NVARCHAR] (200)
		)
	END
GO

IF NOT EXISTS ( SELECT NULL FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Club' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'dbo')
	BEGIN
		CREATE TABLE [dbo].[Club] (
			[ClubID] [INT] CONSTRAINT pk__Club_ClubId  PRIMARY KEY,
			[ClubName] [NVARCHAR] (200),
			[ClubNumber] [NVARCHAR] (10),
			[ClubHeadID] [INT] CONSTRAINT fk_Club_ClubHeadID REFERENCES Members(MemberID),
			[City] [NVARCHAR] (200),
			[Address] [NVARCHAR] (200),
			[PostBox] [NVARCHAR] (200)
		)
	END
GO



IF NOT EXISTS ( SELECT NULL FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PhoneTypes' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'dbo')
	BEGIN
		CREATE TABLE [dbo].[PhoneTypes] (
			[ID] [INT] CONSTRAINT pk_PhoneTypes_ID PRIMARY KEY,
			[PhoneType] [NVARCHAR] (50) NOT NULL

			CONSTRAINT uk_PhoneTypes_PhoneType UNIQUE (PhoneType),
		)
	END
GO


IF NOT EXISTS ( SELECT NULL FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MembersPhone' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'dbo')
	BEGIN
		CREATE TABLE [dbo].[MembersPhone] (
			[ID] [INT] CONSTRAINT pk_MembersPhone_ID PRIMARY KEY,
			[MemberID] [INT] CONSTRAINT fk_MembersPhone_MemberID REFERENCES Members(MemberID),
			
			[PhoneTypeID] [INT] CONSTRAINT fk_MembersPhone_PhoneTypeID REFERENCES PhoneTypes(ID),
			[PhoneNumber] [NVARCHAR] (200)

			CONSTRAINT uk_MembersPhone_MemberID UNIQUE (MemberID, PhoneNumber),
		)
	END
GO

