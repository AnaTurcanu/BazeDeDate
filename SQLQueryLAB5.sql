--1.Completați următorul cod pentru a afișa cel mai mare număr dintre cele trei numere prezentate:
DECLARE @N1 INT, @N2 INT, @N3 INT;
DECLARE @MAI_MARE INT;
SET @N1 = 60 * RAND()
SET @N2 = 60 * RAND()
SET @N3 = 60 * RAND()
if @N1 > @N2 set @MAI_MARE = @N1
else set @MAI_MARE = @N2
if @N2 > @N3 set @MAI_MARE = @N2
else set @MAI_MARE = @N3
if @N3 > @N1 set @MAI_MARE = @N3
else set @MAI_MARE = @N1
PRINT @N1;
PRINT @N2;
PRINT @N3;
PRINT 'Mai mare = ' + CAST(@MAI_MARE AS VARCHAR(2));

--2.Afișati primele zece date (numele, prenumele studentului) în funcție de valoarea notei (cu exceptia notelor 6 și 8) a studentului la primul test al disciplinei 
--Baze de date, folosind structura de altemativă IF...ELSE. Să se folosească variabilele.

declare @IgnoreMark_01 int = 6;
declare @IgnoreMark_02 int = 8;

select  top (30) Nume_Student, Prenume_Student, Nota
from studenti, studenti_reusita, discipline
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and studenti.Id_Student = studenti_reusita.Id_Student
and Disciplina = 'Baze de date'
and Tip_Evaluare = 'Testul 1'
and Nota = IIF(Nota != @IgnoreMark_01 AND Nota != @IgnoreMark_02, Nota, 0);

--3.Rezolvati acee~i sarcina, 1, apeland la structura selectiva CASE.

set @Nl = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand();
set @MAI_MARE = @Nl;
set @MAI_MARE = case 
when @MAI_MARE < @N3 and @N2<@N3 then  @N3
when  @MAI_MARE < @N2 and @N3 < @N2 then  @N2
else @MAI_MARE
end   
print @Nl;
print @N2;
print @N3;
print 'Mai mare = ' + cast( @MAI_MARE as varchar(2));

--4.Modificați exercițiile din sarcinile 1 și 2 pentru a include procesarea erorilor cu TRY și CATCH și RAISERROR.

begin try
DECLARE @N1 INT, @N2 INT, @N3 INT;
DECLARE @MAI_MARE INT;
SET @N1 = 60 * RAND()
SET @N2 = 60 * RAND()
SET @N3 = 60 * RAND()
if @N1 > @N2 and @N1 > @N3 set @MAI_MARE = @N1
else if @N2 > @N1 and @N2 > @N3 set @MAI_MARE = @N2
else if @N3 > @N1 and @N3 > @N2 set @MAI_MARE = @N3
else
raiserror('Asa valoare a fost declarata de 2 ori', 16, 1);
end try
begin catch
print ' ERROR :' + cast(ERROR_LINE() as varchar(20));
end catch
PRINT @N1;
PRINT @N2;
PRINT @N3;
PRINT 'Mai mare = ' + CAST(@MAI_MARE AS VARCHAR(2));

