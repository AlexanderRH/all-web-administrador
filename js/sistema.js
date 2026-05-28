function Nuevo()
{
	try
	{
		var param = document.getElementById("txtUrlListaN").value
		CargarPagina(null, 'sistema', param);
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
		CargarPagina(null, 'sistema_lista', param);
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
		var idsistema = document.getElementById("txtIdSistema").value
		var nombre = document.getElementById("txtNombre").value
		var descripcion = document.getElementById("txtDescripcion").value
		
		var url = 'sistema_data.asp'
		var valores = 'token=' + token +
						'&accion=guardar' +
						'&op=' + op +
						'&idsistema=' + idsistema +
						'&nombre=' + escape(nombre) +
						'&descripcion=' + escape(descripcion)

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
							document.getElementById("txtIdSistema").value = lst[1]
							idsistema = lst[1]
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

function BloquearBotones(bloqueo)
{
	if(document.getElementById("btnLista") != null) document.getElementById("btnLista").disabled = bloqueo
	if(document.getElementById("btnGuardar") != null) document.getElementById("btnGuardar").disabled = bloqueo
	if(document.getElementById("btnNuevo") != null) document.getElementById("btnNuevo").disabled = bloqueo
}
