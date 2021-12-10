create database NegozioDischi

create table Band(
IdBand int primary key identity(1,1),
Nome nvarchar(30) not null,
NumeroComponenti int not null)

create table Brano(
IdBrano int primary key identity(1,1),
Titolo nvarchar(50)not null,
Durata int not null)

create table Album(
IdAlbum int primary key identity(1,1),
Titolo nvarchar(50) not null,
AnnoDinascita date not null,
CasaDiscografica nvarchar(50) not null,
Genere nvarchar(50) not null,
SupportoDistribuzione nvarchar(50) not null,
IdBand int foreign key references Band(IdBand),

constraint ChK_Genere check(Genere='Classico'OR Genere='Jazz'OR Genere='pop'OR Genere='rock'),
constraint Chk_SupportoDistribuzione check(SupportoDistribuzione='Cd'OR SupportoDistribuzione='Vinile'OR SupportoDistribuzione='Streaming'))

create table BranoAlbum(
IdBrano int foreign key references Brano(IdBrano),
IdAlbum int foreign key references Album(IdAlbum),
constraint PK_BRANOALBUM primary key (IdAlbum, IdBrano))

--inserimento dati

insert into Brano values('Ucciso l uomo ragno',200),
			('marlena ',230),
			('Felicita',201);
			

select * from Brano


insert into Band values('883',6),
					('Maneskin',4),
					('Giornalisti',5),
					
select * from Band

insert into Album values('Grazie mille','1992-04-23','Sony','pop','Cd',1),
				('teatro d ira','2021-09-02','Sony','rock','Streaming',2),
				('love','2018-06-12','Sony','pop','Cd',3);

select * from Album


--query
--1

select a.Titolo
from   Album as a join Band as bd on a.IdBand=bd.IdBand
where bd.Nome='883'
order by a.Titolo;
--2
insert into Album values ('ciao bella','2020-05-13','SonyMusic','pop','Cd',4)
insert into Band values('Sconosciuti',6);
insert into Brano values('ciccia',181);
 
 select *
 from Album 
 where CasaDiscografica='SonyMusic'
 and DATEPART(YEAR,AnnoDinascita)=2020

 
 --3
 select b.Titolo
 from Brano as b join BranoAlbum as ba on b.IdBrano=ba.IdBrano
 join Album as a on ba.IdAlbum=a.IdAlbum
 join Band as bd on a.IdBand=bd.IdBand
 where bd.Nome='maneskin' and
 DATEPART(YEAR,a.AnnoDinascita)<2019

 --4
 insert into Brano values('imagine',180);

 select b.Titolo
 from Brano as b join BranoAlbum as ba on b.IdBrano=ba.IdBrano
 join Album as a on ba.IdAlbum=a.IdAlbum
 where b.Titolo='imagine'


 --5
 select count(bd.Nome)
 from Brano as b join BranoAlbum as ba on b.IdBrano=ba.IdBrano
 join Album as a on ba.IdAlbum=a.IdAlbum
 join Band as bd on a.IdBand=bd.IdBand
 where bd.Nome='Giornalisti'
 


 --6
 select ba.IdAlbum, SUM(b.Durata)
 from Brano as b join BranoAlbum as ba on b.IdBrano=ba.IdBrano
 join Album as a on ba.IdAlbum=a.IdAlbum
 group by ba.IdAlbum



 
 --7
  select distinct ba.IdBrano
 from Brano as b join BranoAlbum as ba on b.IdBrano=ba.IdBrano
 join Album as a on ba.IdAlbum=a.IdAlbum
 join Band as bd on a.IdBand=bd.IdBand
 where bd.Nome='883' and
 b.Durata>=180

 --8