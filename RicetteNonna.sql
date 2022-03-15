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