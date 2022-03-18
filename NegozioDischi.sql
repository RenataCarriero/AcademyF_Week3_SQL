create database NegozioDischi

create table Band(
BandId int identity(1,1) constraint PK_BANDID primary key,
Nome nvarchar(30) not null,
NumeroComponenti int not null constraint CHK_NumComponenti check (NumeroComponenti>1)
);

Create Table Brano(
BranoId int identity(1,1) constraint PK_BranoID primary key,
Titolo nvarchar(50) not null,
Durata int not null constraint CHK_Durata check (Durata>0)
);

create table Album(
AlbumId int identity(1,1) constraint PK_ALBUMID primary key,
Titolo nvarchar(50) not null,
AnnoUscita int not null constraint CHK_ANNOUSCITA check (AnnoUscita<=year(getdate()) and AnnoUscita>=1900),
CasaDiscografica nvarchar(50) not null,
Genere nvarchar(30) not null Check (Genere in ('Classico', 'Jazz', 'Pop', 'Rock', 'Metal')),
Supporto nvarchar(30) not null check (Supporto in ('CD', 'Vinile', 'Streaming')),
BandID int not null foreign key references Band(BandID),
constraint UNQ_ALBUM Unique (Titolo, AnnoUscita, CasaDiscografica, Genere, Supporto, BandID)
);

create table AlbumBrano(
AlbumID int not null foreign key references Album(AlbumId),
BranoID int not null foreign key references Brano(BranoID),
constraint PK_ALBUM_BRANO primary key(AlbumId, BranoId)
);

--insert
insert into Band values('883', 3)
insert into Band values('Maneskin', 4)
insert into Band values('Beatles', 4)
select * from Band

insert into Album values ('The Beatles 1', 2000, 'Casa Disco 1', 'Pop','CD', 3)
insert into Album values ('Il meglio degli 883', 1997, 'Sony Music', 'Rock','CD', 1)
insert into Album values ('Gli anni', 2000, 'Sony Music', 'Rock','CD', 1)
insert into Album values ('The Beatles Esordi', 1978, 'Casa Disco 1', 'Pop','CD', 3)
insert into Album values ('The songs', 1980, 'Casa Disco 1', 'Pop','CD', 3)
insert into Album values ('The Beatles 1', 2000, 'Casa Disco 1', 'Pop','Vinile', 3)

insert into Brano values ('Love me do', 132)
insert into Brano values ('From me to you', 93)
insert into Brano values ('She loves you',133)
insert into Brano values ('I want to hold your Hand', 143)
insert into Brano values ('La dura legge del gol', 120)
insert into Brano values ('Imagine', 133)


insert into AlbumBrano values (1,1)
insert into AlbumBrano values (1,2)
insert into AlbumBrano values (1,3)
insert into AlbumBrano values (2,5)
insert into AlbumBrano values (1,6)
insert into AlbumBrano values (5,6)

insert into AlbumBrano values (6,1)
insert into AlbumBrano values (6,2)
insert into AlbumBrano values (6,3)
insert into AlbumBrano values (6,6)


--1 Scrivere una query che restituisca i titoli degli album degli “883” in ordine alfabetico
select a.Titolo
from Album a join Band b on a.BandID=b.BandId
where b.Nome='883'
order by a.Titolo asc;

--2 Selezionare tutti gli album della casa discografica “Sony Music” relativi all’anno 2020;
select * 
from Album a
where a.CasaDiscografica='Sony Music' and a.AnnoUscita=2020;


--3 Scrivere una query che restituisca tutti i titoli delle canzoni dei “Maneskin” 
--appartenenti ad album pubblicati prima del 2019;

select distinct b.Titolo
from Brano b join AlbumBrano ab on b.BranoId=ab.BranoID
			 join Album a on a.AlbumId=ab.AlbumID
			 join Band bd on a.BandID=bd.BandId
where bd.Nome='Maneskin' and a.AnnoUscita<2019;

--4 Individuare tutti gli album in cui è contenuta la canzone “Imagine”;
select distinct a.Titolo
from Brano b join AlbumBrano ab on b.BranoId=ab.BranoID
			 join Album a on a.AlbumId=ab.AlbumID
where b.Titolo='Imagine'


--5 Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”;
select count(b.BranoId)
from Brano b join AlbumBrano ab on b.BranoId=ab.BranoID
			 join Album a on a.AlbumId=ab.AlbumID
			 join Band bd on a.BandID=bd.BandId
where bd.Nome='The Giornalisti'

select bd.Nome, count(b.BranoId)
from Brano b join AlbumBrano ab on b.BranoId=ab.BranoID
			 join Album a on a.AlbumId=ab.AlbumID
			 join Band bd on a.BandID=bd.BandId
group by bd.Nome
having bd.Nome='The Giornalisti'


--6 Contare per ogni album, la “durata totale” cioè la somma dei secondi dei suoi brani
select a.AlbumId, a.Titolo, sum(b.durata) as [Durata Totale] 
from Brano b join AlbumBrano ab on b.BranoId=ab.BranoID
			 join Album a on a.AlbumId=ab.AlbumID
group by a.AlbumId, a.Titolo


--7 Mostrare i brani (distinti) degli “883” che durano più di 3 minuti 
select distinct b.Titolo
from Brano b join AlbumBrano ab on b.BranoId=ab.BranoID
			 join Album a on a.AlbumId=ab.AlbumID
			 join Band bd on a.BandID=bd.BandId
where b.Durata>3*60 and bd.Nome='883'

--8 Mostrare tutte le Band il cui nome inizia per “M” e finisce per “n”.
select *
from Band b
where b.Nome like('M%n');


--9 Mostrare il titolo dell’Album e di fianco un’etichetta che stabilisce che si tratta di un Album:
--‘Very Old’ se il suo anno di uscita è precedente al 1980,
--‘New Entry’ se l’anno di uscita è il 2021,
--‘Recente’ se il suo anno di uscita è compreso tra il 2010 e 2020,
--‘Old’ altrimenti. 

select a.Titolo,
case
	when a.AnnoUscita<1980 then 'Very Old'
	when a.AnnoUscita=2021 then 'New Entry'
	when a.AnnoUscita between 2010 and 2020 then 'Recente'
	else 'Old'
end as [Classifica Album]
from Album a;

--10 Mostrare i brani non contenuti in nessun album.
select b.Titolo
from brano b
where b.BranoId not in (select ab.BranoID
						from AlbumBrano ab)

select b.Titolo
from brano b left join AlbumBrano ab on ab.BranoID=b.BranoId
where ab.AlbumID is null 


