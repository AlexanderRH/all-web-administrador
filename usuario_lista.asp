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

on error resume next

campo = request("campo")
if isnull(campo) or isempty(campo) or campo = "" then campo = 1

filtro = request("filtro")
if isnull(filtro) or isempty(filtro) then filtro = ""

idempresa = request("idempresa")
if isnull(idempresa) or isempty(idempresa) or idempresa = "" then idempresa = 1

idtanexo = request("idtanexo")
if isnull(idtanexo) or isempty(idtanexo) or idtanexo = "" then idtanexo = 3

estado = request("estado")
if isnull(estado) or isempty(estado) or estado = "" then estado = -1

orden_ca = request("orden_ca")
if isnull(orden_ca) or isempty(orden_ca) or orden_ca = "" then orden_ca = 2

orden_ad = request("orden_ad")
if isnull(orden_ad) or isempty(orden_ad) then orden_ad = "asc"

orden_flecha = ""
if orden_ad = "desc" then
	orden_flecha = "style=""background-image:url(img/flecha_down_header.png)"""
else
	orden_flecha = "style=""background-image:url(img/flecha_up_header.png)"""
end if

'busq = request("busq")
'if isnull(busq) or isempty(busq) or busq = "" then busq = 0

'if busq = 0 then
	url = "usuario_lista_data.asp?token=" & session.SessionID & "&accion=lista_usuario&campo=" & campo & "&filtro=" & filtro & "&idempresa=" & idempresa & "&idtanexo=" & idtanexo & "&estado=" & estado
'end if
%>
	<input id="txtGrillaUsuarioURL" name="txtGrillaUsuarioURL" type="hidden" value="<%=url%>"/>

		<div style="width:100%; height:30px; font-size:17px; font-weight:bold; color:#3366CC;">
			<div class="pagina_titulo">Usuario - Lista</div>
			<div class="pagina_boton" style="width:64px;">
				<input type="button" id="btnBuscar" class="boton" value="Buscar" style="width:55px" onClick="Buscar(0);"/>
			</div>
			<div class="pagina_boton">
				<input type="button" id="btnNuevo" class="boton" value="Nuevo" style="width:55px" onClick="Nuevo();"/>
			</div>
			<div class="pagina_proceso" id="divProceso" style="display:none">
				<img src="img/loader1.gif" style="width:25px">
			</div>
		</div>
		<div style="width:100%; height:40px;">
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Filtrar por </div>
				<div class="ventana_dato">
					<select id="cboCampoFiltro" class="combo" style="width:85px" onclick="Buscar(1);" onChange="Buscar(1);" onBlur="Buscar(1);">
						<option value="1" <% if campo = 1 then response.Write("selected=""selected""") end if%>>Nickname</option>
						<option value="2" <% if campo = 2 then response.Write("selected=""selected""") end if%>>Nombre</option>
					</select>
				</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtFiltro" values="<%=filtro%>" style="width:240px;" onKeyUp="Buscar(1);" value="<%=filtro%>"/>
				</div>
				<div class="ventana_dato">
					<select id="cboEmpresa" class="combo" style="width:221px" onclick="Buscar(1);" onChange="Buscar(1);" onBlur="Buscar(1);">
<%
					response.Write("<option value=""0"" selected=""selected"">-- Todos --</option>")
					set rs = cn.execute("USP_Empresa_Listar")
					while not rs.eof
						if cint(idempresa) = cint(rs("idempresa")) then
							response.Write("<option value=""" & rs("idempresa") & """ selected=""selected"">" & rs("razonsocial") & "</option>")
						else
							response.Write("<option value=""" & rs("idempresa") & """>" & rs("razonsocial") & "</option>")
						end if
						rs.movenext
					wend
%>
					</select>
				</div>
				<div class="ventana_dato">
					<select id="cboTipoAnexo" class="combo" style="width:181px" onclick="Buscar(1);" onChange="Buscar(1);" onBlur="Buscar(1);">
<%
					set rs = cn.execute("USP_TipoAnexo_Listar")
					while not rs.eof
						if cint(rs("idtanexo")) = 0 then
							tanexo = "-- Todos --"
						else
							tanexo = rs("nombre")
						end if
						if cint(idtanexo) = cint(rs("idtanexo")) then
							response.Write("<option value=""" & rs("idtanexo") & """ selected=""selected"">" & tanexo & "</option>")
						else
							response.Write("<option value=""" & rs("idtanexo") & """>" & tanexo & "</option>")
						end if
						rs.movenext
					wend
%>
					</select>
				</div>
				<div class="ventana_dato">
					<select id="cboEstado" class="combo" style="width:90px" onclick="Buscar(1);" onChange="Buscar(1);" onBlur="Buscar(1);">
						<option value="-1" <% if estado = -1 then response.Write("selected=""selected""") end if %>>-- Todos --</option>
						<option value="1" <% if estado = 1 then response.Write("selected=""selected""") end if %>>Activo</option>
						<option value="0" <% if estado = 0 then response.Write("selected=""selected""") end if %>>Inactivo</option>
					</select>
				</div>
			</div>
		</div>
		<div id="divGrillaUsuario" style="background-color:white; width:935px; height:100%; overflow:auto; " >
<%
		'if busq = 0 then
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn
			cmd.CommandType= adCmdStoredProc
			cmd.CommandText = "USP_Usuario_Listar"
			cmd.Parameters.Append cmd.CreateParameter("@campo", adTinyint, adParamInput, 3)
			cmd.Parameters.Append cmd.CreateParameter("@filtro", adVarchar, adParamInput, 150)
			cmd.Parameters.Append cmd.CreateParameter("@idempresa", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@idtanexo", adInteger, adParamInput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@estado", adInteger, adParamInput, 10)

			cmd.Parameters("@campo") = campo
			cmd.Parameters("@filtro") = filtro
			cmd.Parameters("@idempresa") = idempresa
			cmd.Parameters("@idtanexo") = idtanexo
			cmd.Parameters("@estado") = estado

			set rs = cmd.execute
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
			<td class="gr_head01" width="120px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 4);"></div><div class="gr_hd3" <% if orden_ca = 4 then response.Write(orden_flecha) end if %>></div>
				<div class="gr_hd4" style="width:112px; text-align:left" onClick="GROrdenar2('tblGrillaUsuario', 4);">Perfil</div></div>
			</td>
			<td class="gr_head01" width="160px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 5);"></div><div class="gr_hd3" <% if orden_ca = 5 then response.Write(orden_flecha) end if %>></div>
				<div class="gr_hd4" style="width:152px; text-align:left" onClick="GROrdenar2('tblGrillaUsuario', 5);">Empresa</div></div>
			</td>
			<td class="gr_head01" width="120px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 6);"></div><div class="gr_hd3" <% if orden_ca = 8 then response.Write(orden_flecha) end if %>></div>
				<div class="gr_hd4" style="width:112px; text-align:left" onClick="GROrdenar2('tblGrillaUsuario', 6);">Tipo de Anexo</div></div>
			</td>
			<td class="gr_head01" width="45px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 7);"></div><div class="gr_hd3" <% if orden_ca = 7 then response.Write(orden_flecha) end if %>></div>
				<div class="gr_hd4" style="width:37px; text-align:center" onClick="GROrdenar2('tblGrillaUsuario', 7);">Est</div></div>
			</td>
			<td class="gr_head01" width="35px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 8);"></div><div class="gr_hd3"></div>
				<div class="gr_hd4" style="width:27px; text-align:center;">Edit</div></div>
			</td>
			<td class="gr_head01" width="35px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaUsuario', 8);"></div><div class="gr_hd3"></div>
				<div class="gr_hd4" style="width:27px; text-align:center;">Del</div></div>
			</td>
			<td class="gr_head01">
			</td>
		</tr>
<%
			cont = 0
			while not rs.eof
				cont = cont + 1
				class_tr = "class=""gr_row02"""
				if cont mod 2 = 0 then
					class_tr = "class=""gr_row03"""
				end if
%>
				<tr <%=class_tr%>>
					<td class="gr_body01" align="center"><%=rs("idusuario")%></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rs("nickname")%></div></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rs("nombrecompleto")%></div></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rs("tperfil")%></div></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rs("empresa")%></div></td>
					<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rs("tanexo")%></div></td>
					<td class="gr_body01" align="center">
<%
				if rs("estado") = 0 then
					response.Write("<img src=""img/x2.gif"" title=""Inactivo"" border=""0px"">")
				else
					response.Write("<img src=""img/ret.gif"" title=""Inactivo"" border=""0px"">")
				end if
%>
					</td>
					<td class="gr_body01" align="center">
<%
				response.Write("<img src=""img/edit.png"" title=""Editar"" border=""0px"" height=""15px"" style=""cursor:pointer"" onClick=""Editar(" & rs("idusuario") & ")"">")
%>
					</td>
					<td class="gr_body01" align="center">
<%
				response.Write("<img src=""img/ACTN011.ICO"" title=""Eliminar"" border=""0px"" height=""15px"" style=""cursor:pointer"" onClick=""Eliminar(" & rs("idusuario") & ")"">")
%>
					</td>
					<td class="gr_body02"></td>
				</tr>
<%
				rs.movenext
			wend
%>
			</table>
<%
		'end if
%>
		</div>
