### ex1 
 ## ** Completati urmatorul cod pentru a afisa eel mai mare numar dintre cele trei numere prezentate: DECLARE @Nl INT, @N2 INT, @N3 INT; 
												      DECLARE @MAI_MARE INT; 
												      SET @Nl = 60 * RAND(); 
												      SET @N2 = 60 * RAND(); 
												      SET @N3 = 60 * RAND(); 
												      -- Aici ar trebui plasate IF-urile 
												      PRINT @Nl; PRINT @N2; PRINT @N3; PRINT 'Mai mare = ' + CAST(@MAI_MARE AS VARCHAR(2)); ** 


![image](https://github.com/AnaTurcanu/MSSQL/blob/master/lab5BD/Capture.PNG)

### ex2 
 ## ** Afisati primele zece date (numele, prenumele studentului) in functie de valoarea notei (cu exceptia notelor 6 si 8) a studentului 
       la primul test al disciplinei Baze de date, folosind structura de altemativa IF. .. ELSE. Sa se foloseasca variabilele.  ** 



![image](https://github.com/AnaTurcanu/MSSQL/blob/master/lab5BD/Capture1.PNG)


### ex3 
 ## ** Rezolvati aceeasi sarcina, 1, apeland la structura selectiva CASE.   ** 



![image](https://github.com/AnaTurcanu/MSSQL/blob/master/lab5BD/Capture2.PNG)


### ex4 
 ## ** Modificati exercitiile din sarcinile 1 si 2 pentru a include procesarea erorilor cu TRY si CATCH, si RAISERRROR.  ** 


![image](https://github.com/AnaTurcanu/MSSQL/blob/master/lab5BD/Capture3.PNG)
