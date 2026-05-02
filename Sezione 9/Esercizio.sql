-- Seleziona tutti i prodotti il cui prezzo è sup. al prezzo medio di tutti i prodotti presenti nella categoria
/*SELECT
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.Prodotti
WHERE
	PrezzoUnitario > (
		SELECT AVG(PrezzoUnitario)
		FROM dbo.Prodotti
	);
GO*/

-- Trova tutti i clienti che hanno effettuato più di un ordine.
/*SELECT 
	Nome,
	Cognome
FROM 
	dbo.Clienti AS C
WHERE
	EXISTS (
		SELECT 1
		FROM dbo.Ordini AS O
		WHERE C.IDCliente = O.IDCliente
		);
GO*/

-- Per ogni prodotto, mostra il suo nome, il suo prezzo e una colonna aggiuntiva 
-- chiamata OrdiniRicevuti che contenga il numero totale di volte che quel prodotto è stato ordinato
/*SELECT
	P.NomeProdotto,
	P.PrezzoUnitario,
	(SELECT 
		COUNT(*)
	FROM
		dbo.DettagliOrdine AS DO
	WHERE
		DO.IDProdotto = P.IDProdotto) AS OrdiniRicevuti
FROM
	dbo.Prodotti AS P;
GO*/

-- Calcola la spesa totale per ogni cliente. 
-- La query deve restituire l'IDCliente, il Nome del cliente e una colonna TotaleSpeso. Ordina i risultati per spesa totale in ordine decrescente.
/*SELECT
	c.IDCliente,
	c.Nome,
	TOT.TotaleSpeso
FROM
	dbo.Clienti AS c
JOIN
	(SELECT
		o.IDCliente,
		SUM(do.Quantita * do.PrezzoUnitarioAcquisto) AS TotaleSpeso
	FROM
		dbo.Ordini AS o
	JOIN
		dbo.DettagliOrdine AS do ON do.IDOrdine = o.IDOrdine
	GROUP BY o.IDCliente
	) AS TOT ON c.IDCliente = TOT.IDCliente
	ORDER BY TOT.TotaleSpeso DESC;
GO*/

-- Restituisci l'elenco dei prodotti che non sono mai stati venduti
/*SELECT
	p.NomeProdotto,
	p.Descrizione
FROM
	dbo.Prodotti AS p
WHERE
	NOT EXISTS (
	SELECT 1
	FROM dbo.DettagliOrdine AS do
	WHERE do.IDProdotto = p.IDProdotto
	);
GO*/

-- Crea un'unica lista contenente i nomi dei clienti e i nomi dei prodotti. 
-- Includi una colonna Tipo che indichi se la riga si riferisce a un 'Cliente' o a un 'Prodotto'.
/*SELECT
	c.Nome AS NomeCliente,
	'Cliente' AS Tipo
FROM
	dbo.Clienti AS c
UNION ALL
SELECT 
	p.NomeProdotto,
	'Prodotto' AS Tipo
FROM
	dbo.Prodotti AS p;
GO*/

-- Trova gli IDCliente dei clienti che sono registrati e che hanno anche effettuato almeno un ordine.
/*SELECT
	IDCliente
FROM
	dbo.Clienti
INTERSECT
SELECT
	IDCliente
FROM
	dbo.Ordini;
GO*/

-- Scrivi un'unica query che restituisca i 3 prodotti più venduti in termini di quantità totale. 
-- La query deve mostrare IDProdotto, NomeProdotto e QuantitaTotaleVenduta.
/*SELECT
	TOP 3
	p.IDProdotto,
	p.NomeProdotto,
	TOT.QuantitaTotaleVenduta
FROM
	dbo.Prodotti AS p
JOIN
	(SELECT
		do.IDProdotto,
		SUM(do.Quantita) AS QuantitaTotaleVenduta
	FROM
		dbo.DettagliOrdine AS do
	GROUP BY
		do.IDProdotto
	) AS TOT ON p.IDProdotto = TOT.IDProdotto
ORDER BY
	TOT.QuantitaTotaleVenduta DESC;
GO*/