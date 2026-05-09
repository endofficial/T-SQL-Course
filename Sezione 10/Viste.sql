-- Creo una vista. Una convenzione per dare un nome è vw_nomevista
-- Order BY non si applica in una vista
/*CREATE VIEW vw_ProdottiConCateogria
AS
SELECT
	p.NomeProdotto,
	p.PrezzoUnitario,
	c.NomeCategoria
FROM
	dbo.Prodotti AS p
JOIN
	dbo.Categorie AS c ON p.IDCategoria = c.IDCategoria*/

-- Per prendere la vista
/*SELECT *
FROM dbo.vw_ProdottiConCategoria;*/

/*SELECT
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.vw_ProdottiConCategoria
WHERE
	NomeCategoria = 'Elettronica' AND PrezzoUnitario > 300
ORDER BY
	PrezzoUnitario DESC;*/

-- Posso aggiornare una vista se la modifica non è ambigua
/*UPDATE dbo.vw_ProdottiConCategoria
SET PrezzoUnitario = 999.99
WHERE NomeProdotto = 'Smartphone X400';
GO*/

-- Un altro UPDATE che funziona
/*UPDATE dbo.vw_ProdottiConCategoria
SET NomeCategoria = 'Cellulari'
WHERE NomeProdotto = 'Smartphone X400';
GO*/

-- Così non funziona perché sono più tabelle di base
/*UPDATE dbo.vw_ProdottiConCategoria
SET 
	NomeCategoria = 'Elettronica scontata',
	PrezzoUnitario = 900.00
WHERE
	NomeProdotto = 'Smartphone X400';
GO*/

-- Per modificare, aggiornare una vista esistente
/*ALTER VIEW dbo.vw_ProdottiConCategoria
AS
SELECT
	p.IDProdotto,
	p.NomeProdotto,
	p.PrezzoUnitario,
	c.NomeCategoria
FROM
	dbo.Prodotti AS p
JOIN
	dbo.Categorie AS c ON p.IDCategoria = c.IDCategoria;
GO*/

-- Per eliminare una vista usare DROP VIEW (solo dopo aver constato che non ci siano dipendenze)
-- Quando si crea una vista, per dare più stabilità al db, posso usare WITH SCHEMABIDING