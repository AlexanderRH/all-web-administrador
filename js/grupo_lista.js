function Nuevo()
{
	try
	{
		var bfiltro = document.getElementById("txtFiltro").value
		
		var param = "&op=0" + 
					"&bfiltro=" + escape(bfiltro)
	
		CargarPagina(null, 'grupo', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Editar(idperfil)
{
	try
	{
		var bfiltro = document.getElementById("txtFiltro").value
		
		var param = "&op=1" + 
					"&idperfil=" + idperfil + 
					"&bfiltro=" + escape(bfiltro)
	
		CargarPagina(null, 'grupo', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Eliminar(idperfil)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var divProceso = document.getElementById("divProceso")
		
		var url = "grupo_lista_data.asp?token=" + token +
										"&accion=eliminar" +
										"&idperfil=" + idperfil

		//BloquearControles(true);
		var ajax = NuevoAjax();
		
		divProceso.style.display = ""
		ajax.open("GET", url);
		//alert(url)
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
					if(ajax.responseText == "ok")
						Buscar(0);
					else
						alert(ajax.responseText)
					//BloquearControles(false);
				}
			}
		ajax.send(null);
		
		//tblProceso.style.display = ""
		//CargarGrilla(gridEmbarque, url)
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Buscar(verificar)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var bfiltro = document.getElementById("txtFiltro").value
		var divProceso = document.getElementById("divProceso")
		var divGrillaPerfil = document.getElementById("divGrillaPerfil")
		
		var url = "grupo_lista_data.asp?token=" + token +
										"&accion=lista_perfil" +
										"&filtro=" + escape(bfiltro)

		if(verificar == 1)
			if(document.getElementById("txtGrillaPerfilURL").value == url)
				return false
				
		//BloquearControles(true);
		var ajax = NuevoAjax();
		
		divProceso.style.display = ""
		ajax.open("GET", url);
		//alert(url)
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					divProceso.style.display = ""
				}
				if (ajax.readyState == 4)
				{
					document.getElementById("txtGrillaPerfilURL").value = url
					divProceso.style.display = "none"
					divGrillaPerfil.innerHTML = ajax.responseText
					//BloquearControles(false);
				}
			}
		ajax.send(null);
		
		//tblProceso.style.display = ""
		//CargarGrilla(gridEmbarque, url)
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function GROrdenarGrilla(tabla_grilla, orden_ca, orden_ad)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var divProceso = document.getElementById("divProceso")
		var divGrilla = document.getElementById(tabla_grilla.replace("tbl", "div"))
		var url = document.getElementById(tabla_grilla.replace("tbl", "txt") + "URL").value
		if(url != "")
		{
			url = url + "&orden_ca=" + orden_ca + "&orden_ad=" + escape(orden_ad)
			//alert(url)
			var ajax = NuevoAjax();
							
			divProceso.style.display = ""
			
			//BloquearControles(true);
			ajax.open("GET", url);
			//alert(url)
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
						divGrilla.innerHTML = ajax.responseText
						//BloquearControles(false);
					}
				}
			ajax.send(null);
		}
	}
	catch(e)
	{
		if(divProceso != null) divProceso.style.display = "none"
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}