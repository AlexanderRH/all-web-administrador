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

set rsS = CreateObject("ADODB.Recordset")
set rsG = CreateObject("ADODB.Recordset")
set rsM = CreateObject("ADODB.Recordset")
set rsA = CreateObject("ADODB.Recordset")

accion = request("accion")
if isnull(accion) or isempty(accion) then accion = ""

if accion = "guardar" then
	call Guardar
end if
function Guardar()
on error resume next
	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0
	
	idusuario = request("idusuario")
	if isnull(idusuario) or isempty(idusuario) or idusuario = "" then idusuario = 0
	
	idempresa = request("idempresa")
	if isnull(idempresa) or isempty(idempresa) or idempresa = "" then idempresa = 0
	
	idtanexo = request("idtanexo")
	if isnull(idtanexo) or isempty(idtanexo) or idtanexo = "" then idtanexo = 0
	
	idanexo = request("idanexo")
	if isnull(idanexo) or isempty(idanexo) or idanexo = "" then idanexo = 0
	
	idccosto = request("idccosto")
	if isnull(idccosto) or isempty(idccosto) or idccosto = "" then idccosto = 0
	
	nickname = request("nickname")
	if isnull(nickname) or isempty(nickname) then nickname = ""

	password = request("password")
	if isnull(password) or isempty(password) then password = ""
	
	apellidopaterno = request("apellidopaterno")
	if isnull(apellidopaterno) or isempty(apellidopaterno) then apellidopaterno = ""
	
	apellidomaterno = request("apellidomaterno")
	if isnull(apellidomaterno) or isempty(apellidomaterno) then apellidomaterno = ""
	
	nombres = request("nombres")
	if isnull(nombres) or isempty(nombres) then nombres = ""
	
	direccion = request("direccion")
	if isnull(direccion) or isempty(direccion) then direccion = ""
	
	telefono = request("telefono")
	if isnull(telefono) or isempty(telefono) then telefono = ""
	
	celular = request("celular")
	if isnull(celular) or isempty(celular) then celular = ""
	
	email = request("email")
	if isnull(email) or isempty(email) then email = ""
	
	emailpassword = request("emailpassword")
	if isnull(emailpassword) or isempty(emailpassword) then emailpassword = ""
	

	token_url = request("token_url")
	if isnull(token_url) or isempty(token_url) then token_url = ""

	client_id = request("client_id")
	if isnull(client_id) or isempty(client_id) then client_id = ""

	client_secret = request("client_secret")
	if isnull(client_secret) or isempty(client_secret) then client_secret = ""

	refresh_token = request("refresh_token")
	if isnull(refresh_token) or isempty(refresh_token) then refresh_token = ""


	firma = request("firma")
	if isnull(firma) or isempty(firma) then firma = ""
	
	estado = request("estado")
	if isnull(estado) or isempty(estado) or estado = "" then estado = 0
	
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc
	if op = 0 then
		cmd.CommandText = "USP_Usuario_Insertar"
		cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamOutput, 10)
	else
		cmd.CommandText = "USP_Usuario_Modificar"
		cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
	end if
	cmd.Parameters.Append cmd.CreateParameter("@idempresa", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@nickname", adVarchar, adParamInput, 15)
	cmd.Parameters.Append cmd.CreateParameter("@password", adVarchar, adParamInput, 15)
	cmd.Parameters.Append cmd.CreateParameter("@apellidopaterno", adVarchar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@apellidomaterno", adVarchar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@nombres", adVarchar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@direccion", adVarchar, adParamInput, 100)
	cmd.Parameters.Append cmd.CreateParameter("@telefono", adVarchar, adParamInput, 20)
	cmd.Parameters.Append cmd.CreateParameter("@celular", adVarchar, adParamInput, 20)
	cmd.Parameters.Append cmd.CreateParameter("@email", adVarchar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@emailpassword", adVarchar, adParamInput, 20)

	cmd.Parameters.Append cmd.CreateParameter("@token_url", adVarchar, adParamInput, 200)
	cmd.Parameters.Append cmd.CreateParameter("@client_id", adVarchar, adParamInput, 200)
	cmd.Parameters.Append cmd.CreateParameter("@client_secret", adVarchar, adParamInput, 200)
	cmd.Parameters.Append cmd.CreateParameter("@refresh_token", adVarchar, adParamInput, 200)

	cmd.Parameters.Append cmd.CreateParameter("@firma", adVarchar, adParamInput, 1000)
	cmd.Parameters.Append cmd.CreateParameter("@idanexo", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@idtanexo", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@idccosto", adInteger, adParamInput, 10)
	cmd.Parameters.Append cmd.CreateParameter("@estado", adTinyint, adParamInput, 3)

	if op = 1 then
		cmd.Parameters("@idusuario") = idusuario
	end if
	cmd.Parameters("@idempresa") = idempresa
	cmd.Parameters("@nickname") = nickname
	cmd.Parameters("@password") = password
	cmd.Parameters("@apellidopaterno") = apellidopaterno
	cmd.Parameters("@apellidomaterno") = apellidomaterno
	cmd.Parameters("@nombres") = nombres
	cmd.Parameters("@direccion") = direccion
	cmd.Parameters("@telefono") = telefono
	cmd.Parameters("@celular") = celular
	cmd.Parameters("@email") = email
	cmd.Parameters("@emailpassword") = emailpassword

	cmd.Parameters("@token_url") = token_url
	cmd.Parameters("@client_id") = client_id
	cmd.Parameters("@client_secret") = client_secret
	cmd.Parameters("@refresh_token") = refresh_token

	cmd.Parameters("@firma") = firma
	cmd.Parameters("@idanexo") = idanexo
	cmd.Parameters("@idtanexo") = idtanexo
	cmd.Parameters("@idccosto") = idccosto
	cmd.Parameters("@estado") = estado
	
	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description)
		response.End()
	end if
	
	if op = 0 then
		idusuario = cmd.Parameters("@idusuario")
	end if
	
	if isnull(idusuario) or isempty(idusuario) then
		response.Write("Ocurrio un error al registrar el usuario")
	else
		idperfil = 0
		perfil = ""
		
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = cn 
		cmd.CommandType= adCmdStoredProc  
		cmd.CommandText = "USP_Usuario_ObtenerxIdUsuario"
		cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
		cmd.Parameters("@idusuario") = idusuario
		set rsU = cmd.execute
		if not rsU.eof then
			idperfil = rsU("idperfil")
			perfil = rsU("perfil")
		end if
		
		response.Write("ok<:-:>" & idusuario & "<:-:>" & idperfil & "<:-:>" & perfil & "<:-:>")
		call MenuCargar(idperfil)
	end if
	
if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "perfil_cambiar" then
	call PerfilCambiar
end if
function PerfilCambiar()
on error resume next
	idusuario = request("idusuario")
	if isnull(idusuario) or isempty(idusuario) or idusuario = "" then idusuario = 0
	
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
		
		
		idperfil = rsU("IdPerfil")
		perfil = rsU("Perfil")
		grupo = rsU("Grupo")
	end if
		
%>
	<select id="cboPerfil" class="combo" style="width:200px">
<%
	if cint(grupo) = 1 then	'de grupo a unico
		response.Write("<option value=""0"">[ " & nombrecompleto & " ]</option>")
	end if
	set rsP = cn.execute("USP_Perfil_ListarGrupo")
	while not rsP.eof
		response.Write("<option value=""" & rsP("idperfil") & """>" & rsP("perfil") & "</option>")
		rsP.movenext
	wend
%>
	</select>
<%

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "perfil_clonar" then
	call PerfilClonar
end if
function PerfilClonar()
on error resume next
	idusuario = request("idusuario")
	if isnull(idusuario) or isempty(idusuario) or idusuario = "" then idusuario = 0
	
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

%>
	<select id="cboPerfilTipo" class="combo" style="width:70px" onChange="PerfilCargarLista();" onClick="PerfilCargarLista();" onBlur="PerfilCargarLista();">
		<option value="1" selected="selected">�nico</option>
		<option value="2">Grupo</option>
	</select>
<%
	response.Write("<:-:>")
%>
	<select id="cboPerfil" class="combo" style="width:200px">
<%
	set rsP = cn.execute("USP_Perfil_Listar")
	if not rsP.eof then
		rsP.filter = "Grupo = 0"
	end if
	while not rsP.eof
		response.Write("<option value=""" & rsP("idperfil") & """>" & rsP("perfil") & "</option>")
		rsP.movenext
	wend
%>
	</select>
<%

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "perfil_cargar_lista" then
	call PerfilCargarLista
end if
function PerfilCargarLista()
on error resume next
	idtperfil = request("idtperfil")
	if isnull(idtperfil) or isempty(idtperfil) or idtperfil = "" then idtperfil = 0
%>
	<select id="cboPerfil" class="combo" style="width:200px">
<%
	set rsP = cn.execute("USP_Perfil_Listar")
	if not rsP.eof then
		if idtperfil = 1 then rsP.filter = "Grupo = 0"
		if idtperfil = 2 then rsP.filter = "Grupo = 1"
	end if
	while not rsP.eof
		response.Write("<option value=""" & rsP("idperfil") & """>" & rsP("perfil") & "</option>")
		rsP.movenext
	wend
%>
	</select>
<%

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
end if
end function


if accion = "perfil_guardar" then
	call PerfilGuardar
end if
function PerfilGuardar()
on error resume next
	idusuario = request("idusuario")
	if isnull(idusuario) or isempty(idusuario) or idusuario = "" then idusuario = 0
	
	idperfil = request("idperfil")
	if isnull(idperfil) or isempty(idperfil) or idperfil = "" then idperfil = 0
	
	idperfilclonar = request("idperfilclonar")
	if isnull(idperfilclonar) or isempty(idperfilclonar) or idperfilclonar = "" then idperfilclonar = 0
	
	tcambio = request("tcambio")
	if isnull(tcambio) or isempty(tcambio) or tcambio = "" then tcambio = 0

	perfil = ""
	
	if cint(tcambio) = 1 then ' cambio
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = cn 
		cmd.CommandType= adCmdStoredProc  
		cmd.CommandText = "USP_Usuario_ObtenerxIdUsuario"
		cmd.Parameters.Append cmd.CreateParameter("@idusuario", adInteger, adParamInput, 10)
		cmd.Parameters("@idusuario") = idusuario
		
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
	
		if cint(xgrupo) = 0 and cint(idperfil) = 0 then
			response.Write("Usuario ya tiene un perfil �nico.")
			response.End()
		end if
		if cint(xgrupo) = 0 and cint(idperfil) = cint(xidperfil) then
			response.Write("Usuario ya tiene asignado este perfil �nico.")
			response.End()
		end if
		if cint(xgrupo) = 1 and cint(idperfil) = cint(xidperfil) then
			response.Write("Usuario ya tiene asignado este perfil grupal.")
			response.End()
		end if
	
		if cint(idperfil) = 0 then
			perfil = nombrecompleto
			
			'creamos el perfil unico
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = cn 
			cmd.CommandType= adCmdStoredProc
			cmd.CommandText = "USP_Perfil_Insertar"
			cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamOutput, 10)
			cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 100)
			cmd.Parameters.Append cmd.CreateParameter("@grupo", adTinyint, adParamInput, 3)
		
			cmd.Parameters("@nombre") = perfil
			cmd.Parameters("@grupo") = 0
			
			cmd.Execute ,,adExecuteNoRecords
			if err.number <> 0 then
				response.Write("Error Nro. " & err.number & ": " & err.description)
				response.End()
			end if
			
			idperfil = cmd.Parameters("@idperfil")
			
			if isnull(idperfil) or isempty(idperfil) then
				response.Write("Ocurrio un error al registrar el perfil �nico")
				response.End()
			end if
		end if
		
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
			response.Write("Error Nro. " & err.number & ": " & err.description)
			response.End()
		end if
	else
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = cn 
		cmd.CommandType= adCmdStoredProc  
		cmd.CommandText = "USP_Perfil_ObtenerxIdPerfil"
		cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
		cmd.Parameters("@idperfil") = idperfil
		set rsP = cmd.execute
		if not rsP.eof then
			xgrupo = rsP("grupo")
		end if
		
		if xgrupo = true then
			response.Write("El perfil actual del usuario es grupal y no se puede clonar desde otro perfil.")
			response.End()
		end if
		
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = cn 
		cmd.CommandType= adCmdStoredProc
		cmd.CommandText = "USP_Usuario_ClonarPerfil"
		cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
		cmd.Parameters.Append cmd.CreateParameter("@idperfilclonar", adInteger, adParamInput, 10)
	
		cmd.Parameters("@idperfil") = idperfil
		cmd.Parameters("@idperfilclonar") = idperfilclonar
		
		cmd.Execute ,,adExecuteNoRecords
		if err.number <> 0 then
			response.Write("Error Nro. " & err.number & ": " & err.description)
			response.End()
		end if
	end if
	
	' obtenemos el nombre del perfil que elegimos/creamos
	perfil = ""
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Perfil_ObtenerxIdPerfil"
	cmd.Parameters.Append cmd.CreateParameter("@idperfil", adInteger, adParamInput, 10)
	cmd.Parameters("@idperfil") = idperfil
	
	set rsP = cmd.execute
	if not rsP.eof then
		perfil = rsP("perfil")
	end if

	if err.number <> 0 then
		response.Write("Error x Nro. " & err.number & ": " & err.description)
	end if
	
	response.Write("ok<:-:>" & idperfil & "<:-:>" & perfil & "<:-:>")
	call MenuCargar(idperfil)
	
if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description)
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

%>
