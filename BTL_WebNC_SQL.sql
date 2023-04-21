create database BTL_WebNC
use BTL_WebNC

create table Persons (
	ID int identity(1, 1) primary key,
	Fullname nvarchar(50) not null,
	Email nvarchar(50) not null,
	Password nvarchar(20) not null,
	PhoneNumber nvarchar(50) not null,
	DOB DATE NOT NULL,
	Gender nvarchar(10) not null CHECK (Gender IN('Male', 'Female')),
	Position nvarchar(10) not null CHECK (Position IN('Admin', 'Customer'))
);


select * from PurchaseHistory

insert into Persons (Fullname, Email, Password, PhoneNumber, DOB, Gender, Position)
values ('Han', 'admin', 'admin', '0365059595', '01-01-2001', 'FeMale', 'Admin')

create table Books (
	ID int identity(1, 1) primary key,
	Title nvarchar(30) not null,
	Author nvarchar(30) not null,
	Price decimal(10, 2) not null,
	Genre nvarchar(20) not null,
	Publisher nvarchar(50) not null,
	ImageLink nvarchar(50) not null
)

insert into Books (Title, Author, Price, Genre, Publisher, ImageLink)
values (N'Đắc Nhân Tâm', 'Dale Carnegie', 15.99, N'Self-Help', 'Simon & Schuster', 'images/DarkNhanTam.jpg'),
(N'The Big Nine', 'Amy Webb', 18.99, 'Economic', N'1980 Books', 'images/TheBigNine.jpg')

insert into Books (Title, Author, Price, Genre, Publisher, ImageLink)
values (N'Clean Code', 'Robert Martin', 22.99, 'Education', N'Pearson', 'images/CleanCode.jpg'),
(N'Thế giới phẳng', 'Thomas Friendman', 17.99, 'Economic', N'NXB Trẻ', 'images/TheWorldIsFlat.jpg')

insert into Books (Title, Author, Price, Genre, Publisher, ImageLink)
values (N'Money: Vintage Minis', 'Yuval Noah Harari', 17.99, 'Economic', N'Vintage Classics', 'images/Money.jpg'),
(N'The Big Short', 'Michael Lewis', 16.99, 'Economic', N'Penguin Books Ltd', 'images/TheBigShort.jpg'),
(N'Nhà Giả Kim', 'Paulo Coelho', 12.99, 'Novel', N'NXB Hội Nhà Văn', 'images/TheAlchemist.jpg')

insert into Books (Title, Author, Price, Genre, Publisher, ImageLink)
values (N'First Readers Cinderella', 'Geraldine Taylor', 13.99, 'Education', N'Parragon', 'images/Cinderella.jpg'),
(N'Dune', 'Frank Herbert', 19.99, 'Novel', N'Ace Books', 'images/Dune.jpg')

insert into Books (Title, Author, Price, Genre, Publisher, ImageLink)
values (N'The Hobbit', 'J.R.R. Tolkien', 18.99, 'Fiction', N'HarperCollins', 'images/TheHobbit.jpg')


create table CartItems (
	CartItemID int identity(1, 1) primary key,
	PersonID int foreign key References Persons(Id),
	PersonFullname nvarchar(50),
	PersonPhoneNumber nvarchar(50),
	BookID int foreign key References Books(Id),
	BookTitle nvarchar(30),
	BookPrice decimal(10, 2),
	BookImageLink nvarchar(50),
	Quantity int,
	TotalPrice decimal(10, 2)
) 

select * from CartItems

truncate table CartItems

create table PurchaseHistory (
	ReceiptID int identity(1, 1) primary key,
	PersonID int ,
	OrderDate DATE,
	EstimateReceiveDate DATE,
	Address nvarchar(150),
	Note text,
	TotalPrice decimal(10, 2)
)
ALTER TABLE PurchaseHistory ADD CONSTRAINT fk_per_history FOREIGN KEY (PersonID) REFERENCES Persons (ID); 



select * from PurchaseHistory
select * from PurchaseList

create table PurchaseList (
	PurchasedItemID int identity(1, 1) primary key,
	Receiptid int,
	BookID int,
	Quantity int
)
ALTER TABLE PurchaseList ADD CONSTRAINT fk_pur_history FOREIGN KEY (Receiptid) REFERENCES  PurchaseHistory(ReceiptID); 



