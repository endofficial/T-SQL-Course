-- Aggiorna la descrizione solo di quel NomeProdotto
/*UPDATE dbo.Prodotti
SET Descrizione = N'Descrizione aggiornata'
WHERE NomeProdotto = N'Smartphone X100';
GO*/

/*SELECT NomeProdotto, Descrizione
FROM dbo.Prodotti
WHERE NomeProdotto = N'Smartphone X100';
GO*/

-- Utilizzare TRUNCATE TABLE -> QUESTO DA ERRORE PERCHE' E' PRESENTE UNA CHIAVE
/*TRUNCATE TABLE dbo.Categorie;
GO*/

-- Con questo comando resetto anche l'id; con DELETE no
/*TRUNCATE TABLE dbo.LogEventi;
GO*/

-- Questo comando elimina completamente la tabella
/*DROP TABLE dbo.LogEventi;
GO*/

-- Così creo una colonna con questo nome e registro il conteggio
/*SELECT COUNT(*) AS NumeroProdottiInCategoria1
FROM dbo.Prodotti
WHERE IDCategoria = 1;
GO*/

-- Non funziona poiché c'è il vincolo FK_PRodotti_Categorie
/*DELETE FROM dbo.Categorie
WHERE IDCategoria = 1;
GO*/