--Está verificado con los PDF de la UTN
--se usa ~ para uno u otro, - es para rangos, verificado por mi
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

select f.nro_factura, c.nom_cliente + space (3) + c.ape_cliente 'Cliente', v.nom_vendedor +space(3)+ v.ape_vendedor 'Vendedor', f.fecha
from facturas f, clientes c, vendedores v
where f.cod_cliente = c.cod_cliente 
and f.cod_vendedor = v.cod_vendedor
and f.fecha between '2008-02-01' and '2010-03-01'
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
and year(f.fecha) = year(getdate()) -5
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
and f.fecha between '2010-12-01' and '2012-03-01'

--6) Ídem al ejercicio anterior, sólo que además del código, identifique de donde obtiene la información
--(de qué tabla se obtienen los datos).

select  c.cod_cliente , c.ape_cliente+space(2)+c.nom_cliente 'Cliente', 'Cliente' Tipo
from clientes c
union
select  c.cod_cliente , c.ape_cliente+space(2)+c.nom_cliente 'Cliente',  'Facturas'
from clientes c, facturas f
where f.cod_cliente = c.cod_cliente
and f.fecha between '2010-12-01' and '2012-03-01'

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















































