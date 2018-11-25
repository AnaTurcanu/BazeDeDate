select * from studenti;
select * from grupe;

--1. Creati o diagrama a bazei de date, folosind forma de vizualizare standart, structura careia este descrisa la inceputul sarcinilor practice din capitolul 4. 



--2. Sa se adauge constrangeri referentiale (legate cu tabelele studenti ~i profesori) necesare coloanelor Sef_grupa ~i Prof_Indrumator (sarcina3, capitolul 6) din tabelul grupe. 
--3 La diagrama construitii, sa se adauge ~i tabelul orarul definit in capitolul 6 al acestei lucrari: tabelul orarul contine identificatorul disciplinei (ld_Disciplina), identificatorul profesorului (Id_Profesor) ~i blocul de studii (Bloc). Cheia tabelului este constituita din trei cfunpuri: identificatorul grupei (Id_ Grupa), ziua lectiei (Z1), ora de inceput a lectiei (Ora), sala unde are loc lectia (Auditoriu). 
--4. Tabelul orarul trebuie sa contina ~i 2 chei secundare: (Zi, Ora, Id_ Grupa, Id_ Profesor) ~i (Zi, Ora, ld_Grupa, ld_Disciplina). 
--5. in diagrama, de asemenea, trebuie sa se defineasca constrangerile referentiale (FK-PK) ale atributelor ld_Disciplina, ld_Profesor, Id_ Grupa din tabelului orarul cu atributele tabelelor respective. 
--6. Creati, in baza de date universitatea, trei scheme noi: cadre_didactice, plan_studii ~i studenti. Transferati tabelul profesori din schema dbo in schema cadre didactice, tinand cont de dependentelor definite asupra tabelului mentionat. in acela~i mod ~ se trateze tabelele orarul, discipline care apartin schemei plan_studii ~i tabelele studenti, studenti_reusita, care apartin schemei studenti. Se scrie instructiunile SQL respective. 

USE universitatea;
GO
ALTER SCHEMA cadre_didactice TRANSFER dbo.profesori; 
GO

USE universitatea; 
GO 
ALTER SCHEMA plan_studii TRANSFER dbo.discipline; 
GO 

USE universitatea; 
GO 
ALTER SCHEMA studenti TRANSFER dbo.studenti; 
GO  

USE universitatea; 
GO 
ALTER SCHEMA studenti TRANSFER dbo.studenti_reusita; 
GO 

SELECT * from cadre_didactice.profesori;
SELECT * from plan_studii.discipline;
SELECT * from studenti.studenti;
SELECT * from studenti.studenti_reusita;

--7. Modificati 2-3 interogari asupra bazei de date universitatea prezentate in capitolul 4 astfel ca numele tabelelor accesate sa fie descrise in mod explicit, tinand cont de faptul ca tabelele au fost mutate in scheme noi. 

-------------------3. Aflati cursurile (Disciplina) predate de fiecare profesor (Nume_Profesor, Prenume_Profesor) sortate descrescator dupa nume si apoi prenume. 

select distinct d.Disciplina, p.Nume_Profesor, p.Prenume_Profesor
from plan_studii.discipline as d join studenti.studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join cadre_didactice.profesori as p
on r.Id_Profesor=p.Id_Profesor
order by p.Nume_Profesor desc, p.Prenume_Profesor desc;

-------------------4. Afisati care dintre discipline au denumirea formata din mai mult de 20 de caractere? 

select disciplina
from plan_studii.discipline
where len(disciplina)>20;

-------------------5. Sa se afiseze lista studentilor al caror nume se termina in ,,u" 

select nume_student, prenume_student
from studenti.studenti
where Nume_Student like '%u';

-------------------20. Afisati numarul de studenti care au sustinut testul (Testul 2) la disciplina Baze de date in 2018.

select count(distinct r.id_student) as nr_students
from studenti.studenti_reusita as r join plan_studii.discipline as d
on r.Id_Disciplina=d.Id_Disciplina
where r.Tip_Evaluare='Testul 2'and d.Disciplina='Baze de date' and r.Data_Evaluare like '2018%';

--8. Creati sinonimele respective pentru a simplifica interogarile construite in exercitiul precedent ~i reformulati interogarile, folosind sinonimele create.

-- Create a synonym for tables.
CREATE SYNONYM discipline  
FOR plan_studii.discipline; 
GO  

CREATE SYNONYM reusita  
FOR studenti.studenti_reusita; 
GO

CREATE SYNONYM studenti  
FOR studenti.studenti; 
GO  

CREATE SYNONYM profesori  
FOR cadre_didactice.profesori; 
GO  
-- Query by using the synonym.  
select distinct d.Disciplina, p.Nume_Profesor, p.Prenume_Profesor
from discipline as d join reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join profesori as p
on r.Id_Profesor=p.Id_Profesor
order by p.Nume_Profesor desc, p.Prenume_Profesor desc;

select disciplina
from discipline
where len(disciplina)>20;

select nume_student, prenume_student
from studenti
where Nume_Student like '%u';