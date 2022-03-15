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

