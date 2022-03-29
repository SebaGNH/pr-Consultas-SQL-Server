--Está verificado con los PDF de la UTN
--se usa ~ para uno u otro, - es para rangos


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
and v.fec_nac > '01/01/1970'


--8) Mostrar las facturas realizadas entre el 1/1/2007 y el 1/5/2009 y
--cuyos códigos de vendedor sean 1, 3 y 4
--o bien entre el 1/1/2010 y el 1/5/2011 y cuyos códigos de vendedor sean 2 y 4.

select *
from facturas f
where (f.fecha between '01/01/2007'and '01/05/2009'
and f.cod_vendedor in (1,3,4)
or  f.fecha between '01/01/2010' and '01/05/2011'
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
where year(f.fecha) = year(getdate()) -1  -- el -1 va afuera del parentesis ya que year es el número, no getdate, este da una fecha completa


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

select f.nro_factura, c.nom_cliente + space (3) + c.ape_cliente 'Cliente', v.nom_vendedor +space(3)+ v.ape_vendedor 'Vendedor', f.fecha
from facturas f, clientes c, vendedores v
where f.cod_cliente = c.cod_cliente 
and f.cod_vendedor = v.cod_vendedor
and f.fecha between '01/02/2008' and '01/03/2010'
and c.ape_cliente not like '%c%'


--3) Liste el número de factura, la fecha de venta, la descripción del artículo y el importe(precio por cantidad);
--para los casos en que el año de venta sea uno de los siguientes: 2009, 2010 y 2012 y la descripción no comience con R.
--Ordene por número de factura e importe, este en forma descendente. Rotule.


select f.nro_factura, f.fecha, a.descripcion, df.pre_unitario * df.cantidad 'Importe'
from facturas f, detalle_facturas df, articulos a
where f.nro_factura = df.nro_factura and df.cod_articulo = a.cod_articulo
and year(f.fecha) in (2009,2010,2012)
and a.descripcion not like 'r%'
order by f.nro_factura desc, 'Importe' desc

--4)Se quiere saber que artículos se vendieron, siempre que el precio al que fue vendido no varíe entre $10 y $50.
--Muestre código y descripción, cantidad

select a.cod_articulo,a.descripcion, df.cantidad
from detalle_facturas df, articulos a
where df.cod_articulo = a.cod_articulo
and df.pre_unitario not between 10 and 50

--5)Liste el nro de factura, la fecha de vta, el vendedor (apellido y nombre), el cliente(apel.y nombre), el artículo (descripción), la canttidad 
--y el importe (precio por cant); para teléfono. o direcciones de e-mail conocidas (del cliente)
--y siempre que el importe sea superior a $50. Rotule como FACTURA, FECHA, VENDEDOR, CLIENTE, artículo, CANTIDAD, IMPORTE.
--Ordene por vendedor, factura y artículo.

select f.nro_factura 'FACTURA', f.fecha 'FECHA', v.ape_vendedor +space(2)+ v.nom_vendedor'VENDEDOR', c.ape_cliente +space(2)+ c.nom_cliente 'CLIENTE',a.descripcion 'ARTICULO', df.cantidad 'CANTIDAD', df.pre_unitario * df.cantidad 'IMPORTE'
from facturas f, vendedores v, clientes c,detalle_facturas df, articulos a
where f.cod_vendedor = v.cod_vendedor and f.cod_cliente = c.cod_cliente and f.nro_factura = df.nro_factura and df.cod_articulo = a.cod_articulo
and (c.nro_tel is not null or c.[e-mail] is not null)
and df.pre_unitario * df.cantidad > 50
order by 3, 1,5 asc


--6)Se quiere saber a que cliente, de que barrio, vendedor y en que fecha se les vendió con los siguientes nros.de factura: 12, 18, 1, 3, 35, 26 y 29

select c.ape_cliente +space(2)+c.nom_cliente 'Cliente', b.barrio 'Barrio',v.ape_vendedor+space(2)+v.nom_vendedor, f.fecha
from facturas f, clientes c, vendedores v, barrios b
where f.cod_cliente = c.cod_cliente and f.cod_vendedor = v.cod_vendedor and b.cod_barrio = c.cod_barrio
and f.nro_factura in (12,18,1,3,35,26,29)


--7)Se quiere saber que artículos se vendieron, siempre que el número de factura no oscile entre 7 y 36.
-- Liste la descripción, cantidad e importe. Ordene por descripción y cantidad. Sin duplicados

select distinct a.descripcion, df.cantidad, df.pre_unitario * df.cantidad 'Importe'
from articulos a, detalle_facturas df
where a.cod_articulo = df.cod_articulo
and df.nro_factura not between 7 and 36
order by a.descripcion, df.cantidad asc


--8)Liste el nro de factura, la fecha de venta, el cliente, la descripción del artículo, la cant y el importe;
--para apellidos de cliente o descripciones que comiencen con letras que van de la L a S.Ordene por cliente, fecha y artículo.

select f.nro_factura, f.fecha, c.ape_cliente+space(2)+c.nom_cliente'Cliente', a.descripcion,df.cantidad,df.pre_unitario * df.cantidad 'Importe'
from facturas f,detalle_facturas df, articulos a, clientes c
where f.nro_factura = df.nro_factura and df.cod_articulo = a.cod_articulo and f.cod_cliente = c.cod_cliente
and (c.ape_cliente like '[L-S]%' or a.descripcion like '[L-S]%')
order by c.cod_cliente, f.fecha, a.descripcion asc


--9) Se quiere saber que artículos se vendieron en lo que va del año. Muestre código, descripción, stock y precio unitario,sin duplicados.

select distinct a.cod_articulo, a.descripcion, a.stock_minimo, a.pre_unitario
from articulos a, detalle_facturas df, facturas f
where a.cod_articulo = df.cod_articulo and f.nro_factura = df.nro_factura
and year(f.fecha) = year(getdate()) 


--10)Se quiere saber a que clientes se les vendió el año pasado, que vendedor que realizó la vta., 
--y que artículo compró, siempre que el barrio del cliente comience con letras de la A a la P, 
--siempre que el vendedor que les vendió sea menor de 35 años.


select c.ape_cliente +space(2)+ c.nom_cliente 'Cliente', v.ape_vendedor+space(2)+v.nom_vendedor, a.descripcion
from facturas f, detalle_facturas df, clientes c, vendedores v, articulos a, barrios b
where f.nro_factura = df.nro_factura and c.cod_cliente = f.cod_cliente and f.cod_vendedor = v.cod_vendedor and a.cod_articulo = df.cod_articulo and c.cod_barrio = b.cod_barrio
and year(f.fecha) = year(getdate())
and b.barrio like '[a-p]%'
and (  year(v.fec_nac) - year(getdate())  ) < 35


--11) Liste número de factura, fecha, vendedor, articulo, cantidad e importe; 
--para los casos en que los prec.unitarios oscilen entre 2 y 6 
--y para nombres de vendedor cuyo nombre comience con letras que van de la L a la M.
--Ordene por vendedor, fecha e importe.

select f.nro_factura, f.fecha, v.ape_vendedor+space(2)+ v.nom_vendedor, a.descripcion, df.cantidad, df.pre_unitario * df.cantidad 'Importe' 
from facturas f, detalle_facturas df, vendedores v, articulos a
where df.cod_articulo = a.cod_articulo and df.nro_factura = f.nro_factura and f.cod_vendedor = v.cod_vendedor
and a.pre_unitario between 2 and 6
and v.nom_vendedor like '[L-m]%'
order by v.nom_vendedor, f.fecha, 'Importe' asc


--12) Se desea emitir un listado de clientes  que compraron en enero(de cualquier año),
--además saber qué compraron cuánto gastaron (mostrar los datos en forma conveniente) 

select c.ape_cliente +space(2)+c.nom_cliente 'Cliente', month(f.fecha)'Mes', a.descripcion, df.pre_unitario * df.cantidad 'Importe'
from facturas f, clientes c, articulos a, detalle_facturas df
where df.nro_factura = f.nro_factura and df.cod_articulo = a.cod_articulo and f.cod_cliente = c.cod_cliente
and month(f.fecha) = 01


--13) Emitir un reporte de artículos vendidos en el 2010 a que precios se vendieron y qué precio tienen hoy.

select a.descripcion 'Articulos', year(f.fecha)'Fecha', df.pre_unitario 'Precio vendido', a.pre_unitario 'Precio Actual'
from detalle_facturas df, articulos a, facturas f
where df.cod_articulo = a.cod_articulo and f.nro_factura = df.nro_factura
and year(f.fecha) = 2010       -- también se puede usar (DATEPART(year,fa.fecha)=2010), es lo mismo


--14) Listar los vendedores que hace 10 años le vendieron a clientes cuyos nombres o apellidos comienzan con "C"


select v.ape_vendedor +space(2)+ v.nom_vendedor 'Vendedores', f.fecha, c.ape_cliente +space(2)+ c.nom_cliente 'Cliente'
from facturas f, clientes c, vendedores v
where f.cod_cliente = c.cod_cliente and f.cod_vendedor = v.cod_vendedor
and year(f.fecha) = year(getdate()) -10
and ( c.nom_cliente like 'c%' or c.ape_cliente like 'c%' )


--15) El encargado de la librería necesita tener información sobre los artículos que se vendían a menos de $ 10 antes del 2005.
--Mostrar los datos que se consideren relevantes para el encargado, rotular y ordenar

select a.descripcion 'Articulos', a.pre_unitario 'Precio', f.fecha 'Fecha'
from detalle_facturas df, facturas f, articulos a
where df.cod_articulo = a.cod_articulo and df.nro_factura = f.nro_factura
and df.pre_unitario < 10
and year(f.fecha) < 2005





--Guía de Ejercicios Nº 4: UNION --------------------------------------------------------------

--1.Se quiere saber qué vendedores y clientes hay en la empresa; para los casos en que su teléfono y dirección de e-mail sean conocidos.
--Se deberá visualizar el código, nombre y si se trata de un cliente o de un vendedor.
--Ordene por la columna tercera y segunda.

select c.cod_cliente 'Codigo', c.nom_cliente 'Nombre', 'Cliente' Tipo
from clientes c
where c.nro_tel is not null and c.[e-mail] is not null
union
select v.cod_vendedor"Codigo", v.nom_vendedor "Nombre", 'Vendedor' Tipo
from vendedores v
where v.nro_tel is not null and v.[e-mail] is not null
order by 3, 2 asc


--2) Emitir un listado donde se muestren qué artículos, clientes y vendedores hay en la empresa.
--Determine los campos a mostrar y su ordenamiento.

select a.descripcion, 'Artículos' Tipo
from articulos a
union
select c.ape_cliente +space(2)+ c.nom_cliente, 'Cliente' Tipo
from clientes c
union
select v.ape_vendedor + space(2)+v.nom_vendedor, 'Vendedor' Tipo
from vendedores v
order by 2 asc


--3) En un mismo listado mostrar todos los artículos que hay en la empresa y los artículos que han sido vendidos. 
--Determine Ud. las columnas a mostrar.


select a.descripcion, 'en Stock' Tipo
from articulos a
UNION
select a.descripcion, 'Vendidos' Tipo
from detalle_facturas df, articulos a
where df.cod_articulo = a.cod_articulo

--4.Se quiere saber las direcciones (incluido el barrio) tanto de clientes como de vendedores.
--Para el caso de los vendedores, códigos entre 3 y 12. 
--En ambos casos las direcciones deberán ser conocidas. 
--Rotule como NOMBRE, DIRECCION, BARRIO, INTEGRANTE (en donde indicará si es cliente o vendedor).
--Ordenado por la primera y la última columna. "str(altura) o CONVERT(varchar(10), field_name)"

select c.ape_cliente+space(2)+c.nom_cliente'NOMBRE', c.calle +space(2)+str(c.altura) 'DIRECCION', b.barrio 'BARRIO', 'Cliente' INTEGRANTE
from clientes c, barrios b
where c.cod_barrio = b.cod_barrio
and c.calle is not null and c.altura is not null
union
select v.ape_vendedor+space(2)+ v.nom_vendedor 'NOMBRE', v.calle +space(2)+convert(varchar(4),v.altura)'DIRECCION', b.barrio 'BARRIO', 'Vendedor' INTEGRANTE
from vendedores v, barrios b
where v.cod_barrio = b.cod_barrio
and v.cod_vendedor between 3 and 12
and v.calle is not null and v.altura is not null
order by 1, 4 asc


--5.Se quiere saber que clientes hay en la empresa y listar además los clientes que han comparado entre el 1/12/2010 y el 1/03/2012.
--Muestre el código, sin duplicarlos. "Si le agretó el campo tipo con su rotulo agrega duplicados"

select  c.cod_cliente , c.ape_cliente+space(2)+c.nom_cliente 'Cliente'
from clientes c
union
select  c.cod_cliente , c.ape_cliente+space(2)+c.nom_cliente 'Cliente'
from clientes c, facturas f
where f.cod_cliente = c.cod_cliente
and f.fecha between '01/12/2010' and '01/03/2012'

--6) Ídem al ejercicio anterior, sólo que además del código, identifique de donde obtiene la información
--(de qué tabla se obtienen los datos).

select  c.cod_cliente , c.ape_cliente+space(2)+c.nom_cliente 'Cliente', 'Cliente' Tipo
from clientes c
union
select  c.cod_cliente , c.ape_cliente+space(2)+c.nom_cliente 'Cliente',  'Facturas'
from clientes c, facturas f
where f.cod_cliente = c.cod_cliente
and f.fecha between '01/12/2010' and '01/03/2012'

--7.Se quiere saber qué clientes hay en la empresa y quienes han comprado; 
--para el primer caso para nombres que empiecen con letras que van de la C a la L y
-- para el segundo para facturas que oscilen entre 10 y 23. Muestre el código (no elimine los que se repiten).


select  c.cod_cliente, c.nom_cliente, 'Cliente' Tabla
from clientes c
where c.nom_cliente like '[C-L]%'
union all
select  c.cod_cliente, c.nom_cliente, 'Compro'
from clientes c, facturas f
where f.cod_cliente = c.cod_cliente
and f.nro_factura between 10 and 23
order by 1

--8.Listar todos los artículos que están a la venta cuyo precio unitario oscile entre 10 y 50; 
--también se quieren listar los artículos que fueron comprados por los clientes cuyos apellidos comiencen con M o con P.


select a.cod_articulo, a.descripcion,'En Venta' Tipo
from articulos a
where a.pre_unitario between 10 and 50
union
select a.cod_articulo, a.descripcion, 'Facturados'
from articulos a, detalle_facturas df, facturas f, clientes c
where a.cod_articulo = df.cod_articulo and df.nro_factura = f.nro_factura and f.cod_cliente = c.cod_cliente
and c.ape_cliente like '[M~P]%'
order by 1





--Guía de Ejercicios Nº 5: Consultas Sumarias --------------------------------------------------------------

--1.Se quiere saber la cant.de clientes que hay en la empresa.

select count(c.cod_cliente)'Cantidad de clientes'
from clientes c


--2.Se quiere saber que cant. vendedores hay en la empresa.

select count(v.cod_vendedor) 'Cantidad de vendedores'
from vendedores v


--3.Se quiere saber el promedio de la cant.total de artículos vendidos.

select avg(df.cantidad) 'Promedio'
from detalle_facturas df


--4.Se quiere saber la cantidad de vtas que hizo el vendedor de código 3.

select count(f.nro_factura)'Cant. Ventas'
from facturas f
where f.cod_vendedor = 3


--5.Se quiere saber cual fue la fecha de la 1ra. y última vta.
--Rotule como PRIMER VENTA, última VENTA.

select min(f.fecha)'PRIMER VENTA', max(f.fecha)'última VENTA'
from facturas f


--6.Se quiere saber cual fue la máxima y la mínima cant.que se vendió para el artículo 8.

select max(df.cantidad)'cant Maxima', min(df.cantidad)'Minima Cantidad'
from detalle_facturas df
where df.cod_articulo = 8


--7.Se quiere saber la cant.vendida, la cant.de vtas. el importe total para la factura 15.

select sum(df.cantidad)'cant Vendida', count(df.nro_factura)'cant Ventas', sum(df.pre_unitario * df.cantidad)'importe Total'
from detalle_facturas df
where df.nro_factura = 15


--8.Se quiere saber la cant.total vendida, el importe total  el importe promedio;
-- para vendedores cuyo nombres comienzan con letras que van de la D a la L.

select sum(df.cantidad)'cant Total', sum(df.pre_unitario * df.cantidad)'Importe Total', avg(df.pre_unitario*df.cantidad)'importe Promedio'
from detalle_facturas df, facturas f, vendedores v
where df.nro_factura = f.nro_factura and f.cod_vendedor = v.cod_vendedor
and v.nom_vendedor like '[D-L]%'


--9.Se quiere saber el promedio del importe, el total del importe vendido, el promedio de la cant.vendida y la cant.total vendida.

select avg(df.pre_unitario* df.cantidad)'importe Promedio', sum(df.pre_unitario*df.cantidad)'importe Total', avg(df.cantidad)'Promedio Cantidad',sum(df.cantidad)'cant Total'
from detalle_facturas df


--10.Se quiere saber el importe total vendido, el promedio del importe vendido y la cant.total vendida para el cliente de código 3.

select sum(df.pre_unitario*df.cantidad)'Importe Total', avg(df.pre_unitario*df.cantidad)'Promedio Importe',sum(df.cantidad)'Cant Total'
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura
and f.cod_cliente = 3


--11.Se quiere saber la fecha de la 1er vta, la cant total vendida y el importe total vendido para los artículos que empiecen con C.

select min(f.fecha)'1ra Vta', sum(df.cantidad)'cant Tot vendida',sum(df.pre_unitario*df.cantidad)'importe Total vendido'
from detalle_facturas df, facturas f, articulos a
where df.nro_factura = f.nro_factura and df.cod_articulo = a.cod_articulo
and a.descripcion like 'c%'


--12.Se quiere saber la cant total vendida y el importe total vendido para el periodo del 15/06/2008 al 15/06/2011.

select sum(df.cantidad)'cant Total Vendida', sum(df.pre_unitario * df.cantidad)'Importe Total Vendido'
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura 
and f.fecha between '15/06/2008' and '15/06/2011'


--13.Se quiere saber la cant. de veces y la última vez que vino el cliente de apellido Abarca.

select count(f.nro_factura) 'Cantidad de veces que vino el cliente', max(f.fecha)'ultima visita'
from facturas f, clientes c
where f.cod_cliente = c.cod_cliente
and c.ape_cliente like 'Abarca'


--14.Se quiere saber el importe total y el promedio del importe para los clientes cuya dirección de mail es conocida.
--Rotule como IMPORTE TOTAL, PROMEDIO.

select  sum(df.pre_unitario * df.cantidad)'IMPORTE TOTAL', avg(df.pre_unitario*df.cantidad)'PROMEDIO'
from detalle_facturas df, facturas f, clientes c
where df.nro_factura = f.nro_factura and f.cod_cliente = c.cod_cliente
and c.[e-mail] is not null


--15.Se quiere saber el importe total vendido y el importe promedio vendido para nros.de factura que
--no sean los siguientes: 13, 5, 17, 33, 24.

select sum(df.pre_unitario*df.cantidad)'Importe Total', avg(df.pre_unitario*df.cantidad)'Importe Promedio'
from detalle_facturas df
where df.nro_factura not in (13,5,17,33,24)


--16.Se quiere saber la fecha de la primera venta, el importe total vendido y la cantidad total vendida para el año 2014.

select min(f.fecha)'1ra Venta', sum(df.pre_unitario*df.cantidad)'Importe Total Vendido', sum(df.cantidad)'Cant Total Vendida'
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura
and year(f.fecha) = 2014

--17.Se quiere saber la cant. de vtas, la cant. total vendida y el importe promedio vendido para la factura 33.
--Rotule como CANTIDAD DE VENTAS, CANTIDAD VENDIDA, PROMEDIO VENDIDO.

select count(df.nro_factura)'CANTIDAD DE VENTAS', sum(df.cantidad)'CANTIDAD VENDIDA', avg(df.pre_unitario*df.cantidad)'PROMEDIO VENDIDO'
from detalle_facturas df
where df.nro_factura = 33




--Guía de Ejercicios Nº 6: Consultas Agrupadas  --------------------------------------------------------------

--Cantidad de facturas diarias
select count(f.nro_factura),f.fecha
from facturas f
group by f.fecha


--Cantidad de facturas por año
select count(f.nro_factura),year(f.fecha)
from facturas f
group by year(f.fecha)


--Cantidad de facturas emitidas por cada vendedor, ademas de la primer venta que hizo c/u

select count(f.nro_factura), min(f.nro_factura)
from facturas f, vendedores v
where v.cod_vendedor = f.cod_vendedor
group by v.cod_vendedor


--Ingresos mensuales este año

select sum(df.pre_unitario*df.cantidad),month(f.fecha)
from facturas f, detalle_facturas df
where df.nro_factura = f.nro_factura
and year(f.fecha) = year(getdate())
group by month(f.fecha)


--Cantidad de clientes

select count(c.cod_cliente)
from clientes c


--cantidad de clientes con tel conocido

select count(c.cod_cliente)
from clientes c
where c.nro_tel is not null



--1). Mostrar la cantidad de artículos vendidos (suma de las cantidades vendidas), cantidad de ventas
--(cantidad de registros de detalles) y el Importe total por factura.

select sum(df.cantidad), count(df.cod_articulo), sum(df.pre_unitario*df.cantidad)
from detalle_facturas df

--2. Se quiere saber en este negocio, cuanto se factura:
--a. Diariamente (importe total de facturacion por fecha)
--b. Mensualmente (importe total de facturacion por mes, por año)
--c. Anualmente (importe total de facturacion por año)

--a
select sum(df.pre_unitario*df.cantidad), f.fecha
from facturas f,detalle_facturas df
where df.nro_factura = f.nro_factura
group by f.fecha
--b
select sum(df.pre_unitario*df.cantidad),month(f.fecha),year(f.fecha)
from facturas f,detalle_facturas df
where df.nro_factura = f.nro_factura
group by month(f.fecha),year(f.fecha)
--c
select sum(df.pre_unitario*df.cantidad),year(f.fecha)
from facturas f,detalle_facturas df
where df.nro_factura = f.nro_factura
group by year(f.fecha)


--3. Se quiere saber la cantidad de facturas por fecha, 
--siempre que los meses de venta no sean uno de los siguientes: 7, 1, 12. 
--Rotule como FECHA, CANTIDAD VENTAS. Ordene por la cantidad de facturas en forma descendente y fecha.

select count(f.nro_factura) 'Cantidad Ventas', f.fecha 'FECHA'
from facturas f
where month(f.fecha) not in (7,1,12)
group by f.fecha
order by 1 desc, 2 desc


--4. Mostrar la cantidad total vendida, el importe total vendido y la fecha de la primer venta por cliente, para nombres de cliente que no empiecen con P.

select count(df.cantidad), sum(df.pre_unitario*df.cantidad),min(f.fecha),f.cod_cliente
from detalle_facturas df, facturas f, clientes c
where df.nro_factura = f.nro_factura and c.cod_cliente = f.cod_cliente
and c.nom_cliente not like 'P%'
group by f.cod_cliente


--5.Se quiere saber la cantidad y el importe promedio vendido por fecha y cliente, para códigos de vendedor superiores a 2. Ordene por fecha y cliente.

select avg(df.cantidad), avg(pre_unitario* df.cantidad), f.fecha, f.cod_cliente
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura
and f.cod_vendedor > 2
group by f.fecha, f.cod_cliente
order by 2, 3


--6.Se quiere saber el importe promedio vendido y la cantidad total vendida por fecha y artículos, para códigos de cliente inferior a 3. Ordene por fecha y artículos.

select avg(df.pre_unitario*df.cantidad), sum(df.cantidad), f.fecha,a.descripcion
from detalle_facturas df, facturas f, articulos a
where df.nro_factura = f.nro_factura and a.cod_articulo = df.cod_articulo
and f.cod_cliente < 3
group by f.fecha,a.descripcion
order by f.fecha, a.descripcion


--7.Listar la cantidad total vendida, el importe total vendido y el importe promedio total vendido por número de factura, 
--siempre que la fecha no oscile entre el 13/2/2007 y el 13/7/2010.

select sum(df.cantidad), sum(df.cantidad*df.pre_unitario),avg(df.cantidad*df.pre_unitario),f.nro_factura
from detalle_facturas df, facturas f
where f.nro_factura = df.nro_factura
and f.fecha not between '13/02/2007' and '13/07/2010'
group by f.nro_factura


--8.Mostrar la cantidad de ventas para meses que oscilen entre julio y noviembre ():
--a. Por fecha y vendedor.
--b. Por vendedor y fecha.
--Ordene por los mismos campos por los que agrupa.

--a. Por fecha y vendedor.

select count(f.nro_factura), f.fecha, f.cod_vendedor
from facturas f, detalle_facturas df
where df.nro_factura = f.nro_factura
and month(f.fecha) between 7 and 11
group by f.fecha, f.cod_vendedor
order by f.fecha, f.cod_vendedor

--b. Por vendedor y fecha.
select count(f.nro_factura), f.cod_vendedor, f.fecha
from facturas f, detalle_facturas df
where df.nro_factura = f.nro_factura
and month(f.fecha) between 7 and 11
group by f.cod_vendedor, f.fecha
order by f.cod_vendedor, f.fecha


--9.Se quiere saber la fecha de la primer y última venta y el importe comprado por cliente. 
--Rotule como CLIENTE, PRIMER VENTA, ÚLTIMA VENTA, IMPORTE.

select f.cod_cliente 'CLIENTE',min(f.fecha)'PRIMER VENTA', max(f.fecha)'ÚLTIMA VENTA', sum(df.cantidad*df.pre_unitario)'IMPORTE'
from facturas f, detalle_facturas df
where f.nro_factura = df.nro_factura
group by f.cod_cliente


--10.Se quiere saber el importe total vendido, la cantidad total vendida y el precio unitario promedio por cliente y artículo,
--siempre que el nombre del cliente comience con letras que van de la “a” a la “m”.
--Ordene por cliente, precio unitario promedio en forma descendente y artículo. Rotule como IMPORTE TOTAL, CANTIDAD TOTAL, PRECIO PROMEDIO.

select sum(df.pre_unitario*df.cantidad)'IMPORTE TOTAL', sum(df.cantidad)'CANTIDAD TOTAL', avg(df.pre_unitario)'PRECIO PROMEDIO', f.cod_cliente, df.cod_articulo 
from detalle_facturas df, facturas f, clientes c
where f.nro_factura = df.nro_factura and c.cod_cliente = f.cod_cliente
and c.nom_cliente like '[a-m]%'
group by f.cod_cliente, df.cod_articulo
order by 4,3 desc, df.cod_articulo

--11.Mostrar la fecha de la primera venta y la cantidad de ventas (cantidad de registros en el detalle) por vendedor, para el año pasado.

select min(f.fecha), count(df.nro_factura), f.cod_vendedor
from facturas f, detalle_facturas df
where f.nro_factura = df.nro_factura
and year(f.fecha) = year(getdate()) -1
group by f.cod_vendedor


--12.Se quiere saber la cantidad de facturas y la fecha la primer y última factura por vendedor y cliente,
--para números de factura que oscilan entre 5 y 30. Ordene por vendedor, cantidad de ventas en forma descendente y cliente.

select count(f.nro_factura), min(f.fecha),max(f.fecha), f.cod_vendedor, f.cod_cliente
from facturas f
where f.nro_factura between 5 and 30
group by f.cod_vendedor, f.cod_cliente
order by f.cod_vendedor, 1 desc, 5





--Guía de Ejercicios Nº 7:  Consultas Agrupadas con condición --------------------------------------------------------------

--1.Se quiere saber la fecha de la primer venta, la cantidad total vendida y el importe total vendido por vendedor 
--para los casos en que el promedio de la cantidad vendida sea inferior o igual a 56.

select min(f.fecha), sum(df.cantidad), sum(df.pre_unitario*df.cantidad), f.cod_vendedor
from facturas f,detalle_facturas df
where df.nro_factura = f.nro_factura
group by f.cod_vendedor
having avg(df.cantidad) <= 56


--2.Liste el importe máximo y mínimo e importe total por factura y por cliente donde el importe total sea entre 100 y 500.

select max(df.pre_unitario*df.cantidad)'Maximo', min(df.pre_unitario*df.cantidad)'Minimo', sum(df.pre_unitario*df.cantidad)'Total'
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura
group by f.nro_factura,f.cod_cliente
having sum(df.cantidad*df.pre_unitario) between 100 and 500


--3.Muestre la cantidad de ventas por vendedor y fecha;
--para los casos en esa cantidad de ventas sea superior a 1.

select count(f.nro_factura)'Cant Ventas',f.cod_vendedor,f.fecha
from facturas f
group by f.cod_vendedor,f.fecha
having count(f.nro_factura) > 1


--4.Se quiere saber el precio promedio, el importe y el promedio total vendido por artículo;
--para los casos en que el artículo no comience con “c”,
--que su cantidad vendida sea igual o superior a 100 o que ese importe total vendido sea superior a 350

select avg(df.pre_unitario), avg(df.pre_unitario* df.cantidad),sum(df.pre_unitario * df.cantidad),a.descripcion
from detalle_facturas df, articulos a
where df.cod_articulo = a.cod_articulo
and a.descripcion not like 'c%'
group by a.descripcion
having ( sum(df.cantidad) >= 100 or sum(df.pre_unitario*df.cantidad) > 350)


--5.Muestre la cantidad total vendida, el importe total y la fecha de la primer y  última venta por cliente,
--para lo números de factura que no sean los siguientes: 2, 12, 20, 17, 30 y
--que el promedio de la cantidad vendida no oscile entre 2 y 6.
--Rotule como CLIENTE, CANTIDAD TOTAL, IMPORTE TOTAL, PRIMER VENTA, ULTIMA VENTA.

select sum(df.cantidad)'CANTIDAD TOTAL', sum(df.pre_unitario*df.cantidad)'IMPORTE TOTAL',min(f.fecha)'PRIMER VENTA',max(f.fecha)'ULTIMA VENTA',f.cod_cliente 'CLIENTE'
from detalle_facturas df,facturas f
where df.nro_factura = f.nro_factura
and f.nro_factura not in (2,12,20,17,30) 
group by f.cod_cliente
having avg(df.cantidad) not between 2 and 6

--6.Muestre la cantidad total vendida, el importe total vendido y el promedio total vendido por vendedor y cliente;
--para los casos en que el importe total vendido oscile entre 2000 y 6000 
--y para códigos de cliente que oscilen entre 1 y 5.


select sum(df.cantidad), sum(df.cantidad*df.pre_unitario),avg(df.pre_unitario*df.cantidad), f.cod_vendedor,f.cod_cliente
from detalle_facturas df, facturas f
where f.nro_factura = df.nro_factura
and f.cod_cliente between 1 and 5
group by f.cod_vendedor, f.cod_cliente
having sum(df.pre_unitario*df.cantidad) between 2000 and 6000


--7.Se quiere saber el importe promedio y el total vendido por factura,
--para los casos en que la cantidad total vendida sea superior a 50 y
--que el importe total sea superior a 100.
--Ordene por importe en forma descendente.
--Rotule como FACTURA, IMPORTE TOTAL,PROMEDIO.

select avg(df.pre_unitario*df.cantidad)'PROMEDIO', sum(df.pre_unitario*df.cantidad)'IMPORTE TOTA',df.nro_factura 'FACTURA'
from detalle_facturas df
group by df.nro_factura
having sum(df.cantidad) > 50 and sum(df.pre_unitario*df.cantidad) > 100
order by 2 desc


--8.Se quiere saber la cantidad total vendida, el precio promedio y el importe total vendido por fecha;
--para los casos en que el año de la venta sea uno de los siguientes 2008, 2010 o 2011 y
--que ese importe total sea inferior a 200. Ordene por importe en forma descendente.

select sum(df.cantidad), avg(df.pre_unitario), sum(df.pre_unitario*df.cantidad), f.fecha
from detalle_facturas df,facturas f
where f.nro_factura = df.pre_unitario
and year(f.fecha) in (2008,2010,2011)
group by f.fecha
having sum(df.pre_unitario*df.cantidad) < 200
order by 3 desc


--9.Muestre la cantidad total vendida y el promedio total vendido por cliente y fecha;
--para los casos en que el importe total vendido sea inferior a 150 y
--que el promedio de la cantidad vendida sea inferior a 20.
--Rotule como CLIENTE, FECHA, CANTIDAD, IMPORTE PROMEDIO.

select sum(df.cantidad)'CANTIDAD', avg(df.pre_unitario*df.cantidad)'IMPORTE PROMEDIO', f.cod_cliente 'CLIENTE',f.fecha 'FECHA'
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura
group by f.cod_cliente, f.fecha
having sum(df.pre_unitario*df.cantidad) < 150 and avg(df.cantidad) < 20


--10.Liste la cantidad total y el promedio de ventas, el importe total y el promedio del importe por vendedor por año,
--para las ventas realizadasanteriores 1/1/2008 y que el importe total no supere los $ 850.

select  count(df.nro_factura),avg(df.nro_factura), sum(df.pre_unitario*df.cantidad), avg(df.pre_unitario*df.cantidad),f.cod_cliente,year(f.fecha)
from detalle_facturas df, facturas f
where df.nro_factura = f.nro_factura
and f.fecha < '01/01/2008'
group by f.cod_cliente, year(f.fecha)
having sum(df.pre_unitario*df.cantidad) <= 850


--Guía de Ejercicios Nº 8:  Join --------------------------------------------------------------


--1)Liste factura, fecha, nombre de vendedor y nombre de cliente 
--para las ventas del año 2006, 2007, 2009 y 2012.

select  f.nro_factura'Nro. Factura',f.fecha'Fecha',v.nom_vendedor'Vendedor',c.nom_cliente'Cliente'
from facturas f join clientes c on f.cod_cliente = c.cod_cliente join vendedores v on f.cod_vendedor = v.cod_vendedor
where year(f.fecha) in (2006,2007,2009,2012)


--2)Liste nro. de factura, fecha, descripción del artículo, cantidad vendida, precio unitario e importe,
-- de las facturas correspondientes al mes pasado.

select f.nro_factura, f.fecha, a.descripcion'Articulo', df.cantidad'Cantidad Vendida', df.pre_unitario'Precio Unitario', df.pre_unitario * df.cantidad 'Importe'
from facturas f join detalle_facturas df on df.nro_factura = f.nro_factura join articulos a on a.cod_articulo = df.cod_articulo
where month(f.fecha) = month(getdate()) -1 and year(f.fecha) = year(getdate())


--3)Liste código de vendedor, nombre, fecha y factura;
-- para las ventas en lo que va del año.
-- Muestre los vendedores aun así no tengan ventas registradas en el año solicitado.

select v.cod_vendedor, v.nom_vendedor, f.fecha,f.nro_factura
from facturas f left join vendedores v on f.cod_vendedor = v.cod_vendedor
where year(f.fecha) = year(getdate())


--4)Liste descripción, cantidad e importe;
-- aun para aquellos artículos que no registran ventas.

select a.descripcion'Articulo', df.cantidad, df.pre_unitario*df.cantidad'Importe'
from articulos a left join detalle_facturas df on df.cod_articulo = a.cod_articulo


--5)Liste factura, fecha, vendedor, cliente, articulo, cantidad e importe;
-- para las ventas de febrero y marzo de los años 2006 y 2007
-- y siempre que el artículo empiece con letras que van de la “a” a la “m”.
-- Ordene por fecha, cliente y artículo.

select f.nro_factura, f.fecha, v.ape_vendedor +space(2)+v.nom_vendedor'Vendedor', c.ape_cliente+space(2)+c.nom_cliente'Cliente',a.descripcion'Articulo', 
df.cantidad'Cantidad',df.pre_unitario*df.cantidad'Importe'
from facturas f join vendedores v on v.cod_vendedor = f.cod_vendedor join clientes c on c.cod_cliente = f.cod_cliente join detalle_facturas df on df.nro_factura = f.nro_factura join articulos a on a.cod_articulo = df.cod_articulo
where month(f.fecha) in (02,03) and year(f.fecha) in (2006,2007)
and a.descripcion like '[a-m]%'
order by f.fecha,'Cliente','Articulo'


--6)Liste código de cliente, nombre, fecha y factura 
--para las ventas del año 2007.
-- Muestre los clientes hayan comprado o no en ese año.

select c.cod_cliente, c.nom_cliente, f.fecha, f.nro_factura
from facturas f right join clientes c on f.cod_cliente = c.cod_cliente
where year(f.fecha) = 2007


--7)Se quiere saber los artículos 
--que compro el cliente 7 en lo que va del año.
-- Liste artículo, observaciones e importe.


select a.descripcion'Articulo',a.observaciones'Observaciones', df.pre_unitario * df.cantidad 'Importe'
from articulos a join detalle_facturas df on df.cod_articulo = a.cod_articulo join facturas f on df.nro_factura = f.nro_factura
where f.cod_cliente = 7
and year(f.fecha) = year(getdate())

--8)Se quiere saber los artículos que compraron los clientes que empiezan con “p”.
-- Liste cliente, articulo, cantidad e importe. 
--Ordene por cliente y artículo, este en forma descendente.
-- Rotule como CLIENTE, ARTICULO, CANTIDAD, IMPORTE.

select c.cod_cliente'Cliente', a.descripcion'Articulo', df.cantidad'Cantidad', df.pre_unitario*df.cantidad'Importe'
from articulos a join detalle_facturas df on a.cod_articulo = df.cod_articulo join facturas f on f.nro_factura = df.nro_factura join clientes c on c.cod_cliente = f.cod_cliente
where c.nom_cliente like 'p%'
order by c.cod_cliente, a.descripcion desc


--9)Listar los artículos (código y descripción) que vendieron los vendedores 2 y 5.
-- Muestre también el nombre de los vendedores.

select convert(varchar(10), a.cod_articulo) +space(2)+a.descripcion, v.nom_vendedor'Vendedor'
from articulos a join detalle_facturas df on df.cod_articulo = a.cod_articulo join facturas f on f.nro_factura = df.nro_factura join vendedores v on v.cod_vendedor = f.cod_vendedor
where f.cod_vendedor in (2,5)


--10)Listar todos los clientes (incluidos los que nunca compraron) y los años de compra.
-- No muestre registros repetidos.

select distinct c.nom_cliente +space(2)+ c.ape_cliente'Cliente', year(f.fecha)'Fecha'
from clientes c left join facturas f on f.cod_cliente = c.cod_cliente



--Guía de Ejercicios Nº 8:  Joins --------------------------------------------------------------
/*
in: =any
not int: <> all
exists: true  <-- si la subconsuta devuelve datos
not exist: false  <--Si no recibimos resultados trabaja con los datos de la consulta principal
si negamos un dato negativo no da un positivo
*/


--1)Liste factura, fecha, nombre de vendedor y nombre de cliente para las ventas del año 2006, 2007, 2009 y 2012.

select f.nro_factura, f.fecha, v.nom_vendedor 'Vendedor',c.nom_cliente'Cliente'
from facturas f join vendedores v on v.cod_vendedor = f.cod_vendedor join clientes c on c.cod_cliente = f.cod_cliente
where year(f.fecha) in (2006,2007,2009,2012)



--2)Liste nro. de factura, fecha, descripción del artículo, cantidad vendida, precio unitario e importe,
-- de las facturas correspondientes al mes pasado.

select f.nro_factura, f.fecha, a.descripcion'Articulo', df.cantidad'Cantidad Vendida', df.pre_unitario, df.pre_unitario* df.cantidad 'Importe'
from facturas f join detalle_facturas df on df.nro_factura = f.nro_factura join articulos a on a.cod_articulo = df.cod_articulo
where year(f.fecha) = year(getdate())  and month(f.fecha) = month(getdate()) -1


--3)Liste código de vendedor, nombre, fecha y factura;
-- para las ventas en lo que va del año.
-- Muestre los vendedores aun así no tengan ventas registradas en el año solicitado.

select v.cod_vendedor, v.nom_vendedor, f.fecha,f.nro_factura
from vendedores v left join facturas f on f.cod_vendedor = v.cod_vendedor
and year(f.fecha) = year(getdate())  --- con and arroja todos los resultados, con where no muestra los null





