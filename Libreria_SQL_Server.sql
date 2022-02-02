--Está verificado con los PDF de la UTN
--J:\Dev\TSP - SQL Server\02 Segundo Cuatrimestre\Segunda Unidad 2019\Practicos
--GUIA DE EJERCICIOS 02 --------------------------------------------------------------

--1) Liste Código, descripción, stock mínimo y precio de todos los artículos, ordenados por precio y descripción.
--Rotule (alias) como CÓDIGO DE ARTICULO, DESCRIPCION, STOCK MíNIMO y PRECIO UNITARIO.

select a.cod_articulo 'CÓDIGO DE ARTICULO', a.descripcion 'DESCRIPCION', a.stock_minimo'STOCK MíNIMO' , a.pre_unitario 'PRECIO UNITARIO'
from articulos a
order by a.pre_unitario asc, a.descripcion asc


--2) Se quiere listar todos los datos de los clientes con número de teléfono conocidos.
--Muestre el nombre y apellido en una misma columna. Ordene por nombre completo. Rotule en forma conveniente.

select c.cod_cliente, c.nom_cliente +space(5)+ c.ape_cliente 'Nombre Completo',c.calle,c.altura,c.nro_tel,c.[e-mail]
from clientes c
where c.nro_tel is not null
order by 'Nombre Completo' asc


--3) Se quiere saber el subtotal de todos los artículos vendidos, para ello liste el código y
--multiplique la cantidad por el precio unitario (de la tabla: detalle_facturas). 
--Ordene por código en forma ascendente y subtotal en forma descendente. 
--No muestre datos duplicados.

select distinct df.cod_articulo, df.cantidad * df.pre_unitario 'Subtotal de articulos vendidos'
from detalle_facturas df
order by df.cod_articulo asc, 'Subtotal de articulos vendidos' desc


--4) Muestre el código, nombre, apellido y dirección (calle y altura, en altura utilice una función de conversión)
--de todos los clientes cuyo nombre comience con C y cuyo apellido termine con Z.
--Rotule como CÓDIGO DE CLIENTE, NOMBRE, DIRECCIÓN.


select c.cod_cliente 'CODIGO DE CLIENTE', c.nom_cliente 'NOMBRE', c.ape_cliente, c.calle +space(2) +cast(c.altura as varchar(5)) 'Direccion'
from clientes c
where c.nom_cliente like 'c%'
and c.ape_cliente like '%z'


--5) Ídem al anterior pero el apellido comience con letras que van de la D a la L y cuyo nombre no comience con letras que van dela A a la G.

select c.cod_cliente 'CODIGO DE CLIENTE', c.nom_cliente 'NOMBRE', c.ape_cliente, c.calle +space(2) +cast(c.altura as varchar(5)) 'Direccion'
from clientes c
where c.nom_cliente not like '[a-g]%'
and c.ape_cliente like '[d-l]%'


--6) Liste los artículos cuyo precio sea menor a 40 y sin observaciones.
--Ordene por descripción y precio ambos descendente.

select *
from articulos a
where a.pre_unitario < 40
and a.observaciones is NULL
order by a.descripcion desc, a.pre_unitario desc


--7) Muestre los datos de los vendedores cuyo nombre no contenga Z y cuya fecha de nacimiento sea posterior a 1/1/1970.

select *
from vendedores v
where v.nom_vendedor not like '%z%'
and v.fec_nac > '1970-01-01'


--8) Mostrar las facturas realizadas entre el 1/1/2007 y el 1/5/2009 y
--cuyos códigos de vendedor sean 1, 3 y 4
--o bien entre el 1/1/2010 y el 1/5/2011 y cuyos códigos de vendedor sean 2 y 4.

select *
from facturas f
where (f.fecha between '2007-01-01' and '2009-05-01'
and f.cod_vendedor in (1,3,4)
or  f.fecha between '2010-01-01' and '2011-05-01'
and f.cod_vendedor in (2,4) )


--9) Muestre las ventas (tabla detalle_facturas) de los artículos cuyo precio unitario sea mayor o igual a 10 
--o cuyos códigos de artículos no sea uno de los siguientes: 2,5, 6, 8, 10.
--En ambos casos que los números de facturas oscilen entre 50 y 100.  "Atención a los ()"

select *
from detalle_facturas df
where (df.pre_unitario >= 10
or df.cod_articulo not in (2,5,6,8,10))
and df.nro_factura between 50 and 100


--10) Listar todos los datos de los artículos cuyo stock mínimo sea superior a 10 o cuyo precio sea inferior a 20.
--En ambos casos su descripción no debe comenzar con las letras P ni la letra R.

select *
from articulos a
where (a.stock_minimo > 10
or a.pre_unitario < 20)
and a.descripcion not like '[c~l]%' -- se usa ~ para uno u otro, - es para rangos, verificado por mi
order by descripcion asc


--11) Listar los datos de los vendedores pero la fecha de nacimiento en
--columnas diferentes día, mes y año. Rotular

select v.nom_vendedor, v.ape_vendedor,day(v.fec_nac)'Día',month(v.fec_nac)'Mes', year(v.fec_nac) 'Año'
from vendedores v


--12) Mostrar todos los datos de las facturas realizadas durante el año en curso;
--luego las del año pasado.

select *
from facturas f
where year(f.fecha) = year(getdate()) -4  -- el -4 va afuera del parentesis ya que year es el número, no getdate, este da una fecha completa


--13) Listar los datos de los vendedores nacidos en febrero, abril, mayo o septiembre.

select *
from vendedores v
where month(v.fec_nac) in (2,4,5,9)


--14) Listar los datos de los clientes: el apellido y nombre en la misma columna,
--separados por 5 espacios y el apellido en mayúscula.

select upper(c.ape_cliente) +space(5)+ c.nom_cliente 'Cliente'
from clientes c





--GUIA DE EJERCICIOS 03 - Composición Simple --------------------------------------------------------------

--1)Liste número de factura, fecha de venta y vendedor(apellido y nombre) para los casos en que el código del cliente oscile entre 2 y 6.
--Ordene por vendedor y fecha, ambas en forma descendente.

select f.nro_factura, f.fecha, v.ape_vendedor+space(2)+v.nom_vendedor 'Vendedor'
from facturas f, vendedores v
where f.cod_vendedor = v.cod_vendedor
and f.cod_cliente between 2 and  6
order by 'Vendedor' desc, f.fecha desc


--2)Liste el número de factura, el nombre y apellido del cliente y del vendedor y la fecha; 
--para los casos en que la fecha de vta oscile entre el 1/02/2008 y el 1/03/2010
--y que el apellido del cliente no contenga C
















































































