--create database Cinema

--questo è un commento 
/* questo è un commento 
su più righe */
--commento 1
--commento 2
--commento 3 

create table Attore(
CodiceAttore int identity(1,1) ,
Nome varchar(100) not null,
Nazionalita varchar(20) not null,
DataNascita datetime null,

constraint PK_Attore primary key (CodiceAttore)
)

create table Sala (
CodiceSala int identity(1,1) not null,
Nome varchar(30) not null,
PostiTotali int not null, --check(PostiTotali>0)

constraint PK_SALA primary key (CodiceSala),
constraint CHK_POSTITotaliMaggioriDiZero check(PostiTotali>0)
)

create table Film (
CodiceFilm int identity(1,1) constraint PK_Film primary key,
Titolo varchar(100) not null ,
Genere varchar(30) not null default 'Sconosciuto',
Durata int constraint CHK_Durata check (Durata>0),

constraint CHK_GENERE check (Genere='Sconosciuto' or Genere='Drammatico' or Genere='Storico' or Genere='Commedia' or Genere='Fantasy')
)

create table FilmAttore(
CodiceFilm int not null,
CodiceAttore int not null,
Cachet decimal(9,2) check(Cachet >0),

constraint FK_FILM foreign key (CodiceFilm) references Film(CodiceFilm),
constraint FK_Attore foreign key (CodiceAttore) references Attore(CodiceAttore),
constraint PK_FILMATTORE primary key(CodiceFilm, CodiceAttore)
)

create table Programmazione (
CodiceProgrammazione int identity(1,1) primary key,
DataOra Datetime not null,
PostiDisponibili int not null check(PostiDisponibili >=0),
CodiceFilm int not null foreign key references Film(CodiceFilm),
CodiceSala int not null constraint FK_SALA_Progr foreign key references Sala(CodiceSala),
constraint UNQ_Programmazione unique(CodiceSala, DataOra)
)
--Alter table Programmazione add constraint UNQ_Programmazione unique(CodiceSala, DataOra)

create table Prenotazione(
CodicePrenotazione int identity(1,1) primary key,
Email varchar(100) not null,
PostiDaPrenotare int not null check(PostiDaPrenotare>0),
CodiceProgrammazione int constraint FK_PRE_PROG foreign key references Programmazione(CodiceProgrammazione)
)

--inserimento dati
--Insert into NomeTabella Values (valori da inserire nell'ordine delle colonne) 
insert into Film values('Harry Potter e la pietra filosofare', 'Fantasy', 140)
insert into Film values('Il re leone', 'Animazione', 145)

insert into Film values('Mamma ho perso l''aereo', 'Commedia', 125),
					   ('Preatty Woman', 'Commedia', 156)

select * from Film
select * from Attore

insert into Attore values ('Julia Roberts', 'Americana', '1967-10-28')
insert into Attore values ('Macaulay Culkin', 'Americano', '1977-11-23')
insert into Attore values ('Richard Gere', 'Americano', '1950-12-25')
insert into Attore values ('Daniel Radcliffe', 'Americano', '1990-08-15')

select * from FilmAttore

insert into FilmAttore values(1,4,284522.23)
insert into FilmAttore values(3,2,20000)
insert into FilmAttore values(4,1,100000)
insert into FilmAttore values(4,3,100000)

insert into Sala values ('Sala rossa', 120), ('Sala verde',80), ('Sala Bianca', 80)
select * from Sala

insert into Programmazione values ('2022-03-16 17:00', 30, 4, 1)
insert into Programmazione values ('2022-03-16 21:00', 50, 3, 2)
insert into Programmazione values ('2022-03-16 17:00', 20, 3, 2)

--insert into Programmazione values ('2022-03-16 17:00', 30, 2, 1)  violato vincolo di unicità (sala, dataOra)
select * from Programmazione

insert into Prenotazione values ('renata@mail.it', 3, 1)
insert into Prenotazione values ('mario@mail.it', 3, 1)
select * from Prenotazione

--esempio di delete con condizione
delete from Prenotazione where CodicePrenotazione=1

--esepio di update con condizione
update Attore SET Nazionalita='USA' where Nazionalita='Americana'

--tutti i campi e tutti i record della tabella film
select * from Film

--solo alcuni campi: solo titolo e durata
select Titolo, durata
from Film

--alias AS per etichettare/rinominare i nomi delle colonne in visualizzazione!
select Titolo as [Titolo del Film], durata as DurataDelFilm
from Film

select * from Film
--select con condizione (where)
--selezionare titolo, genere, durata dei film che durano almeno 130 minuti

select Titolo, Genere, Durata
from Film
where Durata>=130

insert into Film values ('Dott. Potter', 'Commedia', 180),
						('Harry Potter e la camera dei segreti', 'Fantasy', 170)


-- like % --Nota: Attenzione agli spazi!
--Selezionare Titolo e genere dei film su Harry Potter
select Titolo, Genere
from Film
where Titolo like 'Harry Potter %'

--Selezionare Titolo e genere dei film contenti Potter nel titolo
select Titolo, Genere
from Film
where Titolo like '%Potter%'

--Distinct
--seleziono tutti i generi dei film (distinti)
select distinct Genere
from Film

--selezionare tutti i film fantasy con durata inferiore a 150 minuti
select *
from Film
where Genere='Fantasy' and Durata<150

--selezionare tutti i film fantasy o con durata inferiore a 150 minuti

select *
from Film
where Film.Genere='Fantasy' OR Durata<150

select * from Programmazione
--visualizzare i dati dei film per cui esiste una programmazione
select Film.*, Programmazione.DataOra as 'Data e ora di programmazione'
from Film, Programmazione
where Film.CodiceFilm=Programmazione.CodiceFilm

select Film.*, Programmazione.DataOra as 'Data e ora di programmazione'
from Film join Programmazione 
on Film.CodiceFilm=Programmazione.CodiceFilm

select * 
from Programmazione right join Film 
on Film.CodiceFilm=Programmazione.CodiceFilm

select * 
from Film f left join Programmazione as p
on f.CodiceFilm=p.CodiceFilm

--selezionare il titolo dei film per cui è prevista una programmazione nella sala rossa
select f.Titolo
from Film f, Programmazione p, Sala s
where f.CodiceFilm=p.CodiceFilm 
      and s.CodiceSala=p.CodiceSala
	  and s.Nome='Sala Rossa'
	  
select f.Titolo
from Film f join Programmazione p on f.CodiceFilm=p.CodiceFilm
			join Sala s on s.CodiceSala=p.CodiceSala
where s.Nome='Sala Rossa'

--visaulizzare i dati di riepilogo dei film programmati
select f.Titolo 'Titolo Film', f.Genere, f.Durata as 'Durata in minuti', s.Nome as 'Nome Sala',
	   p.PostiDisponibili, p.DataOra 'Data e ora programmazione'
from Film f join Programmazione p on f.CodiceFilm=p.CodiceFilm
			join Sala s on s.CodiceSala=p.CodiceSala

--Order by 
--Mostrare titolo, genere e durata dei film in ordine di durata crescente
select Titolo, Genere, Durata
from Film
order by Durata
--Mostrare titolo, genere e durata dei film in ordine di durata decrescente
select Titolo, Genere, Durata
from Film
order by Durata desc

--Mostrare titolo, genere e durata dei film in ordine di genere crescente e durata decrescente 
select Titolo, Genere, Durata
from Film
order by Genere asc, Durata desc 

--Esercitazione
--1.	Mostrare tutti gli attori del film Harry Potter e la pietra in ordine alfabetico crescente
--2.	Mostrare Nome, nazionalità e cachet percepito dagli attori di “Mamma Ho perso l’aereo” in ordine decrescente per cachet percepito.
--3.	Mostrare tutti gli attori dei film programmati nella sala verde.
--4.	Mostrare quanti posti disponibili ci sono nella programmazione di oggi alle 17:00 del film Mamma ho perso l’aereo.
--5.	Mostrare gli attori (nome e data di nascita) dei soli film proiettati oggi nella sala rossa se i posti disponibili sono maggiori di 30 e se il cachet percepito è superiore a 1000 euro

--1.Mostrare tutti gli attori del film Harry Potter e la pietra filosofare in ordine alfabetico crescente
select *
from Attore a
join FilmAttore fa on a.CodiceAttore=fa.CodiceAttore
join Film f on fa.CodiceFilm=f.CodiceFilm
where f.Titolo='Harry Potter e la pietra filosofare'
order by Nome

--2.Mostrare Nome, nazionalità e cachet percepito dagli attori di “Mamma Ho perso l’aereo” in ordine decrescente per cachet percepito.
select a.Nome, a.Nazionalita, fa.Cachet
from Attore a
join FilmAttore fa on a.CodiceAttore=fa.CodiceAttore
join Film f on fa.CodiceFilm=f.CodiceFilm
where f.Titolo='Mamma ho perso l''aereo'
order by Cachet desc

--3.Mostrare tutti gli attori dei film programmati nella sala verde.
Select *
from sala s join programmazione p on s.CodiceSala=p.CodiceSala
join film f on p.CodiceFilm=f.CodiceFilm
join filmAttore fa on fa.CodiceFilm=f.CodiceFilm
join attore a on fa.CodiceAttore=a.CodiceAttore
where s.Nome='Sala Verde'

--4.Mostrare quanti posti disponibili ci sono nella programmazione di oggi alle 17:00 del film Mamma ho perso l’aereo.
select PostiDisponibili
from Programmazione p join film f on p.CodiceFilm=f.CodiceFilm
where f.titolo='Mamma ho perso l''aereo' --And p.DataOra='2022-03-16 17:00'
and DAY(p.dataOra) =DAY(sysdatetime())
--and datepart(DAYOFYEAR,p.DataOra)=datepart(DAYOFYEAR, SYSDATETIME())
and DATEPART(HOUR, p.DataOra)=17
and DATEPART(MINUTE, p.DataOra)=0

--5.Mostrare gli attori (nome e data di nascita) dei soli film proiettati oggi nella sala rossa se i posti disponibili sono maggiori di 30 e se il cachet percepito è superiore a 1000 euro
select a.Nome as [Nome Attore], DataNascita as [Data di nascita]
from Attore a   join FilmAttore fa on a.CodiceAttore=fa.CodiceAttore
				join Film f on f.CodiceFilm=fa.CodiceFilm
				join Programmazione p on p.CodiceFilm=f.CodiceFilm
				join Sala s on p.CodiceSala=s.CodiceSala
where s.Nome ='Sala Rossa' And p.PostiDisponibili>30 and cachet>1000 
and datepart(DAYOFYEAR,p.DataOra)=datepart(DAYOFYEAR, SYSDATETIME())
--and p.DataOra between '2022-03-16 00:00' and '2022-03-16 23:59'

--between
--selezionare tutte le programmazioni del mese di giugno
select *
from Programmazione p
where p.DataOra>='2022-06-01' and p.DataOra <= '2022-06-30'

select *
from Programmazione p
where p.DataOra between '2022-06-01' and '2022-06-30'

--IN
--selezionare tutti i film di genere fantasy o drammatici
select * 
from Film
where Genere='Fantasy' or Genere='Drammatico'

select * 
from Film
where Genere in ('Fantasy','Drammatico')




