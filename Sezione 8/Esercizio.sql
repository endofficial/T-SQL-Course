-- Una volta creato il nuovo db Lab_Integrity, costruisco lo schema NO ACTION
/*CREATE TABLE dbo.Categorie (
	IDCategoria INT PRIMARY KEY,
	NomeCategoria VARCHAR(100) NOT NULL
);*/

/*CREATE TABLE dbo.Prodotti (
	IDProdotto INT PRIMARY KEY,
	NomeProdotto VARCHAR(100) NOT NULL,
	PrezzoUnitario DECIMAL(10, 2) NOT NULL,
	IDCategoria INT,
	CONSTRAINT FK_Prodotti_Categorie FOREIGN KEY (IDCategoria) REFERENCES dbo.Categorie (IDCategoria)
);*/

/*-- categorie
INSERT INTO dbo.Categorie VALUES (1,'Elettronica'),(2,'Libri');
 
-- prodotto valido
INSERT INTO dbo.Prodotti VALUES (101,'Smart-TV',499.00,1);
 
-- prodotto NON valido (FK violata)
INSERT INTO dbo.Prodotti VALUES (102,'Tostapane X',19.90,77);*/

-- Non funziona per il vincolo
/*DELETE FROM dbo.Categorie WHERE IDCategoria = 1;*/

-- Rifaccio i passaggi con CASCADE per notare le differenze
/*CREATE TABLE dbo.CategorieCAS (
    IDCategoria  INT PRIMARY KEY,
    NomeCategoria VARCHAR(100) NOT NULL
);*/

/*CREATE TABLE dbo.ProdottiCAS (
    IDProdotto      INT PRIMARY KEY,
    NomeProdotto    VARCHAR(100) NOT NULL,
    PrezzoUnitario  DECIMAL(10,2) NOT NULL,
    IDCategoria     INT,
	CONSTRAINT FK_ProdottiCAS_CategorieCAS
	FOREIGN KEY (IDCategoria) 
	REFERENCES dbo.CategorieCAS (IDCategoria)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);*/

/*INSERT INTO dbo.CategorieCAS VALUES (1,'Elettrodomestici'),(2,'Posate');*/

/*INSERT INTO dbo.ProdottiCAS VALUES (101,'Freezer',499.00,1);*/

-- Funziona per il CASCADE ed elimina anche tutti i figli
/*DELETE FROM dbo.CategorieCAS WHERE IDCategoria = 1;*/

-- Aggiungo il vincolo CHECK a Prodotti per forzare:
/*ALTER TABLE dbo.Prodotti
ADD CONSTRAINT CK_Prezzo_Pos CHECK (PrezzoUnitario > 0);*/

/*CREATE TABLE dbo.Clienti (
    IDCliente INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    CONSTRAINT UQ_Clienti_Email UNIQUE (Email)
);*/

INSERT INTO dbo.Prodotti
VALUES (102, 'Frigo', -5, 1);