var isCtrl = false;
var bloqueo = false;

document.onkeyup=function(e)
{
	var tecla = getTecla(e);

	if(tecla == 17) isCtrl = false;
}

document.onkeydown=function(e)
{
	try
	{
		var tecla = getTecla(e);
		if(tecla == 17) isCtrl = true;
		if(tecla == 27)
		{
			if(document.getElementById("divBloqueaPagina") != null)
				if(document.getElementById("divBloqueaPagina").style.display == "")
					CerrarBloqueo();

			return false;
		}
		if(tecla == 71 && isCtrl == true) // CTRL+S: Guardar
		{
			alert("Guardar")
			return false;
		}
	}
	catch(e)
	{
		alert("Error y Nro. " + e.number + ": " + e.description)
	}
}

function CerrarBloqueo()
{
	try
	{
		var idsistema = document.getElementById("txtIdSistema").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var origen_opciones = "opc" + tipo + idmenu

		document.getElementById(origen_opciones).innerHTML = ""
		document.getElementById("divBloqueaPagina").style.display = "none"

		document.getElementById("txtIdSistema").value = ""
		document.getElementById("txtTipoOpcion").value = ""
		document.getElementById("txtIdOpcion").value = ""
		document.getElementById("txtNivel").value = ""
	}
	catch(e)
	{
		alert("Error x Nro. " + e.number + ": " + e.description)
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////

function Desplegar(tipo, idmenu, d)
{
	try
	{
		var det = document.getElementById("det" + tipo + idmenu)
		var des = document.getElementById("des" + tipo + idmenu)
		if(d == 1)
		{
			des.innerHTML = "<img src=\"img/menos.gif\" onClick=\"Desplegar('" + tipo + "', " + idmenu + ", 0)\">"
			det.style.display = ""
		}
		else
		{
			des.innerHTML = "<img src=\"img/mas.gif\" onClick=\"Desplegar('" + tipo + "', " + idmenu + ", 1)\">"
			det.style.display = "none"
		}
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MostrarOpciones(idsistema, tipo, idmenu, topcion, nivel)
{
	try
	{
		if(bloqueo) return false;
		
		var destino_opciones = "opc" + tipo + idmenu
		var cont_opciones = document.getElementById("txtContOpciones").value
		if(destino_opciones != cont_opciones)
		{
			document.getElementById(destino_opciones).innerHTML = document.getElementById(cont_opciones).innerHTML
			document.getElementById(cont_opciones).innerHTML = ""

			document.getElementById("txtContOpciones").value = destino_opciones
			document.getElementById("txtIdSistema").value = idsistema
			document.getElementById("txtTipoOpcion").value = tipo
			document.getElementById("txtIdOpcion").value = idmenu
			document.getElementById("txtNivel").value = nivel
		}
		if(tipo == "S" && topcion == 1)
		{
			document.getElementById("divBtnNuevoM").style.display = ""
			document.getElementById("divBtnNuevoF").style.display = "none"
			document.getElementById("divBtnEditar").style.display = "none"
			document.getElementById("divBtnEliminar").style.display = "none"
			document.getElementById("divBtnArriba").style.display = "none"
			document.getElementById("divBtnAbajo").style.display = "none"
		}
		if(tipo == "M" && topcion == 1)
		{
			document.getElementById("divBtnNuevoM").style.display = ""
			document.getElementById("divBtnNuevoF").style.display = "none"
			document.getElementById("divBtnEditar").style.display = ""
			document.getElementById("divBtnEliminar").style.display = ""
			document.getElementById("divBtnArriba").style.display = ""
			document.getElementById("divBtnAbajo").style.display = ""
		}
		if(tipo == "M" && topcion == 2)
		{
			document.getElementById("divBtnNuevoM").style.display = "none"
			document.getElementById("divBtnNuevoF").style.display = ""
			document.getElementById("divBtnEditar").style.display = ""
			document.getElementById("divBtnEliminar").style.display = ""
			document.getElementById("divBtnArriba").style.display = ""
			document.getElementById("divBtnAbajo").style.display = ""
		}
		if(tipo == "M" && topcion == 3)
		{
			document.getElementById("divBtnNuevoM").style.display = ""
			document.getElementById("divBtnNuevoF").style.display = ""
			document.getElementById("divBtnEditar").style.display = ""
			document.getElementById("divBtnEliminar").style.display = ""
			document.getElementById("divBtnArriba").style.display = ""
			document.getElementById("divBtnAbajo").style.display = ""
		}
		if(tipo == "F" && topcion == 1)
		{
			document.getElementById("divBtnNuevoM").style.display = "none"
			document.getElementById("divBtnNuevoF").style.display = "none"
			document.getElementById("divBtnEditar").style.display = ""
			document.getElementById("divBtnEliminar").style.display = ""
			document.getElementById("divBtnArriba").style.display = "none"
			document.getElementById("divBtnAbajo").style.display = "none"
		}
		if(tipo == "A" && topcion == 1)
		{
			document.getElementById("divBtnNuevoM").style.display = "none"
			document.getElementById("divBtnNuevoF").style.display = "none"
			document.getElementById("divBtnEditar").style.display = "none"
			document.getElementById("divBtnEliminar").style.display = ""
			document.getElementById("divBtnArriba").style.display = "none"
			document.getElementById("divBtnAbajo").style.display = "none"
		}
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Nuevo(mf)
{
	if(mf == "M")
		MenuNuevo()
	if(mf == "F")
		FormularioNuevo();
}

function Editar()
{
	var tipo = document.getElementById("txtTipoOpcion").value
	if(tipo == "M")
		MenuEditar()
	if(tipo == "F")
		FormularioEditar()
}

function MenuNuevo()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idsistema = document.getElementById("txtIdSistema").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value
		var idmenupadre = 0
		if(tipo != "S")
			idmenupadre = idmenu

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&accion=menu_nuevo' +
						'&op=0' +
						'&idsistema=' + idsistema +
						'&idmenupadre=' + idmenupadre +
						'&nivel=' + nivel

		document.getElementById("divBloqueaPagina").style.display = ""
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var origen_opciones = "opc" + tipo + idmenu
					var destino_opciones = "divContOpciones"
					document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
					document.getElementById(origen_opciones).innerHTML = ""
					document.getElementById("txtContOpciones").value = destino_opciones
					//document.getElementById("txtTipoOpcion").value = ""
					//document.getElementById("txtIdOpcion").value = ""

					document.getElementById("divBloqueaPagina").style.display = ""
					document.getElementById(origen_opciones).innerHTML = ajax.responseText
					document.getElementById("txtCodigo").focus()
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MenuInsertar(idsistema, idmenupadre, op)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var codigo = document.getElementById("txtCodigo").value
		var nombre = document.getElementById("txtNombre").value
		var nivel = document.getElementById("txtNivel").value

		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var strDes = document.getElementById("des" + tipo + idmenu).innerHTML
		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
			desplegado = 0
		else
			if(strDes.indexOf("menos.gif") != -1)
				desplegado = 1


		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idsistema=' + idsistema +
						'&idmenupadre=' + idmenupadre +
						'&tipopadre=' + tipo +
						'&codigo=' + escape(codigo) +
						'&nombre=' + escape(nombre) +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado
		if(op == 0)
			valores = valores + '&accion=menu_inserta'
		else
			valores = valores + '&accion=menu_modifica'

		var ajax = NuevoAjax();

		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						if(lst[1] != null) document.getElementById("det" + tipo + idmenu).innerHTML = lst[1]
						if(lst[2] != null) document.getElementById("fila" + tipo + idmenu).innerHTML = lst[2]
						CerrarBloqueo()
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MenuEditar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idsistema = document.getElementById("txtIdSistema").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value
		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&accion=menu_editar' +
						'&op=1' +
						'&idsistema=' + idsistema +
						'&idmenu=' + idmenu +
						'&nivel=' + nivel

		document.getElementById("divBloqueaPagina").style.display = ""
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var origen_opciones = "opc" + tipo + idmenu
					var destino_opciones = "divContOpciones"
					document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
					document.getElementById(origen_opciones).innerHTML = ""
					document.getElementById("txtContOpciones").value = destino_opciones
					//document.getElementById("txtTipoOpcion").value = ""
					//document.getElementById("txtIdOpcion").value = ""

					document.getElementById("divBloqueaPagina").style.display = ""
					document.getElementById(origen_opciones).innerHTML = ajax.responseText
					document.getElementById("txtCodigo").focus()
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MenuModificar(idsistema, idmenu, op)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var codigo = document.getElementById("txtCodigo").value
		var nombre = document.getElementById("txtNombre").value
		var nivel = document.getElementById("txtNivel").value

		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var strDes = document.getElementById("des" + tipo + idmenu).innerHTML

		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
			desplegado = 0
		else
			if(strDes.indexOf("menos.gif") != -1)
				desplegado = 1


		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idsistema=' + idsistema +
						'&idmenu=' + idmenu +
						'&codigo=' + escape(codigo) +
						'&nombre=' + escape(nombre) +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado
		if(op == 0)
			valores = valores + '&accion=menu_inserta'
		else
			valores = valores + '&accion=menu_modifica'

		var ajax = NuevoAjax();

		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						if(lst[1] != null) document.getElementById("fila" + tipo + idmenu).innerHTML = lst[1]
						CerrarBloqueo()
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Eliminar()
{
	var tipo = document.getElementById("txtTipoOpcion").value
	if(tipo == "M")
		MenuEliminar()
	if(tipo == "F")
		FormularioEliminar()
	if(tipo == "A")
		AccionEliminar()
}

function MenuEliminar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value

		var fila_menu = document.getElementById("fila" + tipo + idmenu);
		var det_menu = document.getElementById("det" + tipo + idmenu);
		var padre_fila_menu = fila_menu.parentNode;
		var strDes = document.getElementById(padre_fila_menu.id.replace("det", "des")).innerHTML
		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
				desplegado = 0
		else
				if(strDes.indexOf("menos.gif") != -1)
						desplegado = 1

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idmenu=' + idmenu +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado

		valores = valores + '&accion=menu_elimina'

		var ajax = NuevoAjax();

		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						// ocultamos las opciones
						var origen_opciones = "opc" + tipo + idmenu
						var destino_opciones = "divContOpciones"
						document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
						document.getElementById(origen_opciones).innerHTML = ""
						document.getElementById("txtContOpciones").value = destino_opciones

						// eliminamos los div del menu y su detalle
						padre_fila_menu.removeChild(fila_menu);
						padre_fila_menu.removeChild(det_menu);

						// cargamos la fila del menu padre
						var id = padre_fila_menu.id.replace("det", "fila")
						if(lst[1] != null) document.getElementById(id).innerHTML = lst[1]

						// si no tiene hijos ocultamos el detalle
						strDes = document.getElementById(id.replace("fila", "des")).innerHTML
						if(strDes.indexOf("mas.gif") == -1 && strDes.indexOf("menos.gif") == -1)
							document.getElementById(id.replace("fila", "det")).style.display = "none"
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Subir()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var fila_menu = document.getElementById("fila" + tipo + idmenu);
		var det_menu = document.getElementById("det" + tipo + idmenu);
		var div = document.createElement('div');
		var xfila = -1
		var i = 0
		var padre_fila_menu = fila_menu.parentNode;

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idmenu=' + idmenu

		valores = valores + '&accion=menu_subir'

		var ajax = NuevoAjax();

		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						// ocultamos las opciones
						var origen_opciones = "opc" + tipo + idmenu
						var destino_opciones = "divContOpciones"
						document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
						document.getElementById(origen_opciones).innerHTML = ""
						document.getElementById("txtContOpciones").value = destino_opciones

						// ubicamos la posicion del div fila del menu
						for(i = 0; i < padre_fila_menu.childNodes.length; i++)
						{
							if(padre_fila_menu.childNodes[i].id.indexOf("fila") != -1)
								if(padre_fila_menu.childNodes[i].id == fila_menu.id)
								{
									xfila = i
									break
								}	
						}

						// movemos hacia arriba
						if(xfila >= 2)
						{
							i = 0
							while(i < xfila - 2)
							{
								div.appendChild(padre_fila_menu.childNodes[0])
								i = i + 1
							}
							div.appendChild(padre_fila_menu.childNodes[2])
							div.appendChild(padre_fila_menu.childNodes[2])
							while(padre_fila_menu.childNodes.length > 0)
								div.appendChild(padre_fila_menu.childNodes[0])
							padre_fila_menu.innerHTML = div.innerHTML
						}
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Bajar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var fila_menu = document.getElementById("fila" + tipo + idmenu);
		var det_menu = document.getElementById("det" + tipo + idmenu);
		var div = document.createElement('div');
		var xfila = -1
		var i = 0
		var padre_fila_menu = fila_menu.parentNode;

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idmenu=' + idmenu

		valores = valores + '&accion=menu_bajar'

		var ajax = NuevoAjax();

		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						// ocultamos las opciones
						var origen_opciones = "opc" + tipo + idmenu
						var destino_opciones = "divContOpciones"
						document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
						document.getElementById(origen_opciones).innerHTML = ""
						document.getElementById("txtContOpciones").value = destino_opciones

						// ubicamos la posicion del div fila del menu
						for(i = 0; i < padre_fila_menu.childNodes.length; i++)
						{
							if(padre_fila_menu.childNodes[i].id.indexOf("fila") != -1)
								if(padre_fila_menu.childNodes[i].id == fila_menu.id)
								{
									xfila = i
									break
								}	
						}

						// movemos hacia arriba
						if(xfila <= padre_fila_menu.childNodes.length - 2)
						{
							i = 0
							while(i < xfila)
							{
								div.appendChild(padre_fila_menu.childNodes[0])
								i = i + 1
							}
							div.appendChild(padre_fila_menu.childNodes[2])
							div.appendChild(padre_fila_menu.childNodes[2])
							while(padre_fila_menu.childNodes.length > 0)
								div.appendChild(padre_fila_menu.childNodes[0])
							padre_fila_menu.innerHTML = div.innerHTML
						}
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function FormularioNuevo()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idsistema = document.getElementById("txtIdSistema").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value
		var idmenupadre = 0
		if(tipo != "S")
			idmenupadre = idmenu

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&accion=formulario_nuevo' +
						'&op=0' +
						'&idsistema=' + idsistema +
						'&idmenupadre=' + idmenupadre +
						'&nivel=' + nivel

		document.getElementById("divBloqueaPagina").style.display = ""
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
				function() 
				{ 
					if (ajax.readyState == 2)
					{
						tblProceso.style.display = ""
					}
					if (ajax.readyState == 4)
					{
						var origen_opciones = "opc" + tipo + idmenu
						var destino_opciones = "divContOpciones"
						document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
						document.getElementById(origen_opciones).innerHTML = ""
						document.getElementById("txtContOpciones").value = destino_opciones
						//document.getElementById("txtTipoOpcion").value = ""
						//document.getElementById("txtIdOpcion").value = ""

						document.getElementById("divBloqueaPagina").style.display = ""
						document.getElementById(origen_opciones).innerHTML = ajax.responseText
						document.getElementById("txtCodigo").focus()
					}
				}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function FormularioInsertar(idsistema, idmenupadre, op)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var codigo = document.getElementById("txtCodigo").value
		var nombre = document.getElementById("txtNombre").value
		var defecto = 0
		if(document.getElementById("chkDefecto").checked)
			defecto = 1
		var nivel = document.getElementById("txtNivel").value

		//lista de acciones elegidas para el formulario
		var acciones = ""
		var elementos = document.frmSeguridad.elements
		for(var i = 0; i < elementos.length; i++)
		{
			if(elementos[i].type == "checkbox")
			{
				if(Left(elementos[i].id, 4) == "chkA" && elementos[i].checked == true)
					acciones = acciones + Mid(elementos[i].id, 4, elementos[i].id.length) + ','
			}
		}
		if(acciones != "")
			acciones = Left(acciones, acciones.length - 1)


		var tipo = document.getElementById("txtTipoOpcion").value
		var idmenu = document.getElementById("txtIdOpcion").value
		var strDes = document.getElementById("des" + tipo + idmenu).innerHTML
		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
			desplegado = 0
		else
			if(strDes.indexOf("menos.gif") != -1)
				desplegado = 1


		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idsistema=' + idsistema +
						'&idmenupadre=' + idmenupadre +
						'&codigo=' + escape(codigo) +
						'&nombre=' + escape(nombre) +
						'&defecto=' + defecto +
						'&acciones=' + escape(acciones) +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado
		if(op == 0)
			valores = valores + '&accion=formulario_inserta'
		else
			valores = valores + '&accion=formulario_modifica'

		var ajax = NuevoAjax();

		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						if(lst[1] != null) document.getElementById("det" + tipo + idmenu).innerHTML = lst[1]
						if(lst[2] != null) document.getElementById("fila" + tipo + idmenu).innerHTML = lst[2]
						CerrarBloqueo()
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function FormularioEditar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idsistema = document.getElementById("txtIdSistema").value
		var idformulario = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value
		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&accion=formulario_editar' +
						'&op=1' +
						'&idsistema=' + idsistema +
						'&idformulario=' + idformulario +
						'&nivel=' + nivel

		document.getElementById("divBloqueaPagina").style.display = ""
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var origen_opciones = "opc" + tipo + idformulario
					var destino_opciones = "divContOpciones"
					document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
					document.getElementById(origen_opciones).innerHTML = ""
					document.getElementById("txtContOpciones").value = destino_opciones
					//document.getElementById("txtTipoOpcion").value = ""
					//document.getElementById("txtIdOpcion").value = ""

					document.getElementById("divBloqueaPagina").style.display = ""
					document.getElementById(origen_opciones).innerHTML = ajax.responseText
					document.getElementById("txtCodigo").focus()
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function FormularioModificar(idsistema, idformulario, op)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var codigo = document.getElementById("txtCodigo").value
		var nombre = document.getElementById("txtNombre").value
		var defecto = 0
		if(document.getElementById("chkDefecto").checked)
			defecto = 1
		var nivel = document.getElementById("txtNivel").value

		//lista de acciones elegidas para el formulario
		var acciones = ""
		var elementos = document.frmSeguridad.elements
		for(var i = 0; i < elementos.length; i++)
		{
			if(elementos[i].type == "checkbox")
			{
				if(Left(elementos[i].id, 4) == "chkA" && elementos[i].checked == true)
					acciones = acciones + Mid(elementos[i].id, 4, elementos[i].id.length) + ','
			}
		}
		if(acciones != "")
			acciones = Left(acciones, acciones.length - 1)


		var tipo = document.getElementById("txtTipoOpcion").value
		var idformulario = document.getElementById("txtIdOpcion").value
		var strDes = document.getElementById("des" + tipo + idformulario).innerHTML
		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
			desplegado = 0
		else
			if(strDes.indexOf("menos.gif") != -1)
				desplegado = 1
		var idformulariod_ant = 0
		var acciones_ant = document.getElementById("txtAccionesAnt").value


		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idsistema=' + idsistema +
						'&idformulario=' + idformulario +
						'&codigo=' + escape(codigo) +
						'&nombre=' + escape(nombre) +
						'&defecto=' + defecto +
						'&acciones=' + escape(acciones) +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado +
						'&acciones_ant=' + escape(acciones_ant)
		if(op == 0)
			valores = valores + '&accion=formulario_inserta'
		else
			valores = valores + '&accion=formulario_modifica'

		var ajax = NuevoAjax();

		//alert(url + "?" + valores)
		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						if(lst[1] != null) document.getElementById("fila" + tipo + idformulario).innerHTML = lst[1]
						if(lst[2] != null) document.getElementById("det" + tipo + idformulario).innerHTML = lst[2]
						if(lst[3] != null) idformulariod_ant = lst[3]
						if(idformulariod_ant != 0)
							document.getElementById("ico" + tipo + idformulariod_ant).innerHTML = "<img src=\"img/icono_formulario.png\">"
						CerrarBloqueo()
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function FormularioEliminar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idformulario = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value

		var fila_formulario = document.getElementById("fila" + tipo + idformulario);
		var det_formulario = document.getElementById("det" + tipo + idformulario);
		var padre_fila_formulario = fila_formulario.parentNode;
		var strDes = document.getElementById(padre_fila_formulario.id.replace("det", "des")).innerHTML
		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
			desplegado = 0
		else
			if(strDes.indexOf("menos.gif") != -1)
				desplegado = 1

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idformulario=' + idformulario +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado

		valores = valores + '&accion=formulario_elimina'

		var ajax = NuevoAjax();

		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						// ocultamos las opciones
						var origen_opciones = "opc" + tipo + idformulario
						var destino_opciones = "divContOpciones"
						document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
						document.getElementById(origen_opciones).innerHTML = ""
						document.getElementById("txtContOpciones").value = destino_opciones

						// eliminamos los div del menu y su detalle
						padre_fila_formulario.removeChild(fila_formulario);
						padre_fila_formulario.removeChild(det_formulario);

						// cargamos la fila del menu padre
						var id = padre_fila_formulario.id.replace("det", "fila")
						if(lst[1] != null) document.getElementById(id).innerHTML = lst[1]

						// si no tiene hijos ocultamos el detalle
						strDes = document.getElementById(id.replace("fila", "des")).innerHTML
						if(strDes.indexOf("mas.gif") == -1 && strDes.indexOf("menos.gif") == -1)
							document.getElementById(id.replace("fila", "det")).style.display = "none"
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function AccionEliminar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var tipo = document.getElementById("txtTipoOpcion").value
		var idformularioaccion = document.getElementById("txtIdOpcion").value
		var nivel = document.getElementById("txtNivel").value

		var fila_formularioaccion = document.getElementById("fila" + tipo + idformularioaccion);
		var padre_fila_formularioaccion = fila_formularioaccion.parentNode;
		var strDes = document.getElementById(padre_fila_formularioaccion.id.replace("det", "des")).innerHTML
		var desplegado = -1
		if(strDes.indexOf("mas.gif") != -1)
			desplegado = 0
		else
			if(strDes.indexOf("menos.gif") != -1)
				desplegado = 1

		var url = 'menu_data.asp'
		var valores = 'token=' + token +
						'&idformularioaccion=' + idformularioaccion +
						'&nivel=' + nivel +
						'&desplegado=' + desplegado

		valores = valores + '&accion=accion_elimina'

		var ajax = NuevoAjax();

		//document.getElementById("res").innerHTML = url + "?" + valores
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					tblProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						// ocultamos las opciones
						var origen_opciones = "opc" + tipo + idformularioaccion
						var destino_opciones = "divContOpciones"
						document.getElementById(destino_opciones).innerHTML = document.getElementById(origen_opciones).innerHTML
						document.getElementById(origen_opciones).innerHTML = ""
						document.getElementById("txtContOpciones").value = destino_opciones

						// eliminamos los div de la accion y su detalle
						padre_fila_formularioaccion.removeChild(fila_formularioaccion);

						// cargamos la fila del formulario padre
						var id = padre_fila_formularioaccion.id.replace("det", "fila")
						if(lst[1] != null) document.getElementById(id).innerHTML = lst[1]

						// si no tiene hijos ocultamos el detalle
						strDes = document.getElementById(id.replace("fila", "des")).innerHTML
						if(strDes.indexOf("mas.gif") == -1 && strDes.indexOf("menos.gif") == -1)
							document.getElementById(id.replace("fila", "det")).style.display = "none"
					}
					else
						alert(ajax.responseText)
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}
