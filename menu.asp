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

%>

<form id="frmSeguridad" name="frmSeguridad">
	<input type="hidden" id="txtContOpciones" value="divContOpciones"/>
	<input type="hidden" id="txtIdSistema"/>
	<input type="hidden" id="txtTipoOpcion"/>
	<input type="hidden" id="txtIdOpcion"/>
	<input type="hidden" id="txtNivel"/>

<div id="divBloqueaPagina" style="top:0; left:0; width:100%; height:100%; position:absolute;z-index:1; display:none; background-image:url(img/blanco_transparente.png)">
</div>
<!--
	<div style="width:1000px;">
		<div class="fmenu">
			<div class="espacio">&nbsp;</div>
			<div class="despliegue"><img src="img/mas.gif"></div>
			<div class="icono"><img src="img/icono_menu.png"></div>
			<div class="menu">menu 1</div>
		</div>
		<div class="fdetalle">
			<div class="fmenu">
				<div class="espacio" style="width:24px;">&nbsp;</div>
				<div class="despliegue"><img src="img/mas.gif"></div>
				<div class="icono"><img src="img/icono_menu.png"></div>
				<div class="menu">sub-menu 1</div>
			</div>
			<div class="fmenu">
				<div class="espacio" style="width:24px;">&nbsp;</div>
				<div class="despliegue"><img src="img/mas.gif"></div>
				<div class="icono"><img src="img/icono_menu.png"></div>
				<div class="menu">sub-menu 2</div>
			</div>
			<div class="fdetalle">
				<div class="fmenu">
					<div class="espacio" style="width:36px;">&nbsp;</div>
					<div class="despliegue"></div>
					<div class="icono"><img src="img/icono_formulariod.png"></div>
					<div class="menu">item 1</div>
				</div>
				<div class="fmenu">
					<div class="espacio" style="width:36px;">&nbsp;</div>
					<div class="despliegue"></div>
					<div class="icono"><img src="img/icono_formulario.png"></div>
					<div class="menu">item 2</div>
				</div>
			</div>
		</div>
	</div>
	<br><br><br>
-->
	<div style="width:100%;">
<%

ancho = 14
set rsM = CreateObject("ADODB.Recordset")
set rsA = CreateObject("ADODB.Recordset")

set rsS = cn.execute("exec USP_Sistema_Listar")
if not rsS.eof then
	MostrarSistemas
end if

'while not rsS.eof
'	set rsM = cn.execute("exec USP_Menu_Listar " & rsS("IdSistema"))
'	set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & rsS("IdSistema"))
'	
'	if not rsM.eof then
'		MostrarMenu 0, 1
'	end if
'	
'	rsS.movenext
'wend


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
		response.Write("	<div class=""menu"" onMouseOver=""MostrarOpciones(" & rsS("idsistema") & ", 'S', " & rsS("idsistema") & ", 1, 0)"">" & rsS("nombre") & "</div>")
		response.Write("	<div class=""fopciones"" id=""opcS" & rsS("idsistema") & """>&nbsp;</div>")
		response.Write("</div>")

		' mostramos el detalle del menu
		response.Write("<div class=""fdetalle"" id=""detS" & rsS("idsistema") & """ style=""display:none"">")
		if bhijos then
		
			set rsM = cn.execute("exec USP_Menu_Listar " & rsS("IdSistema"))
			set rsA = cn.execute("exec USP_FormularioAccion_ListarFormulario " & rsS("IdSistema"))
			
			if not rsM.eof then
				MostrarMenu 0, 1
			end if
			
			'MostrarMenu rs("idmenu"), nivel + 1
		end if
		response.Write("</div>")
		
		rsS.movenext
	wend
if err.number <> 0 then
end if
end function

function MostrarMenu(idpadre, nivel)
on error resume next
	set rs = CreateObject("ADODB.Recordset")
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


function MostrarFormulario(idmenu, idformulariod, nivel)
on error resume next
	idformulario_ant = -1
	set rs = CreateObject("ADODB.Recordset")
	set rs = rsA.clone
	rs.filter = "idmenu = " & idmenu
	if not rs.eof then
		'rs.sort = "formulario, idformulario, accion"
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
	</div>
	<div id="divContOpciones" style="display:none;">
		<div id="divOpciones" class="opciones">
			<div class="opcion_esq"><img src="img/esq_opciones.png"/></div>
			<div class="opcion_opc">
				<div class="opcion" id="divBtnNuevoM"><img src="img/nuevo_menu.gif" title="Nuevo Menu" style="cursor:pointer" onClick="Nuevo('M');"/></div>
				<div class="opcion" id="divBtnNuevoF"><img src="img/nuevo_formulario.gif" title="Nuevo Formulario" style="cursor:pointer" onClick="Nuevo('F');"/></div>
				<div class="opcion" id="divBtnEditar"><img src="img/edit.png" title="Editar" style="cursor:pointer" onClick="Editar();"/></div>
				<div class="opcion" id="divBtnEliminar"><img src="img/actn011.ico" title="Eliminar" style="cursor:pointer" onClick="Eliminar();"/></div>
				<div class="opcion" id="divBtnArriba"><img src="img/foldoutmenu2_arrow_up.gif" title="Mover Hacia Arriba" style="cursor:pointer" onClick="Subir();"/></div>
				<div class="opcion" id="divBtnAbajo"><img src="img/foldoutmenu2_arrow_open.gif" title="Mover Hacia Abajo" style="cursor:pointer" onClick="Bajar();"/></div>
			</div>
		</div>
	</div>
</form>
