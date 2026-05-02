-- Trovare tutti gli id ordine che contengono il prodotto
/*SELECT DISTINCT IDOrdine
FROM dbo.DettagliOrdine
WHERE IDProdotto = 101;*/

-- Subquery non correlata
/*SELECT
	IDOrdine,
	IDCliente,
	DataOrdine
FROM
	dbo.Ordini
WHERE
	IDOrdine IN -- Da una lista di valori
	(SELECT DISTINCT IDOrdine
	FROM dbo.DettagliOrdine
	WHERE IDProdotto = 101)
ORDER BY
	DataOrdine DESC;
GO*/

-- Subquery scalare
/*SELECT
	PrezzoUnitario
FROM
	dbo.Prodotti
WHERE
	NomeProdotto = 'Smartphone X100';
GO*/

-- Passo 2
/*SELECT
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.Prodotti
WHERE
	PrezzoUnitario > (SELECT PrezzoUnitario
						FROM dbo.Prodotti
						WHERE NomeProdotto = 'Smartphone X400');
GO*/

-- Con questo trovo, ad esempio, quei prodotti che hanno un prezzo maggiore alla media
/*SELECT
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.Prodotti
WHERE 
	PrezzoUnitario > (SELECT AVG(PrezzoUnitario) 
						FROM dbo.Prodotti);
GO*/


-- Subquery correlata 
-- Trovare tutti i prodotti il cui prezzo è maggiore del prezzo medio dei prodotti della stessa categoria a cui appartengono
/*SELECT
	P1.NomeProdotto,
	P1.PrezzoUnitario,
	P1.IDCategoria
FROM
	dbo.Prodotti AS P1
WHERE -- Inizia la subquery
	P1.PrezzoUnitario > (
		SELECT
			AVG(P2.PrezzoUnitario)
			FROM
				dbo.Prodotti AS P2
			WHERE
				P2.IDCategoria = P1.IDCategoria
);
GO*/

-- Subquery nella clausola SELECT
-- Se togliessi AVG non funzionerebbe perché è la subquery è scalare
/*SELECT 
	NomeProdotto,
	PrezzoUnitario,
	IDCategoria,
	(SELECT AVG(P2.PrezzoUnitario)
		FROM dbo.Prodotti AS P2
		WHERE P2.IDCategoria = P1.IDCategoria) AS PrezzoMedioCategoria
FROM
	dbo.Prodotti AS P1;
GO*/

-- in FROM
/*SELECT 
	NomeProdotto,
	PrezzoUnitario,
	Medie.PrezzoMedioCategoria
FROM
	dbo.Prodotti AS P
JOIN
	(SELECT
		IDCategoria,
		AVG(PrezzoUnitario) AS PrezzoMedioCategoria
		FROM dbo.Prodotti
		GROUP BY IDCategoria) AS Medie
	ON P.IDCategoria = Medie.IDCategoria
WHERE
	P.PrezzoUnitario > Medie.PrezzoMedioCategoria;
GO*/

-- Trovare tutti i prodotti che sono stati ordinati almeno una volta
-- IN si usa per verificare se il valore di una colonna corrisponde a uno qualsiasi dei valori presenti in un elenco specifico
/*SELECT
	NomeProdotto,
	PrezzoUnitario
FROM dbo.Prodotti
WHERE
	IDProdotto IN (
		SELECT DISTINCT IDProdotto
		FROM dbo.DettagliOrdine
);
GO*/

-- Operatore EXISTS (Verifica se esistono delle righe che soddisfano una certa condizione)
/*SELECT
	Nome,
	Cognome
FROM dbo.Clienti AS C
WHERE 
	EXISTS (
		SELECT 1
		FROM dbo.Ordini AS O
		WHERE O.IDCliente = C.IDCliente
);
GO*/

-- Operatori ANY e ALL usati con un operatore di confronto e uuna subq. che restituisce una singola colonna
-- Trovare un prodotto il cui prezzo è maggiore del prezzo minimo della categoria
-- ALL invece verifica se la condizione è vera per tutti
/*SELECT
	NomeProdotto,
	PrezzoUnitario
FROM
	dbo.Prodotti
WHERE
	PrezzoUnitario > ANY (
		SELECT PrezzoUnitario
		FROM dbo.Prodotti
		WHERE IDCategoria = 1
	);
GO*/

-- Utilizzo UNION ALL per unire tutti i risultati anche i duplicati
/*SELECT
	Nome AS NOMEENTITA,
	'Cliente' AS TIPOENTITA
FROM
	dbo.Clienti
UNION ALL
SELECT
	NomeProdotto,
	'Prodotto'
FROM
	dbo.Prodotti;
GO*/

-- UNION toglie le righe duplicate
/*SELECT 
	IDCliente 
FROM
	dbo.Clienti
WHERE Nome LIKE 'M%'

UNION

SELECT 
	IDCliente 
FROM
	dbo.Ordini
WHERE
	IDOrdine > 2
ORDER BY IDCliente DESC;
GO*/

-- INTERSECT serve per ottenere solo le righe che sono presenti sia nel risultato della prima che della seconda tabella
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

-- EXCEPT serve solo per ottenere i risultati della prima tabella che non appaiono nella seconda tabella
SELECT
	IDCliente
FROM
	dbo.Clienti

EXCEPT

SELECT 
	IDCliente
FROM
	dbo.Ordini;
GO