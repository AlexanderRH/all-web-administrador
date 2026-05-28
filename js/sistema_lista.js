function Nuevo()
{
	try
	{
		var bcampo = document.getElementById("cboCampoFiltro").value
		var bfiltro = document.getElementById("txtFiltro").value
		
		var param = "&op=0" + 
					"&bcampo=" + bcampo + 
					"&bfiltro=" + escape(bfiltro)
	
		CargarPagina(null, 'sistema', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Editar(idsistema)
{
	try
	{
		var bcampo = document.getElementById("cboCampoFiltro").value
		var bfiltro = document.getElementById("txtFiltro").value
		
		var param = "&op=1" + 
					"&idsistema=" + idsistema + 
					"&bcampo=" + bcampo + 
					"&bfiltro=" + escape(bfiltro)
	
		CargarPagina(null, 'sistema', param);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function Eliminar(idsistema)
{
	try
	{
		var token = document.getElementById("txtToken").value
		var divProceso = document.getElementById("divProceso")
		
		var url = "sistema_lista_data.asp?token=" + token +
										"&accion=eliminar" +
										"&idsistema=" + idsistema

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
		var bcampo = document.getElementById("cboCampoFiltro").value
		var bfiltro = document.getElementById("txtFiltro").value
		var divProceso = document.getElementById("divProceso")
		var divGrillaSistema = document.getElementById("divGrillaSistema")
		
		var url = "sistema_lista_data.asp?token=" + token +
										"&accion=lista_sistema" +
										"&campo=" + bcampo + 
										"&filtro=" + escape(bfiltro)

		if(verificar == 1)
			if(document.getElementById("txtGrillaSistemaURL").value == url)
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
					document.getElementById("txtGrillaSistemaURL").value = url
					divProceso.style.display = "none"
					divGrillaSistema.innerHTML = ajax.responseText
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