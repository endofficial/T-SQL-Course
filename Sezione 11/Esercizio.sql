-- Crea una funzione scalare che deve accettare un prezzo e restituire il prezzo ivato al 22%
/*CREATE FUNCTION dbo.fn_CalcolaPrezzoIvato
	(@Prezzo DECIMAL (10, 2))
RETURNS DECIMAL (10, 2)
AS
BEGIN
	DECLARE @Iva DECIMAL (10, 2)
	SET @Iva = @Prezzo * 1.22;

RETURN @Iva;
END;
GO*/

/*SELECT
	NomeProdotto,
	PrezzoUnitario,
	dbo.fn_CalcolaPrezzoIvato(PrezzoUnitario) AS IVASulPrezzo,
	PrezzoUnitario + dbo.fn_CalcolaPrezzoIvato(PrezzoUnitario) AS PrezzoConIVA
FROM
	dbo.Prodotti
GO*/

-- Crea una funzione che deve accettare un @ClienteID come parametro e restituire tutti i dettagli degli ordini (IDOrdine, DataOrdine) per quel cliente.
/*CREATE FUNCTION dbo.fn_TrovaOrdiniPerCliente
	(@ClienteID INT)
RETURNS TABLE
AS
RETURN
(SELECT
	IDOrdine,
	DataOrdine
FROM
	dbo.Ordini
WHERE
	IDCliente = @ClienteID
);
GO*/

/*SELECT
	IDOrdine,
	DataOrdine
FROM
	dbo.fn_TrovaOrdiniPerCliente(2) AS TotOrdiniCliente;
GO*/

-- Creare una stored procedure con parametri di input
/*CREATE PROC dbo.usp_AggiungiProdottoAlCarrello
	@IDOrdine INT, @IDProdotto INT, @Quantita INT
AS
BEGIN
	DECLARE @PrezzoAttuale DECIMAL (10, 2) 

	SELECT @PrezzoAttuale = PrezzoUnitario
	FROM dbo.Prodotti
	WHERE IDProdotto = @IDProdotto;

	INSERT INTO dbo.DettagliOrdine(IDOrdine, IDProdotto, Quantita, PrezzoUnitarioAcquisto)
	VALUES (@IDOrdine, @IDProdotto, @Quantita, @PrezzoAttuale);
END;
GO*/

/*EXEC dbo.usp_AggiungiProdottoAlCarrello @IDOrdine=1001, @IDProdotto=102, @Quantita=2;*/

/*SELECT * FROM dbo.DettagliOrdine WHERE IDOrdine=1001 AND IDProdotto=102;
GO*/