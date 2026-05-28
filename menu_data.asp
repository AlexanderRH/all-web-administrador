<!-- #INCLUDE FILE="./inc/conexion.asp" -->
<%
response.buffer = true
Response.AddHeader "pragma", "no-cache" 
Response.CacheControl = "Private" 
Response.Expires = -1000
Session.LCID = 10250

su_idusuario = Session(session_idusuario) 
if isnull(su_idusuario) or isempty(su_idusuario) or su_idusuario = "" then su_idusuario = 0

token = request("token") 
if isnull(token) or isempty(token) or token = "" then token = 0

if clng(su_idusuario) = 0 then
	if clng(token) = 0 then
%>
    <!-- #INCLUDE FILE="login.asp" -->
<%
	else
		response.write("Su sesi�n ha terminado!")
	end if
    response.End()
end if

if Session.SessionID <> token then
	response.Redirect(".")
    response.End()
end if

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

ancho = 14
set rsS = CreateObject("ADODB.Recordset")
set rsM = CreateObject("ADODB.Recordset")
set rsA = CreateObject("ADODB.Recordset")

accion = request("accion")
if isnull(accion) or isempty(accion) then accion = ""


if accion = "menu_nuevo" then
	call MenuNuevo
end if
function MenuNuevo()
on error resume next
	
	resp = ""

	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0

	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
		
	idmenupadre = request("idmenupadre")
	if isnull(idmenupadre) or isempty(idmenupadre) or idmenupadre = "" then idmenupadre = 0
	
	sistema = ""
	menu = ""
	set rs = cn.execute("exec USP_Sistema_ObtenerxIdSistema " & idsistema)
	if not rs.eof then
		sistema = rs("nombre")
	end if
	set rs = cn.execute("exec USP_Menu_ObtenerxIdMenu " & idmenupadre)
	if not rs.eof then
		menu = rs("menu")
	end if
%>
<div class="sombra1" style="z-index:1000;">
	<div class="subsombra">
		<div class="ventana_menu">
			<div class="ventana_titulo">Menu (Nuevo)</div>
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Sistema:</div>
				<div class="ventana_dato"><%=sistema%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Menu Padre:</div>
				<div class="ventana_dato"><%=menu%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">C�digo:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtCodigo" values="" style="width:234px;" maxlength="20" tabindex="101"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombre:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtNombre" values="" style="width:234px;" maxlength="50" tabindex="102"/>
				</div>
			</div>
			<div class="ventana_fila" style="padding:6px; text-align:center">
				<input type="button" value="Guardar" class="boton" onClick="MenuInsertar(<%=idsistema%>, <%=idmenupadre%>, <%=op%>);" tabindex="103"/>&nbsp;&nbsp;
				<input type="button" value="Cancelar" class="boton" onClick="CerrarBloqueo()" tabindex="104"/>&nbsp;
			</div>
		</div>
	</div>
</div>
<%
if err.number <> 0 then
	response.Write("Error Nuevo Nro " & err.number & ": " & err.description)
end if
end function


if accion = "menu_inserta" then
	call MenuInserta
end if
function MenuInserta()
on error resume next
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
				
	idmenupadre = request("idmenupadre")
	if isnull(idmenupadre) or isempty(idmenupadre) or idmenupadre = "" then idmenupadre = 0
	
	tipopadre = request("tipopadre")
	if isnull(tipopadre) or isempty(tipopadre) or tipopadre = "" then tipopadre = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0

	codigo = request("codigo")
	if isnull(codigo) or isempty(codigo) then codigo = ""
				
	nombre = request("nombre")
	if isnull(nombre) or isempty(nombre) then nombre = ""
	
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	msg = ""
	idmenu = 0
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Menu_Insertar"
	cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamOutput, 10)
 	cmd.Parameters.Append cmd.CreateParameter("@idsistema", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@codigo", adVarchar, adParamInput, 20) 
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 50) 
 	cmd.Parameters.Append cmd.CreateParameter("@idmenupadre", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idsistema") = idsistema
	cmd.Parameters("@codigo") = codigo
	cmd.Parameters("@nombre") = nombre
	cmd.Parameters("@idmenupadre") = idmenupadre
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if isnull(cmd.Parameters("@idmenu")) or isempty(cmd.Parameters("@idmenu")) then
		idmenu = -1
	else
		idmenu = cmd.Parameters("@idmenu")
	end if
	if msg = "" then
		response.Write("ok<:-:>")
		
		set rsS = cn.execute("exec USP_Sistema_Listar")
		set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
		set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
		MostrarMenu idmenupadre, nivel + 1
		
		response.Write("<:-:>")
		if tipopadre = "S" then
			MostrarSistemaFila idsistema, nivel, desplegado
		else
			MostrarMenuFila idmenupadre, nivel, desplegado
		end if
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Inserta Nro " & err.number & ": " & err.description)
end if
end function


if accion = "menu_editar" then
	call MenuEditar
end if
function MenuEditar()
on error resume next
	
	resp = ""

	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0
	
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
		
	idmenu = request("idmenu")
	if isnull(idmenu) or isempty(idmenu) or idmenu = "" then idmenu = 0
	
	sistema = ""
	codigo = ""
	menu = ""
	menupadre = ""
	set rs = cn.execute("exec USP_Sistema_ObtenerxIdSistema " & idsistema)
	if not rs.eof then
		sistema = rs("nombre")
	end if
	set rs = cn.execute("exec USP_Menu_ObtenerxIdMenu " & idmenu)
	if not rs.eof then
		codigo = rs("codigo")
		menu = rs("menu")
		idmenupadre = rs("idmenupadre")
		menupadre = rs("menupadre")
	end if
%>
<div class="sombra1" style="z-index:1000;">
	<div class="subsombra">
		<div class="ventana_menu">
			<div class="ventana_titulo">Menu (Editar)</div>
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Sistema:</div>
				<div class="ventana_dato"><%=sistema%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Menu Padre:</div>
				<div class="ventana_dato"><%=menupadre%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">C�digo:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtCodigo" value="<%=codigo%>" style="width:234px;" maxlength="20" tabindex="101"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombre:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtNombre" value="<%=menu%>" style="width:234px;" maxlength="50" tabindex="102"/>
				</div>
			</div>
			<div class="ventana_fila" style="padding:6px; text-align:center">
				<input type="button" value="Guardar" class="boton" onClick="MenuModificar(<%=idsistema%>, <%=idmenu%>, <%=op%>);" tabindex="103"/>&nbsp;&nbsp;
				<input type="button" value="Cancelar" class="boton" onClick="CerrarBloqueo()" tabindex="104"/>&nbsp;
			</div>
		</div>
	</div>
</div>
<%
if err.number <> 0 then
	response.Write("Error Editar Nro " & err.number & ": " & err.description)
end if
end function


if accion = "menu_modifica" then
	call MenuModifica
end if
function MenuModifica()
on error resume next
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
				
	idmenu = request("idmenu")
	if isnull(idmenu) or isempty(idmenu) or idmenu = "" then idmenu = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0

	codigo = request("codigo")
	if isnull(codigo) or isempty(codigo) then codigo = ""
				
	nombre = request("nombre")
	if isnull(nombre) or isempty(nombre) then nombre = ""
	
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Menu_Modificar"
	cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@codigo", adVarchar, adParamInput, 20) 
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 50) 
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idmenu") = idmenu
	cmd.Parameters("@codigo") = codigo
	cmd.Parameters("@nombre") = nombre
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then
		response.Write("ok<:-:>")
		
		set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
		set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
		
		MostrarMenuFila idmenu, nivel, desplegado
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Modifica Nro " & err.number & ": " & err.description)
end if
end function


if accion = "menu_elimina" then
	call MenuElimina
end if
function MenuElimina()
on error resume next
	idmenu = request("idmenu")
	if isnull(idmenu) or isempty(idmenu) or idmenu = "" then idmenu = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0
	
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	idsistema = 0	
	idmenupadre = 0
	set rs = cn.execute("exec USP_Menu_ObtenerxIdMenu " & idmenu)
	if not rs.eof then
		idsistema = rs("idsistema")
		idmenupadre = rs("idmenupadre")
	end if
		
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Menu_Eliminar"
	cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idmenu") = idmenu
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then
		response.Write("ok<:-:>")
		set rsS = cn.execute("exec USP_Sistema_Listar")
		set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
		set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
		if clng(idmenupadre) = 0 then
			MostrarSistemaFila idsistema, nivel - 1, desplegado
		else
			MostrarMenuFila idmenupadre, nivel - 1, desplegado
		end if
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Elimina Nro " & err.number & ": " & err.description)
end if
end function


if accion = "menu_subir" then
	call MenuSubir
end if
function MenuSubir()
on error resume next
	idmenu = request("idmenu")
	if isnull(idmenu) or isempty(idmenu) or idmenu = "" then idmenu = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Menu_Subir"
	cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idmenu") = idmenu
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then
		response.Write("ok")
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Subir Nro " & err.number & ": " & err.description)
end if
end function


if accion = "menu_bajar" then
	call MenuBajar
end if
function MenuBajar()
on error resume next
	idmenu = request("idmenu")
	if isnull(idmenu) or isempty(idmenu) or idmenu = "" then idmenu = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Menu_Bajar"
	cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idmenu") = idmenu
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then
		response.Write("ok")
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Bajar Nro " & err.number & ": " & err.description)
end if
end function


if accion = "formulario_nuevo" then
	call FormularioNuevo
end if
function FormularioNuevo()
on error resume next
	resp = ""

	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0

	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
		
	idmenupadre = request("idmenupadre")
	if isnull(idmenupadre) or isempty(idmenupadre) or idmenupadre = "" then idmenupadre = 0
	
	sistema = ""
	menu = ""
	set rs = cn.execute("exec USP_Sistema_ObtenerxIdSistema " & idsistema)
	if not rs.eof then
		sistema = rs("nombre")
	end if
	set rs = cn.execute("exec USP_Menu_ObtenerxIdMenu " & idmenupadre)
	if not rs.eof then
		menu = rs("menu")
	end if
%>
<div class="sombra1" style="z-index:1000;">
	<div class="subsombra">
		<div class="ventana_formulario">
			<div class="ventana_titulo">Formulario (Nuevo)</div>
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Sistema:</div>
				<div class="ventana_dato"><%=sistema%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Menu Padre:</div>
				<div class="ventana_dato"><%=menu%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">C�digo:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtCodigo" values="" style="width:234px;" maxlength="40" tabindex="101"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombre:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtNombre" values="" style="width:234px;" maxlength="50" tabindex="102"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Por Defecto:</div>
				<div class="ventana_dato">
					<input class="checkbox" type="checkbox" id="chkDefecto" tabindex="103"/>
				</div>
			</div>
			<div class="ventana_fila" style="height:331px;">
				<div class="ventana_listaacc">
<%
				columnas = 4
				set rs = cn.execute("exec USP_Formulario_ListarAccion 0")
				if not rs.eof then
					rs.sort = "accion"
				end if
				while not rs.eof
					response.Write("<div class=""ventana_filaacc"">")
					for i = 1 to columnas
						if not rs.eof then
							response.Write("	<div class=""ventana_tdatoacc"">")
							response.Write("		<input class=""checkbox"" type=""checkbox"" id=""chkA" & rs("idaccion") & """ tabindex=""104""/>")
							response.Write("	</div>")
							response.Write("	<div class=""ventana_datoacc"">")
							response.Write("		" & rs("accion") & "")
							response.Write("	</div>")
							rs.movenext
						end if
					next
					response.Write("</div>")
				wend
%>
				</div>
			</div>
			<div class="ventana_fila" style="padding:6px; text-align:center">
				<input type="button" value="Guardar" class="boton" onClick="FormularioInsertar(<%=idsistema%>, <%=idmenupadre%>, <%=op%>);" tabindex="104"/>&nbsp;&nbsp;
				<input type="button" value="Cancelar" class="boton" onClick="CerrarBloqueo()" tabindex="105"/>&nbsp;
			</div>
		</div>
	</div>
</div>
<%
if err.number <> 0 then
	response.Write("Error Nuevo Nro " & err.number & ": " & err.description)
end if
end function


if accion = "formulario_inserta" then
	call FormularioInserta
end if
function FormularioInserta()
on error resume next
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
				
	idmenupadre = request("idmenupadre")
	if isnull(idmenupadre) or isempty(idmenupadre) or idmenupadre = "" then idmenupadre = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0

	codigo = request("codigo")
	if isnull(codigo) or isempty(codigo) then codigo = ""
				
	nombre = request("nombre")
	if isnull(nombre) or isempty(nombre) then nombre = ""

	defecto = request("defecto")
	if isnull(defecto) or isempty(defecto) or defecto = "" then defecto = 0
	
	acciones = request("acciones")
	if isnull(acciones) or isempty(acciones) then acciones = ""
		
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	msg = ""
	idmenu = 0
	
	cn.begintrans
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Formulario_InsertarNTR"
	cmd.Parameters.Append cmd.CreateParameter("@idformulario", adInteger, adParamOutput, 10)
 	cmd.Parameters.Append cmd.CreateParameter("@idsistema", adInteger, adParamInput, 10)
 	cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@codigo", adVarchar, adParamInput, 40) 
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 50) 
 	cmd.Parameters.Append cmd.CreateParameter("@defecto", adTinyint, adParamInput, 3)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idsistema") = idsistema
	cmd.Parameters("@idmenu") = idmenupadre
	cmd.Parameters("@codigo") = codigo
	cmd.Parameters("@nombre") = nombre
	cmd.Parameters("@defecto") = defecto
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if isnull(cmd.Parameters("@idformulario")) or isempty(cmd.Parameters("@idformulario")) then
		idformulario = -1
	else
		idformulario = cmd.Parameters("@idformulario")
	end if
	if msg = "" then
	
		lsAcciones = split(acciones, ",")
		for i = 0 to ubound(lsAcciones)
			msg2 = ""
			idaccion = lsAcciones(i)
			
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn 
			cmd.CommandType= adCmdStoredProc  
			cmd.CommandText = "USP_FormularioAccion_InsertarNTR"
			cmd.Parameters.Append cmd.CreateParameter("@idformularioaccion", adInteger, adParamOutput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idformulario", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idaccion", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)
		
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			
			cmd.Parameters("@idformulario") = idformulario
			cmd.Parameters("@idaccion") = idaccion
			
			cmd.Execute ,,adExecuteNoRecords 
			
			if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
				msg2 = "Error inesperado."
			else
				msg2 = cmd.Parameters("@msg")
			end if
			if msg2 <> "" or err.number <> 0 then
				response.Write(msg2)
				cn.rollbacktrans
				exit for
			end if
		next
		
		if msg2 = "" and err.number = 0 then
			cn.committrans
	
			response.Write("ok<:-:>")
			
			set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
			set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
			set rs = cn.execute("exec USP_Menu_ObtenerxIdMenu " & idmenupadre)
			idformulariod = 0
			if not rs.eof then
				idformulariod = rs("idformulario")
			end if
			MostrarFormulario idmenupadre, idformulariod, nivel + 2
			
			response.Write("<:-:>")
			
			MostrarMenuFila idmenupadre, nivel, desplegado
		end if
	else
		cn.rollbacktrans
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Inserta Nro " & err.number & ": " & err.description)
end if
end function


if accion = "formulario_editar" then
	call FormularioEditar
end if
function FormularioEditar()
on error resume next
	resp = ""

	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0
	
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
		
	idformulario = request("idformulario")
	if isnull(idformulario) or isempty(idformulario) or idformulario = "" then idformulario = 0
	
	sistema = ""
	codigo = ""
	formulario = ""
	idmenu = ""
	menu = ""
	defecto = 0
	set rs = cn.execute("exec USP_Sistema_ObtenerxIdSistema " & idsistema)
	if not rs.eof then
		sistema = rs("nombre")
	end if
	set rs = cn.execute("exec USP_Formulario_ObtenerxIdFormulario " & idformulario)
	if not rs.eof then
		codigo = rs("codigo")
		formulario = rs("formulario")
		idmenu = rs("idmenu")
		menu = rs("menu")
		defecto = rs("defecto")
	end if
	acciones_ant = ""
%>
<div class="sombra1" style="z-index:1000;">
	<div class="subsombra">
		<div class="ventana_formulario">
			<div class="ventana_titulo">Formulario (Editar)</div>
			<div class="ventana_fila" style="height:4px">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Sistema:</div>
				<div class="ventana_dato"><%=sistema%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Menu Padre:</div>
				<div class="ventana_dato"><%=menu%></div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">C�digo:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtCodigo" value="<%=codigo%>" style="width:234px;" maxlength="40" tabindex="101"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombre:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtNombre" value="<%=formulario%>" style="width:234px;" maxlength="50" tabindex="102"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Por Defecto:</div>
				<div class="ventana_dato">
					<input class="checkbox" type="checkbox" id="chkDefecto" <% if defecto = 1 then response.Write("checked=""defecto""") end if %> tabindex="103"/>
				</div>
			</div>
			<div class="ventana_fila" style="height:331px;">
				<div class="ventana_listaacc">
<%
				columnas = 4
				set rs = cn.execute("exec USP_Formulario_ListarAccion " & idformulario)
				if not rs.eof then
					rs.sort = "accion"
				end if
				while not rs.eof
					response.Write("<div class=""ventana_filaacc"">")
					for i = 1 to columnas
						if not rs.eof then
							idformularioaccion = rs("idformularioaccion")
							if isnull(idformularioaccion) or isempty(idformularioaccion) or idformularioaccion = "" then idformularioaccion = 0
	
							response.Write("	<div class=""ventana_tdatoacc"">")
							if clng(idformularioaccion) = 0 then
								response.Write("		<input class=""checkbox"" type=""checkbox"" id=""chkA" & rs("idaccion") & """ tabindex=""104""/>")
							else
								response.Write("		<input class=""checkbox"" type=""checkbox"" id=""chkA" & rs("idaccion") & """ tabindex=""104"" checked=""checked""/>")
								acciones_ant = acciones_ant & rs("idaccion") & ","
							end if
							response.Write("	</div>")
							response.Write("	<div class=""ventana_datoacc"">")
							response.Write("		" & rs("accion") & "")
							response.Write("	</div>")
							rs.movenext
						end if
					next
					response.Write("</div>")
				wend
				
				if acciones_ant <> "" then
					acciones_ant = left(acciones_ant, len(acciones_ant) - 1)
				end if
%>
				</div>
			</div>
			<div class="ventana_fila" style="padding:6px; text-align:center">
				<input type="hidden" id="txtAccionesAnt" value="<%=acciones_ant%>"/>&nbsp;&nbsp;
				<input type="button" value="Guardar" class="boton" onClick="FormularioModificar(<%=idsistema%>, <%=idformulario%>, <%=op%>);" tabindex="105"/>&nbsp;&nbsp;
				<input type="button" value="Cancelar" class="boton" onClick="CerrarBloqueo()" tabindex="106"/>&nbsp;
			</div>
		</div>
	</div>
</div>
<%
if err.number <> 0 then
	response.Write("Error Editar Nro " & err.number & ": " & err.description)
end if
end function


if accion = "formulario_modifica" then
	call FormularioModifica
end if
function FormularioModifica()
on error resume next
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
				
	idformulario = request("idformulario")
	if isnull(idformulario) or isempty(idformulario) or idformulario = "" then idformulario = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0

	codigo = request("codigo")
	if isnull(codigo) or isempty(codigo) then codigo = ""
				
	nombre = request("nombre")
	if isnull(nombre) or isempty(nombre) then nombre = ""
	
	defecto = request("defecto")
	if isnull(defecto) or isempty(defecto) or defecto = "" then defecto = 0
	
	acciones = request("acciones")
	if isnull(acciones) or isempty(acciones) then acciones = ""
	
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	acciones_ant = request("acciones_ant")
	if isnull(acciones_ant) or isempty(acciones_ant) then acciones_ant = ""
	
	'obtenemos el idmenu del formulario
	idmenu = 0
	set rs = cn.execute("exec USP_Formulario_ObtenerxIdFormulario " & idformulario)
	if not rs.eof then
		idmenu = rs("idmenu")
	end if
	
	'obtenemos el formulario por defecto anterior
	idformulariod = 0
	if defecto = 1 then
		set rs = cn.execute("exec USP_Menu_ObtenerxIdMenu " & idmenu)
		if not rs.eof then
			idformulariod = rs("idformulario")
			if clng(idformulariod) = clng(idformulario) then
				idformulariod = 0
			end if
		end if
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cn.begintrans
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Formulario_ModificarNTR"
	cmd.Parameters.Append cmd.CreateParameter("@idformulario", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@codigo", adVarchar, adParamInput, 40) 
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 50) 
	cmd.Parameters.Append cmd.CreateParameter("@defecto", adTinyint, adParamInput, 3)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idformulario") = idformulario
	cmd.Parameters("@codigo") = codigo
	cmd.Parameters("@nombre") = nombre
	cmd.Parameters("@defecto") = defecto
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then

		lsAcciones = split(acciones, ",")
		lsAccionesAnt = split(acciones_ant, ",")
		
		' obtenemos las acciones que estaban marcadas pero ahora ya no
		acciones_eliminar = ""
		band = true
		for j = 0 to ubound(lsAccionesAnt)
			band = true
			for i = 0 to ubound(lsAcciones)
				if lsAccionesAnt(j) = lsAcciones(i) then
					band = false
					exit for
				end if
			next
			if band then
				acciones_eliminar = acciones_eliminar & lsAccionesAnt(j) & ","
			end if
		next

		' agregamos las acciones 
		for i = 0 to ubound(lsAcciones)
			msg2 = ""
			idaccion = lsAcciones(i)
			
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn 
			cmd.CommandType= adCmdStoredProc  
			cmd.CommandText = "USP_FormularioAccion_InsertarNTR"
			cmd.Parameters.Append cmd.CreateParameter("@idformularioaccion", adInteger, adParamOutput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idformulario", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idaccion", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)
		
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			
			cmd.Parameters("@idformulario") = idformulario
			cmd.Parameters("@idaccion") = idaccion
			
			cmd.Execute ,,adExecuteNoRecords 
			
			if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
				msg2 = "Error inesperado."
			else
				msg2 = cmd.Parameters("@msg")
			end if
			if msg2 <> "" or err.number <> 0 then
				response.Write(msg2)
				cn.rollbacktrans
				exit for
			end if
		next
		
		' eliminamos las acciones que ya no van
		lsAccionesElim = split(acciones_eliminar, ",")
		for i = 0 to ubound(lsAccionesElim) - 1
			msg2 = ""
			idaccion = lsAccionesElim(i)

			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn 
			cmd.CommandType= adCmdStoredProc  
			cmd.CommandText = "USP_FormularioAccion_EliminarNTR"
			cmd.Parameters.Append cmd.CreateParameter("@idformulario", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idaccion", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)
		
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			
			cmd.Parameters("@idformulario") = idformulario
			cmd.Parameters("@idaccion") = idaccion
			
			cmd.Execute ,,adExecuteNoRecords 
			
			if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
				msg2 = "Error inesperado."
			else
				msg2 = cmd.Parameters("@msg")
			end if
			if msg2 <> "" or err.number <> 0 then
				response.Write(msg2)
				cn.rollbacktrans
				exit for
			end if
		next
	
		if msg2 = "" and err.number = 0 then
			cn.committrans
			
			response.Write("ok<:-:>")
			set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
			set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
	
			MostrarFormularioFila idformulario, nivel, desplegado
			response.Write("<:-:>")
			MostrarFormularioDetalle idformulario, nivel
			response.Write("<:-:>")
			response.Write(idformulariod)
		end if
	else
		cn.rollbacktrans
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Modifica Nro " & err.number & ": " & err.description)
end if
end function


if accion = "formulario_elimina" then
	call FormularioElimina
end if
function FormularioElimina()
on error resume next
	idformulario = request("idformulario")
	if isnull(idformulario) or isempty(idformulario) or idformulario = "" then idformulario = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0
	
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	idsistema = 0	
	idmenu = 0
	set rs = cn.execute("exec USP_Formulario_ObtenerxIdFormulario " & idformulario)
	if not rs.eof then
		idsistema = rs("idsistema")
		idmenu = rs("idmenu")
	end if
	
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Formulario_Eliminar"
	cmd.Parameters.Append cmd.CreateParameter("@idformulario", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idformulario") = idformulario
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then
		response.Write("ok<:-:>")
		set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
		set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
		if clng(idmenu) <> 0 then
			MostrarMenuFila idmenu, nivel - 2, desplegado
		end if
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Elimina Nro " & err.number & ": " & err.description)
end if
end function


if accion = "accion_elimina" then
	call AccionElimina
end if
function AccionElimina()
on error resume next
	idformularioaccion = request("idformularioaccion")
	if isnull(idformularioaccion) or isempty(idformularioaccion) or idformularioaccion = "" then idformularioaccion = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0
	
	desplegado = request("desplegado")
	if isnull(desplegado) or isempty(desplegado) or desplegado = "" then desplegado = 0
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	idsistema = 0	
	idformulario = 0
	set rs = cn.execute("exec USP_FormularioAccion_ObtenerxIdFormularioAccion " & idformularioaccion)
	if not rs.eof then
		idsistema = rs("idsistema")
		idformulario = rs("idformulario")
	end if
	
	msg = ""
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_FormularioAccion_Eliminar"
	cmd.Parameters.Append cmd.CreateParameter("@idformularioaccion", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@msg", adVarchar, adParamOutput, 1000)

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	cmd.Parameters("@idformularioaccion") = idformularioaccion
	
	cmd.Execute ,,adExecuteNoRecords 
	

	if isnull(cmd.Parameters("@msg")) or isempty(cmd.Parameters("@msg")) then
		msg = "Error inesperado."
	else
		msg = cmd.Parameters("@msg")
	end if
	if msg = "" then
		response.Write("ok<:-:>")
		set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
		set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
		if clng(idformulario) <> 0 then
			MostrarFormularioFila idformulario, nivel - 2, desplegado
		end if
	else
		response.Write(msg)
	end if
if err.number <> 0 then
	if msg <> "" then response.Write(vbCrLf)
	response.Write("Error Elimina Nro " & err.number & ": " & err.description)
end if
end function


function MostrarSistemaFila(idsistema, nivel, desplegado)
on error resume next
	bhijos = false
	
	if not rsS.eof then
		rsS.filter = "idsistema = " & idsistema
		if not rsS.eof then
			if cint(rsS("bhijos")) = 1 then bhijos = true
			
			' mostramos el sistema
			response.Write("	<div class=""despliegue"" id=""desS" & rsS("idsistema") & """>")
			
			if bhijos then
				if desplegado = 0 then
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('S', " & rsS("idsistema") & ", 0)"">")
				elseif desplegado = 1 then
					response.Write("		<img src=""img/menos.gif"" onClick=""Desplegar('S', " & rsS("idsistema") & ", 1)"">")
				else
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('S', " & rsS("idsistema") & ", 1)"">")
				end if
			else
				response.Write("		&nbsp;")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""icono""><img src=""img/icono_sistema.gif""></div>")
			response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rsS("idsistema") & ", 'S', " & rsS("idsistema") & ", 1, 0)"">" & rsS("nombre") & "</div>")
			response.Write("	<div class=""fopciones"" id=""opcS" & rsS("idsistema") & """>&nbsp;</div>")
			response.Write("</div>")
		end if
	end if
if err.number <> 0 then
	response.Write("Error Sistema Fila Nro " & err.number & ": " & err.description)
end if
end function


function MostrarMenuFila(idmenupadre, nivel, desplegado)
on error resume next
	bhijos = false
	bformularios = false
	
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsM.clone
	if not rs.eof then
		rs.filter = "idmenu = " & idmenupadre
		if not rs.eof then
			if cint(rs("bhijos")) = 1 then bhijos = true
			if cdbl(rs("bformularios")) = 1 then bformularios = true
			
			response.Write("	<div class=""espacio"" style=""width:" & (nivel * ancho) & "px"">&nbsp;</div>")
			response.Write("	<div class=""despliegue"" id=""desM" & rs("idmenu") & """>")
			if bhijos or bformularios then
				if desplegado = 0 then
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('M', " & rs("idmenu") & ", 0)"">")
				elseif desplegado = 1 then
					response.Write("		<img src=""img/menos.gif"" onClick=""Desplegar('M', " & rs("idmenu") & ", 1)"">")
				else
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('M', " & rs("idmenu") & ", 1)"">")
				end if
			else
				response.Write("		&nbsp;")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""icono""><img src=""img/icono_menu.png""></div>")
			if bhijos then
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'M', " & rs("idmenu") & ", 1, " & nivel & ")"">" & rs("menu") & "</div>")
			elseif bformularios then
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'M', " & rs("idmenu") & ", 2, " & nivel & ")"">" & rs("menu") & "</div>")
			else
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'M', " & rs("idmenu") & ", 3, " & nivel & ")"">" & rs("menu") & "</div>")
			end if
			response.Write("	<div class=""fopciones"" id=""opcM" & rs("idmenu") & """>&nbsp;</div>")
		end if
	end if
if err.number <> 0 then
	response.Write("Error Menu Fila Nro " & err.number & ": " & err.description)
end if
end function

if accion = "mostrar_menu" then
	idsistema = request("idsistema")
	if isnull(idsistema) or isempty(idsistema) or idsistema = "" then idsistema = 0
	
	idmenupadre = request("idmenupadre")
	if isnull(idmenupadre) or isempty(idmenupadre) or idmenupadre = "" then idmenupadre = 0
	
	nivel = request("nivel")
	if isnull(nivel) or isempty(nivel) or nivel = "" then nivel = 0
	
	set rsM = cn.execute("exec USP_Menu_Listar " & idsistema)
	set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & idsistema)
	call MostrarMenu(idmenupadre, nivel + 1)
end if
function MostrarMenu(idpadre, nivel)
on error resume next
	set rs = rsM.clone
	rs.filter = "idmenupadre = " & idpadre
	if not rs.eof then
		rs.sort = "orden"
		while not rs.eof
			bhijos = false
			bformularios = false
			
			if cint(rs("bhijos")) = 1 then bhijos = true
			if cdbl(rs("bformularios")) = 1 then bformularios = true
			
			' mostramos el menu
			response.Write("<div class=""fmenu"" id=""filaM" & rs("idmenu") & """>")
			response.Write("	<div class=""espacio"" style=""width:" & (nivel * ancho) & "px"">&nbsp;</div>")
			response.Write("	<div class=""despliegue"" id=""desM" & rs("idmenu") & """>")
			if bhijos or bformularios then
				response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('M', " & rs("idmenu") & ", 1)"">")
			else
				response.Write("		&nbsp;")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""icono""><img src=""img/icono_menu.png""></div>")
			if bhijos then
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'M', " & rs("idmenu") & ", 1, " & nivel & ")"">" & rs("menu") & "</div>")
			elseif bformularios then
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'M', " & rs("idmenu") & ", 2, " & nivel & ")"">" & rs("menu") & "</div>")
			else
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'M', " & rs("idmenu") & ", 3, " & nivel & ")"">" & rs("menu") & "</div>")
			end if
			response.Write("	<div class=""fopciones"" id=""opcM" & rs("idmenu") & """>&nbsp;</div>")
			response.Write("</div>")

			' mostramos el detalle del menu
			response.Write("<div class=""fdetalle"" id=""detM" & rs("idmenu") & """ style=""display:none"">")
			if bhijos then
				MostrarMenu rs("idmenu"), nivel + 1
			elseif bformularios then
				MostrarFormulario rs("idmenu"), rs("idformulario"), nivel + 2
			end if
			response.Write("</div>")
			
			rs.movenext
		wend
	end if
if err.number <> 0 then
	response.Write("Error Menu N� " & err.number & ": " & err.description)
end if
end function


function MostrarFormularioFila(idformulario, nivel, desplegado)
on error resume next
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsA.clone
	if not rs.eof then
		rs.filter = "idformulario = " & idformulario
		if not rs.eof then
			idformularioaccion = rs("idformularioaccion")
			if isnull(idformularioaccion) or isempty(idformularioaccion) or idformularioaccion = "" then idformularioaccion = 0
			
			response.Write("	<div class=""espacio"" style=""width:" & nivel*ancho & "px"">&nbsp;</div>")
			response.Write("	<div class=""despliegue"" id=""desF" & rs("idformulario") & """>")
			if clng(idformularioaccion) > 0 then
				if desplegado = 0 then
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('F', " & rs("idformulario") & ", 0)"">")
				elseif desplegado = 1 then
					response.Write("		<img src=""img/menos.gif"" onClick=""Desplegar('F', " & rs("idformulario") & ", 1)"">")
				else
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('F', " & rs("idformulario") & ", 1)"">")
				end if
			else
				response.Write("		&nbsp;")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""icono"" id=""icoF" & rs("idformulario") & """>")
			if rs("defecto") = 1 then
				response.Write("		<img src=""img/icono_formulariod.png"">")
			else
				response.Write("		<img src=""img/icono_formulario.png"">")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'F', " & rs("idformulario") & ", 1, " & nivel & ")"">" & rs("formulario") & "</div>")
			response.Write("	<div class=""fopciones"" id=""opcF" & rs("idformulario") & """>&nbsp;</div>")
		end if
	end if
if err.number <> 0 then
	response.Write("Error Formulario Fila Nro " & err.number & ": " & err.description)
end if
end function


function MostrarFormularioDetalle(idformulario, nivel)
on error resume next
	idformulario_ant = -1
	
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsA.clone
	rs.filter = "idformulario = " & idformulario
	if not rs.eof then
		'rs.sort = "orden"
		while not rs.eof
			idformularioaccion = rs("idformularioaccion")
			if isnull(idformularioaccion) or isempty(idformularioaccion) or idformularioaccion = "" then idformularioaccion = 0
			
			if clng(idformularioaccion) > 0 then
				' mostramos las acciones
				response.Write("<div class=""fmenu"" id=""filaA" & rs("idformularioaccion") & """>")
				response.Write("	<div class=""espacio"" style=""width:" & (nivel + 2)*ancho & "px"">&nbsp;</div>")
				response.Write("	<div class=""icono""><img src=""img/icono_accion.png""></div>")
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'A', " & rs("idformularioaccion") & ", 1, " & (nivel + 2) & ")"">" & rs("accion") & "</div>")
				response.Write("	<div class=""fopciones"" id=""opcA" & rs("idformularioaccion") & """>&nbsp;</div>")
				response.Write("</div>")
			end if
			rs.movenext
		wend
	end if
if err.number <> 0 then
	response.Write("Error Formulario N� " & err.number & ": " & err.description)
end if
end function


function MostrarFormulario(idmenu, idformulariod, nivel)
on error resume next
	idformulario_ant = -1
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsA.clone
	rs.filter = "idmenu = " & idmenu
	if not rs.eof then
		'rs.sort = "formulario, idformulario, accion"
		rs.movefirst
		while not rs.eof
			idformularioaccion = rs("idformularioaccion")
			if isnull(idformularioaccion) or isempty(idformularioaccion) or idformularioaccion = "" then idformularioaccion = 0

			if cdbl(idformulario_ant) <> cdbl(rs("idformulario")) then
				if cdbl(idformulario_ant) <> -1 then
					' cerramos el detalle del formulario que contiene las acciones
					response.Write("</div>")
				end if
				
				' mostramos el formulario
				response.Write("<div class=""fmenu"" id=""filaF" & rs("idformulario") & """>")
				response.Write("	<div class=""espacio"" style=""width:" & nivel*ancho & "px"">&nbsp;</div>")
				response.Write("	<div class=""despliegue"" id=""desF" & rs("idformulario") & """>")
				if clng(idformularioaccion) > 0 then
					response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('F', " & rs("idformulario") & ", 1)"">")
				else
					response.Write("		&nbsp;")
				end if
				response.Write("	</div>")
				response.Write("	<div class=""icono"" id=""icoF" & rs("idformulario") & """>")
				if cdbl(rs("idformulario")) = cdbl(idformulariod) then
					response.Write("		<img src=""img/icono_formulariod.png"">")
				else
					response.Write("		<img src=""img/icono_formulario.png"">")
				end if
				response.Write("	</div>")
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'F', " & rs("idformulario") & ", 1, " & nivel & ")"">" & rs("formulario") & "</div>")
				response.Write("	<div class=""fopciones"" id=""opcF" & rs("idformulario") & """>&nbsp;</div>")
				response.Write("</div>")
				
				'mostramos el detalle que contendra las acciones
				response.Write("<div class=""fdetalle"" id=""detF" & rs("idformulario") & """ style=""display:none"">")
				
				idformulario_ant = cdbl(rs("idformulario"))
			end if
			
			if clng(idformularioaccion) > 0 then
				' mostramos las acciones
				response.Write("<div class=""fmenu"" id=""filaA" & rs("idformularioaccion") & """>")
				response.Write("	<div class=""espacio"" style=""width:" & (nivel + 2)*ancho & "px"">&nbsp;</div>")
				response.Write("	<div class=""icono""><img src=""img/icono_accion.png""></div>")
				response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rs("idsistema") & ", 'A', " & rs("idformularioaccion") & ", 1, " & (nivel + 2) & ")"">" & rs("accion") & "</div>")
				response.Write("	<div class=""fopciones"" id=""opcA" & rs("idformularioaccion") & """>&nbsp;</div>")
				response.Write("</div>")
			end if
			rs.movenext
		wend
		' cerramos el ultimo detalle del formulario que contiene las acciones
		response.Write("</div>")
	end if
if err.number <> 0 then
	response.Write("Error Formulario N� " & err.number & ": " & err.description)
end if
end function
%>