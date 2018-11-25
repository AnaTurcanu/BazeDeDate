SELECT * FROM profesori;
--1. Sa se scrie o instructiune T-SQL, care ar popula co Joana Adresa _ Postala _ Profesor din tabelul profesori cu valoarea 'mun. Chisinau', unde adresa este necunoscuta. 

UPDATE profesori set Adresa_Postala_Profesor = 'mun.Chisinau'
				 where Adresa_Postala_Profesor IS NULL;

SELECT Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor
FROM profesori

--2. Sa se modifice schema tabelului grupe, ca sa corespunda urmatoarelor cerinte: 
----a) Campul Cod_ Grupa sa accepte numai valorile unice ~i sa nu accepte valori necunoscute.
----b) Sa se tina cont ca cheie primarii, deja, este definitii asupra coloanei Id_ Grupa.

ALTER TABLE grupe 
ADD UNIQUE (Cod_Grupa)
ALTER TABLE grupe 
ALTER COLUMN Cod_Grupa char(6) NOT NULL;

select Cod_Grupa
from grupe

-- 3. La tabelul grupe, sa se adauge 2 coloane noi Sef_grupa si Prof_Indrumator, ambele de tip INT. 
--   Sa se populeze campurile nou-create cu cele mai potrivite candidaturi in baza criteriilor de mai jos:
-- a) Seful grupei trebuie sa aiba cea mai buna reusita (medie) din grupa la toate formele de evaluare si la toate disciplinele.
--    Un student nu poate fi sef de grupa la mai multe grupe. 
-- b) Profesorul indrumator trebuie sa predea un numar maximal posibil de discipline la grupa data. 
--    Daca nu exista o singura candidatura, care corespunde primei cerinte, atunci este ales din grupul de candidati acel cu identificatorul (Id_Profesor) minimal. 
--    Un profesor nu poate fi indrumator la mai multe grupe.
-- c) Sa se scrie instructiunile ALTER, SELECT, UPDATE necesare pentru crearea coloanelor in tabelul grupe, pentru selectarea candidatilor si inserarea datelor.

ALTER TABLE grupe
ADD Sef_Grupa INT, Prof_Indrumator INT


DECLARE @nr_de_grupe INT = (select count (Id_Grupa) from grupe)
DECLARE @index INT = 1
DECLARE @sef_grupa INT

WHILE (@index <= @nr_de_grupe)
BEGIN 
UPDATE grupe

---- setare sef grupa 

set Sef_Grupa = (select top(1) Id_Student from
(select Id_Student, avg(Nota) as nrNota        --maybe use cast(Nota as float) for more precision
from studenti_reusita where Id_Grupa = @index group by Id_Student) as q1
order by q1.nrNota desc),

---- setare indrumator 

Prof_Indrumator = (select top(1) Id_Profesor from
(select Id_Profesor, count (distinct Id_Disciplina) as nr_Disciplina
from studenti_reusita where Id_Grupa = @index group by Id_Profesor) as q2
order by q2.nr_Disciplina desc) where Id_Grupa = @index;

set @index += 1;

END

select* from grupe;
alter table grupe drop column sef_grupa;
alter table grupe drop column prof_indrumator;
--4. Sa se scrie o instructiune T-SQL, care ar mari toate notele de evaluare sefilor de grupe cu un punct. Nota maximala (10) nu poate fi miirita.


----with CASE
  SELECT case nota when 10 then Nota
         else nota+1 end new_nota
  FROM studenti_reusita
  WHERE Id_Student IN
  (SELECT  Sef_Grupa
  FROM grupe);

----without CASE I
UPDATE studenti_reusita
set Nota += 1
where Id_Student = any (select Sef_Grupa from grupe) and nota != 10;

----without CASE II
UPDATE studenti_reusita 
SET Nota=Nota+1
WHERE Nota<>10 and Nota IN ( SELECT Nota
  FROM studenti_reusita
  WHERE Id_Student IN
  (SELECT  Sef_Grupa
  FROM grupe));

  SELECT * FROM studenti_reusita;


 -- 5. Sa se creeze un tabel profesori_new, care include urmatoarele coloane:
 --  Id_Profesor, Nume _ Profesor, Prenume _ Profesor, Localitate, Adresa _ 1, Adresa _2.
 --  a) Coloana Id_Profesor trebuie sa fie definita drept cheie primara si, in baza ei, sa fie construit un index CLUSTERED. 
 --  b) Campul Localitate trebuie sa posede proprietatea DEF A ULT= 'mun. Chisinau'.
 --  c) Sa se insereze toate datele din tabelul profesori in tabelul profesori_new. Sa se scrie, cu acest scop, un numar potrivit de instructiuni T-SQL.
 --  in coloana Localitate sii fie inserata doar informatia despre denumirea localitatii din coloana-sursa Adresa_Postala_Profesor. in coloana Adresa_l,
 --  doar denumirea strazii. in coloana Adresa_2, sa se pastreze numarul casei si (posibil) a apartamentului.

create table profesori_new
	(Id_Profesor int NOT NULL, Nume_Profesor char(255), Prenume_Profesor char(255), Localitate char (255) DEFAULT ('mun. Chisinau'),
	Adresa_1 char (255), Adresa_2 char (255), CONSTRAINT [PK_profesori_new] PRIMARY KEY CLUSTERED (Id_Profesor)) ON [PRIMARY]

select * from profesori_new;

insert profesori_new (Id_Profesor,Nume_Profesor, Prenume_Profesor, Localitate,Adresa_1, Adresa_2)
	(SELECT Id_Profesor, Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor
	from profesori)

UPDATE profesori_new
	SET Localitate = (case when CHARINDEX(', s.',Localitate) > 0
				               then case when CHARINDEX (', str.',Localitate) > 0 
				                             then SUBSTRING (Localitate, 1, CHARINDEX (', str.',Localitate) -1)
					                     when CHARINDEX (', bd.',Localitate) > 0 
							                 then SUBSTRING (Localitate, 1, CHARINDEX (', bd.',Localitate) -1)
				           end
				           when  CHARINDEX(', or.',Localitate) > 0
				               then case when CHARINDEX (', str.',Localitate) > 0 
							                 then SUBSTRING (Localitate,1, CHARINDEX ('str.',Localitate) -3)
					                     when CHARINDEX (', bd.',Localitate) > 0 
										     then SUBSTRING (Localitate,1, CHARINDEX ('bd.',Localitate) -3)
					       end
				           when CHARINDEX('mun.',Localitate) > 0 
						       then SUBSTRING(Localitate, 1, CHARINDEX('nau',Localitate)+2)
				end),
	Adresa_1 = (case when CHARINDEX('str.', Adresa_1) > 0
					     then SUBSTRING(Adresa_1,CHARINDEX('str',Adresa_1), PATINDEX('%, [0-9]%',Adresa_1)- CHARINDEX('str.',Adresa_1))
			         when CHARINDEX('bd.',Adresa_1) > 0 
					     then SUBSTRING(Adresa_1,CHARINDEX('bd',Adresa_1), PATINDEX('%, [0-9]%',Adresa_1) -  CHARINDEX('bd.',Adresa_1))
			   end),
	Adresa_2 = case when PATINDEX('%, [0-9]%',Adresa_2) > 0
					    then SUBSTRING(Adresa_2, PATINDEX('%, [0-9]%',Adresa_2) +1,len(Adresa_2) - PATINDEX('%, [0-9]%',Adresa_2) +1)
				end

--6. Sa se insereze datele in tabelul orarul pentru Grupa= 'CIBJ 71' (Id_ Grupa= 1) pentru ziua de luni. Toate lectiile vor avea loc in blocul de studii 'B'. 
--Mai jos, sunt prezentate detaliile de inserare: (ld_Disciplina = 107, Id_Profesor= 101, Ora ='08:00', Auditoriu = 202); 
--(Id_Disciplina = 108, Id_Profesor= 101, Ora ='11:30', Auditoriu = 501); (ld_Disciplina = 119, Id_Profesor= 117, Ora ='13:00', Auditoriu = 501);

CREATE TABLE orarul ( Id_Disciplina INT, Id_Profesor INT, Id_Grupa INT DEFAULT(1), Zi CHAR(255), Ora TIME, Auditoriu INT,
					  Bloc CHAR(1) DEFAULT('B'), PRIMARY KEY (Id_Grupa, Zi, Ora))

INSERT INTO orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       VALUES ( 107, 101, 'Lu','08:00', 202 )
INSERT INTO orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       VALUES ( 108, 101, 'Lu','11:30', 501 )
INSERT INTO orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       VALUES ( 109, 117, 'Lu','13:00', 501 )

SELECT * FROM orarul;

DROP TABLE orarul;

---- 7. Sa se scrie expresiile T-SQL necesare pentru a popula tabelul orarul pentru grupa INFl 71 , ziua de luni.
--Datele necesare pentru inserare trebuie sa fie colectate cu ajutorul instructiunii/instructiunilor 
--SELECT ~i introduse in tabelul-destinatie, ~tiind ca: lectie #1 (Ora ='08:00', Disciplina = 'Structuri de date si algoritmi', Prof esor ='Bivol Ion')
-- lectie #2 (Ora ='11 :30', Disciplina = 'Programe aplicative', Profesor ='Mircea Sorin') lectie #3 (Ora ='13:00', Disciplina ='Baze de date', Profesor = 'Micu Elena')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '08:00')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '11:30')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '13:00')

--8. Sa se scrie interogarile de creare a indecsilor asupra tabelelor din baza de date universitatea pentru a asigura o performanta sporita la executarea interogarilor 
--SELECT din Lucrarea practica 4. Rezultatele optimizarii sa fie analizate in baza planurilor de executie, pana la si dupa crearea indecsilor. 
--Indecsii nou-creati sa fie plasati fizic in grupul de fisiere userdatafgroupl (Crearea $i intrefinerea bazei de date - sectiunea 2.2.2)

ALTER DATABASE universitatea ADD FILE ( NAME = Indexes, FILENAME = 'd:\indexes_universitateaDB.ndf', SIZE = 1MB)
TO FILEGROUP userdatafgroupl GO

DROP index pk_discipline on discipline

CREATE nonclustered index pk_id_disciplina ON discipline (id_disciplina)

DROP index pk_grupe on grupe

CREATE nonclustered index pk_id_grupa ON grupe (id_grupa)

DROP index pk_profesori on profesori

CREATE nonclustered index pk_id_profesor ON profesori (id_profesor)

DROP index pk_studenti on studenti

CREATE nonclustered index pk_id_student ON studenti (id_student)





















DROP INDEX pk_discipline on discipline

ALTER DATABASE universitatea
ADD FILEGROUP userdatafgroupl
GO

ALTER DATABASE universitatea
ADD FILE
( NAME = Indexes,
FILENAME = 'd:\db.ndf',
SIZE = 1MB
)
TO FILEGROUP userdatafgroupl
GO

CREATE NONCLUSTERED INDEX pk_id_disciplina1 ON
discipline (id_disciplina)
ON [userdatafgroupl]