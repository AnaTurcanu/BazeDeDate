
--1--

 sp_dropdevice device01

EXEC sp_addumpdevice 'DISK','device01','C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVEREXE\MSSQL\Backup\universitatea.bak'
GO
BACKUP DATABASE universitatea 
TO device01  
   WITH FORMAT, 
      NAME = 'Full Backup of universitatea'; 

--2--

 sp_dropdevice device02

EXEC sp_addumpdevice 'DISK','device02','C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVEREXE\MSSQL\Backup\universitatea_diff.bak'

	BACKUP DATABASE universitatea TO device02 WITH DIFFERENTIAL


--3--

 sp_dropdevice device03


EXEC sp_addumpdevice 'DISK','BACKUP_LOG','C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVEREXE\MSSQL\Backup\universitatea_log.bak'

BACKUP LOG universitatea
TO BACKUP_LOG
WITH FORMAT, 
      NAME = 'Transactions Log Backup of universitatea'
