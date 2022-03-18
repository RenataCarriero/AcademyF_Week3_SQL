create database RicetteNonna;

create table Libro(
IdLibro int Identity(1,1) not null,
Titolo nvarchar(50) not null,
Tipologia nvarchar (30) not null,
constraint PK_Libro primary key (idLibro),
constraint Chk_Tipologia check (Tipologia='Primi' OR Tipologia='Secondi' OR Tipologia='Dolci')
);

create table Ricetta(
IdRicetta int identity(1,1) not null constraint PK_IdRicetta primary key,
Nome nvarchar(50) not null,
TempoPreparazione int not null,
NumeroPersone int not null,
Preparazione nvarchar(100),
IdLibro int Constraint FK_IdLibro foreign key references Libro(IdLibro)
);

create table Ingrediente(
IdIngrediente int identity(1,1) not null constraint PK_IdIngrediente primary key,
Nome nvarchar(50) not null,
Descrizione nvarchar(50) not null,
UnitaDiMisura nvarchar(10)
);

create table RicettaIngrediente(
IdRicetta int not null Constraint FK_IdRicetta foreign key references Ricetta(IdRicetta),
IdIngrediente int not null Constraint FK_IdIngrediente foreign key references Ingrediente(IdIngrediente),
Quantita int constraint check_qnt_positiva check (Quantita>=0)
constraint UNQ_RICETTA_INGREDIENTE unique (idRicetta, IdIngrediente)
)

insert into Ingrediente values ('Uova', 'Uova medie allevate a terra', null)
insert into Ingrediente values ('Carne', 'carne macinata', null)
insert into Ingrediente values ('Pesce Spada', 'pesce spada oceano atlantico', 'kg')
insert into Ingrediente values ('Latte', 'Latte intero fresco', 'litri')
insert into Ingrediente values ('Zucchero', 'zucchero semolato', 'grammi')
insert into Ingrediente values ('Zucchero a velo', 'zucchero a velo vanigliato', 'grammi')
insert into Ingrediente values ('Pomodori', 'Pomodori datterini', 'kg')
insert into Ingrediente values ('Pomodori', 'Pomodorini gialli', 'kg')
insert into Ingrediente values ('Olive', 'Olive nere greche', 'grammi')


insert into Libro values ('I dolci della nonna','Dolci')
insert into Libro values ('I secondi della nonna','Secondi')
select * from Libro;

insert into Ricetta values ('Torta', 120, 10,'Sbattere le uova..', 1)
insert into Ricetta values ('Torta Paradiso', 130, 8, 'Preparare zucchero a velo..',1)
insert into Ricetta values ('Polpette fritte', 30, 4, 'Condire carne',2)
select * from Ricetta;


insert into RicettaIngrediente values (1,1,4)
insert into RicettaIngrediente values (1,4,1)
insert into RicettaIngrediente values (2,1,10)
insert into RicettaIngrediente values (3,2,1)



select * from Ingrediente;
select * from Ricetta;
select * from RicettaIngrediente;
select * from Libro;



--Esercitazione Ricette Nonna
--1.Visualizzare tutta la lista degli ingredienti distinti.
--2.Visualizzare tutta la lista degli ingredienti distinti utilizzati in almeno una ricetta.
--3.Estrarre tutte le ricette che contengono l’ingrediente uova.
--4.Mostrare il titolo delle ricette che contengono almeno 4 uova
--5.Estrarre tutte le ricette dei libri di Tipologia=Secondi per 4 persone contenenti l’ingrediente carne
--6.Mostrare tutte le ricette che hanno un tempo di preparazione inferiore a 10 minuti.
--7.Mostrare il titolo del libro che contiene più ricette
--8.Visualizzare i Titoli dei libri ordinati rispetto al numero di ricette che contengono (il libro che contiene più ricette deve essere visualizzato per primo, quello con meno ricette per ultimo) e, 
--  a parità di numero ricette in ordine alfabetico su Titolo del libro.


--1.Visualizzare tutta la lista degli ingredienti distinti.
select distinct Nome
from Ingrediente

--2.Visualizzare tutta la lista degli ingredienti distinti utilizzati in almeno una ricetta.
select  distinct i.IdIngrediente, i.Nome,i.Descrizione
from Ingrediente i join RicettaIngrediente ri on i.IdIngrediente=ri.IdIngrediente

--3.Estrarre tutte le ricette che contengono l’ingrediente uova.
select r.Nome
from Ricetta r join RicettaIngrediente ri on r.IdRicetta=ri.IdRicetta
	join Ingrediente i on i.IdIngrediente=ri.IdIngrediente
where i.Nome='Uova'

--4.Mostrare il titolo delle ricette che contengono almeno 4 uova
select r.Nome
from Ricetta r join RicettaIngrediente ri on r.IdRicetta=ri.IdRicetta
	join Ingrediente i on i.IdIngrediente=ri.IdIngrediente
where i.Nome='Uova' and ri.Quantita>=4

--5.Estrarre tutte le ricette dei libri di Tipologia=Secondi per 4 persone contenenti l’ingrediente carne
select r.Nome
from Ricetta r join RicettaIngrediente ri on r.IdRicetta=ri.IdRicetta
	 join Ingrediente i on i.IdIngrediente=ri.IdIngrediente
	 join Libro l on l.IdLibro=r.IdLibro
where l.Tipologia='Secondi' 
and i.Nome='Carne'
and r.NumeroPersone=4

--6.Mostrare tutte le ricette che hanno un tempo di preparazione inferiore a 10 minuti.
select Nome
from Ricetta
where TempoPreparazione<10


--8.Visualizzare i Titoli dei libri ordinati rispetto al numero di ricette che contengono (il libro che contiene più ricette deve essere visualizzato per primo, quello con meno ricette per ultimo) e, 
--a parità di numero ricette in ordine alfabetico su Titolo del libro.
select l.Titolo, count(r.IdRicetta) as [Numero ricette libro] 
from Ricetta as r join Libro l on l.IdLibro=r.IdLibro
group by r.IdLibro, l.Titolo
order by [Numero ricette libro] desc, l.Titolo
--oppure
select*
from (select l.Titolo as Tit, count (r.IDRicetta) as 'NumeroRicette'
	  from Libro l join Ricetta r on r.IDLibro=l.IDLibro
	  group by l.Titolo) as Tabella_Libro_NumeroRicette
order by NumeroRicette desc, Tit


--7.Mostrare il titolo del libro che contiene più ricette
select Tit

from (select l.Titolo as Tit, count (r.IDRicetta) as 'NumeroRicette'
	  from Libro l join Ricetta r on r.IDLibro=l.IDLibro
      group by l.Titolo) as Tabella_Libro_NumeroRicette

where NumeroRicette = (select max(NumeroRicette) 
					   from (select l.Titolo as Tit, count (r.IDRicetta) as 'NumeroRicette'
							 from Libro l join Ricetta r on r.IDLibro=l.IDLibro
							 group by l.Titolo) as Tabella_Libro_NumeroRicette)


--nuova vista 
create view Tabella_Libro_NumeroRicette
as (select l.Titolo as Tit, count (r.IDRicetta) as 'NumeroRicette'
from Libro l join Ricetta r on r.IDLibro=l.IDLibro
group by l.Titolo)
 
select Tit
from Tabella_Libro_NumeroRicette
where NumeroRicette = (select max(NumeroRicette) 
					   from Tabella_Libro_NumeroRicette)
