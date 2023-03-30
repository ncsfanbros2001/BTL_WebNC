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
	Position nvarchar(10) not null
);

select * from Persons

insert into Persons (Fullname, Email, Password, PhoneNumber, DOB, Gender, Position)
values ('James Fowler', 'fwlr@gmail.com', 'password', '0348591274', '2001-05-11', 'Male', 'Admin')

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
