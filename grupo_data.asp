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

accion = request("accion")
if isnull(accion) or isempty(accion) then accion = ""


set rsS = CreateObject("ADODB.Recordset")
set rsG = CreateObject("ADODB.Recordset")
set rsM = CreateObject("ADODB.Recordset")
set rsA = CreateObject("ADODB.Recordset")


if accion = "guardar" then
	call Guardar
end if
function Guardar()
on error resume next
	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0

	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	nombre = request("nombre")
	if isnull(nombre) or isempty(nombre) then nombre = ""


	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	if cint(op) = 0 then
		cmd.CommandText = "USP_Perfil_Insertar"
		cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamOutput, 10)
	else
		cmd.CommandText = "USP_Perfil_Modificar"
		cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
	end if
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@grupo", adTinyint, adParamInput, 3)

	if cint(op) = 1 then
		cmd.Parameters("@idperfil") = idperfil
	end if
	cmd.Parameters("@nombre") = nombre
	cmd.Parameters("@grupo") = 1

	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error y Nro. " & err.number & ": " & err.description)
		response.End()
	end if

	if op = 0 then
		idperfil = cmd.Parameters("@idperfil")
	end if

	if isnull(idperfil) or isempty(idperfil) then
		response.Write("Ocurrio un error al registrar el Perfil de Grupo")
	else
		response.Write("ok<:-:>" & idperfil)
		if cint(op) = 0 then
			response.Write("<:-:>")
			call UsuarioCargar(idperfil)
			response.Write("<:-:>")
			call MenuCargar(idperfil)
		end if
	end if

if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "cargar_combo_usuarios" then
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	call UsuarioCargarCombo(idperfil)
end if
function UsuarioCargarCombo(idperfil)
on error resume next
%>
					<select id="cboUsuario" class="combo" style="width:250px">
<%
					set rsU2 = cn.execute("USP_Usuario_ListarNoPerfil " & idperfil)
					while not rsU2.eof
						response.Write("<option value=""" & rsU2("idusuario") & """>" & rsU2("NombreCompleto") & " (" & rsU2("nickname") & ")</option>")
						rsU2.movenext
					wend
%>
					</select>
<%
if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "guardar_usuario" then
	call UsuarioGuardar
end if
function UsuarioGuardar()
on error resume next
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	idusuario = request("idusuario")
	if isnull(idusuario) or isempty(idusuario) or idusuario = "" then idusuario = 0

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Usuario_CambiarPerfil"
	cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)

	cmd.Parameters("@idusuario") = idusuario
	cmd.Parameters("@idperfil") = idperfil

	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error y Nro. " & err.number & ": " & err.description)
		response.End()
	end if

	response.Write("ok<:-:>")
	call UsuarioCargarCombo(idperfil)
	response.Write("<:-:>")
	call UsuarioCargar(idperfil)

if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "cargar_usuarios" then
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	call UsuarioCargar(idperfil)
end if
function UsuarioCargar(idperfil)
on error resume next

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Usuario_ListarxIdPerfil"
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)

	cmd.Parameters("@idperfil") = idperfil

	set rsU = CreateObject("ADODB.Recordset")
	set rsU = cmd.execute
	if err.number <> 0 then response.Write("<br>Error Nro. " & err.number & ": " & err.description)

%>
			<table id="tblGrillaUsuario" class="gr_table01" width="100%">
				<tr class="gr_row01">
					<td class="gr_head01" id="gr_head01" width="40px">
						<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 1);"></div><div class="gr_hd3" <% if orden_ca = 1 then response.Write(orden_flecha) end if %>></div>
						<div class="gr_hd4" style="width:32px; text-align:center;" onClick="GROrdenar2('tblGrillaUsuario', 1);">ID</div></div>
					</td>
					<td class="gr_head01" width="120px">
						<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 2);"></div><div class="gr_hd3" <% if orden_ca = 2 then response.Write(orden_flecha) end if %>></div>
						<div class="gr_hd4" style="width:112px; text-align:left" onClick="GROrdenar2('tblGrillaUsuario', 2);">Nickname</div></div>
					</td>
					<td class="gr_head01" width="240px">
						<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 3);"></div><div class="gr_hd3" <% if orden_ca = 3 then response.Write(orden_flecha) end if %>></div>
						<div class="gr_hd4" style="width:232px; text-align:left" onClick="GROrdenar2('tblGrillaUsuario', 3);">Nombre</div></div>
					</td>
					<td class="gr_head01" width="45px">
						<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 4);"></div><div class="gr_hd3" <% if orden_ca = 6 then response.Write(orden_flecha) end if %>></div>
						<div class="gr_hd4" style="width:37px; text-align:center" onClick="GROrdenar2('tblGrillaUsuario', 4);">Est</div></div>
					</td>
					<td class="gr_head01" width="35px">
						<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 5);"></div><div class="gr_hd3"></div>
						<div class="gr_hd4" style="width:27px; text-align:center;">Del</div></div>
					</td>
					<td class="gr_head01">
					</td>
				</tr>
<%
			cont = 0
			while not rsU.eof
				cont = cont + 1
				class_tr = "class=""gr_row02"""
				if cont mod 2 = 0 then
					class_tr = "class=""gr_row03"""
				end if
%>
				<tr <%=class_tr%>>
					<td class="gr_body01" align="center"><%=rsU("idusuario")%></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rsU("nickname")%></div></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rsU("nombrecompleto")%></div></td>
					<td class="gr_body01" align="center">
<%
				if rsU("estado") = 0 then
					response.Write("<img src=""img/x2.gif"" title=""Inactivo"" border=""0px"">")
				else
					response.Write("<img src=""img/ret.gif"" title=""Inactivo"" border=""0px"">")
				end if
%>
					</td>
					<td class="gr_body01" align="center">
<%
				response.Write("<img src=""img/ACTN011.ICO"" title=""Eliminar"" border=""0px"" height=""15px"" style=""cursor:pointer"" onClick=""Eliminar(" & rsU("idusuario") & ")"">")
%>
					</td>
					<td class="gr_body02"></td>
				</tr>
<%
				rsU.movenext
			wend
%>
			</table>
<%
if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "eliminar_usuario" then
	call UsuarioEliminar()
end if
function UsuarioEliminar()
on error resume next
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	idusuario = request("idusuario")
	if isnull(idusuario) or isempty(idusuario) or idusuario = "" then idusuario = 0

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Usuario_ObtenerxIdUsuario"
	cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
	cmd.Parameters("@idusuario") = idusuario

	nombrecompleto = ""
	xidperfil = 0
	xperfil = 0
	xgrupo = 0
	set rsU = cmd.execute
	if not rsU.eof then

		apellidopaterno = rsU("apellidopaterno")
		apellidomaterno = rsU("apellidomaterno")
		nombres = rsU("nombres")


		nombrecompleto = trim(nombres)
		if nombrecompleto = "" then
			nombrecompleto = trim(apellidopaterno)
		else
			nombrecompleto = nombrecompleto & " " & trim(apellidopaterno)
		end if
		if nombrecompleto = "" then
			nombrecompleto = trim(apellidomaterno)
		else
			nombrecompleto = nombrecompleto & " " & trim(apellidomaterno)
		end if
		nombrecompleto = trim(nombrecompleto)


		xidperfil = rsU("IdPerfil")
		xperfil = rsU("Perfil")
		xgrupo = rsU("Grupo")

	end if

	if cint(xidperfil) = 0 or cint(xidperfil) = 1 then
		response.Write("El perfil del usuario es incorrecto o pertenece al perfil Administrador y no puede eliminarse.")
		response.End()
	end if

	if cint(xgrupo) = 0 then
		response.Write("Usuario ya tiene un perfil �nico.")
		response.End()
	end if

	'creamos el perfil unico
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Perfil_Insertar"
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamOutput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 100)
	cmd.Parameters.Append cmd.CreateParameter("@grupo", adTinyint, adParamInput, 3)

	cmd.Parameters("@nombre") = nombrecompleto
	cmd.Parameters("@grupo") = 0

	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description)
		response.End()
	end if

	xidperfil = cmd.Parameters("@idperfil")

	if isnull(xidperfil) or isempty(xidperfil) or xidperfil = 0 then
		response.Write("Ocurrio un error al registrar el perfil �nico")
		response.End()
	end if

	' cambiamos el perfil del usuario al perfil unico
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Usuario_CambiarPerfil"
	cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)

	cmd.Parameters("@idusuario") = idusuario
	cmd.Parameters("@idperfil") = xidperfil

	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description)
		response.End()
	end if

	response.Write("ok<:-:>")
	call UsuarioCargarCombo(idperfil)
	response.Write("<:-:>")
	call UsuarioCargar(idperfil)

if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "menu_asignar" then
	call MenuAsignar()
end if
function MenuAsignar()
on error resume next
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	tipo = request("tipo")
	if isnull(tipo) or isempty(tipo) then tipo = ""

	id = request("id")
	if isnull(id) or isempty(id) or id = "" then id = 0

	valor = request("valor")
	if isnull(valor) or isempty(valor) or valor = "" then valor = 0

	if tipo = "M" then
		if cint(valor) = 1 then
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn
			cmd.CommandType= adCmdStoredProc
			cmd.CommandText = "USP_PerfilMenu_Insertar"
			cmd.Parameters.Append cmd.CreateParameter("@idperfilmenu", adInteger, adParamOutput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@password", adVarchar, adParamInput, 20)

			cmd.Parameters("@idperfil") = idperfil
			cmd.Parameters("@idmenu") = id
			cmd.Parameters("@password") = ""

			cmd.Execute ,,adExecuteNoRecords
			if err.number <> 0 then
				response.Write("Error Nro. " & err.number & ": " & err.description)
				response.End()
			end if
		else
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn
			cmd.CommandType= adCmdStoredProc
			cmd.CommandText = "USP_PerfilMenu_EliminarxIdMenu"
			cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idmenu", adInteger, adParamInput, 10)

			cmd.Parameters("@idperfil") = idperfil
			cmd.Parameters("@idmenu") = id

			cmd.Execute ,,adExecuteNoRecords
			if err.number <> 0 then
				response.Write("Error Nro. " & err.number & ": " & err.description)
				response.End()
			end if
		end if
	end if

	if tipo = "A" then
		if cint(valor) = 1 then
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn
			cmd.CommandType= adCmdStoredProc
			cmd.CommandText = "USP_PerfilFormularioAccion_Insertar"
			cmd.Parameters.Append cmd.CreateParameter("@idperfilformularioaccion", adInteger, adParamOutput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idformularioaccion", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@password", adVarchar, adParamInput, 20)

			cmd.Parameters("@idperfil") = idperfil
			cmd.Parameters("@idformularioaccion") = id
			cmd.Parameters("@password") = ""

			cmd.Execute ,,adExecuteNoRecords
			if err.number <> 0 then
				response.Write("Error Nro. " & err.number & ": " & err.description)
				response.End()
			end if
		else
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn
			cmd.CommandType= adCmdStoredProc
			cmd.CommandText = "USP_PerfilFormularioAccion_EliminarxIdFormularioAccion"
			cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idformularioaccion", adInteger, adParamInput, 10)

			cmd.Parameters("@idperfil") = idperfil
			cmd.Parameters("@idformularioaccion") = id

			cmd.Execute ,,adExecuteNoRecords
			if err.number <> 0 then
				response.Write("Error Nro. " & err.number & ": " & err.description)
				response.End()
			end if
		end if
	end if

	response.Write("ok")

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

if accion = "menu_cargar" then
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0

	call MenuCargar(idperfil)
end if
function MenuCargar(idperfil)
on error resume next

	set rsS = cn.execute("exec USP_Sistema_Listar")
	if not rsS.eof then
		MostrarSistemas(idperfil)
	end if

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function

function MostrarSistemas(IdPerfil)
on error resume next
	nivel = 0
	while not rsS.eof
		bhijos = false
		bformularios = false

		if cint(rsS("bhijos")) = 1 then bhijos = true

		' mostramos el menu
		response.Write("<div class=""fmenu"" id=""filaS" & rsS("idsistema") & """>")
		response.Write("	<div class=""despliegue"" id=""desS" & rsS("idsistema") & """>")
		if bhijos then
			response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('S', " & rsS("idsistema") & ", 1)"">")
		else
			response.Write("		&nbsp;")
		end if
		response.Write("	</div>")
		response.Write("	<div class=""icono""><img src=""img/icono_sistema.gif""></div>")
		response.Write("	<div class=""menu"">" & rsS("nombre") & "</div>")
		response.Write("	<div class=""fopciones"" id=""opcS" & rsS("idsistema") & """>&nbsp;</div>")
		response.Write("</div>")

		' mostramos el detalle del menu
		response.Write("<div class=""fdetalle"" id=""detS" & rsS("idsistema") & """ style=""display:none"">")
		if bhijos then

			set rsG = CreateObject("ADODB.Recordset")
			set rsA = CreateObject("ADODB.Recordset")
			set rsG = cn.execute("USP_PerfilMenu_ListarMenu " & rsS("IdSistema") & ", " & IdPerfil)
			set rsA = cn.execute("USP_PerfilFormularioAccion_ListarFormularioAccion " & rsS("IdSistema") & ", " & IdPerfil)

			if not rsG.eof then
				MostrarMenu 0, 1
			end if
		end if
		response.Write("</div>")
		'response.End()
		rsS.movenext
	wend
if err.number <> 0 then
end if
end function

function MostrarMenu(idpadre, nivel)
on error resume next
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsG.clone
	rs.filter = "idmenupadre = " & idpadre
	if not rs.eof then
		rs.sort = "orden"
		while not rs.eof
			bhijos = false
			bformularios = false

			if cint(rs("bhijos")) = 1 then bhijos = true
			if cdbl(rs("idformulario")) <> 0 then bformularios = true

			' mostramos el menu
			response.Write("<div class=""fmenu"">")
			response.Write("	<div class=""espacio"" style=""width:" & (nivel * ancho) & "px"">&nbsp;</div>")
			response.Write("	<div class=""despliegue"" id=""desM" & rs("idmenu") & """>")
			if bhijos or bformularios then
				response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('M', " & rs("idmenu") & ", 1)"">")
			else
				response.Write("		&nbsp;")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""check"">")
			if cdbl(rs("idperfil")) = 0 then
				response.Write("		<img src=""img/uncheck_caja.gif"">")
			else
				response.Write("		<img src=""img/check_caja.gif"">")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""icono""><img src=""img/icono_menu.png""></div>")
			response.Write("	<div class=""menu"">" & rs("menu") & "</div>")
			response.Write("</div>")

			if bhijos or bformularios then
				' mostramos el detalle del menu
				response.Write("<div class=""fdetalle"" id=""detM" & rs("idmenu") & """ style=""display:none"">")
				if bhijos then
					MostrarMenu rs("idmenu"), nivel + 1
				elseif bformularios then
					MostrarFormulario rs("idmenu"), rs("idformulario"), nivel + 2
				end if
				response.Write("</div>")
			end if

			rs.movenext
		wend
	end if
if err.number <> 0 then
end if

end function


function MostrarFormulario(idmenu, idformulariod, nivel)
on error resume next
	idformulario_ant = -1
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsA.clone
	rs.filter = "idmenu = " & idmenu
	if not rs.eof then
		'rs.sort = "orden"
		while not rs.eof
			if cdbl(idformulario_ant) <> cdbl(rs("idformulario")) then
				if cdbl(idformulario_ant) <> -1 then
					' cerramos el detalle del formulario que contiene las acciones
					response.Write("</div>")
				end if

				' mostramos el formulario
				response.Write("<div class=""fmenu"">")
				response.Write("	<div class=""espacio"" style=""width:" & nivel*ancho & "px"">&nbsp;</div>")
				response.Write("	<div class=""despliegue"" id=""desF" & rs("idformulario") & """>")
				response.Write("		<img src=""img/mas.gif"" onClick=""Desplegar('F', " & rs("idformulario") & ", 1)"">")
				response.Write("	</div>")
				response.Write("	<div class=""icono"">")
				if cdbl(rs("idformulario")) = cdbl(idformulariod) then
					response.Write("		<img src=""img/icono_formulariod.png"">")
				else
					response.Write("		<img src=""img/icono_formulario.png"">")
				end if
				response.Write("	</div>")
				response.Write("	<div class=""menu"">" & rs("formulario") & "</div>")
				response.Write("</div>")

				'mostramos el detalle que contendra las acciones
				response.Write("<div class=""fdetalle"" id=""detF" & rs("idformulario") & """ style=""display:none"">")

				idformulario_ant = cdbl(rs("idformulario"))
			end if

			' mostramos las acciones
			response.Write("<div class=""fmenu"">")
			response.Write("	<div class=""espacio"" style=""width:" & (nivel + 2)*ancho & "px"">&nbsp;</div>")
			response.Write("	<div class=""check"">")
			if cdbl(rs("idperfil")) = 0 then
				response.Write("	<img src=""img/uncheck_caja.gif"">")
			else
				response.Write("	<img src=""img/check_caja.gif"">")
			end if
			response.Write("	</div>")
			response.Write("	<div class=""icono""><img src=""img/icono_accion.png""></div>")
			response.Write("	<div class=""menu"">" & rs("accion") & "</div>")
			response.Write("</div>")

			rs.movenext
		wend
		' cerramos el ultimo detalle del formulario que contiene las acciones
		response.Write("</div>")
	end if
if err.number <> 0 then
end if
end function

%>
