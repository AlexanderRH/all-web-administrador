<!-- #INCLUDE FILE="./inc/conexion.asp" -->
<%
response.buffer = true
Response.AddHeader "pragma", "no-cache"
Response.CacheControl = "Private"
Response.Expires = -1000
Session.LCID = 10250

accion = request("accion")
if isnull(accion) or isempty(accion) then accion = ""

if accion = "validar_usuario" then
    call ValidarUsuario()
end if
function ValidarUsuario()
on error resume next
    usuario = request("usuario")
    if isnull(usuario) or isempty(usuario) then usuario = ""

    password = request("password")
    if isnull(password) or isempty(password) then password = ""

    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    set rs = cn.execute("USP_Usuario_ObtenerxNickname '" & usuario & "'")
    if err.number <> 0 then
        response.Write("Error Nro " & err.number & ": " & err.description)
        response.end
    end if
    if not rs.eof then
        if lcase(password) = lcase(rs("password")) and clng(rs("idperfil")) = 1 then
            response.write("ok")
            Session(session_idusuario) = rs("IdUsuario")
            Session(session_nickname) = rs("nickname")
            response.end
        else
            response.write("Usuario/Clave incorrecto")
        end if
    else
        response.write("Usuario/Clave incorrecto")
    end if

if err.number <> 0 then
    response.Write("Error Nro " & err.number & ": " & err.description)
end if
end function

%>
