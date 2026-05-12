-- Un Trigger è un blocco di codice associato a un oggetto db che viene eseguito automaticamente quando si verifica un evento specifico
-- Trigger DELETE, UPDATE, INSERT (DML). 
-- Trigger (DDL: CREATE TABLE, ALTER PROCEDURE, DROP VIEW, LIVELLO DI DB, LIVELLO DI SERVER)
-- EVENTI LOG ON (ACCESSO)
-- Per i Trigger DML associati a tabelle ci sono due tipi: TRIGGER AFTER, TRIGGER INSTEAD OF

-- Trigger AFTER INSERT
-- Creo la tabella LOG
/*CREATE TABLE dbo.LogOrdini (
	LogID INT IDENTITY (1, 1) PRIMARY KEY,
	IDOrdine INT,
	DataOrdine DATE,
	IDCliente INT,
	UtenteOperazione VARCHAR(100),
	DataOraEvento DATETIME DEFAULT GETDATE()
);
GO*/

-- Creo il Trigger
/*CREATE TRIGGER tr_Ordini_AfterInsert
ON dbo.Ordini
AFTER INSERT
AS
BEGIN
	INSERT INTO dbo.LogOrdini (IDOrdine, DataOrdine, IDCliente, UtenteOperazione)
	SELECT
		i.IDOrdine,
		i.DataOrdine,
		i.IDCliente,
		SUSER_NAME() -- Restituisce l'utente
	FROM
		inserted AS i; -- è disponibile solo all'interno di un trigger insert o update e contiene una copia esatta delle righe che sono state inserite
END;
GO*/

-- verifica
/*INSERT INTO dbo.Ordini (IDCliente, DataOrdine)
VALUES (1, '2026-05-11');*/

/*SELECT * FROM dbo.LogOrdini;*/

-- Per ogni singolo INSERT si crea un singolo Trigger.


-- Come gestire UPDATE e DELETE
/*CREATE TABLE dbo.LogProdotti (
	LogID INT IDENTITY(1, 1) PRIMARY KEY,
	IDProdotto INT,
	NomeProdotto VARCHAR(100),
	PrezzoVecchio DECIMAL (10, 2),
	PrezzoNuovo DECIMAL (10, 2),
	UtenteOperazione VARCHAR(100),
	DataOraEvento DATETIME DEFAULT GETDATE(),
	TipoOperazione VARCHAR(10)
);
GO*/

/*CREATE TRIGGER tr_Prodotiti_AfterUpdate
ON dbo.Prodotti
AFTER UPDATE
AS
BEGIN
	INSERT INTO dbo.LogProdotti (
		IDProdotto,
		NomeProdotto,
		PrezzoVecchio,
		PrezzoNuovo,
		UtenteOperazione,
		TipoOperazione
	)
	SELECT
		i.IDProdotto,
		i.NomeProdotto,
		d.PrezzoUnitario, -- lo prendo dalla tabella deleted essendo questo il PREZZO VECCHIO
		i.PrezzoUnitario, -- PREZZO NUOVO
		SUSER_SNAME(),
		'UPDATE'
	FROM
		inserted AS i
	JOIN
		deleted AS d ON i.IDProdotto = d.IDProdotto
	WHERE
		i.PrezzoUnitario <> d.PrezzoUnitario;
END;
GO*/

-- Faccio scattare il log
/*UPDATE dbo.Prodotti
SET PrezzoUnitario = 950.00
WHERE IDProdotto = 101;*/


-- Aggiungo una colonna alla tabella LogOrdini
/*ALTER TABLE dbo.LogOrdini
ADD TipoOperazione VARCHAR(10);
GO*/


-- Trigger AFTER DELETE
/*CREATE TRIGGER tr_Ordini_AfterDelete
ON dbo.Ordini
AFTER DELETE
AS
BEGIN
	INSERT INTO dbo.LogOrdini (
		IDOrdine,
		DataOrdine,
		IDCliente,
		UtenteOperazione,
		TipoOperazione
	)
	SELECT
		d.IDOrdine,
		d.DataOrdine,
		d.IDCliente,
		SUSER_NAME(),
		'DELETE'
	FROM
		deleted AS d;
END;
GO*/

/*DELETE FROM dbo.Ordini WHERE IDOrdine = 1007;*/

/*SELECT * FROM dbo.LogOrdini WHERE TipoOperazione = 'DELETE';*/


-- Instead of (si attiva al posto dell'azione che lo fa scattare)
/*CREATE TRIGGER tr_vw_ProdottiConCategoria_InsteadOfInsert
ON dbo.vw_ProdottiConCategoria
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM inserted AS i
				LEFT JOIN dbo.Categorie AS C ON i.NomeCategoria = C.NomeCategoria
				WHERE C.IDCategoria IS NULL)
	BEGIN
		RAISERROR('Una o più categorie specificate non esistono. Operazione annullata.', 16, 1)
		RETURN;
	END

	INSERT INTO dbo.Prodotti (NomeProdotto, PrezzoUnitario, IDCategoria)
	SELECT
		i.NomeProdotto,
		i.PrezzoUnitario,
		(SELECT C.IDCategoria FROM dbo.Categorie AS C WHERE C.NomeCategoria = i.NomeCategoria)
	FROM
		inserted AS i;
END;
GO*/

/*INSERT INTO dbo.vw_ProdottiConCategoria (NomeProdotto, PrezzoUnitario, NomeCategoria)
VALUES ('Tablet Pro', 750.00, 'Elettronica');*/

-- Qui scatta l'errore poiché la categoria non esiste
/*INSERT INTO dbo.vw_ProdottiConCategoria (NomeProdotto, PrezzoUnitario, NomeCategoria)
VALUES ('Drone amatoriale', 499.00, 'Giocattoli volanti');*/