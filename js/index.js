var id_menu_seleccionado = ""; // "mnuHome";

function loadJS(id, src)
{
	try
	{
		//if (document.getElementById(id) != null) return;
		var aleatorio = Math.round(Math.random()*(1000000 - 0)+parseInt(0));
		var js = document.createElement('script'); 
		js.id = id;
		js.async = false;
		js.src = src + "?" + aleatorio
		//alert(src + "?" + aleatorio)
		document.getElementsByTagName('head')[0].appendChild(js);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function loadCSS(css)
{
	try
	{

		var aleatorio = Math.round(Math.random()*(1000000 - 0)+parseInt(0));
		var fileref = document.createElement("link");
		fileref.setAttribute("rel", "stylesheet");
		fileref.setAttribute("type", "text/css");
		fileref.setAttribute("href", css + "?" + aleatorio);
		document.getElementsByTagName("head")[0].appendChild(fileref);
	}
	catch(e)
	{
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function CargarPagina(elemento, pagina, param)
{
	try
	{
		var divContenido = document.getElementById("divContenido")
		var token = document.getElementById("txtToken").value
		var url = pagina + ".asp?token=" + token + param
		var ajax = NuevoAjax();

		if(elemento != null)
		{
			elemento.parentNode.className = "active";
			if(elemento.parentNode.id != id_menu_seleccionado)
			{
				if(id_menu_seleccionado != "")
					document.getElementById(id_menu_seleccionado).className = "";
				id_menu_seleccionado = elemento.parentNode.id
			}
		}

		divContenido.innerHTML = "<img src=\"img/loader1.gif\" style=\"width: 24px\">"
		ajax.open("GET", url);
		//alert(url)
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					//divProceso.innerHTML = "<img src=\"img/loader1.gif\" style=\"width: 24px\">"
				}
				if (ajax.readyState == 4)
				{
					//loadCSS("css/" + pagina + ".css");
					loadJS("jsdinamico", "js/" + pagina + ".js");
					divContenido.innerHTML = ajax.responseText
				}
			}
		ajax.send(null);
	}
	catch(e)
	{
		if(divContenido != null) divContenido.innerHTML = ""
		alert("Error Nro. " + e.number + ": " + e.description)
	}
}

function CerrarSesion()
{
	try
	{
		var token = document.getElementById("txtToken").value
		var url = "index_data.asp?token=" + token + "&accion=cerrar_sesion"
		var ajax = NuevoAjax();

		ajax.open("GET", url);
		//alert(url)
		ajax.onreadystatechange=
			function() 
			{ 
				if (ajax.readyState == 2)
				{
					//divProceso.innerHTML = "<img src=\"img/loader1.gif\" style=\"width: 24px\">"
				}
				if (ajax.readyState == 4)
				{
					if(ajax.responseText == "ok")
						window.location = "."
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