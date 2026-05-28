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
		response.write("Su sesiï¿½n ha terminado!")
	end if
    response.End()
end if

if Session.SessionID <> token then
	response.Redirect(".")
    response.End()
end if

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

idusuario = request("idusuario")
if isnull(idusuario) or isempty(idusuario) then idusuario = 0

op = request("op")
if isnull(op) or isempty(op) then op = 0

idperfil = 0
idempresa = 1
idtanexo = 3
estado = 1
if op = 1 and idusuario <> 0 then
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Usuario_ObtenerxIdUsuario"
	cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
	cmd.Parameters("@idusuario") = idusuario

	set rsU = cmd.execute
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description & "<br>")
		response.End()
	end if

	if not rsU.eof then
		idusuario = rsU("IdUsuario")
		idempresa = rsU("IdEmpresa")
		nickname = rsU("Nickname")
		password = rsU("Password")
		apellidopaterno = rsU("ApellidoPaterno")
		apellidomaterno = rsU("ApellidoMaterno")
		nombres = rsU("Nombres")
		direccion = rsU("Direccion")
		telefono = rsU("Telefono")
		celular = rsU("Celular")
		email = rsU("Email")
		emailpassword = rsU("EmailPassword")

		token_url = rsU("token_url")
		client_id = rsU("client_id")
		client_secret = rsU("client_secret")
		refresh_token = rsU("refresh_token")

		firma = rsU("Firma")
		idanexo = rsU("IdAnexo")
		idempresa = rsU("idempresa")
		idtanexo = rsU("IdTAnexo")
		idccosto = rsU("IdCCosto")
		idperfil = rsU("IdPerfil")
		perfil = rsU("Perfil")
		grupo = rsU("Grupo")
		estado = rsU("Estado")
	end if
end if

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description & "<br>")
	response.End()
end if

'IdSistema = 2

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
			if cdbl(rs("bformularios")) = 1 then bformularios = true

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
			response.Write("	<div class=""espacio"" style=""width:" & (nivel + 2) * ancho & "px"">&nbsp;</div>")
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


busq_campo = request("bcampo")
if isnull(busq_campo) or isempty(busq_campo) then busq_campo = 0

busq_filtro = request("bfiltro")
if isnull(busq_filtro) or isempty(busq_filtro) then busq_filtro = ""

busq_idempresa = request("bidempresa")
if isnull(busq_idempresa) or isempty(busq_idempresa) then busq_idempresa = 0

busq_idtanexo = request("bidtanexo")
if isnull(busq_idtanexo) or isempty(busq_idtanexo) then busq_idtanexo = 0

busq_estado = request("bestado")
if isnull(busq_estado) or isempty(busq_estado) then busq_estado = 0

url_lista = request("url_lista")
if isnull(url_lista) or isempty(url_lista) or url_lista = "" then
	url_lista = "&campo=" & busq_campo & "&filtro=" & busq_filtro & "&idempresa=" & busq_idempresa & "&idtanexo=" & busq_idtanexo & "&estado=" & busq_estado
end if

url_lista_n = "&op=0&bcampo=" & busq_campo & "&bfiltro=" & busq_filtro & "&bidempresa=" & busq_idempresa & "&bidtanexo=" & busq_idtanexo & "&bestado=" & busq_estado
%>
		<input type="hidden" id="txtUrlLista" name="txtUrlLista" value="<%=url_lista%>">
		<input type="hidden" id="txtUrlListaN" name="txtUrlListaN" value="<%=url_lista_n%>">
		<input type="hidden" id="txtOp" name="txtOp" value="<%=op%>">
		<input type="hidden" id="txtIdPerfil" name="txtIdPerfil" value="<%=idperfil%>">
		<input type="hidden" id="txtIdTPerfil" name="txtIdTPerfil" value="1">
		<input type="hidden" id="txtTCambio" name="txtTCambio" value="0">
		<div style="width:100%; height:32px; font-size:17px; font-weight:bold; color:#3366CC;">
			<div class="pagina_titulo">Usuario</div>
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
		<div style="width:100%; height:560px;">
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">ID:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtIdUsuario" values="" style="width:60px; text-align:center" disabled="disabled" value="<%=idusuario%>"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Empresa</div>
				<div class="ventana_dato">
					<select id="cboEmpresa" class="combo" style="width:207px">
						<option value="0">(Ninguno)</option>
<%
					set rsE = cn.execute("USP_Empresa_Listar")
					while not rsE.eof
						if cint(idempresa) = cint(rsE("idempresa")) then
							response.Write("<option value=""" & rsE("idempresa") & """ selected=""selected"">" & rsE("razonsocial") & "</option>")
						else
							response.Write("<option value=""" & rsE("idempresa") & """>" & rsE("razonsocial") & "</option>")
						end if
						rsE.movenext
					wend
%>
					</select>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Anexo</div>
				<div class="ventana_dato">
					<select id="cboTipoAnexo" class="combo" style="width:207px" onclick="ActivarAnexo();" onChange="ActivarAnexo();" onBlur="ActivarAnexo();">
<%
					set rsTA = cn.execute("USP_TipoAnexo_Listar")
					while not rsTA.eof
						if cint(idtanexo) = cint(rsTA("idtanexo")) then
							response.Write("<option value=""" & rsTA("idtanexo") & """ selected=""selected"">" & rsTA("nombre") & "</option>")
						else
							response.Write("<option value=""" & rsTA("idtanexo") & """>" & rsTA("nombre") & "</option>")
						end if
						rsTA.movenext
					wend
%>
					</select>
				</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtIdAnexo" style="width:60px; text-align:center" value="<%=idanexo%>" maxlength="6"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Centro Costo</div>
				<div class="ventana_dato">
					<select id="cboUnidadNegocio" class="combo" style="width:207px">
<%
					set rsCC = cn.execute("USP_CentroCosto_Listar")
					while not rsCC.eof
						if cint(idccosto) = cint(rsCC("idccosto")) then
							response.Write("<option value=""" & rsCC("idccosto") & """ selected=""selected"">" & rsCC("nombre") & "</option>")
						else
							response.Write("<option value=""" & rsCC("idccosto") & """>" & rsCC("nombre") & "</option>")
						end if
						rsCC.movenext
					wend
%>
					</select>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nickname</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtNickname" style="width:207px;" maxlength="15" value="<%=nickname%>"/>
				</div>
				<div class="ventana_tdato">Password</div>
				<div class="ventana_dato" style="width:20px;">
					<input type="checkbox" id="chkPassword" class="checkbox" onClick="MostrarPassword();"/>
				</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="password" id="txtPassword" value="<%=password%>" style="width:181px;" maxlength="15" onKeyUp="CopiarPassword();" onBlur="CopiarPassword();"/>
					<input class="txtcaja" type="text" id="txtTXTPassword" value="<%=password%>" style="width:181px; display:none" maxlength="15" onKeyUp="CopiarPassword();" onBlur="CopiarPassword();"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Ap. Paterno</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtApPaterno" value="<%=apellidopaterno%>" style="width:207px;" maxlength="50"/>
				</div>
				<div class="ventana_tdato">Ap. Materno</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtApMaterno" value="<%=apellidomaterno%>" style="width:207px;" maxlength="50"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombres</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtNombres" value="<%=nombres%>" style="width:207px;" maxlength="50"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Dirección</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtDireccion" value="<%=direccion%>" style="width:506px;" maxlength="100"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Telefono</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtTelefono" value="<%=telefono%>" style="width:207px;" maxlength="20"/>
				</div>
				<div class="ventana_tdato">Celular</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtCelular" value="<%=celular%>" style="width:207px;" maxlength="20"/>
				</div>
			</div>

			<div class="ventana_fila">
				<div class="ventana_tdato">&nbsp;</div>
				<div class="ventana_dato" style="width:217px">&nbsp;</div>
				<div class="ventana_tdato">&nbsp;</div>
				<div class="ventana_dato">&nbsp;</div>
			</div>

			<div class="ventana_fila">
				<div class="ventana_tdato">Email</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtEmail" value="<%=email%>" style="width:207px;" maxlength="50"/>
				</div>
				<div class="ventana_tdato">Password</div>
				<div class="ventana_dato" style="width:20px;">
					<input type="checkbox" id="chkEmailPassword" class="checkbox" onClick="MostrarEmailPassword();"/>
				</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="password" id="txtEmailPassword" value="<%=emailpassword%>" style="width:181px;" maxlength="20" onKeyUp="CopiarEmailPassword();" onBlur="CopiarEmailPassword();"/>
					<input class="txtcaja" type="text" id="txtTXTEmailPassword" value="<%=emailpassword%>" style="width:181px; display:none;" maxlength="20" onKeyUp="CopiarEmailPassword();" onBlur="CopiarEmailPassword();"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Token URL</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtTokenURL" value="<%=token_url%>" style="width:506px;" maxlength="200"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Client ID</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtClientID" value="<%=client_id%>" style="width:506px;" maxlength="200"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Client Secret</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtClientSecret" value="<%=client_secret%>" style="width:506px;" maxlength="200"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Refresh Token</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtRefreshToken" value="<%=refresh_token%>" style="width:506px;" maxlength="200"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">&nbsp;</div>
				<div class="ventana_dato" style="width:217px">&nbsp;</div>
				<div class="ventana_tdato">&nbsp;</div>
				<div class="ventana_dato">&nbsp;</div>
			</div>


			<div class="ventana_fila" style="height:130px">
				<div class="ventana_tdato">Firma</div>
				<div class="ventana_dato">
					<textarea class="txtcaja" type="text" id="txtFirma" style="width:506px; height:125px"><%=firma%></textarea>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Estado</div>
				<div class="ventana_dato">
					<select id="cboEstado" class="combo" style="width:80px">
						<option value="1" <% if estado = 1 then response.Write("selected=""selected""") end if %>>Activo</option>
						<option value="0" <% if estado = 0 then response.Write("selected=""selected""") end if %>>Inactivo</option>
					</select>
				</div>
			</div>
		</div>
		<div style="width:100%; height:10px;  text-align:left; <% if op = 0 then response.Write("display:none;") end if %>" id="divLinea1">
			<hr style="border:1px dashed #EBEBEB; width:97%; left:0" />
		</div>
		<div style="width:100%; height:28px; text-align:left; <% if op = 0 then response.Write("display:none;") end if %>" id="divLineaPerfil">
			<div class="ventana_fila" id="divPerfil">
				<div class="ventana_tdato">Perfil</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtPerfil" value="<%=perfil%>" disabled="disabled" style="width:207px;"/>
				</div>
				<div class="ventana_dato">
					<input type="button" id="btnPerfilCambiar" class="boton" value="Cambiar" style="width:55px" onClick="PerfilCambiar();"/>
				</div>
				<div class="ventana_dato">
					<input type="button" id="btnPerfilClonar" class="boton" value="Clonar" style="width:55px" onClick="PerfilClonar();"/>
				</div>
				<div class="ventana_dato" id="divPerfilCambio" style="display:none;">
				</div>
				<div class="ventana_dato" id="divPerfilClonar1" style="display:none;">
				</div>
				<div class="ventana_dato" id="divPerfilClonar2" style="display:none;">
				</div>
				<div class="ventana_dato" id="divPerfilGuardar" style="display:none;">
					<input type="button" id="btnPerfilGuardar" class="boton" value="Guardar" style="width:55px;" onClick="PerfilGuardar();"/>
				</div>
				<div class="ventana_dato" id="divPerfilProceso" style="display:none;">
					<img src="img/loader1.gif" style="width:26px">
				</div>
			</div>
		</div>
		<div style="width:100%; height:20px;  text-align:left; <% if op = 0 then response.Write("display:none;") end if %>" id="divLinea2">
			<hr style="border:1px dashed #EBEBEB; width:97%; left:0" />
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
