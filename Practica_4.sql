select * from Aula
select * from Curso1
select * from Empleado
select * from Estudiante
select * from Horario
select * from Materia

insert into Estudiante (Matricula, Nombres, Apellido_paterno, Apellido_Materno, Correo, Telefono, Fecha_ingreso, Colonia, Numero, Calle, Fecha_nacimiento, Edad, Semestre) values (newid(),'Pepe', 'Castañeda', 'Reyes', 'pepin16@yahoo.com','001' , '2000-01-01', 'Las puentes', '16', 'Las arboledas', '1999-03-01', '1', '1')
insert into Estudiante (Matricula, Nombres, Apellido_paterno, Apellido_Materno, Correo, Telefono, Fecha_ingreso, Colonia, Numero, Calle, Fecha_nacimiento, Edad, Semestre) values (newid(),'Alondra', 'Ramirez', 'Ramirez', 'alove@hotmail.com', '002',2017-04-17, 'Estanque', '88', 'Sta Catarina', 1999-12-24, '2', '1')
insert into Estudiante (Matricula, Nombres, Apellido_paterno, Apellido_Materno, Correo, Telefono, Fecha_ingreso, Colonia, Numero, Calle, Fecha_nacimiento, Edad, Semestre) values (newid(),'Salma','Quintanilla', 'Ramirez', 'cute2214@gmail.com', '003',2017-10-14, 'Poseidon', '20', 'Escobedo', 1999-11-01, '18', '3')
insert into Estudiante (Matricula, Nombres, Apellido_paterno, Apellido_Materno, Correo, Telefono, Fecha_ingreso, Colonia, Numero, Calle, Fecha_nacimiento, Edad, Semestre) values (newid(),'Alex', 'Rivera', '', 'alexx99@yahoo.com', '003',2016-05-26,'Canal de Pasas', '23', 'Monte olimpo', 1999-07-25,'19', '4')
insert into Estudiante (Matricula, Nombres, Apellido_paterno, Apellido_Materno, Correo, Telefono, Fecha_ingreso, Colonia, Numero, Calle, Fecha_nacimiento, Edad, Semestre) values (newid(),'Eminem', 'Johnson', 'Michaels', 'eminemiam@hotmail.com', '003',1981-09-09, 'Hollywood', '01', 'La famosa', 1984-10-31, '25','6')

insert into Materia (Id_materia, Hora_semanales, Semestre, Creditos) values (newid(), 8, 1, 3)
insert into Materia (Id_materia, Hora_semanales, Semestre, Creditos) values (newid(), 8, 1, 3)
insert into Materia (Id_materia, Hora_semanales, Semestre, Creditos) values (newid(), 9, 9, 2)
insert into Materia (Id_materia, Hora_semanales, Semestre, Creditos) values (newid(), 3, 4, 1)
insert into Materia (Id_materia, Hora_semanales, Semestre, Creditos) values (newid(), 5, 1, 3)

insert into Aula values (newid(), 45, 'Regular')
insert into Aula values (newid(), 30, 'Regular')
insert into Aula values (newid(), 35, 'Regular')
insert into Aula values (newid(), 30, 'Regular')
insert into Aula values (newid(), 40, 'Regular')

insert into Empleado (Id_empleado) values (newid())
insert into Empleado (Id_empleado) values (newid())
insert into Empleado (Id_empleado) values (newid())
insert into Empleado (Id_empleado) values (newid())
insert into Empleado (Id_empleado) values (newid())

insert into Horario (Id_horario, Hora_inicio, Hora_fin) values (newid(), '2017-01-01T00:07:00', '2017-01-01T00:10:00')
insert into Horario (Id_horario, Hora_inicio, Hora_fin) values (newid(), '2017-02-01T00:08:00', '2017-01-01T00:11:00')
insert into Horario (Id_horario, Hora_inicio, Hora_fin) values (newid(), '2017-03-01T00:09:00', '2017-01-01T00:12:00')
insert into Horario (Id_horario, Hora_inicio, Hora_fin) values (newid(), '2017-04-01T00:10:00', '2017-01-01T00:13:00')
insert into Horario (Id_horario, Hora_inicio, Hora_fin) values (newid(), '2017-05-01T00:11:00', '2017-01-01T00:14:00')

delete from Materia where Creditos = '3'
delete from Estudiante where Nombres = 'Pepe' AND Apellido_paterno = 'Castañeda' AND Apellido_materno = 'Reyes'
delete from Aula where Capacidad = '45'
delete from Horario where Id_horario = '88DD14CA-16B3-41B0-BAD2-1EA1FC85F70A'
delete from Estudiante where Colonia = 'Hollywood'

update Estudiante set Numero = '55' from Estudiante where Numero = '1'
update Estudiante set Edad = '18' from Estudiante where Nombres = 'Alondra' AND Apellido_paterno = 'Ramirez'
update Estudiante set Edad = '20' from Estudiante where Correo = 'pepin16@yahoo.com'
update Materia set Hora_semanales = '4' from Materia where Hora_semanales = '3'
update Aula set Capacidad = '40' from Aula where Capacidad = '35'
