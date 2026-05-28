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

if accion = "lista_perfil" then
	call ListaPerfil
end if
function ListaPerfil()
on error resume next
	filtro = request("filtro")
	if isnull(filtro) or isempty(filtro) then filtro = ""

	orden_ca = request("orden_ca")
	if isnull(orden_ca) or isempty(orden_ca) then orden_ca = 2

	orden_ad = request("orden_ad")
	if isnull(orden_ad) or isempty(orden_ad) then orden_ad = "asc"

	orden_flecha = ""
	if orden_ad = "desc" then
		orden_flecha = "style=""background-image:url(img/flecha_down_header.png)"""
	else
		orden_flecha = "style=""background-image:url(img/flecha_up_header.png)"""
	end if

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Perfil_ListarGrupo2"
	cmd.Parameters.Append cmd.CreateParameter("@filtro", adVarchar, adParamInput, 100)

	cmd.Parameters("@filtro") = filtro

	set rs = cmd.execute
	if err.number <> 0 then response.Write("<br>Error Nro. " & err.number & ": " & err.description)

	cont = 0
	if not rs.eof then
		if orden_ca = 1 then rs.sort = "idperfil " & orden_ad
		if orden_ca = 2 then rs.sort = "nombre " & orden_ad
	end if

%>
	<table id="tblGrillaPerfil" class="gr_table01" width="100%">
		<tr class="gr_row01">
			<td class="gr_head01" id="gr_head01" width="40px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaPerfil', 1);"></div><div class="gr_hd3" <% if orden_ca = 1 then response.Write(orden_flecha) end if %>></div>
				<div class="gr_hd4" style="width:32px; text-align:center;" onClick="GROrdenar2('tblGrillaPerfil', 1);">ID</div></div>
			</td>
			<td class="gr_head01" width="240px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaPerfil', 2);"></div><div class="gr_hd3" <% if orden_ca = 2 then response.Write(orden_flecha) end if %>></div>
				<div class="gr_hd4" style="width:232px; text-align:left" onClick="GROrdenar2('tblGrillaPerfil', 2);">Nombre</div></div>
			</td>
			<td class="gr_head01" width="35px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaPerfil', 3);"></div><div class="gr_hd3"></div>
				<div class="gr_hd4" style="width:27px; text-align:center;">Edit</div></div>
			</td>
			<td class="gr_head01" width="35px">
				<div class="gr_hd1"><div class="gr_hd2" onMouseDown="grComienzoMovimiento(event, 'tblGrillaPerfil', 4);"></div><div class="gr_hd3"></div>
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
			<td class="gr_body01" align="center"><%=rs("idperfil")%></td>
			<td class="gr_body01" align="left"><div style="overflow:hidden; height:12px;"><%=rs("nombre")%></div></td>
			<td class="gr_body01" align="center">
<%
		response.Write("<img src=""img/edit.png"" title=""Editar"" border=""0px"" height=""15px"" style=""cursor:pointer"" onClick=""Editar(" & rs("idperfil") & ")"">")
%>
			</td>
			<td class="gr_body01" align="center">
<%
		if clng(rs("idperfil")) <> 1 then
			response.Write("<img src=""img/ACTN011.ICO"" title=""Eliminar"" border=""0px"" height=""15px"" style=""cursor:pointer"" onClick=""Eliminar(" & rs("idperfil") & ")"">")
		end if
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
if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "eliminar" then
	call Eliminar
end if
function Eliminar()
on error resume next
	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0

	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0


	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn
	cmd.CommandType= adCmdStoredProc
	cmd.CommandText = "USP_Perfil_Eliminar"
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)

	cmd.Parameters("@idperfil") = idperfil

	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description)
		response.End()
	else
		response.Write("ok")
	end if

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function

%>
