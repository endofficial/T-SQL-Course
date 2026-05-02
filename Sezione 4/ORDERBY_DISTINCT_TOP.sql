-- ORDER BY per ordinare in diversi modi le tabelle
/*SELECT IDCategoria, NomeCategoria
FROM dbo.Categorie
ORDER BY NomeCategoria DESC;
GO*/

--Come eliminare i duplicati con DISTINCT
/*SELECT DISTINCT IDCategoria
FROM dbo.Prodotti;*/

/*SELECT DISTINCT IDCategoria, NomeCategoria 
FROM dbo.Categorie;*/

--Limitazione dei risultati delle Query con TOP
/*SELECT TOP 3 NomeProdotto, PrezzoUnitario 
FROM dbo.Prodotti
ORDER BY PrezzoUnitario DESC;*/

/*SELECT TOP 10 PERCENT NomeProdotto, PrezzoUnitario 
FROM dbo.Prodotti
ORDER BY PrezzoUnitario DESC;*/