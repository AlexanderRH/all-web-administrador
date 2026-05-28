function Nuevo()
{
	try
	{
		var param = document.getElementById("txtUrlListaN").value
		CargarPagina(null, 'usuario', param);
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
		CargarPagina(null, 'usuario_lista', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
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

function ActivarAnexo()
{
	try
	{
		var idtanexo = document.getElementById("cboTipoAnexo").value
		var txtIdAnexo = document.getElementById("txtIdAnexo")
		if(idtanexo != 3)
		{
			txtIdAnexo.disabled = false
		}
		else
		{
			txtIdAnexo.value = 0
			txtIdAnexo.disabled = true
		}
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MostrarPassword()
{
	try
	{
		var password = 0
		if(document.getElementById("chkPassword").checked)
			password = 1
		var txtPassword = document.getElementById("txtPassword")
		var txtTXTPassword = document.getElementById("txtTXTPassword")
			
		if(password == 1)
		{
			txtPassword.style.display = "none"
			txtTXTPassword.style.display = ""
		}
		else
		{
			txtPassword.style.display = ""
			txtTXTPassword.style.display = "none"
		}
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function CopiarPassword()
{
	try
	{
		var password = 0
		if(document.getElementById("chkPassword").checked)
			password = 1
		var txtPassword = document.getElementById("txtPassword")
		var txtTXTPassword = document.getElementById("txtTXTPassword")
			
		if(password == 1)
			txtPassword.value = txtTXTPassword.value
		else
			txtTXTPassword.value = txtPassword.value
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function MostrarEmailPassword()
{
	try
	{
		var email_password = 0
		if(document.getElementById("chkEmailPassword").checked)
			email_password = 1
		var txtEmailPassword = document.getElementById("txtEmailPassword")
		var txtTXTEmailPassword = document.getElementById("txtTXTEmailPassword")
			
		if(email_password == 1)
		{
			txtEmailPassword.style.display = "none"
			txtTXTEmailPassword.style.display = ""
		}
		else
		{
			txtEmailPassword.style.display = ""
			txtTXTEmailPassword.style.display = "none"
		}
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function CopiarEmailPassword()
{
	try
	{
		var email_password = 0
		if(document.getElementById("chkEmailPassword").checked)
			email_password = 1
		var txtEmailPassword = document.getElementById("txtEmailPassword")
		var txtTXTEmailPassword = document.getElementById("txtTXTEmailPassword")
			
		if(email_password == 1)
			txtEmailPassword.value = txtTXTEmailPassword.value
		else
			txtTXTEmailPassword.value = txtEmailPassword.value
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
		var idusuario = document.getElementById("txtIdUsuario").value
		var idempresa = document.getElementById("cboEmpresa").value
		var idtanexo = document.getElementById("cboTipoAnexo").value
		var idanexo = document.getElementById("txtIdAnexo").value
		var idccosto = document.getElementById("cboUnidadNegocio").value
		var nickname = document.getElementById("txtNickname").value
		
		CopiarPassword();
		var password = document.getElementById("txtPassword").value
		
		var apellidopaterno = document.getElementById("txtApPaterno").value
		var apellidomaterno = document.getElementById("txtApMaterno").value
		var nombres = document.getElementById("txtNombres").value
		var direccion = document.getElementById("txtDireccion").value
		var telefono = document.getElementById("txtTelefono").value
		var celular = document.getElementById("txtCelular").value
		var email = document.getElementById("txtEmail").value

		CopiarEmailPassword();
		var emailpassword = document.getElementById("txtEmailPassword").value

		var token_url = document.getElementById("txtTokenURL").value
		var client_id = document.getElementById("txtClientID").value
		var client_secret = document.getElementById("txtClientSecret").value
		var refresh_token = document.getElementById("txtRefreshToken").value
		
		var firma = document.getElementById("txtFirma").value
		var estado = document.getElementById("cboEstado").value
		
		var bpass = 0
		
		if(nickname == "")
		{
			alert("Ingrese el Nickname")
			document.getElementById("txtNickname").focus();
			return false;
		}
		
		if(password == "")
		{
			alert("Ingrese el Password")
			
			bpass = 0
			if(document.getElementById("chkPassword").checked)
				bpass = 1
			if(bpass == 0)
				document.getElementById("txtPassword").focus();
			else
				document.getElementById("txtTXTPassword").focus();
			
			return false;
		}
		
		if(email != "" && emailpassword == "")
		{
			alert("Ingrese el Password del Email")
			
			bpass = 0
			if(document.getElementById("chkEmailPassword").checked)
				bpass = 1
			if(bpass == 0)
				document.getElementById("txtEmailPassword").focus();
			else
				document.getElementById("txtTXTEmailPassword").focus();
			
			return false;
		}
		
		var url = 'usuario_data.asp'
		var valores = 'token=' + token +
						'&accion=guardar' +
						'&op=' + op +
						'&idusuario=' + idusuario +
						'&idempresa=' + idempresa +
						'&idtanexo=' + idtanexo +
						'&idanexo=' + idanexo +
						'&idccosto=' + idccosto +
						'&nickname=' + escape(nickname) +
						'&password=' + escape(password) +
						'&apellidopaterno=' + escape(apellidopaterno) +
						'&apellidomaterno=' + escape(apellidomaterno) +
						'&nombres=' + escape(nombres) +
						'&direccion=' + escape(direccion) +
						'&telefono=' + escape(telefono) +
						'&celular=' + escape(celular) +
						'&email=' + escape(email) +
						'&emailpassword=' + escape(emailpassword) +

						'&token_url=' + escape(token_url) +
						'&client_id=' + escape(client_id) +
						'&client_secret=' + escape(client_secret) +
						'&refresh_token=' + escape(refresh_token) +

						'&firma=' + escape(firma) +
						'&estado=' + estado


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
							document.getElementById("txtIdUsuario").value = lst[1]
							idusuario = lst[1]
							document.getElementById("txtIdPerfil").value = lst[2]
							document.getElementById("txtPerfil").value = lst[3]
							document.getElementById("divLineaMenu").innerHTML = lst[4]
							
							document.getElementById("divLinea1").style.display = ""
							document.getElementById("divLineaPerfil").style.display = ""
							document.getElementById("divLinea2").style.display = ""
							document.getElementById("divLineaMenu").style.display = ""
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

function PerfilCambiar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var idusuario = document.getElementById("txtIdUsuario").value
		
		var divPerfilCambio = document.getElementById("divPerfilCambio")
		var divPerfilClonar1 = document.getElementById("divPerfilClonar1")
		var divPerfilClonar2 = document.getElementById("divPerfilClonar2")
		var divPerfilGuardar = document.getElementById("divPerfilGuardar")
		var divPerfilProceso = document.getElementById("divPerfilProceso")
		
		var url = 'usuario_data.asp'
		var valores = 'token=' + token +
						'&accion=perfil_cambiar' +
						'&idusuario=' + idusuario

		divPerfilCambio.style.display = "none"
		divPerfilClonar1.style.display = "none"
		divPerfilClonar2.style.display = "none"
		divPerfilGuardar.style.display = "none"
		divPerfilProceso.style.display = ""
		
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divPerfilProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					divPerfilCambio.innerHTML = ajax.responseText
					btnPerfilGuardar.disabled = false
					
					divPerfilCambio.style.display = ""
					divPerfilGuardar.style.display = ""
					divPerfilProceso.style.display = "none"
					
					document.getElementById("txtTCambio").value = 1 // cambio
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function PerfilClonar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var idusuario = document.getElementById("txtIdUsuario").value
		
		var divPerfilCambio = document.getElementById("divPerfilCambio")
		var divPerfilClonar1 = document.getElementById("divPerfilClonar1")
		var divPerfilClonar2 = document.getElementById("divPerfilClonar2")
		var divPerfilGuardar = document.getElementById("divPerfilGuardar")
		var divPerfilProceso = document.getElementById("divPerfilProceso")
		
		var url = 'usuario_data.asp'
		var valores = 'token=' + token +
						'&accion=perfil_clonar' +
						'&idusuario=' + idusuario

		divPerfilCambio.style.display = "none"
		divPerfilClonar1.style.display = "none"
		divPerfilClonar2.style.display = "none"
		divPerfilGuardar.style.display = "none"
		divPerfilProceso.style.display = ""
		
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divPerfilProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					var lst = ajax.responseText.split("<:-:>")
					
					divPerfilClonar1.innerHTML = lst[0]
					divPerfilClonar2.innerHTML = lst[1]
					btnPerfilGuardar.disabled = false

					divPerfilClonar1.style.display = ""
					divPerfilClonar2.style.display = ""
					divPerfilGuardar.style.display = ""
					divPerfilProceso.style.display = "none"
					
					document.getElementById("txtIdTPerfil").value = 1
					document.getElementById("txtTCambio").value = 2 // clonar
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function PerfilCargarLista()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var idusuario = document.getElementById("txtIdUsuario").value
		var idtperfil = document.getElementById("cboPerfilTipo").value
		var idtperfil_ant = document.getElementById("txtIdTPerfil").value
		
		var divPerfilClonar2 = document.getElementById("divPerfilClonar2")
		var divPerfilGuardar = document.getElementById("divPerfilGuardar")
		var divPerfilProceso = document.getElementById("divPerfilProceso")
		
		if(idtperfil == idtperfil_ant) return false;
		
		document.getElementById("txtIdTPerfil").value = idtperfil
		
		divPerfilClonar2.style.display = "none"
		divPerfilGuardar.style.display = "none"
		divPerfilProceso.style.display = ""
		
		var url = 'usuario_data.asp'
		var valores = 'token=' + token +
						'&accion=perfil_cargar_lista' +
						'&idtperfil=' + idtperfil

		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divPerfilProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					divPerfilClonar2.innerHTML = ajax.responseText
					
					divPerfilClonar2.style.display = ""
					divPerfilGuardar.style.display = ""
					divPerfilProceso.style.display = "none"
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function PerfilGuardar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		
		var divPerfilCambio = document.getElementById("divPerfilCambio")
		var divPerfilClonar1 = document.getElementById("divPerfilClonar1")
		var divPerfilClonar2 = document.getElementById("divPerfilClonar2")
		var divPerfilGuardar = document.getElementById("divPerfilGuardar")
		var divPerfilProceso = document.getElementById("divPerfilProceso")
		
		var btnPerfilGuardar = document.getElementById("btnPerfilGuardar")
		var idusuario = document.getElementById("txtIdUsuario").value
		var idperfilant = document.getElementById("txtIdPerfil").value
		var idperfilclonar = 0
		var idperfil = document.getElementById("cboPerfil").value
		var tcambio = document.getElementById("txtTCambio").value
		var accion = ""
		
		if(tcambio == 1)
		{
			idperfilclonar = 0;
		}
		if(tcambio == 2)
		{
			idperfilclonar = idperfil;
			idperfil = idperfilant;
		}
		if(!(tcambio == 1 || tcambio == 2)) return false;
		
		var url = 'usuario_data.asp'
		var valores = 'token=' + token +
						'&accion=perfil_guardar' +
						'&idusuario=' + idusuario +
						'&idperfil=' + idperfil +
						'&idperfilclonar=' + idperfilclonar +
						'&tcambio=' + tcambio

		divPerfilProceso.style.display = ""
		btnPerfilGuardar.disabled = true
		var ajax = NuevoAjax();
		//alert(url + "?" + valores)
		ajax.open("GET", url + "?" + valores);
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divPerfilProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					divPerfilProceso.style.display = "none"
					divPerfilCambio.innerHTML = ""
					btnPerfilGuardar.disabled = false
					
					divPerfilCambio.style.display = "none"
					divPerfilClonar1.style.display = "none"
					divPerfilClonar2.style.display = "none"
					divPerfilGuardar.style.display = "none"
		
					var lst = ajax.responseText.split("<:-:>")
					if(lst[0] == "ok")
					{
						document.getElementById("txtIdPerfil").value = lst[1]
						document.getElementById("txtPerfil").value = lst[2]
						document.getElementById("divLineaMenu").innerHTML = lst[3]
						//MenuCargar();
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

function BloquearBotones(bloqueo)
{
	if(document.getElementById("btnLista") != null) document.getElementById("btnLista").disabled = bloqueo
	if(document.getElementById("btnGuardar") != null) document.getElementById("btnGuardar").disabled = bloqueo
	if(document.getElementById("btnNuevo") != null) document.getElementById("btnNuevo").disabled = bloqueo
}

function MenuCargar()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var idperfil = document.getElementById("txtIdPerfil").value
		var divProceso = document.getElementById("divProceso")
		var divLineaMenu = document.getElementById("divLineaMenu")

		var url = 'usuario_data.asp'
		var valores = 'token=' + token +
						'&accion=menu_cargar' +
						'&idperfil=' + idperfil
						
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
					divLineaMenu.innerHTML = ajax.responseText
				}
			}
		ajax.send(null);
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

		var url = 'usuario_data.asp'
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
					//alert(ajax.responseText)
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