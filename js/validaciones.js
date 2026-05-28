function MC_ComparaFechas(sTxtIni, sTxtFin) 
{
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Determinar Un Rango Valido de Fechas
Inputs		:    Cadena de Fecha Inical , Cadena de Fecha Final
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
var bResult = true;
var dFecIni, dFecFin, sDia, sMes, nDia, nMes, nAno;

// Si se especificó ambas fechas, verificar que la inicial sea menor o igual a la final
if ((sTxtIni != "") && (sTxtFin != ""))
{
	sFecha = sTxtIni;
	nDia = parseInt(sFecha.substring(0,sFecha.indexOf("/")),10);
	nMes = parseInt(sFecha.substring(sFecha.indexOf("/")+1,sFecha.indexOf("/",sFecha.indexOf("/")+1)),10);
	nAno = parseInt(sFecha.substring(sFecha.indexOf("/",sFecha.indexOf("/")+1)+1,sFecha.length),10);
	dFecIni = new Date(nAno,nMes-1,nDia);
	sFecha = sTxtFin;
	nDia = parseInt(sFecha.substring(0,sFecha.indexOf("/")),10);
	nMes = parseInt(sFecha.substring(sFecha.indexOf("/")+1,sFecha.indexOf("/",sFecha.indexOf("/")+1)),10);
	nAno = parseInt(sFecha.substring(sFecha.indexOf("/",sFecha.indexOf("/")+1)+1,sFecha.length),10);
	dFecFin = new Date(nAno,nMes-1,nDia);
	if (dFecIni > dFecFin)
		bResult = false;
	}
	return bResult;
}

function MC_ComparaFechasCalendario(sTxtIni, sTxtFin) 
{
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Determinar Un Rango Valido de Fechas
Inputs		:    Cadena de Fecha Inical , Cadena de Fecha Final
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
var bResult = true;
var dFecIni, dFecFin, sDia, sMes, nDia, nMes, nAno;

// Si se especificó ambas fechas, verificar que la inicial sea menor o igual a la final
if ((sTxtIni != "") && (sTxtFin != ""))
{
	sFecha = sTxtIni;
	nDia = parseInt(sFecha.substring(0,sFecha.indexOf("/")),10);
	nMes = parseInt(sFecha.substring(sFecha.indexOf("/")+1,sFecha.indexOf("/",sFecha.indexOf("/")+1)),10);
	nAno = parseInt(sFecha.substring(sFecha.indexOf("/",sFecha.indexOf("/")+1)+1,sFecha.length),10);
	dFecIni = new Date(nAno,nMes-1,nDia);
	sFecha = sTxtFin;
	nDia = parseInt(sFecha.substring(0,sFecha.indexOf("/")),10);
	nMes = parseInt(sFecha.substring(sFecha.indexOf("/")+1,sFecha.indexOf("/",sFecha.indexOf("/")+1)),10);
	nAno = parseInt(sFecha.substring(sFecha.indexOf("/",sFecha.indexOf("/")+1)+1,sFecha.length),10);
	dFecFin = new Date(nAno,nMes-1,nDia);
	if (dFecIni >= dFecFin)
		bResult = false;
	}
	return bResult;
}

function MC_ComparaFechasOpcion(sTxtIni, sTxtFin,sOpcion) 
{
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Determinar Un Rango Valido de Fechas con Regla de Decision
Inputs		:    Cadena de Fecha Inical , Cadena de Fecha Final, Opcion de Decision
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
var bResult = true;
var dFecIni, dFecFin, sDia, sMes, nDia, nMes, nAno;

// Si se especificó ambas fechas, verificar que la inicial sea menor o igual a la final
if ((sTxtIni != "") && (sTxtFin != ""))
{
	alert("aa");
	sFecha = sTxtIni;
	nDia = parseInt(sFecha.substring(0,sFecha.indexOf("/")),10);
	nMes = parseInt(sFecha.substring(sFecha.indexOf("/")+1,sFecha.indexOf("/",sFecha.indexOf("/")+1)),10);
	nAno = parseInt(sFecha.substring(sFecha.indexOf("/",sFecha.indexOf("/")+1)+1,sFecha.length),10);
	dFecIni = new Date(nAno,nMes-1,nDia);
	sFecha = sTxtFin;
	nDia = parseInt(sFecha.substring(0,sFecha.indexOf("/")),10);
	nMes = parseInt(sFecha.substring(sFecha.indexOf("/")+1,sFecha.indexOf("/",sFecha.indexOf("/")+1)),10);
	nAno = parseInt(sFecha.substring(sFecha.indexOf("/",sFecha.indexOf("/")+1)+1,sFecha.length),10);
	dFecFin = new Date(nAno,nMes-1,nDia);
	alert("aa");
	if (dFecIni > dFecFin)
		bResult = false;
	}
	if(sOpcion!="" && eval(sOpcion)>0){
		alert("a");
		/*switch (sOpcion){
			case 1:
			alert("1");
			if (dFecIni > dFecFin)
				bResult = false;
			}
			break;
			case 2:
			alert("2");
			if (dFecIni >= dFecFin)
				bResult = false;
			}
			break;
			case 3:
			alert("3");
			if (dFecIni < dFecFin)
				bResult = false;
			}
			break;
			case 4:
			alert("4");
			if (dFecIni <= dFecFin)
				bResult = false;
			}
			break;
			case 5:
			alert("5");
			if (dFecIni = dFecFin)
				bResult = false;
			}
			break;
		}*/
	}
	alert(bResult);
	return bResult;
}


function MC_ValidaNumero(strNameObj) 
{	
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Limitar el Ingreso solo a Numeros
Inputs		:    Objeto de Formulario
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
	//strNameObj : Nombre de la caja de texto a validar.
	var Obj = document.all[strNameObj];
	var intEncontrado = "1234567890".indexOf(String.fromCharCode(window.event.keyCode));		
	if (intEncontrado == -1) {
		window.event.keyCode = 0;		
	}		
}
function MC_PermiteNumeroPunto()
{
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Limitar el Ingreso solo a Numeros y Punto
Inputs		:    Input del Teclado
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
	if (((window.event.keyCode>=48) && (window.event.keyCode<=57)) || (window.event.keyCode==46)){}
	else {window.event.returnValue =0;}
	
}
function MC_PermiteNumero()
{
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Limitar el Ingreso solo a Numeros 
Inputs		:    Input del Teclado
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
	if (((window.event.keyCode>=48) && (window.event.keyCode<=57))){}
	else {window.event.returnValue =0;}
	
}

function MC_PermiteNumeroSlash()
{
/*************************************************************************************
Modulo 		:    EDYFICAR
Descripción 	:    Permite Limitar el Ingreso solo a Numeros y Slash
Inputs		:    Input del Teclado
Autor 		:    Manuel Carruitero Gonzalez
Fecha/hora	:    01/11/2004
*************************************************************************************/
	if (((window.event.keyCode>=48) && (window.event.keyCode<=57)) || (window.event.keyCode==47)){}
	else {window.event.returnValue =0;}
	
}

/*****************************************************************************************
Modulo		:	Todos
Descripcion	:	Funciones generales para cadenas como Left, Mid, Rigth, etc. 
				y funciones para el control de campos numericos
Autor		:	Alexander Rodriguez
Fecha		:	10/03/2010
*/

function ValidarNumerico(campo, e, ndecimales)
{
	var res = true
	if(e < 48 || (e > 57 && e < 96) || e > 105)
	{
		if(e != 9 && (e != 190 || ndecimales <= 0) && (e != 110 || ndecimales <= 0) && e != 8 && e != 109 && e != 46 && e != 37 && e != 39 && e != 16 && e != 35 && e != 36)
			res = false
	}
	if(campo.value.indexOf('.') >= 0 && (e == 190 || e == 110))
			res = false

	//alert(e + ' res = ' + res)
	return res
}

function ValidarParteEntera(parte_entera)
{
	var numeros = "0123456789"
	var parte_entera_new = ""
	var i = 0
	var cont = 0
	
	for(i = parte_entera.length - 1; i >= 0; i--)
	{
		if(parte_entera.charAt(i) != "," && numeros.indexOf(parte_entera.charAt(i)) != -1)
		{
			cont = cont + 1
			parte_entera_new = parte_entera.charAt(i) + parte_entera_new
			if(cont == 3 && i - 1 >= 0)
			{
				parte_entera_new = ',' + parte_entera_new
				cont = 0
			}
		}
	}
	if(parte_entera_new == "")
		parte_entera_new = "0"
		
	return parte_entera_new
}

function ValidarParteDecimal(parte_decimal, ndecimales)
{
	var numeros = "0123456789"
	var parte_decimal_new = ""
	var i = 0
	var cdec = ""

	if(ndecimales <= 0)
		parte_decimal_new = ''
	else
	{
		for(i = parte_decimal.length - 1; i >= 0; i--)
		{
			if(numeros.indexOf(parte_decimal.charAt(i)) != -1)
			{
				parte_decimal_new = parte_decimal.charAt(i) + parte_decimal_new
			}
		}
		
		i = 0	
		while(i < ndecimales) 
		{
			cdec = cdec + '0';
			i = i + 1
		}
		
		parte_decimal_new = '.' + Left(parte_decimal_new + cdec, ndecimales)
	}
	
	return parte_decimal_new
}

function ValidarNumericoBlur(campo, ndecimales)
{
	var i = 0
	var parte_entera = ""
	var parte_entera_new = ""
	var parte_decimal = ""
	var parte_decimal_new = ""
	var numeros = "0123456789"
	var cont = 0
	var signo = ""
	
	campo.value = Replace(campo.value, ",", '')
	signo = Left(campo.value, 1)

	if(signo != "-")
		signo = ""
	else
		campo.value = Replace(campo.value, "-", '')
	
	var lst = campo.value.split(".")
	
	if(lst.length == 2)
		campo.value = signo + ValidarParteEntera(lst[0]) + ValidarParteDecimal(lst[1], ndecimales)
	else
	{
		if(lst.length > 2)
			campo.value = signo + '0' + ValidarParteDecimal('', ndecimales)
		else
			campo.value = signo + ValidarParteEntera(campo.value) + ValidarParteDecimal('', ndecimales)
	}
}

function ValidarNumericoFocus(campo, ndecimales)
{
	ValidarNumericoBlur(campo, ndecimales)
	campo.value = Replace(campo.value, ",", "")
	campo.select();
}

function Replace(valor,v1,v2)
{
	var i = 0
	var res = ""
	for(i = 0; i < valor.length; i++)
	{
		if(valor.charAt(i) != v1)
		{
			res = res + valor.charAt(i)
		}
		else
		{
			res = res + v2
		}
	}
	return res
}

function Left(str, n)
{
	if (n <= 0)
	    return "";
	else if (n > String(str).length)
	    return str;
	else
	    return String(str).substring(0, n);
}

function Right(str, n)
{
    if (n <= 0)
       return "";
    else if (n > String(str).length)
       return str;
    else 
	{
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}

function Mid(str, start, len)
{
    if(start < 0 || len < 0) 
		return "";

	var iEnd, iLen = String(str).length;
	
    if (start + len > iLen)
          iEnd = iLen;
    else
          iEnd = start + len;
		  
    return String(str).substring(start, iEnd);
}

function GetFocus(campo)
{
	campo.style.backgroundColor = '#FFFF00'
	campo.select()
	return false
}

function LostFocus(campo)
{
	campo.style.backgroundColor = '#FFFFFF'
	return false
}

// e:			evento
// tipo:		entero, alfanumerico, etc
// campoAct:	campo que pierde el foco cuando pulsa enter
// campoSig:	campo de obtendra el foco cuando se pulsa enter
function ValidarCC(e, tipo, campoAct, campoSig)
{
	tecla = (document.all) ? e.keyCode : e.which
	if(tecla == 0) return true
	if(tecla == 8) return true // tecla de retroceso
	if(tecla == 13)
	{
		LostFocus(CampoAct)
		campoSig.focus()
		return false
	}
	switch(tipo)
	{
		case 'entero':			patron = /\d/
								break
		case 'alfanumerico':	patron = /\w/	// acepta numeros y letras
								break
		case 'nonumerico':		patron = /\D/	// no acepta numeros
								break
	}
	var te = String.fromCharCode(tecla)
	return patron.test(te)
}

function ValidarSC(e, tipo)
{
	
	tecla = (document.all) ? e.keyCode : e.which
	//alert(tecla)
	if(tecla == 0) return true
	if(tecla == 8) return true // tecla de retroceso
	switch(tipo)
	{
		case 'entero':			patron = /\d/
								break
		case 'alfanumerico':	patron = /\w/	// acepta numeros y letras
								break
		case 'nonumerico':		patron = /\D/	// no acepta numeros
								break
	}
	var te = String.fromCharCode(tecla)
	return patron.test(te)
}

var PatronFecha = new Array(2, 2, 4)
var PatronHora = new Array(2, 2)

// d:		objeto al que se aplica la mascara
// sep:		seperador
// pat:		patron
// nums:	true/false
function Mascara(d, sep, pat, nums)
{
	if(d.valant != d.value)
	{
		val = d.value
		largo = val.length
		val = val.split(sep)
		val2 = ''
		
		for(r = 0; r <val.length; r++)
		{
			val2 += val[r]
		}
		
		if(nums)
		{
			for(z = 0; z < val2.length; z++)
			{
				if(isNaN(val2.charAt(z)))
				{
					letra = new RegExp(val2.charAt(z), "g")
					val2 = val2.replace(letra, "")
				}
			}
		}
		
		val = ""
		val3 = new Array()
		
		for(s = 0; s < pat.length; s++)
		{
			val3[s] = val2.substring(0, pat[s])
			val2 = val2.substr(pat[s])
		}
		
		for(q = 0; q < val3.length; q++)
		{
			if(q == 0)
			{
				val = val3[q]
			}
			else
			{
				if(val3[q] != "")
				{
					val += sep + val3[q]
				}
			}
		}
		
		d.value = val
		d.valant = val
	}
}

function ValidarHoraKeyUp(d)
{
	Mascara(d, ":", PatronHora, true)
}

function ValidarFechaKeyUp(d)
{
	Mascara(d, "/", PatronFecha, true)
}

function ValidarHoraBlur(d)
{
	var numeros = "0123456789"
	var cad = ""
	var i = 0

	for(i = d.value.length - 1; i >= 0; i--)
	{
		if(d.value.charAt(i) == ":" || numeros.indexOf(d.value.charAt(i)) != -1)
			cad =  d.value.charAt(i) + cad
	}
	
	d.value = cad

	if(d.value == "")
		d.value = "00:00"

	lst = d.value.split(":")
	
	if(lst.length == 1)
	{
		if(parseInt(lst[0]) > 23)
			d.value = '23:00'
		else
			d.value = Right('00' + parseInt(lst[0]), 2) + ':00'
	}
	else
	{
		if(lst[0] == "")
			lst[0] = "00"
			
		if(parseInt(lst[0]) > 23)
			lst[0] = "23"
		else
			lst[0] = Right('00' + lst[0], 2)

		//alert('lst[0]=' + lst[0])
		
		//alert('lst[1]=' + lst[1])
		if(lst[1] == "")
			lst[1] = "00"
			
		if(lst[1].length == 1)
			lst[1] = lst[1] + '0'
			
		if(parseInt(lst[1]) > 59)
			lst[1] = "59"
		else
			lst[1] = Left(lst[1] + '00', 2)
			
			
		d.value = lst[0] + ':' + lst[1]
	}
}

function ValidarFechaBlur(d)
{
	var numeros = "0123456789"
	var cad = ""
	var i = 0
	var fecha = new Date();
	var dia = 0
	var mes = 0
	var anho = 0


	for(i = d.value.length - 1; i >= 0; i--)
	{
		if(d.value.charAt(i) == "/" || numeros.indexOf(d.value.charAt(i)) != -1)
			cad =  d.value.charAt(i) + cad
	}
	
	d.value = cad


	if(cad == "" || cad == "//")
		cad = "//"
	else
	{
		lst = d.value.split("/")
		if(lst.length > 0)
		{
			if(!isNaN(parseInt(lst[0], 10)))
			{
				if(parseInt(lst[0], 10) > 31)
					dia = 31
				else
					dia = parseInt(lst[0], 10)
			}
		}
			
		if(lst.length > 1)
		{
			if(!isNaN(parseInt(lst[1], 10)))
			{
				if(parseInt(lst[1], 10) > 12)
					mes = 12
				else
					mes = parseInt(lst[1], 10)
			}
		}

		if(lst.length > 2)
		{
			if(!isNaN(parseInt(lst[2], 10)))
			{
				if(parseInt(lst[2], 10) < 1900)
					anho = fecha.getFullYear()
				else
					anho = parseInt(lst[2], 10)
			}
		}
		else
			if(lst.length > 1)
				anho = fecha.getFullYear();

		if(dia > 0 && mes > 0 && anho > 0)
		{
			var dm = DiasDelMes(mes, anho)
			if (dia > dm)
				dia = dm
		}
		
		cad = ""
		
		if(dia == 0)	cad = cad + '/'
		else			cad = cad + Right('00' + dia, 2) + '/'
		
		if(mes == 0)	cad = cad + '/'
		else			cad = cad + Right('00' + mes, 2) + '/'
		
		if(anho == 0)	cad = cad + ''
		else			cad = cad + Right('0000' + anho, 4)

/*
	if(d.value == "" || d.value == "//")
		d.value = "//"
	else
	{
		lst = d.value.split("/")
		if(lst.length > 0)
		{
			if(isNaN(parseInt(lst[0], 10)))
				d.value = '//'
			else
			{
				if(parseInt(lst[0], 10) > 31)
				{
					dia = 31
					d.value = '31/'
				}
				else
				{
					dia = parseInt(lst[0], 10)
					d.value = Right('00' + parseInt(lst[0], 10), 2) + '/'
				}
			}
		}
		else
			d.value = '/'
			
		if(lst.length > 1)
		{
			if(isNaN(parseInt(lst[1], 10)))
				d.value = d.value + '/'
			else
			{
				if(parseInt(lst[1], 10) > 12)
				{
					d.value = d.value + '12/'
					mes = 12
				}
				else
				{
					mes = parseInt(lst[1], 10)
					d.value = d.value + Right('00' + parseInt(lst[1], 10), 2) + '/'
				}
			}
		}
		else
			d.value = d.value + '/'

		band = false
		if(lst.length > 2)
		{
			if(isNaN(parseInt(lst[2], 10)))
				d.value = d.value + '/'
			else
			{
				band = true
				if(parseInt(lst[2], 10) < 1900)
				{
					anho = fecha.getFullYear()
					d.value = d.value + fecha.getFullYear();
				}
				else
				{
					anho = parseInt(lst[2], 10)
					d.value = d.value + Right('0000' + parseInt(lst[2], 10), 4)
				}
			}
		}
		else
			if(lst.length > 1)
				d.value = d.value + fecha.getFullYear();
*/
	}
	
	//alert(dia)
	//alert(mes)
	//alert(anho)
	d.value = cad
}

function DiasDelMes(mes, anno) 
{
	switch (mes) 
	{
	    case 1 : case 3 : case 5 : case 7 : case 8 : case 10 : case 12 : return 31;
		case 2 : return (anno % 4 == 0) ? 29 : 28;
	}
	
	return 30;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

function getTeclaIE(e)
{
        return e.keyCode;
}

function getTeclaNIE(e)
{
        return e.which;
}

function getTecla(e)
{
        var nav = navigator.appName;
        var tecla = 0
        if(nav.indexOf("Microsoft") != -1)
                tecla = getTeclaIE(event);
        else
                tecla = getTeclaNIE(e);

        return tecla;
}

function ValidarNumericoF2(campo, e, ndecimales, cant, csig, tipo, campotexto)
{
	var tecla = getTecla(e);
	var res = true
	//document.getElementById("res").innerHTML = tecla
	if(tecla == 113) //F2
	{
			var left = 0
			var top = 0

			left = getAbsoluteElementPosition(campo).left;
			top = getAbsoluteElementPosition(campo).top;
			

			if(tipo == 'CLI') document.getElementById("tdTitulo").innerHTML = "Busqueda de Clientes"
			if(tipo == 'CLICC') document.getElementById("tdTitulo").innerHTML = "Busqueda de Clientes"
			if(tipo == 'CON') document.getElementById("tdTitulo").innerHTML = "Busqueda de Consignatarios"
			if(tipo == 'AGE') document.getElementById("tdTitulo").innerHTML = "Busqueda de Agentes"
			if(tipo == 'ADU') document.getElementById("tdTitulo").innerHTML = "Busqueda de Agentes de Aduana"
			if(tipo == 'VEN') document.getElementById("tdTitulo").innerHTML = "Busqueda de Vendedores"
			if(tipo == 'LIA') document.getElementById("tdTitulo").innerHTML = "Busqueda de Lineas Aereas"
			if(tipo == 'NAV') document.getElementById("tdTitulo").innerHTML = "Busqueda de Navieras"
			if(tipo == 'COO') document.getElementById("tdTitulo").innerHTML = "Busqueda de Coloader"
			if(tipo == 'TER') document.getElementById("tdTitulo").innerHTML = "Busqueda de Terminales de Almacenamiento"
			if(tipo == 'POR') document.getElementById("tdTitulo").innerHTML = "Busqueda de Agentes Portuarios"
			if(tipo == 'TDO') document.getElementById("tdTitulo").innerHTML = "Busqueda de Tipos de Documento"
			if(tipo == 'CUS') document.getElementById("tdTitulo").innerHTML = "Busqueda de Customers"
			if(tipo == 'SRV2')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Servicios"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																		"</select>"
			}
			if(tipo == 'SRVE')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Servicios"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																		"</select>"
			}
			if(tipo == 'SVIMI')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Servicios"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																		"</select>"
			}
			if(tipo == 'SVIME')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Servicios"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																		"</select>"
			}
			if(tipo == 'CLI' || tipo == 'CLICC' || tipo == 'CON' || tipo == 'AGE' || tipo == 'VEN' || tipo == 'LIA' || tipo == 'NAV' || tipo == 'ADU' || tipo == 'TER' || tipo == 'POR' || tipo == 'CUS')
			{
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\">RUC</option>" +
																			"<option value=\"2\" selected=\"selected\">Nombre</option>" +
																			"<option value=\"3\">Alias</option>" +
																		"</select>"
			}
			if(tipo == 'TDO')
			{
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																		"</select>"
			}
			if(tipo == 'PTO')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Puertos"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																			"<option value=\"2\">Pais</option>" +
																		"</select>"
			}
			if(tipo == 'ATO')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Aeropuertos"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Nombre</option>" +
																			"<option value=\"2\">País</option>" +
																		"</select>"
			}
			if(tipo == 'CTA')
			{
				document.getElementById("tdTitulo").innerHTML = "Busqueda de Cuenta Contable"
				document.getElementById("tdCampoBusqueda").innerHTML = "<select id=\"cboBusquedaCampo\" class=\"normal\" style=\"width:80px\" onkeydown=\"NextControl13(event, '', 'txtBusquedaTexto');\">" +
																			"<option value=\"1\" selected=\"selected\">Analítica</option>" +
																		"</select>"
			}
			
			document.getElementById("tblBusqueda").style.display = ""
			document.getElementById("tblBusqueda").style.left = left + "px"
			document.getElementById("tblBusqueda").style.top = top + "px"
			document.getElementById("txtBusquedaTipo").value = tipo
			document.getElementById("txtBusquedaControl").value = campo.id
			document.getElementById("txtBusquedaControlTexto").value = campotexto
			document.getElementById("tdBusquedaResultado").innerHTML = ""
			document.getElementById("txtBusquedaTexto").value = ""
			document.getElementById("txtBusquedaTexto").focus()
	}
	else
	{
			if(tecla == 38 || tecla == 40 || tecla == 13)
			{
					NextControl(e, cant, csig)
			}
			else
			{
					if(tecla < 48 || (tecla > 57 && tecla < 96) || tecla > 105)
					{
							if(tecla != 9 && (tecla != 190 || ndecimales <= 0) && (tecla != 110 || ndecimales <= 0) && tecla != 8 && tecla != 109 && tecla != 46 && tecla != 37 && tecla != 39 && tecla != 16 && tecla != 35 && tecla != 36)
									res = false
					}

					if(campo.value.indexOf('.') >= 0 && (tecla == 190 || tecla == 110))
									res = false
			}
	}

	//alert(tecla + ' res = ' + res)
	return res
}

function getDimensions(oElement)
{
        var x, y, w, h;
        x = y = w = h = 0;
        if (document.getBoxObjectFor)
        {
                // Mozilla
                var oBox = document.getBoxObjectFor(oElement);
                x = oBox.x-1;
                w = oBox.width;
                y = oBox.y-1;
                h = oBox.height;
        }
        else if (oElement.getBoundingClientRect)
        {
                // IE
                var oRect = oElement.getBoundingClientRect();
                x = oRect.left-2;
                w = oElement.clientWidth;
                y = oRect.top-2;
                h = oElement.clientHeight;
        }
        return {x: x, y: y, w: w, h: h};
}

function getAbsoluteElementPosition(element)
{
	if (typeof element == "string")
		element = document.getElementById(element)
	
	if (!element) return { top:0,left:0 };
	
	var y = 0;
	var x = 0;
	while (element.offsetParent)
	{
		x += element.offsetLeft;
		y += element.offsetTop;
		element = element.offsetParent;
	}
	return {top:y,left:x};
}

function ValidarNumericoF2Blur(campo, ndecimales, tipo, campotexto)
{
	document.getElementById("txtBusquedaTipo").value = tipo
	ValidarNumericoBlur(campo, ndecimales)
	
	QuitarComas(campo);
	BusquedaMaestro(campo.value, campotexto)
}

function NextControl13(e, cant, csig)
{
	var tecla = getTecla(e);
	if(tecla == 13)
	{
		NextControl(e, cant, csig)
	}
	return true
}

function NextControl(e, cant, csig)
{
	var tecla = getTecla(e);
	if(tecla == 38) // up
	{
		if(document.getElementById(cant) != null)
		{
			document.getElementById(cant).focus();
			tecla = 0;
			return false;
		}
	}
	if(tecla == 40 || tecla == 13) // down, enter
	{
		if(document.getElementById(csig) != null)
		{
			if(document.getElementById(csig).disabled == false && document.getElementById(csig).style.display == "")
			{
				document.getElementById(csig).focus();
				tecla = 0;
				return false;
			}
			else
			{
				NextControlTI(document.getElementById(csig).tabIndex)
			}
		}
		else
		{
			//NextControlTI(csig.tabindex)
		}
	}
	return true
}

function NextControlTI(tabIndex)
{
	try
	{
		var elementos = document.frmFormulario.elements
		var ti = tabIndex
		var x = 1
		var i = 0
		var band = false
		
		for(x = 1; x <= 20; x++)
		{
			band = false
			for(i = 0; i < elementos.length; i++)
			{
				if(elementos[i].tabIndex == ti + 1)
				{
					band = true
					if(elementos[i].disabled == false && elementos[i].style.display == "")
					{
						elementos[i].focus();
						return 0;
					}
					else
					{
						ti = ti + 1
						break;
					}
				}
			}
			if(band == false)
			{
				ti = ti + 1
			}
		}
	}
	catch(e)
	{
		//alert("Error Nro. " + e.number + ": " + e.description)
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
