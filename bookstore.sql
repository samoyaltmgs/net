IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [Firstname] nvarchar(max) NULL,
    [Lastname] nvarchar(max) NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Authors] (
    [AuthorId] int NOT NULL IDENTITY,
    [FirstName] nvarchar(200) NOT NULL,
    [LastName] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_Authors] PRIMARY KEY ([AuthorId])
);
GO

CREATE TABLE [Genres] (
    [GenreId] nvarchar(10) NOT NULL,
    [Name] nvarchar(25) NOT NULL,
    CONSTRAINT [PK_Genres] PRIMARY KEY ([GenreId])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Books] (
    [BookId] int NOT NULL IDENTITY,
    [Title] nvarchar(200) NOT NULL,
    [Price] float NOT NULL,
    [GenreId] nvarchar(10) NOT NULL,
    CONSTRAINT [PK_Books] PRIMARY KEY ([BookId]),
    CONSTRAINT [FK_Books_Genres_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [Genres] ([GenreId]) ON DELETE NO ACTION
);
GO

CREATE TABLE [BookAuthors] (
    [BookId] int NOT NULL,
    [AuthorId] int NOT NULL,
    CONSTRAINT [PK_BookAuthors] PRIMARY KEY ([BookId], [AuthorId]),
    CONSTRAINT [FK_BookAuthors_Authors_AuthorId] FOREIGN KEY ([AuthorId]) REFERENCES [Authors] ([AuthorId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BookAuthors_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [Books] ([BookId]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'AuthorId', N'FirstName', N'LastName') AND [object_id] = OBJECT_ID(N'[Authors]'))
    SET IDENTITY_INSERT [Authors] ON;
INSERT INTO [Authors] ([AuthorId], [FirstName], [LastName])
VALUES (1, N'Michelle', N'Alexander'),
(2, N'Stephen E.', N'Ambrose'),
(3, N'Margaret', N'Atwood'),
(4, N'Jane', N'Austen'),
(5, N'James', N'Baldwin'),
(6, N'Emily', N'Bronte'),
(7, N'Agatha', N'Christie'),
(8, N'Ta-Nehisi', N'Coates'),
(9, N'Jared', N'Diamond'),
(10, N'Joan', N'Didion'),
(11, N'Daphne', N'Du Maurier'),
(12, N'Tina', N'Fey'),
(13, N'Roxane', N'Gay'),
(14, N'Dashiel', N'Hammett'),
(15, N'Frank', N'Herbert'),
(16, N'Aldous', N'Huxley'),
(17, N'Stieg', N'Larsson'),
(18, N'David', N'McCullough'),
(19, N'Toni', N'Morrison'),
(20, N'George', N'Orwell'),
(21, N'Mary', N'Shelley'),
(22, N'Sun', N'Tzu'),
(23, N'Augusten', N'Burroughs'),
(25, N'JK', N'Rowling'),
(26, N'Seth', N'Grahame-Smith');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'AuthorId', N'FirstName', N'LastName') AND [object_id] = OBJECT_ID(N'[Authors]'))
    SET IDENTITY_INSERT [Authors] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GenreId', N'Name') AND [object_id] = OBJECT_ID(N'[Genres]'))
    SET IDENTITY_INSERT [Genres] ON;
INSERT INTO [Genres] ([GenreId], [Name])
VALUES (N'history', N'History'),
(N'memoir', N'Memoir'),
(N'mystery', N'Mystery'),
(N'novel', N'Novel'),
(N'scifi', N'Science Fiction');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GenreId', N'Name') AND [object_id] = OBJECT_ID(N'[Genres]'))
    SET IDENTITY_INSERT [Genres] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BookId', N'GenreId', N'Price', N'Title') AND [object_id] = OBJECT_ID(N'[Books]'))
    SET IDENTITY_INSERT [Books] ON;
INSERT INTO [Books] ([BookId], [GenreId], [Price], [Title])
VALUES (1, N'history', 18.0E0, N'1776'),
(2, N'scifi', 5.5E0, N'1984'),
(3, N'mystery', 4.5E0, N'And Then There Were None'),
(4, N'history', 11.5E0, N'Band of Brothers'),
(5, N'novel', 10.99E0, N'Beloved'),
(6, N'memoir', 13.5E0, N'Between the World and Me'),
(7, N'memoir', 4.25E0, N'Bossypants'),
(8, N'scifi', 16.25E0, N'Brave New World'),
(9, N'history', 15.0E0, N'D-Day'),
(10, N'memoir', 12.5E0, N'Down and Out in Paris and London'),
(11, N'scifi', 8.75E0, N'Dune'),
(12, N'novel', 9.0E0, N'Emma'),
(13, N'scifi', 6.5E0, N'Frankenstein'),
(14, N'novel', 10.25E0, N'Go Tell it on the Mountain'),
(15, N'history', 15.5E0, N'Guns, Germs, and Steel'),
(16, N'memoir', 14.5E0, N'Hunger'),
(17, N'mystery', 6.75E0, N'Murder on the Orient Express'),
(18, N'novel', 8.5E0, N'Pride and Prejudice'),
(19, N'mystery', 10.99E0, N'Rebecca'),
(20, N'history', 5.75E0, N'The Art of War'),
(21, N'mystery', 8.5E0, N'The Girl with the Dragon Tattoo'),
(22, N'scifi', 12.5E0, N'The Handmaid''s Tale'),
(23, N'mystery', 10.99E0, N'The Maltese Falcon'),
(24, N'history', 13.75E0, N'The New Jim Crow'),
(25, N'memoir', 13.5E0, N'The Year of Magical Thinking'),
(26, N'novel', 9.0E0, N'Wuthering Heights'),
(27, N'memoir', 11.0E0, N'Running With Scissors'),
(28, N'novel', 8.75E0, N'Pride and Prejudice and Zombies'),
(29, N'novel', 9.75E0, N'Harry Potter and the Sorcerer''s Stone');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BookId', N'GenreId', N'Price', N'Title') AND [object_id] = OBJECT_ID(N'[Books]'))
    SET IDENTITY_INSERT [Books] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'AuthorId', N'BookId') AND [object_id] = OBJECT_ID(N'[BookAuthors]'))
    SET IDENTITY_INSERT [BookAuthors] ON;
INSERT INTO [BookAuthors] ([AuthorId], [BookId])
VALUES (18, 1),
(20, 2),
(7, 3),
(2, 4),
(19, 5),
(8, 6),
(12, 7),
(16, 8),
(2, 9),
(20, 10),
(15, 11),
(4, 12),
(21, 13),
(5, 14),
(9, 15),
(13, 16),
(7, 17),
(4, 18),
(11, 19),
(22, 20),
(17, 21),
(3, 22),
(14, 23),
(1, 24),
(10, 25),
(6, 26),
(23, 27),
(4, 28),
(26, 28),
(25, 29);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'AuthorId', N'BookId') AND [object_id] = OBJECT_ID(N'[BookAuthors]'))
    SET IDENTITY_INSERT [BookAuthors] OFF;
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE INDEX [IX_BookAuthors_AuthorId] ON [BookAuthors] ([AuthorId]);
GO

CREATE INDEX [IX_Books_GenreId] ON [Books] ([GenreId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241120151133_Initial', N'8.0.11');
GO

COMMIT;
GO

