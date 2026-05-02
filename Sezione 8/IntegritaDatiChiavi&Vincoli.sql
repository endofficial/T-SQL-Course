/*CREATE TABLE dbo.ProdottiTest (
	IDProdotto INT PRIMARY KEY,
	NomeProdotto NVARCHAR(100) NOT NULL,
	PrezzoUnitario DECIMAL(10, 2) NOT NULL,
	IDCategoria INT,
	CONSTRAINT FK_ProdottiTest_Categorie
	FOREIGN KEY (IDCategoria) REFERENCES dbo.Categorie (IDCategoria)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO*/

-- Per aggiungere manualmente una categoria nella tabella categoria
/*SET IDENTITY_INSERT dbo.Categorie ON;*/

/*INSERT INTO dbo.Categorie (IDCategoria, NomeCategoria, Descrizione)
VALUES (999, 'Categoria Test', 'Categoria usata per la dimostrazione del CASCADE');*/

/*SELECT * FROM dbo.Categorie WHERE IDCategoria = 999;*/

/*INSERT INTO dbo.ProdottiTest (IDProdotto, NomeProdotto, PrezzoUnitario, IDCategoria)
VALUES
	(1001, 'Prodotto test 1', 10.00, 999),
	(1002, 'Prodotto test 2', 15.00, 999);*/

-- Così, visto che ho utilizzato CASCADE prima, vengono eliminati tutto ciò che è associato
/*DELETE FROM dbo.Categorie WHERE IDCategoria = 999;*/

-- Caso in cui una tabella esiste già e voglio aggiungere un nuovo vincolo e magari rimuoverne uno esistente

/*CREATE TABLE Fornitori(
	IDFornitori INT PRIMARY KEY,
	NomeAzienda VARCHAR(100) NOT NULL,
	PartitaIva VARCHAR(20),
	EmailContatto VARCHAR(100),
	RatingAffidabilita INT
);*/

/*INSERT INTO dbo.Fornitori (IDFornitori, NomeAzienda, PartitaIva, EmailContatto, RatingAffidabilita)
VALUES (1, 'Tech Supplies S.p.A.', 'IT12345678901', 'info@techsupplies.it', 4);
GO*/

-- Aggiungiamo un vincolo
/*ALTER TABLE Fornitori
ADD CONSTRAINT UQ_Fornitori_PartitaIva UNIQUE (PartitaIva);*/

-- Questo comando mi genera una violazione poiché utilizzo una partita iva già associata 
/*INSERT INTO dbo.Fornitori (IDFornitori, NomeAzienda, PartitaIva)
VALUES (2, 'Office Gear S.r.l.', 'IT12345678901');
GO*/

-- Il raiting deve essere compreso in un intervallo (scrivo CK perché è un check)
/*ALTER TABLE Fornitori
ADD CONSTRAINT CK_Fornitori_rating CHECK (RatingAffidabilita >= 1 AND RatingAffidabilita <= 5);
GO*/

/*INSERT INTO dbo.Fornitori (IDFornitori, NomeAzienda, RatingAffidabilita)
VALUES (3, 'Paper World', 9);
GO*/

-- Voglio rimuovere il vincolo aggiunto ora
/*ALTER TABLE Fornitori
DROP CONSTRAINT CK_Fornitori_rating;*/

-- Per rendere questa colonna obbligatoria
/*ALTER TABLE Fornitori
ALTER COLUMN EmailContatto VARCHAR(100) NOT NULL;*/

-- opzionale
/*ALTER TABLE Fornitori
ALTER COLUMN EmailContatto VARCHAR(100) NULL;*/

-- Per sospendere il vincolo
/*ALTER TABLE Fornitori
NOCHECK CONSTRAINT UQ_Fornitori_PartitaIva;*/

-- Per riabilitarlo
/*ALTER TABLE Fornitori
CHECK CONSTRAINT UQ_Fornitori_PartitaIva*/


-- Sono nella db MioDatabaseDimostrativo
/*CREATE TABLE dbo.Categorie(
	id INT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);*/

/*INSERT INTO dbo.Categorie (id, nome)
VALUES (1, 'Elettronica'), (2, 'Libri');*/

-- Voglio che la colonna della tabella prodotti (id) deve far riferimento ad un valore valido della colonna id di categorie
/*CREATE TABLE dbo.Prodotti(
	id INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	prezzo DECIMAL (10, 2) NOT NULL,
	categoria_id INT,
	CONSTRAINT FK_Prodotti_Categorie FOREIGN KEY (categoria_id) REFERENCES dbo.Categorie (id)
);
GO*/

-- Corretto poiché esiste l'id nella tabella categorie
/*INSERT INTO dbo.Prodotti (id, nome, prezzo, categoria_id)
VALUES (101, 'Iphone 1', 599.99, 1);*/

-- Non funziona
/*INSERT INTO dbo.Prodotti (id, nome, prezzo, categoria_id)
VALUES (102, 'Iphone 2', 699.99, 99);
GO*/

-- Non funziona
/*UPDATE dbo.Prodotti
SET categoria_id = 77
WHERE id = 101;*/

-- Questo non funziona perché esiste il vincolo e eliminare la tabella lascerebbe prodotti orfana
/*DELETE FROM dbo.Categorie WHERE id = 1;*/