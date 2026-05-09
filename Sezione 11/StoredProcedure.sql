-- una convezione per una procedure è dare il nome che inizia con usp_
/*CREATE PROC dbo.usp_MostraTuttiClienti
AS
BEGIN
	SELECT
		IDCliente,
		Nome,
		Cognome,
		EMAIL
	FROM
		dbo.Clienti;
END;
GO*/

-- Per eseguire (statica)
/*EXECUTE dbo.usp_MostraTuttiClienti;*/

-- Se volessi creare una storedProcedure che mi trovi un cliente tramite l'id
/*CREATE PROC dbo.usp_TrovaClientiPerID
	@ClienteID INT
AS
BEGIN
	SELECT
		IDCliente,
		Nome,
		Cognome,
		EMAIL
	FROM
		dbo.Clienti
	WHERE
		IDCliente = @ClienteID;
END;
GO*/

/*EXECUTE dbo.usp_TrovaClientiPerID 1;*/

/*EXECUTE dbo.usp_TrovaClientiPerID @ClienteID = 2;*/

-- Creo una StoredProcedure per cercare i prodotti per prezzo
/*CREATE PROC dbo.usp_CercaProdottiPerPrezzo
	@PrezzoMin DECIMAL(10, 2),
	@PrezzoMax DECIMAL(10, 2)
AS 
BEGIN
	SELECT
		NomeProdotto,
		PrezzoUnitario,
		IDCategoria
	FROM
		dbo.Prodotti
	WHERE
		PrezzoUnitario BETWEEN @PrezzoMin AND @PrezzoMax;
END;
GO*/

/*EXEC dbo.usp_CercaProdottiPerPrezzo @PrezzoMin = 50, @PrezzoMax = 700;*/


-- STORED PROCEDURE CON LOGICA DI OUTPUT
-- Per dichiarare una variabile si usa DECLARE @Variabile
/*DECLARE  @Messaggio VARCHAR(50);
SET @Messaggio = 'Benvenuti nella programmazione T-SQL!';
PRINT @Messaggio;

DECLARE @ConteggioClienti INT;
SELECT @ConteggioClienti = COUNT(*) FROM dbo.Clienti;*/

-- CAST per unire tipi di dati diversi. La variabile sottostante viene trasformata in tipo testo
/*PRINT 'Numero totale di clienti: ' + CAST(@ConteggioClienti AS VARCHAR(10));
GO*/

/*CREATE PROC dbo.usp_VerificaEsistenzaCliente
	@ClienteID INT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.Clienti WHERE IDCliente = @ClienteID)
	BEGIN
		PRINT 'Cliente con ID ' + CAST(@ClienteID AS VARCHAR(10)) + 'Trovato.';
	END
	ELSE
	BEGIN
		PRINT 'Cliente con ID ' + CAST(@ClienteID AS VARCHAR(10)) + 'Non trovato.';
	END;
END;
GO*/

/*EXEC dbo.usp_VerificaEsistenzaCliente @ClienteID = 1;*/

-- Per modificare il print della procedure
/*ALTER PROC dbo.usp_VerificaEsistenzaCliente
    @ClienteID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM dbo.Clienti WHERE IDCliente = @ClienteID)
    BEGIN
        -- Messaggio modificato
        PRINT 'Esito: Il cliente con ID ' + CAST(@ClienteID AS VARCHAR(10)) + ' è presente in anagrafica.';
    END
    ELSE
    BEGIN
        -- Messaggio modificato
        PRINT 'Attenzione: Nessun cliente trovato con ID ' + CAST(@ClienteID AS VARCHAR(10)) + '.';
    END;
END;
GO*/

/*CREATE PROC dbo.usp_TrovaNomeProdotto
	@ProdottoID INT,
	@NomeProdottoRestituito VARCHAR(100) OUTPUT
AS
BEGIN
	SELECT @NomeProdottoRestituito = NomeProdotto
	FROM dbo.Prodotti
	WHERE IDProdotto = @ProdottoID;
END;
GO*/

/*DECLARE @NomeDelProdotto VARCHAR(100);

EXEC dbo.usp_TrovaNomeProdotto
	@ProdottoID = 102,
	@NomeProdottoRestituito = @NomeDelProdotto OUTPUT;
PRINT 'Nome del prodotto recuperato: ' + ISNULL(@NomeDelProdotto, 'NON TROVATO');
GO*/

-- Utilizzo il BEGIN TRY-CATCH in cui il codice al suo interno potrebbe fallire
/*CREATE PROC dbo.usp_InserisciNuovoCliente
	@Nome VARCHAR(50),
	@Cognome VARCHAR(50),
	@Email VARCHAR(100)
AS
BEGIN
	BEGIN TRY
		INSERT INTO dbo.Clienti (Nome, Cognome, EMAIL)
		VALUES (@Nome, @Cognome, @Email);
		PRINT 'Cliente inserito con successo!';
	END TRY
	BEGIN CATCH
		PRINT 'ERRORE: Impossibile inserire il cliente.';
		PRINT 'Messaggio di sistema: ' + ERROR_MESSAGE();
	END CATCH;
END;
GO*/

/*EXEC dbo.usp_InserisciNuovoCliente
	@Nome = 'NULL',
	@Cognome = 'Rossi',
	@Email = 'giulia.rossi@email.it';*/

-- Cercare prodotti in una categoria specifica ma se essa non viene specificata, cerca tutte
/*CREATE PROC dbo.usp_CercaProdottiPerCategoria
	@IDCategoria INT = NULL
AS
BEGIN
	IF @IDCategoria IS NULL
	BEGIN
		PRINT 'Ricerca di tutti i prodotti...';
		SELECT * FROM dbo.Prodotti;
	END
	ELSE
	BEGIN
		PRINT 'Ricerca prodotti per categoria ID: ' + CAST(@IDCategoria AS VARCHAR(10));
		SELECT * FROM dbo.Prodotti WHERE IDCategoria = @IDCategoria;
	END;
END;
GO*/

/*EXEC dbo.usp_CercaProdottiPerCategoria @IDCategoria = 1;*/


-- FUNZIONI SCALARI (RITORNANO UN SOLO VALORE)
-- Solo per calcoli e recupero dati
/*CREATE FUNCTION dbo.fn_CalcoloSconto
	(@Prezzo DECIMAL (10, 2))
RETURNS DECIMAL (10, 2)
AS 
BEGIN
	-- Logica della funzione
	DECLARE @Sconto DECIMAL (10, 2);
	IF @Prezzo > 100
	BEGIN
		SET @Sconto = @Prezzo * 0.10;
	END

	RETURN @Sconto;
END;
GO*/

-- Si usa direttamente nella query
/*SELECT
	NomeProdotto,
	PrezzoUnitario,
	dbo.fn_CalcoloSconto(PrezzoUnitario) AS ScontoPotenziale,
	PrezzoUnitario - dbo.fn_CalcoloSconto(PrezzoUnitario) AS PrezzoScontato
FROM	
	dbo.Prodotti;
GO*/

-- Altro esempio
/*CREATE FUNCTION dbo.fn_NomeCompleto
	(@Nome VARCHAR(50),
	@Cognome VARCHAR(50))
RETURNS VARCHAR(101)
AS
BEGIN
	RETURN @Nome + ' ' + @Cognome;
END;
GO*/

-- Applico
/*SELECT
	IDCliente,
	dbo.fn_NomeCompleto(Nome, Cognome) AS NomeCompleto,
	EMAIL
FROM
	dbo.Clienti;
GO*/


-- Funzioni con valori di tabella
-- INLINE
/*CREATE FUNCTION dbo.fn_CercaProdottiPerNome
	(@TestoRicerca VARCHAR(50))
RETURNS TABLE
AS 
RETURN
(SELECT
	IDProdotto,
	NomeProdotto,
	PrezzoUnitario,
	IDCategoria
 FROM 
	dbo.Prodotti
WHERE
	NomeProdotto LIKE '%' + @TestoRicerca + '%'
);
GO*/

-- Lo utilizzo nella clausola FROM
/*SELECT
	IDProdotto,
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.fn_CercaProdottiPerNome('Smartphone X100') AS ProdottiFiltrati
WHERE
	PrezzoUnitario > 800
GO*/


-- Funzioni di tabella con più istruzioni
/*CREATE FUNCTION dbo.fn_RiepilogoOrdiniCliente
	(@ClienteID INT)
RETURNS @Riepilogo TABLE
(
	RigaRiepilogo VARCHAR(255)
)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.Clienti WHERE IDCliente = @ClienteID)
	BEGIN
		INSERT INTO @Riepilogo (RigaRiepilogo) VALUES ('Cliente non trovato');
	RETURN;
	END;

	DECLARE @NomeCliente VARCHAR(101);
	SELECT @NomeCliente = Nome + ' ' + Cognome FROM dbo.Clienti WHERE IDCliente = @ClienteID
	INSERT INTO @Riepilogo (RigaRiepilogo) VALUES ('Riepilogo per i clienti: ' + @NomeCliente);
	INSERT INTO @Riepilogo (RigaRiepilogo) VALUES ('---------------------------------------');
	INSERT INTO @Riepilogo (RigaRiepilogo) 
	SELECT
		'Ordine #' + CAST(O.IDOrdine AS VARCHAR(10)) + 
		' del ' + CONVERT(VARCHAR(10), o.DataOrdine, 103) -- 103 indica di formattare la data con lo standard europeo
	FROM
		dbo.Ordini AS o
	WHERE
		o.IDCliente = @ClienteID;

		IF NOT EXISTS (SELECT 1 FROM dbo.Ordini WHERE IDCliente = @ClienteID)
		BEGIN
			INSERT INTO @Riepilogo (RigaRiepilogo) VALUES ('Nessun ordine per questo cliente.');
		END;

		RETURN;
END;
GO*/

-- NEL FROM
/*SELECT *
FROM dbo.fn_RiepilogoOrdiniCliente(2) AS Riepilogo;
GO*/

-- Sintassi per modificare le procedure e le funzioni
-- Si utilizza ALTER: ALTER PROCEDURE O PROC E ALTER FUNCTION
-- Per rimuovere DROP: DROP PROCEDURE O PROC OPPURE DROP FUNCTION