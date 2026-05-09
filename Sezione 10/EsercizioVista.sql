-- Creare una vista
/*CREATE VIEW dbo.vw_RiepilogoOrdiniClienti
AS
SELECT
	cl.Nome + '' + cl.Cognome AS NomeCompletoCliente,
	COUNT(DISTINCT o.IDOrdine) AS NumeroTotOrdiniCliente,
	SUM(do.Quantita * do.PrezzoUnitarioAcquisto) AS SpesaTot
FROM
	dbo.Clienti AS cl
JOIN
	dbo.Ordini AS o ON cl.IDCliente = o.IDCliente
JOIN
	dbo.DettagliOrdine AS do ON o.IDOrdine = do.IDOrdine
GROUP BY
	cl.Nome, cl.Cognome;
GO*/

-- Cliente con più spesa
/*SELECT
	TOP 1
	NomeCompletoCliente,
	SpesaTot
FROM 
	dbo.vw_RiepilogoOrdiniClienti
ORDER BY
	SpesaTot DESC;
GO*/

-- Test aggiornabilità
/*UPDATE dbo.vw_ProdottiConCategoria
SET PrezzoUnitario = PrezzoUnitario * 1.05
WHERE NomeCategoria = 'Elettronica';
GO*/

-- Creare vista aggiornabile
/*CREATE VIEW dbo.vw_ClientiEmailPrincipali
AS
SELECT
	cl.IDCliente,
	cl.Nome,
	cl.Cognome,
	cl.EMAIL
FROM	
	dbo.Clienti AS cl
WHERE
	cl.EMAIL LIKE '%@email.com';
GO*/

-- Aggiungere la prima colonna
/*ALTER VIEW dbo.vw_ProdottiConCategoria 
AS
SELECT
	P.IDProdotto,
	P.NomeProdotto,
    P.PrezzoUnitario,
    C.NomeCategoria
FROM
	dbo.Prodotti AS P
JOIN
	dbo.Categorie AS C ON P.IDCategoria = C.IDCategoria;
GO*/

-- Elimina le viste
/*DROP VIEW dbo.vw_RiepilogoOrdiniClienti;
GO
DROP VIEW dbo.vw_ClientiEmailPrincipali;
GO*/