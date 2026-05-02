/*SELECT NomeCategoria,Descrizione FROM dbo.Categorie;
GO*/

/*SELECT IDProdotto, NomeProdotto, PrezzoUnitario, IDCategoria
FROM dbo.Prodotti
WHERE IDCategoria = 1;
GO*/

/*SELECT IDCliente, Nome, Cognome, EMAIL
FROM dbo.Clienti
WHERE Nome = N'mario';
GO*/

/*SELECT IDOrdine, IDCliente, DataOrdine, StatoOrdine
FROM dbo.Ordini
WHERE StatoOrdine <> N'Spedito';
GO*/

/*SELECT NomeProdotto, PrezzoUnitario
FROM dbo.Prodotti
WHERE PrezzoUnitario > 50.00;
GO*/

/*SELECT IDCliente, Nome, Cognome, DataRegistrazione
FROM dbo.Clienti
WHERE DataRegistrazione >= '2026-04-09';
GO*/

/*SELECT NomeProdotto, PrezzoUnitario
FROM dbo.Prodotti
WHERE PrezzoUnitario BETWEEN 20.00 AND 800.00;
GO*/

/*SELECT IDOrdine, DataOrdine
FROM dbo.Ordini
WHERE DataOrdine BETWEEN '2026-04-09' AND '2026-04-12';
GO*/

/*SELECT NomeProdotto, IDCategoria
FROM dbo.Prodotti
WHERE IDCategoria IN (2, 3);
GO*/

/*SELECT Nome, Cognome, EMAIL
FROM dbo.Clienti
WHERE Cognome LIKE N'R%';
GO*/

/*SELECT IDProdotto, NomeProdotto
FROM dbo.Prodotti
WHERE NomeProdotto LIKE N'%SQL%';
GO*/

/*SELECT NomeProdotto
FROM dbo.Prodotti
WHERE NomeProdotto LIKE N'_mart%';
GO*/

/*SELECT IDProdotto, NomeProdotto, Descrizione
FROM dbo.Prodotti
WHERE Descrizione IS NULL;
GO*/

SELECT IDProdotto, NomeProdotto, Descrizione
FROM dbo.Prodotti
WHERE Descrizione IS NOT NULL