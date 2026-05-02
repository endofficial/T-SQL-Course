/*PRINT 'Creazione tabella Clienti...'

CREATE TABLE dbo.Clienti (
	IDCliente INT PRIMARY KEY IDENTITY(1, 1),
	Nome NVARCHAR(50) NOT NULL,
	Cognome NVARCHAR(50) NOT NULL,
	EMAIL NVARCHAR(100) UNIQUE NOT NULL,
	DataRegistrazione DATE DEFAULT GETDATE()
);
GO*/

/*PRINT 'Inserimento dati in Clienti...'

INSERT INTO dbo.Clienti (Nome, Cognome, Email)
VALUES
(N'Mario', N'Rossi', N'mario.rossi@email.com'),
(N'Roberto', N'Rossi', N'roberto.rossi@email.com');
GO*/

/*SELECT * FROM dbo.Clienti;
GO*/

/*PRINT 'Creazione tabella Prodotti...';
CREATE TABLE dbo.Prodotti(
	IDProdotto INT PRIMARY KEY IDENTITY(101, 1),
	NomeProdotto NVARCHAR(100) NOT NULL,
	Descrizione NVARCHAR(MAX) NULL,
	PrezzoUnitario DECIMAL(10,2) NOT NULL CHECK (PrezzoUnitario > 0),
	IDCategoria INT NOT NULL,
	CONSTRAINT FK_Prodotti_Categorie FOREIGN KEY (IDCategoria) REFERENCES dbo.Categorie(IDCategoria)
);
GO*/

/*PRINT 'Creazione tabella Ordini...';
CREATE TABLE dbo.Ordini(
	IDOrdine INT PRIMARY KEY IDENTITY(1001, 1),
	IDCliente INT NOT NULL,
	DataOrdine DATETIME2 DEFAULT GETDATE(),
	StatoOrdine NVARCHAR(50) DEFAULT N'In elaborazione',
	CONSTRAINT FK_Ordini_Clienti FOREIGN KEY (IDCliente) REFERENCES dbo.Clienti(IDCliente)
);
GO*/

/*PRINT 'Inserimento dati in Ordini...';
INSERT INTO dbo.Ordini (IDCliente) VALUES (1);
INSERT INTO dbo.Ordini (IDCliente, StatoOrdine) VALUES (2, N'Spedito');
GO*/

/*PRINT 'Creazione tabella DettagliOrdine...';
CREATE TABLE dbo.DettagliOrdine (
	IDDttagliOrdine INT PRIMARY KEY IDENTITY (1, 1),
	IDOrdine INT NOT NULL,
	IDProdotto INT NOT NULL,
	Quantita INT NOT NULL CHECK (Quantita > 0),
	PrezzoUnitarioAcquisto DECIMAL (10, 2) NOT NULL,
	CONSTRAINT FK_DettagliOrdine_Ordini FOREIGN KEY (IDOrdine) REFERENCES dbo.Ordini(IDOrdine),
	CONSTRAINT FK_DettagliOrdine_Prodotto FOREIGN KEY (IDProdotto) REFERENCES dbo.Prodotti(IDProdotto)
);
GO*/

/*PRINT 'Inserimento dati in Prodotti...';
INSERT INTO dbo.Prodotti (NomeProdotto, Descrizione, PrezzoUnitario, IDCategoria)
VALUES 
(N'Smartphone X100', N'Ultimo modello...', 799.99, 1),
(N'Smartphone X200', N'Ultimo modello...', 699.99, 2),
(N'Smartphone X300', N'Ultimo modello...', 599.99, 3),
(N'Smartphone X400', N'Ultimo modello...', 499.99, 1);
GO*/

/*PRINT 'Inserimento dati in DettagliOrdine';

INSERT INTO dbo.DettagliOrdine (IDOrdine, IDProdotto, Quantita, PrezzoUnitarioAcquisto)
VALUES 
(1001, 101, 1, 799.99),
(1001, 102, 2, 29.50);

INSERT INTO dbo.DettagliOrdine (IDOrdine, IDProdotto, Quantita, PrezzoUnitarioAcquisto)
VALUES 
(1002, 103, 3, 19.99);

GO*/

/*DELETE FROM dbo.DettagliOrdine WHERE IDDttagliOrdine BETWEEN 9 AND 18;*/

