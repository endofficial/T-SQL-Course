-- INNER JOIN ACCOMUNA TUTTI I VALORI UGUALI TRA DUE TABELLE
/*SELECT
	P.IDProdotto,
	P.NomeProdotto,
	P.PrezzoUnitario,
	C.NomeCategoria
FROM 
	dbo.Prodotti AS P
INNER JOIN
	dbo.Categorie AS C ON P.IDCategoria = C.IDCategoria;
GO*/

/*SELECT
	Cl.IDCliente,
	Cl.Nome AS NomeCliente,
	Cl.Cognome AS CognomeCliente,
	O.IDOrdine,
	O.DataOrdine,
	O.StatoOrdine
FROM 
	dbo.Clienti AS Cl
INNER JOIN 
	dbo.Ordini AS O ON Cl.IDCliente = O.IDCliente;
GO*/

--Left Join
/*SELECT
	Cl.IDCliente,
	Cl.Nome AS NomeCliente,
	Cl.Cognome AS CognomeCliente,
	O.IDOrdine,
	O.DataOrdine
FROM
	dbo.Clienti AS Cl
LEFT JOIN
	dbo.Ordini AS O ON Cl.IDCliente = O.IDCliente
ORDER BY 
	Cl.Cognome, Cl.Nome;
GO*/

 /*SELECT
	C.IDCategoria,
	C.NomeCategoria,
	P.IDProdotto,
	P.NomeProdotto
FROM
	dbo.Categorie AS C
LEFT JOIN
	dbo.Prodotti AS P ON C.IDCategoria = P.IDCategoria
ORDER BY
	C.NomeCategoria, P.NomeProdotto;
GO*/

/*SELECT
	P.IDProdotto,
	P.NomeProdotto,
	C.NomeCategoria
FROM
	dbo.Categorie AS C
RIGHT JOIN
	dbo.Prodotti AS P ON C.IDCategoria = P.IDCategoria
ORDER BY
	P.NomeProdotto;
GO*/

-- Invertire un RIGHT in LEFT JOIN
/*SELECT
	P.IDProdotto,
	P.NomeProdotto,
	C.NomeCategoria
FROM
	dbo.Prodotti AS P
LEFT JOIN
	dbo.Categorie AS C ON C.IDCategoria = P.IDCategoria
ORDER BY
	P.NomeProdotto;
GO*/

--FULL OUTER JOIN torna i dati di entrambe le tabelle
/*SELECT
	Cl.IDCliente,
	Cl.Nome AS NomeCliente,
	Cl.Cognome AS CognomeCliente,
	O.IDOrdine,
	O.DataOrdine
FROM
	dbo.Clienti AS Cl
FULL OUTER JOIN
	dbo.Ordini AS O ON Cl.IDCliente = O.IDCliente
ORDER BY
	Cl.IDCliente, O.IDOrdine;
GO*/

--Utilizziamo la tecnica del SELF JOIN (si utilizza quando consideriamo una sola tabella)
--Non puoi inserire un IDManager che non esiste già come IDDipendente. 
--Se provi a dire che il manager di Marco è l'utente "99", ma non esiste nessuno con ID 99, il database bloccherà l'operazione.
/*CREATE TABLE dbo.DipendentiDemo(
	IDDipendente INT PRIMARY KEY,
	NomeDipendente NVARCHAR(100),
	IDManager INT NULL,
	CONSTRAINT FK_Dipendenti_Manager FOREIGN KEY (IDManager) REFERENCES dbo.DipendentiDemo(IDDipendente)
);
GO

INSERT INTO dbo.DipendentiDemo (IDDipendente, NomeDipendente, IDManager) VALUES
(1, N'Anna Bianchi (CEO)', NULL),
(2, N'Mario Rossi (Manager Vendite)', 1),
(3, N'Laura Verdi (Venditore)', 2),
(4, N'Paolo Gialli (Venditore)', 2),
(5, N'Luca Neri (Manager Marketing)', 1);
GO*/

--Con il SELF JOIN voglio mostrare il NomeDipendente accanto il nome del loro manager
/*SELECT 
	D.NomeDipendente AS NomeDipedente,
	M.NomeDipendente AS Manager
FROM
	dbo.DipendentiDemo AS D
INNER JOIN
	dbo.DipendentiDemo AS M
	ON D.IDManager = M.IDDipendente;
GO*/

--In base alla teoria imparata, se volessi mostrare anche chi non ha un manager
/*SELECT 
	D.NomeDipendente AS NomeDipedente,
	ISNULL(M.NomeDipendente, 'Nessun Manager') AS Manager
FROM
	dbo.DipendentiDemo AS D
LEFT JOIN
	dbo.DipendentiDemo AS M
	ON D.IDManager = M.IDDipendente;
GO*/

--CROSS JOIN o Prodotto cartesiano (combina ogni riga di una tabella con ogni riga dell'altra)
/*SELECT
	Cl.Nome AS NomeCliente,
	Cl.Cognome AS CognomeCliente,
	Ca.NomeCategoria
FROM
	dbo.Clienti AS Cl
CROSS JOIN 
	dbo.Categorie AS Ca
ORDER BY 
	NomeCliente, CognomeCliente, NomeCategoria;
GO*/

