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

SELECT
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.vw_ProdottiConCategoria
WHERE
	NomeCategoria = 'Elettronica' AND PrezzoUnitario > 300
ORDER BY
	PrezzoUnitario DESC;