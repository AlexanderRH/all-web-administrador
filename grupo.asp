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

idperfil = request("idperfil")
if isnull(idperfil) or isempty(idperfil) then idperfil = 0

op = request("op")
if isnull(op) or isempty(op) then op = 0

if op = 1 and idperfil <> 0 then
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Perfil_ObtenerxIdPerfil"
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
	cmd.Parameters("@idperfil") = idperfil

	set rsU = cmd.execute
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description & "<br>")
		response.End()
	end if

	if not rsU.eof then
		idperfil = rsU("idperfil")
		nombre = rsU("perfil")
	end if
end if

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description & "<br>")
	response.End()
end if

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

set rsS = CreateObject("ADODB.Recordset")
set rsG = CreateObject("ADODB.Recordset")
set rsM = CreateObject("ADODB.Recordset")
set rsA = CreateObject("ADODB.Recordset")

function MostrarSistemas()
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
			response.Write("	<div class=""check"" id=""divChkOpcionM" & rs("idmenu") & """>")
			if cdbl(rs("idperfil")) = 0 then
				response.Write("		<img src=""img/uncheck_caja.gif"" style=""cursor:pointer;"" onClick=""MenuAsignar('M', " & rs("idmenu") & ", 1);"">")
			else
				response.Write("		<img src=""img/check_caja.gif"" style=""cursor:pointer;"" onClick=""MenuAsignar('M', " & rs("idmenu") & ", 0);"">")
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
			response.Write("	<div class=""check"" id=""divChkOpcionA" & rs("idformularioaccion") & """>")
			if cdbl(rs("idperfil")) = 0 then
				response.Write("	<img src=""img/uncheck_caja.gif"" style=""cursor:pointer;"" onClick=""MenuAsignar('A', " & rs("idformularioaccion") & ", 1);"">")
			else
				response.Write("	<img src=""img/check_caja.gif"" style=""cursor:pointer;"" onClick=""MenuAsignar('A', " & rs("idformularioaccion") & ", 0);"">")
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

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

busq_filtro = request("bfiltro")
if isnull(busq_filtro) or isempty(busq_filtro) then busq_filtro = ""

url_lista = request("url_lista")
if isnull(url_lista) or isempty(url_lista) or url_lista = "" then
	url_lista = "&filtro=" & busq_filtro
end if

url_lista_n = "&op=0&bfiltro=" & busq_filtro
%>
		<input type="hidden" id="txtUrlLista" name="txtUrlLista" value="<%=url_lista%>">
		<input type="hidden" id="txtUrlListaN" name="txtUrlListaN" value="<%=url_lista_n%>">
		<input type="hidden" id="txtOp" name="txtOp" value="<%=op%>">
		<div style="width:100%; height:32px; font-size:17px; font-weight:bold; color:#3366CC;">
			<div class="pagina_titulo">Grupo</div>
			<div class="pagina_boton" style="width:64px;">
				<input type="button" id="btnLista" class="boton" value="Lista" style="width:55px" onClick="Cancelar();"/>
			</div>
			<div class="pagina_boton">
				<input type="button" id="btnGuardar" class="boton" value="Guardar" style="width:55px" onClick="Guardar();"/>
			</div>
			<div class="pagina_boton">
				<input type="button" id="btnNuevo" class="boton" value="Nuevo" style="width:55px" onClick="Nuevo();"/>
			</div>
			<div id="divProceso" class="pagina_proceso" style="display:none">
				<img src="img/loader1.gif" style="width:26px">
			</div>
		</div>
		<div style="width:100%; height:70px;">
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">ID:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtIdPerfil" values="" style="width:60px; text-align:center" disabled="disabled" value="<%=idperfil%>"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombre</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtNombre" value="<%=nombre%>" style="width:250px;" maxlength="50"/>
				</div>
			</div>
		</div>
		<div style="width:100%; height:15px;  text-align:left; <% if op = 0 then response.Write("display:none;") end if %>" id="divLinea1">
			<hr style="border:1px dashed #EBEBEB; width:97%; left:0" />
		</div>
		<div style="width:500px; height:35px; <% if op = 0 then response.Write("display:none;") end if %>" id="divLineaTUsuario">
			<div class="pagina_subtitulo">Usuario(s)</div>
			<div class="pagina_boton" id="divUsuarioGuardar" style="display:none;">
				<input type="button" id="btnUsuarioGuardar" class="boton" value="Guardar" style="width:55px" onClick="UsuarioGuardar();"/>
			</div>
			<div class="pagina_boton" id="divUsuarioCancelar" style="display:none;">
				<input type="button" id="btnUsuarioCancelar" class="boton" value="Cancelar" style="width:55px" onClick="UsuarioCancelar();"/>
			</div>
			<div class="pagina_boton" id="divUsuarioNuevo" style="display:<% if clng(idperfil) = 1 then response.write("none") end if %>;">
				<input type="button" id="btnUsuarioNuevo" class="boton" value="Nuevo" style="width:55px" onClick="UsuarioNuevo()"/>
			</div>
		</div>
		<div style="width:500px; height:35px; display:none;" id="divLineaFUsuario">
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Agregar a:</div>
				<div class="ventana_dato" id="divComboUsuario">
					<select id="cboUsuario" class="combo" style="width:250px">
<%
					set rsU2 = cn.execute("USP_Usuario_ListarNoPerfil " & idperfil)
					while not rsU2.eof
						response.Write("<option value=""" & rsU2("idusuario") & """>" & rsU2("NombreCompleto") & " (" & rsU2("nickname") & ")</option>")
						rsU2.movenext
					wend
%>
					</select>
				</div>
			</div>
		</div>
		<div id="divGrillaUsuario" style="background-color:white; width:500px; height:100%; overflow:auto; <% if op = 0 then response.Write("display:none;") end if %>">
<%
		if cint(op) <> 0 then
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
				if clng(rsU("idperfil")) <> 1 then
					response.Write("<img src=""img/ACTN011.ICO"" title=""Eliminar"" border=""0px"" height=""15px"" style=""cursor:pointer"" onClick=""UsuarioEliminar(" & rsU("idusuario") & ")"">")
				end if
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
		end if
%>
		</div>
		<div style="width:100%; height:20px; padding-top:6px; text-align:left; <% if op = 0 then response.Write("display:none;") end if %>" id="divLinea2">
			<hr style="border:1px dashed #EBEBEB; width:97%; left:0;" />
		</div>
		<div style="width:100%; height:25px; <% if op = 0 then response.Write("display:none;") end if %>" id="divLineaTAcceso">
			<div class="pagina_subtitulo">Acceso</div>
		</div>
		<div style="width:100%; <% if op = 0 then response.Write("display:none;") end if %>" id="divLineaMenu">
<%
		if cint(op) = 1 then
			set rsS = cn.execute("exec USP_Sistema_Listar")
			if not rsS.eof then
				MostrarSistemas
			end if
		end if
%>
		</div>
