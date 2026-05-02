--Utilizzo il GROUPBY per visualizzare quanti prodotti ci sono per ogni categoria
/*SELECT
	IDCategoria,
	COUNT(IDProdotto) AS NumeroProdottiPerCategoria
FROM dbo.Prodotti
GROUP BY IDCategoria;*/

--Visualizzo una tabella con tre colonne e voglio trovare la quantità di ordini effettuati dai ogni cliente.
/*SELECT
	c.Nome,
	c.Cognome,
	COUNT(o.IDOrdine) AS NumeroOrdiniEffettuati
FROM
	dbo.Ordini o
INNER JOIN
	dbo.Clienti c ON o.IDCliente = c.IDCliente
GROUP BY
	c.IDCliente, c.Nome, c.Cognome
ORDER BY
	NumeroOrdiniEffettuati DESC;
GO*/

--Se voglio visualizzare la quantià di ogni singolo prodotto venduta utilizzo SUM per conteggiare le quantita
/*SELECT
	p.NomeProdotto,
	SUM(do.Quantita) AS TotQuantitaVenduta
FROM
	dbo.DettagliOrdine do
INNER JOIN
	dbo.Prodotti p ON do.IDProdotto = p.IDProdotto
GROUP BY 
	p.NomeProdotto
ORDER BY TotQuantitaVenduta DESC;
GO*/

--Utilizzo HAVING per filtrare dopo il GROUPBY a differenza di WHERE che lo può fare solo prima di esso
/*SELECT
	p.NomeProdotto,
	SUM(do.Quantita) AS TotQuantitaVenduta
FROM
	dbo.DettagliOrdine do
INNER JOIN
	dbo.Prodotti p ON do.IDProdotto = p.IDProdotto
GROUP BY 
	p.NomeProdotto
HAVING SUM(do.Quantita) > 2
ORDER BY TotQuantitaVenduta DESC;
GO*/

-- Ottenere le categorie dei prodotti il cui prezzo medio superi i 50 euro però considerare solo i prodotti che singolarmente costano più di 20 euro
/*SELECT
	c.NomeCategoria,
	AVG(p.PrezzoUnitario)
FROM
	dbo.Prodotti p
JOIN
	dbo.Categorie c ON p.IDCategoria = c.IDCategoria
WHERE
	p.PrezzoUnitario > 20
GROUP BY
	c.NomeCategoria
HAVING
	AVG(p.PrezzoUnitario) > 50;
GO*/

-- Scrivere una query per vedere nome e cognome e accanto ad essi la somma totale della spesa di ognuno
/*SELECT
	cl.Nome,
	cl.Cognome,
	SUM(do.Quantita * do.PrezzoUnitarioAcquisto) AS SpesaCliente
FROM
	dbo.Clienti cl
JOIN
	dbo.Ordini o ON cl.IDCliente = o.IDCliente
JOIN
	dbo.DettagliOrdine do ON o.IDOrdine = do.IDOrdine
GROUP BY
	cl.IDCliente, cl.Nome, cl.Cognome
ORDER BY SpesaCliente DESC;
GO*/

-- Voglio vedere il nome di ogni categoria, le unità vendute e il valore totale. Mostrare solo le categoria che hanno venduto più di 50  unità
/*SELECT
	ct.NomeCategoria,
	SUM (do.Quantita) AS TotaleUnitaVendute,
	SUM (do.Quantita * do.PrezzoUnitarioAcquisto) AS ValoreTotaleVenduto
FROM
	dbo.Categorie ct
JOIN
	dbo.Prodotti p ON ct.IDCategoria = p.IDCategoria
JOIN
	dbo.DettagliOrdine do ON p.IDProdotto = do.IDProdotto
GROUP BY
	ct.IDCategoria, ct.NomeCategoria
HAVING 
	SUM(do.Quantita) > 50
ORDER BY ValoreTotaleVenduto DESC;
GO*/

/*SELECT
	cl.IDCliente,
	COUNT(do.Quantita) AS TotaleNumeroOrdini
FROM
	dbo.Clienti cl
JOIN
	dbo.Ordini o ON cl.IDCliente = o.IDCliente
JOIN
	dbo.DettagliOrdine do ON o.IDOrdine = do.IDOrdine
GROUP BY
	cl.IDCliente
ORDER BY
	TotaleNumeroOrdini DESC;
GO*/ --1

/*SELECT
	ct.IDCategoria,
	COUNT(p.IDProdotto) AS TotaleProdottiRegistrati
FROM
	dbo.Categorie ct
JOIN
	dbo.Prodotti p ON ct.IDCategoria = p.IDCategoria
GROUP BY
	ct.IDCategoria
HAVING
	COUNT(p.IDProdotto) > 4;
GO*/ --2

SELECT
	ct.NomeCategoria,
	SUM(do.Quantita * do.PrezzoUnitarioAcquisto) AS ValoreTotaleVendite
FROM
	dbo.Categorie ct
JOIN
	dbo.Prodotti p ON ct.IDCategoria = p.IDCategoria
JOIN
	dbo.DettagliOrdine do ON p.IDProdotto = do.IDProdotto
GROUP BY
	ct.NomeCategoria, ct.IDCategoria
HAVING
	SUM(do.Quantita * do.PrezzoUnitarioAcquisto) >= 100
ORDER BY
	ValoreTotaleVendite DESC;
GO