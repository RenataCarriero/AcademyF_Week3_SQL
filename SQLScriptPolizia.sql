/*Polizia
Creare il database "POLIZIA" per gestire l'associazione tra agenti di polizia e le aree metropolitane che devono pattugliare
(può essere che un agente venga assegnato a più aree e viceversa)
Le entità coinvolte in questo esercizio sono:
AGENTE DI POLIZIA:
- nome (stringa obbligatoria di massimo 30 caratteri)
- cognome (stringa obbligatoria di massimo 50 caratteri)
- codice fiscale (stringa di 16 caratteri obbligatoria)
- data di nascita (data obbligatoria. L'agente deve essere maggiorenne)
- anni di servizio (valore numerico valorizzato con gli effettivi anni di servizio)

AREA METROPOLITANA
- codice area (stringa alfabetica di 5 caratteri che identifica l'area (non è l'id))
- alto rischio (valore che può assumere "0" o "1" a seconda se l'area è considerata ad alto rischio)
individuare la soluzione più adatta a livello di tabelle e creare tutte le relazioni necessarie.
IMPLEMENTARE I SEGUENTI VINCOLI:
-gli id devono essere autoincrementali
-l'agente di polizia deve essere maggiorenne
-il codice fiscale non può essere duplicato  
*/

create database Polizia;

create table Agente(
AgenteId int IDENTITY(1,1) not null constraint Pk_Attore primary key,
Nome nvarchar(30) not null,
Cognome nvarchar(50) not null,
CodiceFiscale nchar(16) not null unique,
DataNascita date not null constraint chk_maggiorenne check (year(getdate())-Year(DataNascita)>=18),
AnniServizio int not null
);

create table AreaMetropolitana (
AreaId int IDENTITY(1,1) not null constraint PK_Area primary key,
CodiceArea nchar(5) not null unique,
AltoRischio bit not null
);


CREATE TABLE AgenteArea(
	AgenteId INT NOT NULL,
	AreaId INT NOT NULL,
	CONSTRAINT FK_Area FOREIGN KEY (AreaId) REFERENCES AreaMetropolitana(AreaId),
	CONSTRAINT FK_Agente FOREIGN KEY (AgenteId) REFERENCES Agente(AgenteId), 
	CONSTRAINT PK_AgenteArea PRIMARY KEY(AreaId, AgenteId)
)

--inserimento dati di test tabella Agente
insert into Agente values ('Mario', 'Rossi', 'MARIOROSSI123456', '1987-01-01', 4);
insert into Agente values ('Giuseppe', 'Verdi', 'GIUSEVERDI123456', '1967-10-01', 2);
insert into Agente values ('Luigi', 'Bianchi', 'LUIGIBIANC123456', '1976-12-01', 1);
insert into Agente values ('Mario', 'Neri', 'MARIONERI0123456', '1988-12-23', 5);
select * from Agente;
--verifica check maggiorenne----------------------------------------------------
insert into Agente values ('Caio', 'Blu', 'CAIOBLU000123456', '2020-08-25', 0);
--------------------------------------------------------------------------------
--verifica vincolo unique su Cofice Fiscale-------------------------------------
insert into Agente values ('Caio', 'Blu', 'MARIOROSSI123456', '1987-01-01', 10);
--------------------------------------------------------------------------------

--inserimento dati di test tabella AreaMetropolitana
insert into AreaMetropolitana values ('Area1', 1);
insert into AreaMetropolitana values ('Area2', 0);
select * from AreaMetropolitana;

--inserimento dati di test tabella di Associazione Agente - AreaMetropolitana
insert into AgenteArea values (1,1);
insert into AgenteArea values (1,2);
insert into AgenteArea values (3,1);
insert into AgenteArea values (4,2);
insert into AgenteArea values (4,1);
select * from AgenteArea;



--1. visualizzare l'elenco degli agenti che lavorano in "aree ad alto rischio" e hanno meno di 3 anni di servizio
select *
from Agente a join AgenteArea aa on a.AgenteId=aa.AgenteId
			  join AreaMetropolitana am on am.AreaId=aa.AreaId
where am.AltoRischio=1 and a.AnniServizio<3;

--2. visualizzare il numero di agenti assegnati per ogni area geografica (numero agenti e codice area)

select count(a.agenteId) as [Numero Agenti], am.CodiceArea as [Codice Area]
from Agente a join AgenteArea aa on a.AgenteId=aa.AgenteId
			  join AreaMetropolitana am on am.AreaId=aa.AreaId
group by am.CodiceArea;

--oppure

select count(aa.agenteId) as [Numero Agenti], am.CodiceArea as [Codice Area]
from AgenteArea aa join AreaMetropolitana am on am.AreaId=aa.AreaId
group by am.CodiceArea;

