/*CREATE TABLE dbo.LogAttivita (
	LogID INT IDENTITY PRIMARY KEY,
	NomeTabella VARCHAR(100),
	TipoOperazione VARCHAR(10), -- es. 'INSERT', 'UPDATE', 'DELETE'
	Descrizione VARCHAR(500),
	DataOraEvento DATETIME DEFAULT GETDATE()
);
GO*/

/*CREATE TRIGGER tr_Clienti_AfterInsert
ON dbo.Clienti
AFTER INSERT
AS
BEGIN
	INSERT INTO dbo.LogAttivita (NomeTabella, TipoOperazione, Descrizione)
	SELECT
		'CLIENTI',
		'INSERT',
		'Nuovo cliente inserito con ID: ' + CAST(i.IDCliente AS VARCHAR(10))
	FROM
		inserted AS i;
END;
GO*/

/*INSERT INTO dbo.Clienti (Nome, Cognome, EMAIL)
VALUES ('Andrea', 'Rossi', 'andrea.rossi@email.it');*/

/*SELECT * FROM dbo.LogAttivita WHERE NomeTabella = 'CLIENTI';*/

/*CREATE TRIGGER tr_Prodotti_ControlloPrezzo
ON dbo.Prodotti
AFTER UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted i
		JOIN deleted AS d ON i.IDProdotto = d.IDProdotto
		WHERE i.PrezzoUnitario > (d.PrezzoUnitario * 1.50)
	)

	-- Gli errori 16 sono di importanza media e possono essere corretti dall'utente
	-- L'1 indica un intero tra 0 e 255 usato per identificare il punto in cui si è verificato l'errore
	BEGIN
		RAISERROR('Errore: Aumento di prezzo superiore al 50%% non consentito.', 16, 1) 
		RETURN;
	END;
END;*/

/*UPDATE dbo.Prodotti
SET PrezzoUnitario = PrezzoUnitario * 1.10
WHERE IDProdotto = 101;

UPDATE dbo.Prodotti
SET PrezzoUnitario = PrezzoUnitario * 1.60
WHERE IDProdotto = 103;*/

/*CREATE TRIGGER tr_DettagliOrdine_AfterDelete
ON dbo.DettagliOrdine
AFTER DELETE
AS
BEGIN
	INSERT INTO dbo.LogAttivita (NomeTabella, TipoOperazione, Descrizione)
	SELECT
		'DettagliOrdine',
		'DELETE',
		'Rimosso prodotto ID ' + CAST(d.IDProdotto AS VARCHAR(10)) + 
		' dall''ordine ID ' + CAST(d.IDOrdine AS VARCHAR(10)) + 
		' (Quantità: ' + CAST(d.Quantita AS VARCHAR(10)) + ')'
	FROM
		deleted AS d;
END;
GO*/

/*DELETE dbo.DettagliOrdine
WHERE IDDttagliOrdine = 24;*/

/*SELECT * FROM dbo.LogAttivita
WHERE TipoOperazione = 'DELETE';*/

/*ALTER TABLE dbo.Ordini
ADD Stato VARCHAR(20) NULL;*/

/*CREATE VIEW vw_OrdiniRecenti
AS
SELECT
	IDOrdine,
	IDCliente,
	DataOrdine,
	Stato
FROM
	dbo.Ordini 
WHERE
	DataOrdine >= DATEADD(day, -30, GETDATE()) -- SOTTRAE 30 GIORNI DALLA DATA ODIERNA
GO*/

/*CREATE TRIGGER tr_vw_OrdiniRecenti_InsteadOfDelete
ON dbo.vw_OrdiniRecenti
INSTEAD OF DELETE
AS
BEGIN
	UPDATE o
	SET o.Stato = 'Annullato'
	FROM dbo.Ordini AS o
	JOIN deleted AS d ON o.IDOrdine = d.IDOrdine;
END;
GO*/

/*INSERT INTO dbo.Ordini(IDCliente, DataOrdine, Stato)
VALUES (1, GETDATE(), 'Attivo')*/

/*DELETE dbo.vw_OrdiniRecenti
WHERE IDCliente = 1;*/

SELECT * FROM dbo.Ordini
WHERE Stato = 'Annullato';