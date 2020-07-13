fotografie(id_fotografie, titlu, id_artist, data_crearii)
expusa(id_fotografie, id_expozitie, data_crearii, nr_zile)
expozitie(id_expozitie, denumire, data_inceput, data_sfarsit, oras);
artist(id_artist, nume, data_nasterii, nationalitate);

1. Sa se afiseze artistii care si-au expus fotografiile in
expozitii care au inceput in anul 2019 pentru care se cunoaste
nationalitatea.

2. Sa se afiseze in ordine alfabetica dupa nume expozitiile 
in care nu s-a expus nicio fotografie.

3. Sa se afiseze expozitiile care au avut expuse cel putin 2 fotografii de la artisti diferiti. 

4. Sa se stearga expunerile fotografiilor care au avut cel putin 2 expozitii.
Anulati modificarile.

5. Sa se adauge coloana id_artist in tabelul expozitie care va permite sa 
se cunoasca artistul care a organizat expozitia. Coloana va fi adaugata impreuna
cu o constrangere de cheie externa.