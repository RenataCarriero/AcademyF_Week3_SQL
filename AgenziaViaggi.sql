CREATE database AgenziaViaggi;


CREATE TABLE Partecipante (
	PartecipanteID INTEGER IDENTITY(1,1) NOT NULL,
	Nome NVARCHAR(30) NOT NULL,
	Cognome NVARCHAR(30) NOT NULL,
	DataNascita DATE NOT NULL,
	Città NVARCHAR(30) NOT NULL,
	Indirizzo NVARCHAR(30) NOT NULL,
	CONSTRAINT PK_Partecipante PRIMARY KEY(PartecipanteID),
);

CREATE TABLE Responsabile (
	ResponsabileID INTEGER IDENTITY(1,1) NOT NULL,
	Nome NVARCHAR(30) NOT NULL,
	Cognome NVARCHAR(30) NOT NULL,
	NumeroTelefono NVARCHAR(10) NOT NULL,
	CONSTRAINT PK_Responsabile PRIMARY KEY(ResponsabileID)
);

CREATE TABLE Itinerario (
	ItinerarioID INTEGER IDENTITY(1,1) NOT NULL,
	Descrizione NVARCHAR(50) NOT NULL,
	Durata INT NOT NULL, -- durata in giorni
	Prezzo Decimal (10,2) NOT NULL,
	CONSTRAINT PK_Itinerario PRIMARY KEY(ItinerarioID)
);
CREATE TABLE Gita (
	GitaID INTEGER IDENTITY(1,1) NOT NULL,
	DataPartenza DATE NOT NULL,
	ResponsabileID INTEGER NOT NULL,
	ItinerarioID INTEGER NOT NULL,
	CONSTRAINT PK_Gita PRIMARY KEY(GitaID),
	CONSTRAINT FK_Responsabile FOREIGN KEY(ResponsabileID) REFERENCES Responsabile(ResponsabileID),
	CONSTRAINT FK_Itinerario FOREIGN KEY(ItinerarioID) REFERENCES Itinerario(ItinerarioID)
);

CREATE TABLE Tappa (
	TappaID INTEGER IDENTITY(1,1)NOT NULL,
	Città NVARCHAR(20) NOT NULL,
    CONSTRAINT Pk_Tappa PRIMARY KEY(TappaID)
);


CREATE TABLE ItinerarioTappa (
	ItinerarioID INTEGER NOT NULL,
	TappaID INTEGER NOT NULL,
	GiorniPermanenza INTEGER NOT NULL,
    CONSTRAINT FK_TappaItinerario FOREIGN KEY(ItinerarioID)  REFERENCES Itinerario(ItinerarioID),
	CONSTRAINT FK_Tappa FOREIGN KEY(TappaID)  REFERENCES Tappa(TappaID),
	CONSTRAINT PK_ItinerarioTappa PRIMARY KEY(TappaID, ItinerarioID)
);



CREATE TABLE PartecipanteGita (
	PartecipanteID INTEGER NOT NULL,
	GitaID INTEGER NOT NULL,
	CONSTRAINT FK_PartecGita FOREIGN KEY(PartecipanteID)  REFERENCES Partecipante(PartecipanteID),
	CONSTRAINT FK_PartecGita2 FOREIGN KEY(GitaID)  REFERENCES Gita(GitaID),
	CONSTRAINT PK_PartecipanteGita PRIMARY KEY(GitaID, PartecipanteID)
);
