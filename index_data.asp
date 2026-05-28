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
		'response.write("Su sesi�n ha terminado!")
	end if
    'response.End()
end if

if Session.SessionID <> token then
	response.Redirect(".")
    response.End()
end if

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

accion = request("accion")
if isnull(accion) or isempty(accion) then accion = ""

if accion = "cerrar_sesion" then
	call CerrarSesion
end if
function CerrarSesion()
on error resume next
	Session.Abandon()
	response.Write("ok")
if err.number <> 0 then
	response.Write("Error x Nro. " & err.number & ": " & err.description)
end if
end function

%>
