IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'NegozioSQL')
BEGIN
    -- STEP 2: Se il db non esiste, lo crea. 
    CREATE DATABASE NegozioSQL;
    --STEP 3: Manda un messaggio di conferma all'utente.
    PRINT 'Database NegozioSQL creato con successo.';
END
ELSE
BEGIN
    -- STEP 4: Se il db esiste.
    PRINT 'Database NegozioSQL esiste già.';
END
-- Indica la fine di un gruppo di istruzioni.
GO 
