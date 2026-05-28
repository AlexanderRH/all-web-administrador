function Validar()
{
	try
	{
		var divProceso = document.getElementById("divProceso")
		
		var url = "login_data.asp"
		var usuario = document.getElementById("txtSUUsuario").value
		var password = document.getElementById("txtSUPassword").value
		
		if(usuario == "")
		{
			alert("Ingrese el usuario")
			return false;
		}
		if(password == "")
		{
			alert("Ingrese el password")
			return false;
		}
		var valores = "accion=validar_usuario" +
						"&usuario=" + escape(usuario) +
						"&password=" + escape(password)

		var ajax = NuevoAjax();
		
		divProceso.innerHTML = "<img src=\"img/loader1.gif\" style=\"width: 24px\">"
		ajax.open("GET", url + "?" + valores);
		//alert(url + "?" + valores)
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					//divProceso.innerHTML = "<img src=\"img/loader1.gif\" style=\"width: 24px\">"
				}
				if (ajax.readyState == 4)
				{
					divProceso.innerHTML = ""
					if(ajax.responseText == "ok")
					{
						document.frmLogin.submit()
					}
					else
					{
						alert(ajax.responseText)
						return false;
					}
				}
			}
		ajax.send(null);
		return false;
	}
	catch(e)
	{
		if(divProceso != null) divProceso.innerHTML = ""
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}