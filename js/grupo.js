function Nuevo()
{
	try
	{
		var param = document.getElementById("txtUrlListaN").value
		CargarPagina(null, 'grupo', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Cancelar()
{
	try
	{
		var param = document.getElementById("txtUrlLista").value
		CargarPagina(null, 'grupo_lista', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Guardar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var divProceso = document.getElementById("divProceso")
		var op = document.getElementById("txtOp").value
		var idperfil = document.getElementById("txtIdPerfil").value
		var nombre = document.getElementById("txtNombre").value
		
		var url = 'grupo_data.asp'
		var valores = 'token=' + token +
						'&accion=guardar' +
						'&op=' + op +
						'&idperfil=' + idperfil +
						'&nombre=' + escape(nombre)

		BloquearBotones(true);
		
		var ajax = NuevoAjax();
		
		divProceso.style.display = ""
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					//alert(ajax.responseText)
					BloquearBotones(false);
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						divProceso.style.display = "none"
						if(op == 0)
						{
							document.getElementById("txtOp").value = 1
							document.getElementById("txtIdPerfil").value = lst[1]
							idperfil = lst[1]
							
							document.getElementById("divLinea1").style.display = ""
							document.getElementById("divLineaTUsuario").style.display = ""
							document.getElementById("divLineaFUsuario").style.display = "none"
							document.getElementById("divGrillaUsuario").style.display = ""
							document.getElementById("divGrillaUsuario").innerHTML = lst[2]
							document.getElementById("divLinea2").style.display = ""
							document.getElementById("divLineaTAcceso").style.display = ""
							document.getElementById("divLineaMenu").style.display = ""
							document.getElementById("divLineaMenu").innerHTML = lst[3]
						}
					}
					else
					{
						divProceso.style.display = "none"
						alert(ajax.responseText)
					}
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function UsuarioNuevo()
{
	try
	{
		MostrarBotones(false, true, true)
		document.getElementById("divLineaFUsuario").style.display = ""
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function UsuarioCancelar()
{
	try
	{
		MostrarBotones(true, false, false)
		document.getElementById("divLineaFUsuario").style.display = "none"
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function UsuarioGuardar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var divProceso = document.getElementById("divProceso")
		var idperfil = document.getElementById("txtIdPerfil").value
		var idusuario = document.getElementById("cboUsuario").value
		
		var url = 'grupo_data.asp'
		var valores = 'token=' + token +
						'&accion=guardar_usuario' +
						'&idperfil=' + idperfil +
						'&idusuario=' + idusuario

		BloquearBotonesUsuario(true);
		
		var ajax = NuevoAjax();
		
		divProceso.style.display = ""
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					//alert(ajax.responseText)
					BloquearBotonesUsuario(false);
					MostrarBotones(true, false, false)
					document.getElementById("divLineaFUsuario").style.display = "none"
					
					divProceso.style.display = "none"
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						document.getElementById("divComboUsuario").innerHTML = lst[1]
						document.getElementById("divGrillaUsuario").innerHTML = lst[2]
					}
					else
					{
						divProceso.style.display = "none"
						alert(ajax.responseText)
					}
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function UsuarioEliminar(idusuario)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var divProceso = document.getElementById("divProceso")
		var idperfil = document.getElementById("txtIdPerfil").value
		
		var url = 'grupo_data.asp'
		var valores = 'token=' + token +
						'&accion=eliminar_usuario' +
						'&idperfil=' + idperfil +
						'&idusuario=' + idusuario

		BloquearBotonesUsuario(true);
		
		var ajax = NuevoAjax();
		
		divProceso.style.display = ""
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					//alert(ajax.responseText)
					BloquearBotonesUsuario(false);
					MostrarBotones(true, false, false)
					document.getElementById("divLineaFUsuario").style.display = "none"
					
					divProceso.style.display = "none"
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						document.getElementById("divComboUsuario").innerHTML = lst[1]
						document.getElementById("divGrillaUsuario").innerHTML = lst[2]
					}
					else
					{
						divProceso.style.display = "none"
						alert(ajax.responseText)
					}
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MostrarBotones(nuevo, cancelar, guardar)
{
	if(document.getElementById("divUsuarioNuevo") != null) document.getElementById("divUsuarioNuevo").style.display = (nuevo==true?"":"none");
	if(document.getElementById("divUsuarioCancelar") != null) document.getElementById("divUsuarioCancelar").style.display = (cancelar==true?"":"none");
	if(document.getElementById("divUsuarioGuardar") != null) document.getElementById("divUsuarioGuardar").style.display = (guardar==true?"":"none");
}

function BloquearBotones(bloqueo)
{
	if(document.getElementById("btnLista") != null) document.getElementById("btnLista").disabled = bloqueo
	if(document.getElementById("btnGuardar") != null) document.getElementById("btnGuardar").disabled = bloqueo
	if(document.getElementById("btnNuevo") != null) document.getElementById("btnNuevo").disabled = bloqueo
}

function BloquearBotonesUsuario(bloqueo)
{
	if(document.getElementById("btnUsuarioNuevo") != null) document.getElementById("btnUsuarioNuevo").disabled = bloqueo
	if(document.getElementById("btnUsuarioCancelar") != null) document.getElementById("btnUsuarioCancelar").disabled = bloqueo
	if(document.getElementById("btnUsuarioGuardar") != null) document.getElementById("btnUsuarioGuardar").disabled = bloqueo
}

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

function MenuAsignar(tipo, id, valor)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var idperfil = document.getElementById("txtIdPerfil").value
		var divChkOpcion = document.getElementById("divChkOpcion" + tipo + id)
		var divProceso = document.getElementById("divProceso")

		var url = 'grupo_data.asp'
		var valores = 'token=' + token +
						'&accion=menu_asignar' +
						'&idperfil=' + idperfil +
						'&tipo=' + escape(tipo) +
						'&id=' + id +
						'&valor=' + valor
						
		divProceso.style.display = ""
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					divProceso.style.display = "none"
					//alert("respuesta : " + ajax.responseText)
					if(ajax.responseText == "ok")
					{
						if(valor == 0)
							divChkOpcion.innerHTML = "<img src=\"img/uncheck_caja.gif\" id=\"chkOpcion" + tipo + id + "\" style=\"cursor:pointer;\" onClick=\"MenuAsignar('" + tipo + "', " + id + ", 1);\">"
						if(valor == 1)
							divChkOpcion.innerHTML = "<img src=\"img/check_caja.gif\" id=\"chkOpcion" + tipo + id + "\" style=\"cursor:pointer;\" onClick=\"MenuAsignar('" + tipo + "', " + id + ", 0);\">"
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