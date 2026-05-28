var debug = true;

function creaAjax() 
{
	var objetoAjax = false;
	try 
	{
		/*Para navegadores distintos a internet explorer*/
		objetoAjax = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch (e)
	{
		try
		{
			/*Para explorer*/
			objetoAjax = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch (E)
		{
			//objetoAjax = false;
			
            if (!objetoAjax && typeof XMLHttpRequest!="undefined") 
				objetoAjax = new XMLHttpRequest();
		}
	}
	
	if (objetoAjax.overrideMimeType) 
	{
		objetoAjax.overrideMimeType('text/xml');
	}


	//if (!objetoAjax && typeof XMLHttpRequest != 'undefined') 
	//{
	//	objetoAjax = new XMLHttpRequest();
	//}
	return objetoAjax;
}

function FAjax (cProceso, cContenido, cHabilita, metodo, url, valores)
{
	var ajax = creaAjax();
	var capaContenido = document.getElementById(cContenido);
	var capaProceso = document.getElementById(cProceso);
	var capaHabilita = document.getElementById(cHabilita);	

	/*Creamos y ejecutamos la instancia si el metodo elegido es POST*/
	if(metodo.toUpperCase() == 'POST')
	{
		ajax.open ('POST', url, true);
		ajax.onreadystatechange = function() 
		{
			if (ajax.readyState == 1) 
			{
//				habilitaInhabilita('formulario', false);
				capaContenido.innerHTML = "";
				capaProceso.style.display = 'block'
			}
			else if (ajax.readyState == 4)
			{
//				habilitaInhabilita('formulario', true);
				if(ajax.status == 200)
				{
					capaProceso.style.display = 'none'
					capaContenido.innerHTML = ajax.responseText;
				}
				else if(ajax.status == 404)
				{
					capaProceso.style.display = 'none'
					capaContenido.innerHTML = "La direccion no existe";
				}
				else
				{
					capaProceso.style.display = 'none';
					capaContenido.innerHTML = "";
					reportError(ajax, url, valores);
					//capaContenido.innerHTML = "Error: " + ajax.status;
				}
			}
		}
		ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		ajax.send(valores);
		return;
	}

	/*Creamos y ejecutamos la instancia si el metodo elegido es GET*/
	if (metodo.toUpperCase() == 'GET')
	{
		ajax.open ('GET', url, true);
		ajax.onreadystatechange = function() 
		{
			if (ajax.readyState == 1) 
			{
				capaContenido.innerHTML = "";
				capaProceso.style.display = 'block'
			}
			else if (ajax.readyState == 4)
			{
				if(ajax.status == 200)
				{
					capaProceso.style.display = 'none'
					capaContenido.innerHTML = ajax.responseText;
				}
				else if(ajax.status == 404)
				{
					capaProceso.innerHTML = "La direccion no existe";
				}
				else
				{
					capaProceso.innerHTML = "Error: ".ajax.status;
				}
			}
		}
		ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		ajax.send(null);
		
		return;
	}
}

function reportError(request, url, params) 
{
	if (debug)
	{
        if (request.status != 200) 
		{
            if (request.statusText)
                alert("HTTP Status: " + request.status + " - " + request.statusText);
            else
                alert("HTTP Status: " + request.status);
        } 
		else
            alert("Response Error");
        if (params)
            url += "?" + buildQueryString(params);
			
        document.location = url;
    }
}

function CargarGrilla(grilla, url)
{
	//grilla.selectAll()
	//grilla.deleteSelectedRows()
	grilla.clearAll()
	
	var ajax = NuevoAjax();
	ajax.open("GET", url);
	ajax.onreadystatechange=
		function() 
		{ 
			if (ajax.readyState == 2)
			{
				//tdServicio.innerHTML = "<img src='images/procesando.gif' border='0px' height='20px' width='20px'>"
			}
			if (ajax.readyState == 4)
			{
				//return ajax.responseText
				grilla.parse(ajax.responseText,"xml");
			}
		}
	ajax.send(null);
}

function CargarGrillaP(grilla, url, proceso)
{
	//grilla.selectAll()
	//grilla.deleteSelectedRows()
	grilla.clearAll()
	
	var ajax = NuevoAjax();
	ajax.open("GET", url);
	ajax.onreadystatechange=
		function() 
		{ 
			if (ajax.readyState == 2)
			{
				proceso.style.display = "block"
			}
			if (ajax.readyState == 4)
			{
				grilla.parse(ajax.responseText,"xml");
				proceso.style.display = "none"
			}
		}
	ajax.send(null);
}