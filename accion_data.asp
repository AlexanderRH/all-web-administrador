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

if accion = "guardar" then
	call Guardar
end if
function Guardar()
on error resume next
	op = request("op")
	if isnull(op) or isempty(op) or op = "" then op = 0
	
	idaccion = request("idaccion")
	if isnull(idaccion) or isempty(idaccion) or idaccion = "" then idaccion = 0

	codigo = request("codigo")
	if isnull(codigo) or isempty(codigo) then codigo = ""
		
	nombre = request("nombre")
	if isnull(nombre) or isempty(nombre) then nombre = ""

	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc
	if cint(op) = 0 then
		cmd.CommandText = "USP_Accion_Insertar"
		cmd.Parameters.Append cmd.CreateParameter("@idaccion", adInteger, adParamOutput, 10)
	else
		cmd.CommandText = "USP_Accion_Modificar"
		cmd.Parameters.Append cmd.CreateParameter("@idaccion", adInteger, adParamInput, 10)
	end if
	cmd.Parameters.Append cmd.CreateParameter("@codigo", adVarchar, adParamInput, 20)
	cmd.Parameters.Append cmd.CreateParameter("@nombre", adVarchar, adParamInput, 50)

	if cint(op) = 1 then
		cmd.Parameters("@idaccion") = idaccion
	end if
	cmd.Parameters("@codigo") = codigo
	cmd.Parameters("@nombre") = nombre
	
	cmd.Execute ,,adExecuteNoRecords
	if err.number <> 0 then
		response.Write("Error y Nro. " & err.number & ": " & err.description & " op = " & op)
		response.End()
	end if
	
	if op = 0 then
		idaccion = cmd.Parameters("@idaccion")
	end if
	
	if isnull(idaccion) or isempty(idaccion) then
		response.Write("Ocurrio un error al registrar la Acci�n")
	else
		response.Write("ok<:-:>" & idaccion)
	end if
	
if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function

%>
