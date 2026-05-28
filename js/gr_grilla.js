function grIntercambiar(array, c, a, b)
{
	var cell1 = array[a].getElementsByTagName("td")
	var cell2 = array[b].getElementsByTagName("td")
	//alert("1:  a: " + cell1[c].innerHTML + "     b: " + cell2[c].innerHTML)
	for(var i = 0; i < cell1.length; i++)			
	{
		var tmp = cell1[i].innerHTML
		cell1[i].innerHTML = cell2[i].innerHTML
		cell2[i].innerHTML = tmp
	}
	
	//alert("2:  a: " + cell1[c].innerHTML + "     b: " + cell2[c].innerHTML)
}

function grGetValor(cad, tipo_orden)
{
	if(tipo_orden == "num")
	{
		var valor = parseFloat(cad)
		if(isNaN(valor))
			return -9999999999999999999
		else
			return valor
	}
	else
	{
		return cad
	}
}

function grPartition(array, c, begin, end, pivot, orden, tipo_orden)
{
	var cell = array[pivot].getElementsByTagName("td")
	var piv = grGetValor(cell[c].innerHTML, tipo_orden)
	var comparacion = true
	//alert("inicio")
	grIntercambiar(array, c, pivot, end - 1)
	
	var store = begin;
	var ix;
	for(ix = begin; ix < end - 1; ++ix)
	{
		var cell = array[ix].getElementsByTagName("td")
		var valor = grGetValor(cell[c].innerHTML, tipo_orden)
		
		if(orden == "asc")
		{
			if(tipo_orden == "num")	comparacion = (parseFloat(valor) <= parseFloat(piv))
			if(tipo_orden == "fec")
			{
				var x_valor = valor
				var x_piv = piv
				
				x_valor = x_valor.replace("/", "").replace("/", "")
				x_valor = x_valor.substring(4, 8) + x_valor.substring(2, 4) + x_valor.substring(0, 2)
				
				x_piv = x_piv.replace("/", "").replace("/", "")
				x_piv = x_piv.substring(4, 8) + x_piv.substring(2, 4) + x_piv.substring(0, 2)
				
				//alert(x_valor + ", " + x_piv)
				
				comparacion = (parseFloat(x_valor) <= parseFloat(x_piv))
			}
			else					comparacion = (valor <= piv)
			
			if(comparacion)
			{
				grIntercambiar(array, c, store, ix)
				++store;
			}
		}
		else
		{
			if(tipo_orden == "num")	comparacion = (parseFloat(valor) >= parseFloat(piv))
			if(tipo_orden == "fec")
			{
				var x_valor = valor
				var x_piv = piv
				
				x_valor = x_valor.replace("/", "").replace("/", "")
				x_valor = x_valor.substring(4, 8) + x_valor.substring(2, 4) + x_valor.substring(0, 2)
				
				x_piv = x_piv.replace("/", "").replace("/", "")
				x_piv = x_piv.substring(4, 8) + x_piv.substring(2, 4) + x_piv.substring(0, 2)
				
				//alert(x_valor + ", " + x_piv)
				
				comparacion = (parseFloat(x_valor) >= parseFloat(x_piv))
			}
			else					comparacion = (valor >= piv)
			
			if(comparacion)
			{
				grIntercambiar(array, c, store, ix)
				++store;
			}
		}
	}
	grIntercambiar(array, c, end - 1, store)
	
	return store;
}

function grQsort(array, c, begin, end, orden, tipo_orden)
{
	if(end - 1 > begin)
	{
		var pivot = begin + Math.floor(Math.random() * (end - begin));
		pivot = grPartition(array, c, begin, end, pivot, orden, tipo_orden);
		grQsort(array, c, begin, pivot, orden, tipo_orden);
		grQsort(array, c, pivot + 1, end, orden, tipo_orden);
	}
}

function grQuickSort(array, c, orden, tipo_orden)
{
	grQsort(array, c, 1, array.length, orden, tipo_orden);
}

function grDoSort(array, c, orden, tipo_orden)
{
	grQuickSort(array, c, orden, tipo_orden);
	return array;
}

/***************************************************************/

function grLTrim(s)
{
	return s.replace(/^\s+/, "");
}

function grRTrim(s)
{
	return s.replace(/\s+$/, "");
}

function grTrim(s)
{
	return grRTrim(grLTrim(s));
}

function GROrdenar(tabla, columna, tipo_orden)
{
	var orden = ""
	var arrow_down = "url(\"img/flecha_down_header.png\")"
	var arrow_up = "url(\"img/flecha_up_header.png\")"
	var i = 0
	var j = 0
	var carrow = 2
	
	//var celdas_header = document.getElementById(tabla).getElementsByTagName("td")
	var nfilas = document.getElementById(tabla).rows.length
	var filas_body = document.getElementById(tabla).rows
	var fila_header = document.getElementById(tabla).rows[0]
	var celdas_header = fila_header.getElementsByTagName("td")

	for(var i = 0; i < celdas_header.length; i++)
	{
		var divs_header = celdas_header[i].getElementsByTagName("div")
			
		if(i + 1 != columna)
		{
			if(divs_header[carrow] != null)
			{
				divs_header[carrow].style.display = "none"
				divs_header[carrow].style.backgroundImage = ""
			}
		}
		else
		{
			if(divs_header[carrow].style.backgroundImage == "")
			{
				divs_header[carrow].style.display = "block"
				divs_header[carrow].style.backgroundImage = arrow_up
				orden = "asc"
			}
			else
			{
				var pat = /flecha_up_header.png/
				if(pat.test(divs_header[carrow].style.backgroundImage) || divs_header[carrow].style.backgroundImage == "")
				{
					divs_header[carrow].style.backgroundImage = arrow_down
					orden = "desc"
				}
				else
				{
					divs_header[carrow].style.backgroundImage = arrow_up
					orden = "asc"
				}
			}
		}
	}
	//alert(orden)
	// ordenamos
	filas_body = grDoSort(filas_body, columna - 1, orden, tipo_orden)
}

function GROrdenar2(tabla, columna)
{
	var orden = ""
	var arrow_down = "url(\"img/flecha_down_header.png\")"
	var arrow_up = "url(\"img/flecha_up_header.png\")"
	var i = 0
	var j = 0
	var carrow = 2
	
	//var celdas_header = document.getElementById(tabla).getElementsByTagName("td")
	var fila_header = document.getElementById(tabla).rows[0]
	var celdas_header = fila_header.getElementsByTagName("td")

	var divs_header = celdas_header[columna - 1].getElementsByTagName("div")
		
	if(divs_header[carrow].style.backgroundImage == "")
	{
		divs_header[carrow].style.display = "block"
		//divs_header[carrow].style.backgroundImage = arrow_up
		orden = "asc"
	}
	else
	{
		var pat = /flecha_up_header.png/
		if(pat.test(divs_header[carrow].style.backgroundImage) || divs_header[carrow].style.backgroundImage == "")
		{
			//divs_header[carrow].style.backgroundImage = arrow_down
			orden = "desc"
		}
		else
		{
			//divs_header[carrow].style.backgroundImage = arrow_up
			orden = "asc"
		}
	}

	//alert(orden)
	// ordenamos
	GROrdenarGrilla(tabla, columna, orden)
}

/***************************************************************************************************************************/

var gr_navegador = 0
var gr_xActual = 0
var gr_yActual = 0
var gr_elComienzoX = 0
var gr_elComienzoY = 0
var gr_cursorComienzoX = 0
var gr_cursorComienzoY = 0
var gr_elMovimiento
var gr_band_ordenar = true

var gr_nm_navegador = navigator.appName 
if (gr_nm_navegador == "Microsoft Internet Explorer") 
	gr_navegador = 0
else 
	gr_navegador = 1

function grEvitaEventos(event)
{
	// Funcion que evita que se ejecuten eventos adicionales
	if(gr_navegador==0)
	{
		window.event.cancelBubble=true;
		window.event.returnValue=false;
	}
	if(gr_navegador==1) event.preventDefault();
}
 
function grComienzoMovimiento(event, objresize, c)
{
	var fila_header = document.getElementById(objresize).rows[0]
	var celdas_header = fila_header.getElementsByTagName("td")
	gr_band_ordenar = false
	
	//gr_elMovimiento = document.getElementById(objresize + 'H' + c);
	gr_elMovimiento = celdas_header[c - 1]
	
	 // Obtengo la posicion del cursor
	if(gr_navegador == 0)
	 {
		gr_cursorComienzoX = window.event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
		gr_cursorComienzoY = window.event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
 
		document.attachEvent("onmousemove", grEnMovimiento);
		document.attachEvent("onmouseup", grFinMovimiento);
	}
	if(gr_navegador == 1)
	{   
		gr_cursorComienzoX = event.clientX + window.scrollX;
		gr_cursorComienzoY = event.clientY + window.scrollY;
	   
		document.addEventListener("mousemove", grEnMovimiento, true);
		document.addEventListener("mouseup", grFinMovimiento, true);
	}
   
	//gr_elComienzoX = parseInt(gr_elMovimiento.style.left);
	//gr_elComienzoY = parseInt(gr_elMovimiento.style.top);
	
	// Actualizo el posicion del elemento
	//gr_elMovimiento.style.zIndex=++posicion;
	grEvitaEventos(event);
}

function grEnMovimiento(event)
{ 
	//var gr_xActual, gr_yActual;
	if(gr_navegador == 0)
	{   
		gr_xActual = window.event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
		gr_yActual = window.event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	} 
	if(gr_navegador==1)
	{
		gr_xActual = event.clientX + window.scrollX;
		gr_yActual = event.clientY + window.scrollY;
	}
   
	//gr_elMovimiento.style.left = (gr_elComienzoX + gr_xActual - gr_cursorComienzoX) + "px";
	//gr_elMovimiento.style.top = (gr_elComienzoY + gr_yActual - gr_cursorComienzoY) + "px";

	var width = parseFloat(gr_elMovimiento.width) + (parseFloat(gr_xActual) - parseFloat(gr_cursorComienzoX))
	if(width > 15)
	{
		var div_celdas = gr_elMovimiento.getElementsByTagName("div")
		var div_mov = div_celdas[3]
		//var div_fle = div_celdas[2]
		
		gr_elMovimiento.width = width
		div_mov.style.width = parseInt(width) - 8 + 'px'
		div_mov.width = parseInt(width) - 8
		
		//document.getElementById("res").innerHTML = " div_mov.style.width = " + div_mov.style.width
		
		gr_cursorComienzoX = gr_xActual
	}
 
	grEvitaEventos(event);
}
 
function grFinMovimiento(event)
{
	if(gr_navegador == 0)
	{   
		document.detachEvent("onmousemove", grEnMovimiento);
		document.detachEvent("onmouseup", grFinMovimiento);
	}
	if(gr_navegador == 1)
	{
		document.removeEventListener("mousemove", grEnMovimiento, true);
		document.removeEventListener("mouseup", grFinMovimiento, true);
	}
	//alert(gr_elMovimiento.width)
	//alert(parseFloat(gr_xActual))
	//alert(parseFloat(gr_cursorComienzoX))
	var width = parseFloat(gr_elMovimiento.width) + (parseFloat(gr_xActual) - parseFloat(gr_cursorComienzoX))
	if(width > 20)
		gr_elMovimiento.width = width
		
	gr_band_ordenar = true
}

function grLoadHead(nm_grilla, tipo_orden)
{
	var fila_header = document.getElementById(nm_grilla).rows[0]
	var celdas_header = fila_header.getElementsByTagName("td")
	var nceldas = celdas_header.length
	var i = 0
	var lst = tipo_orden.split(",")
	var nm_columna = ""
	var indice = 0
	
	for(i = 0; i < nceldas; i++)
	{
		indice = ((i + 1) * 4) - 4
		celdas_header[indice].id = nm_grilla + "H" + (i + 1)
		nm_columna = celdas_header[indice].innerHTML
		//alert(nm_columna)
		if(lst[i] != "")
		{
			celdas_header[indice].innerHTML = "<table class=\"gr_chead\">" +
											  "  <tr>" +
											  "    <td class=\"gr_caption01\" onclick=\"GROrdenar('" + nm_grilla  + "', " + (i + 1) + ", '" + lst[i] + "');\"><div style=\"position:relative; width:100%; height:13px; overflow:hidden\">" + nm_columna + "</div></td>" +
											  "    <td class=\"gr_arrow01\" onclick=\"GROrdenar('" + nm_grilla  + "', " + (i + 1) + ", '" + lst[i] + "');\"></td>" +
											  "    <td class=\"gr_resize01\" onmousedown=\"grComienzoMovimiento(event, '" + nm_grilla + "', " + (i + 1) + ");\">&nbsp;</td>" +
											  "  </tr>" +
											  "</table>"
		}
		else
		{
			celdas_header[indice].innerHTML = "<table class=\"gr_chead\">" +
											  "  <tr>" +
											  "    <td class=\"gr_caption01\" style=\"cursor:default;\"><div style=\"position:relative; width:100%; height:13px; overflow:hidden\">" + nm_columna + "</div></td>" +
											  //"    <td class=\"gr_arrow01\" style=\"cursor:default;\"></td>" +
											  "    <td class=\"gr_resize01\" onmousedown=\"grComienzoMovimiento(event, '" + nm_grilla + "', " + (i + 1) + ");\">&nbsp;</td>" +
											  "  </tr>" +
											  "</table>"
		}
	}
}

function grMostrarGrilla(divGrilla, contenido, nm_tabla, tipo_orden)
{
	document.getElementById(divGrilla).innerHTML = contenido
	grLoadHead(nm_tabla, tipo_orden)
}