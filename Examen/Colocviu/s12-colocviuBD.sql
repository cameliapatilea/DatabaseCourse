--fotografie(id_fotografie, titlu, id_artist, data_crearii)
--expusa(id_fotografie, id_expozitie, data_crearii, nr_zile)
--expozitie(id_expozitie, denumire, data_inceput, data_sfarsit, oras);
--artist(id_artist, nume, data_nasterii, nationalitate);

--1. Sa se afiseze artistii care si-au expus fotografiile in
--expozitii care au inceput in anul 2019 pentru care se cunoaste
--nationalitatea.
SELECT a.id_artist, a.nume, a.data_nasterii, a.nationalitate
FROM artist a
WHERE a.nationalitate IS NOT NULL AND
    1 <= (SELECT COUNT(*)
          FROM fotografie f
          JOIN expusa expu ON expu.id_fotografie = f.id_fotografie
          JOIN expozitie expo ON expo.id_expozitie = expu.id_expozitie
          WHERE f.id_artist = a.id_artist AND
                TO_CHAR(expo.data_inceput, 'YYYY') = '2019')


--2. Sa se afiseze in ordine alfabetica dupa nume expozitiile 
--in care nu s-a expus nicio fotografie.

SELECT DISTINCT e.*
FROM expozitie e
LEFT JOIN expusa exp on exp.id_expozitie = e.id_expozitie
WHERE exp.id_expozitie IS NULL
ORDER BY e.denumire;


--3. Sa se afiseze expozitiile care au avut expuse cel putin 2 fotografii de la artisti diferiti. 
SELECT expo.id_expozitie, expo.denumire,
(SELECT COUNT(*) 
            FROM (SELECT DISTINCT a.id_artist, expu.id_expozitie as "id_expozitie"
                  FROM artist a
                  JOIN fotografie f ON f.id_artist = a.id_artist
                  JOIN expusa expu ON expu.id_fotografie = f.id_fotografie)
                  --WHERE expu.id_expozitie = expo.id_expozitie)
            WHERE "id_expozitie" = expo.id_expozitie
            ) as "Numar artisti participanti"
FROM expozitie expo
WHERE 2 <= (SELECT COUNT(*) 
            FROM (SELECT DISTINCT a.id_artist, expu.id_expozitie as "id_expozitie"
                  FROM artist a
                  JOIN fotografie f ON f.id_artist = a.id_artist
                  JOIN expusa expu ON expu.id_fotografie = f.id_fotografie)
                  --WHERE expu.id_expozitie = expo.id_expozitie)
            WHERE "id_expozitie" = expo.id_expozitie
            ); 
                  


--4. Sa se stearga expunerile fotografiilor care au avut cel putin 2 expozitii.
--Anulati modificarile.

SELECT * FROM expusa --observam ca trebuie sterse doar 3 randuri pt id_fotografie = 10

DELETE
FROM expusa e
WHERE e.id_fotografie IN 
    (SELECT "id"
     FROM (SELECT e.id_fotografie AS "id", COUNT(*)
            FROM expusa e
            GROUP BY e.id_fotografie
            HAVING COUNT(e.id_fotografie) >= 2));
            
SELECT * FROM expusa;
            
ROLLBACK;

--5. Sa se adauge coloana id_artist in tabelul expozitie care va permite sa 
--se cunoasca artistul care a organizat expozitia. Coloana va fi adaugata impreuna
--cu o constrangere de cheie externa. 

DESCRIBE expozitie

ALTER TABLE expozitie
ADD id_artist NUMBER(10)
CONSTRAINT expozitie_artist REFERENCES artist(id_artist)

DESCRIBE expozitie

