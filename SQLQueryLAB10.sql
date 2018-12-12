
create procedure lab10_ex1
@vechi int,
@nou int,
@auditoriu_vechi int output,
@auditoriu_nou int output
as
select @auditoriu_vechi = (select auditoriu from orarul where Auditoriu=@vechi)
select @auditoriu_nou = (select auditoriu from orarul where Auditoriu=@nou)


create trigger inregistratre_noua on orarul
after update 
as --set nocount on
if update(Auditoriu)
declare @auditoriu_vechi int, @auditoriu_nou int
 select 'The '+ upper(d.Disciplina) + 'course from ' + cast(orarul.Zi as varchar(20)) +', ' + cast(orarul.ora as varchar(20)) + ' of ' + 
 Cast(grupe.Cod_Grupa as varchar(20)) + ' from ' + cast(orarul.bloc as varchar(1))  + cast(@auditoriu_vechi as varchar(20)) + 'to ' + cast(@auditoriu_nou as varchar(20))
 from orarul join grupe on orarul.Id_Grupa=grupe.Id_Grupa join discipline d on orarul.Id_Disciplina=d.Id_Disciplina

 
 update orarul set auditoriu = @change

 create 

 DROP TRIGGER IF EXISTS inregistrare_noua 
GO
CREATE TRIGGER inregistrare_noua ON orarul
AFTER UPDATE
AS SET NOCOUNT ON
IF UPDATE(Auditoriu)
SELECT 'Lectia la disciplina ' + UPPER(discipline.Disciplina)+ ', a grupei ' + grupe.Cod_Grupa +
		', ziua de ' + CAST(inserted.Zi as VARCHAR(5)) + ', de la ora ' + CAST(inserted.Ora as VARCHAR(5))
		+ ', a fost transferata in aula ' + CAST(inserted.Auditoriu as VARCHAR(5)) + ', Blocul '+
		CAST(inserted.Bloc as VARCHAR(5)) + '. Auditoriul vechi: ' + CAST(deleted.Auditoriu as VARCHAR(5))+
		', Auditoriul nou: ' + CAST(inserted.Auditoriu as VARCHAR(5)) as Mesaj
FROM inserted, deleted, discipline, grupe
WHERE deleted.Id_Disciplina = discipline.Id_Disciplina
AND inserted.Id_Grupa = grupe.Id_Grupa
GO

update orarul set Auditoriu=520 where zi='Lu'

select * from orarul
select * from studenti.studenti_reusita


-------------------------------------------------------------------------------------
drop trigger lab10_ex2
CREATE TRIGGER lab10_ex2 ON studenti.studenti_reusita
INSTEAD OF INSERT
AS SET NOCOUNT ON

  
 if exists (SELECT * FROM inserted
  WHERE Id_Student in (SELECT Id_Student FROM studenti.studenti))
begin
  INSERT INTO studenti.studenti_reusita
  SELECT * FROM inserted
  WHERE Id_Student in (SELECT Id_Student FROM studenti.studenti)

  end
else
begin
   print'The student is not inserted, because it does not exist in studenti table!'
end
  
  
  INSERT INTO studenti.studenti_reusita values (235, 101, 101, 1, 'Testul 1', 9, null)
  
  INSERT INTO studenti values (234,'AAA', 'BBB', '1999-11-18', null)

  INSERT INTO studenti.studenti_reusita values (176, 101, 101, 1, 'Testul 1', 9, null)

  INSERT INTO studenti values (176,'AAA', 'BBB', '1999-11-18', null)

 -- delete from studenti where Id_Student = 200
  select * from studenti where Id_Student= 200
  select * from studenti.studenti_reusita where Id_Student = 234

------------------------------------------------------------------------------------

select * from studenti.studenti_reusita