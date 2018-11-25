
select * from discipline;
select * from grupe;
select * from profesori;
select * from studenti;
select * from studenti_reusita;

--1. Aflafi toate datele despre grupele de studii de la facultate.
 
select * 
from grupe;

--2. Sa se obtina lista disciplinelor in ordine descrescatoare a numarului de ore. 

select * 
from discipline
order by Nr_ore_plan_disciplina desc;

--3. Aflati cursurile (Disciplina) predate de fiecare profesor (Nume_Profesor, Prenume_Profesor) sortate descrescator dupa nume si apoi prenume. 

select distinct d.Disciplina, p.Nume_Profesor, p.Prenume_Profesor
from discipline as d join studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join profesori as p
on r.Id_Profesor=p.Id_Profesor
order by p.Nume_Profesor desc, p.Prenume_Profesor desc;

--4. Afisati care dintre discipline au denumirea formata din mai mult de 20 de caractere? 

select disciplina
from discipline
where len(disciplina)>20;

--5. Sa se afiseze lista studentilor al caror nume se termina in ,,u" 

select nume_student, prenume_student
from studenti
where Nume_Student like '%u';

--6. Afisati numele si prenumele primilor 5 studenti, care au obtinut note in ordine descrescatoare la al doilea test de la disciplina Baze de date. Sa se foloseasca optiunea TOP ... WITH TIES. 

select top(5) with ties s.nume_student, s.prenume_student 
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
where r.Tip_Evaluare='Testul 2' and d.Disciplina='Baze de date'
order by r.Nota desc


--7. In ce grupa (Cod_ Grupa) invata studentii care locuiesc pe strada 31 August? 

select distinct g.Cod_Grupa
from grupe g join studenti_reusita r
on g.Id_Grupa=r.Id_Grupa
join studenti s
on r.Id_Student=s.Id_Student
where s.Adresa_Postala_Student like '%31 August%';

--8. Obtineti identificatorii si numele studentilor, ale examenelor sustinute in anul 2018. 

select r.Id_Student, (s.Nume_Student+' '+s.Prenume_Student) as nume
from studenti_reusita r join studenti s
on r.Id_Student=s.Id_Student
where r.Data_Evaluare like '2018%' and r.Tip_Evaluare='Examen';

--9. Gasiti numele, adresa studentilor si codul disciplinei la care studentii au avut cel putin o nota mai mare decat 8 in 2018. 

select distinct (s.Nume_Student+' '+s.Prenume_Student) as nume, s.Adresa_Postala_Student, r.Id_Disciplina
from studenti_reusita r join studenti s
on r.Id_Student=r.Id_Student
where r.Nota>8 and r.Data_Evaluare like '2018%';

--10. Gasiti studentii (numele, prenumele), care au obtinut la disciplina Baze de date (examen), in anul 2018, vreo nota mai mica de 8 si mai mare ca 4. 

select s.Nume_Student, s.Prenume_Student 
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
where d.Disciplina='Baze de date' and r.Data_Evaluare like '2018%' and r.nota between 4 and 8 and r.Tip_Evaluare='Examen';

--11. Furnizati numele si prenumele profesorilor, care au predat disciplina Baze de date, in 2018, si au evaluat vreun student cu nota nesatisracatoare la reusita curenta. 

select distinct p.Nume_Profesor, p.Prenume_Profesor
from studenti_reusita r join profesori p
on r.Id_Profesor=p.Id_Profesor
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
where d.Disciplina='Baze de date' and r.Data_Evaluare like '2018%' and r.nota<5;

--12. Furnizati, in evidenta academica (reusita) a studentilor cu prenumele Alex, urmatoarele date: numele, prenumele, denumirea disciplinei, notele (inclusiv la probele intermediare) si anul la care au sustinut.

select s.Nume_Student, s.Prenume_Student, d.Disciplina, r.Nota, year(r.Data_Evaluare)
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
 
--13. Aflati cursurile urmate de catre studentul Florea loan. 

select distinct d.Disciplina
from discipline d join studenti_reusita r
on d.Id_Disciplina=r.Id_Disciplina
join studenti s
on r.Id_Student=s.Id_Student
where s.Nume_Student='Florea' and s.Prenume_Student='Ioan';

--14. Aflati numele si prenumele studentilor, precum si cursurile promovate cu note mai mari de 8 la examen. 

select s.Nume_Student, s.Prenume_Student, d.Disciplina
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
where r.Nota>8 and r.Tip_Evaluare='Examen';

--15. Gasiti numele si prenumele studentilor, care au sustinut examen atat la profesorul Ion, cat si la profesorul Gheorge in anul 2017 (folositi pentru nume clauza LIKE) 

select s.Nume_Student, s.Prenume_Student
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
join profesori p
on r.Id_Profesor=p.Id_Profesor
where r.Data_Evaluare like '2017%' and r.Tip_Evaluare='Examen' and (p.Prenume_Profesor+' '+p.Nume_Profesor) like 'Ion%' and (p.Prenume_Profesor+' '+p.Nume_Profesor) like 'George'

--16. Furnizati numele si prenumele studentilor, care au studiat discipline cu un volum de lectii mai mic de 60 de ore, precum si profesorii (identificatorii) respectivi, care le-au predat. 

select distinct s.Nume_Student, s.Prenume_Student, r.Id_Profesor
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
where d.Nr_ore_plan_disciplina<60;

--17. Afisati numele si pronumele profesorilor, care au predat cel putin o disciplina studentului cu identificatorul 100. 

select distinct p.Nume_Profesor, p.Prenume_Profesor
from profesori p join studenti_reusita r
on p.Id_Profesor=r.Id_Profesor
where r.Id_Student=100;

--18. Afisati numele si prenumele profesorilor, care au predat doar discipline cu o incarcare orara mai mica de 60 de ore. 

select distinct p.Nume_Profesor, p.Prenume_Profesor
from profesori p join studenti_reusita r
on p.Id_Profesor=r.Id_Profesor
join discipline d
on r.Id_Disciplina=d.Id_Disciplina
where d.Nr_ore_plan_disciplina<60;

--19. Gasiti numele si prenumele profesorilor, care au predat discipline, in care studentul "Cosovanu" a fost respins (nota <5) la cel putin o proba. 

select (p.Nume_Profesor + ' ' + p.Prenume_Profesor) as prof_name, r.nota as "Cosovanu's grade"
from profesori as p join studenti_reusita as r
on p.Id_Profesor=r.Id_Profesor
 join studenti as s
on r.Id_Student=s.Id_Student
where s.Nume_Student='Cosovanu' and r.nota<5;

--20. Afisati numarul de studenti care au sustinut testul (Testul 2) la disciplina Baze de date in 2018.

select count(distinct r.id_student) as nr_students
from studenti_reusita as r join discipline as d
on r.Id_Disciplina=d.Id_Disciplina
where r.Tip_Evaluare='Testul 2'and d.Disciplina='Baze de date' and r.Data_Evaluare like '2018%';
 
--21. Cate note are fiecare student? Furnizati numele si prenumele lor. 

select s.Nume_Student, s.Prenume_Student, count(r.nota) as "No. of grades"
from studenti_reusita as r join studenti as s
on r.Id_Student=s.Id_Student
group by s.Nume_Student, s.Prenume_Student;

--22. Sa se obtina numarul de discipline predate de fiecare profesor (Nume_Profesor, Prenume _ Profesor). 

select p.Nume_Profesor, p.Prenume_Profesor, count(distinct r.id_disciplina) as "No. of disciplines"
from studenti_reusita as r join profesori as p
on r.Id_Profesor=p.Id_Profesor
group by p.Nume_Profesor, p.Prenume_Profesor;

--!!!23. Sa se obtina lista disciplinelor (Disciplina) sustinute de studenti cu nota medie de promovare la examen mai mare de 7, in ordine descrescatoare dupa denumirea disciplinei. 

select distinct d.Disciplina 
from discipline as d join studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join
(select Id_Student, avg(nota) as average_grade from studenti_reusita where Tip_Evaluare='Examen' group by id_student) as t
on r.Id_student=t.Id_Student
where t.average_grade>7
order by d.disciplina desc;


--24. Sa se afiseze lista disciplinelor (Disciplina) predate de cel putin doi profesori. 

select distinct d.Disciplina
from discipline as d join studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
group by d.Disciplina
having count(distinct r.Id_Profesor)>2; --Checked: (Id_Disciplina for "Practica de productie": 118, and Id_profesor: 118 and 128)

--25. In ce grupe de studii (Cod_ Grupa) figureaza mai mult de 24 de studenti?

select grupe.cod_grupa, count(distinct reusita.id_student) as nr_students 
from studenti_reusita as reusita join grupe 
on reusita.Id_Grupa=grupe.Id_Grupa
group by grupe.cod_grupa
having count(distinct reusita.id_student)>24;

--26. Gasiti numele, prenumele si adresele studentilor si ale profesorilor care locuiesc pe strada 31 August. 

Select s.Adresa_Postala_Student, s.Nume_Student, s.Prenume_Student
from studenti as s
where s.Adresa_Postala_Student like '%31 August%'
Union
Select p.Adresa_Postala_Profesor, p.Nume_Profesor, p.Prenume_Profesor
from profesori as p 
where p.Adresa_Postala_Profesor like '%31 August%';

--27. Afisati studentii (identificatorii) care au sustinut (evaluare examen) la toate disciplinele predate de prof. lon. 

select distinct id_student
from studenti_reusita
where Id_Disciplina in 
(select r.Id_Disciplina
from studenti_reusita as r join profesori as p
on r.Id_Profesor=p.Id_Profesor
where p.Prenume_Profesor='Ion') and Nota>=5 and Tip_Evaluare='Examen'
order by Id_Student;

--28. Gasiti numele, prenumele si media grupei studentilor care au sustinut toate disciplinele predate de profesorii ce locuiesc pe strada 31 August. 

select distinct s.Nume_Student, s.Prenume_Student, r.Id_Grupa, t.Media_grupei
from studenti as s join studenti_reusita as r
on s.Id_Student=r.Id_Student
join(select id_grupa, avg(nota) as Media_grupei from studenti_reusita group by Id_Grupa) as t
on r.Id_Grupa=t.Id_Grupa
where r.Id_Disciplina in (select r.Id_Disciplina
							from studenti_reusita as r join profesori as p
							on r.Id_Profesor=p.Id_Profesor
							where p.Adresa_Postala_Profesor like '%Chisinau%'); --could've been done through another join as well

--29. Determinati numele si prenumele studentilor, care au sustinut examene cu o nota mai mica decat oricare dintre notele studentilor cu identificatorul l 00. 

select distinct s.Nume_Student, s.Prenume_Student
from studenti as s join studenti_reusita as r
on s.Id_Student=r.Id_Student
where r.Nota < any (select nota 
					from studenti_reusita 
					where Id_Student=100);

--30. Cati studenti au studiat, deja, disciplina Baze de date in 2018 si 2019 si care este media lor la reusita curenta? 

select count(x.Id_Student) "No of students", avg(x.reusita_curenta) "Media curenta totala"
from
(select distinct r.Id_Student, t.reusita_curenta
from studenti_reusita r join discipline d
on r.Id_Disciplina=d.Id_Disciplina
join (select r.id_student, avg(r.nota) as reusita_curenta
	  from studenti_reusita r
	  where r.Tip_Evaluare='Reusita curenta'
	  group by r.Id_Student) as t
on r.Id_Student=t.Id_Student
where d.Disciplina='Baze de date' and r.Data_Evaluare like '2018%' and r.Data_Evaluare like '2019%' 
) as x  --TO SEE RESULTS: change to 2017 and 2018, and don't select 2018

--31. Fumizati numele si prenumele studentilor, care au avut mai mult de doua dezaprobari intr-un an la o disciplina. 

select Nume_Student, Prenume_Student,Id_Disciplina
from studenti_reusita r
join studenti s on r.Id_Student = s.Id_Student
where r.Nota <= 4
group by Nume_Student,Prenume_Student,Id_Disciplina
having count(r.nota)>2

--32. Fumizati numele, prenumele si media notelor pe grupe pentru studenti 

select s.Nume_Student, s.Prenume_Student, avg(r.Nota) as Media, r.Id_Grupa
from studenti s join studenti_reusita r
on s.Id_Student=r.Id_Student
group by s.Nume_Student, s.Prenume_Student, r.Id_Grupa

--33. Gasiti numele ~i prenumele studentilor, care nu au luat nota. de promovare la reu~ita curenta la nicio disciplina. 
--34. Gasiti numele ~i prenumele studentilor, care nu au luat note de promovare (inclusiv note intermediare) la nicio disciplina. 
--35. Gasiti denumirile disciplinelor ~i media notelor pe disciplina. Afi~ati numai disciplinele cu medii mai mari de 7.0. 
--36. Gasiti numele, prenumele si adresele studentilor si ale profesorilor care locuiesc 'intr-o localitate. Sa se afiseze denumirea localitatii si numarul de locuitori inclu~i 'in cele doua categorii. Datele se afi~eaza 'in ordinea crescatoare a numarului membrilor din categoria mentionata anterior.
--37. Gasiti disciplina sustinuta de studenti cu nota medie (la examen) cea mai inalta. 
--38. Furnizati denumirile disciplinelor cu o medie mai mica decat media notelor de la disciplina Baze de date. 
--39. Gasiti denumirile disciplinelor la care nu au sustinut examenul, in medie, peste 5% de studenti. 

