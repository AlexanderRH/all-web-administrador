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

idaccion = request("idaccion")
if isnull(idaccion) or isempty(idaccion) then idaccion = 0

op = request("op")
if isnull(op) or isempty(op) then op = 0

if op = 1 and idaccion <> 0 then
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = cn 
	cmd.CommandType= adCmdStoredProc  
	cmd.CommandText = "USP_Accion_ObtenerxIdAccion"
	cmd.Parameters.Append cmd.CreateParameter("@idaccion", adInteger, adParamInput, 10)
	cmd.Parameters("@idaccion") = idaccion
	
	set rsU = cmd.execute
	if err.number <> 0 then
		response.Write("Error Nro. " & err.number & ": " & err.description & "<br>")
		response.End()
	end if
	
	if not rsU.eof then
		idaccion = rsU("idaccion")
		codigo = rsU("codigo")
		nombre = rsU("nombre")
	end if
end if

if err.number <> 0 then
	response.Write("Error Nro. " & err.number & ": " & err.description & "<br>")
	response.End()
end if


busq_campo = request("bcampo")
if isnull(busq_campo) or isempty(busq_campo) then busq_campo = 0

busq_filtro = request("bfiltro")
if isnull(busq_filtro) or isempty(busq_filtro) then busq_filtro = ""

url_lista = request("url_lista")
if isnull(url_lista) or isempty(url_lista) or url_lista = "" then
	url_lista = "&campo=" & busq_campo & "&filtro=" & busq_filtro
end if

url_lista_n = "&op=0&bcampo=" & busq_campo & "&bfiltro=" & busq_filtro
%>
		<input type="hidden" id="txtUrlLista" name="txtUrlLista" value="<%=url_lista%>">
		<input type="hidden" id="txtUrlListaN" name="txtUrlListaN" value="<%=url_lista_n%>">
		<input type="hidden" id="txtOp" name="txtOp" value="<%=op%>">
		<div style="width:100%; height:32px; font-size:17px; font-weight:bold; color:#3366CC;">
			<div class="pagina_titulo">Acci�n</div>
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
		<div style="width:100%; height:90px;">
			<div class="ventana_fila" style="height:4px;">
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">ID:</div>
				<div class="ventana_dato">
					<input class="txtcaja" type="text" id="txtIdAccion" values="" style="width:60px; text-align:center" disabled="disabled" value="<%=idaccion%>"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">C�digo</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtCodigo" style="width:207px;" maxlength="20" value="<%=codigo%>"/>
				</div>
			</div>
			<div class="ventana_fila">
				<div class="ventana_tdato">Nombre</div>
				<div class="ventana_dato" style="width:217px">
					<input class="txtcaja" type="text" id="txtNombre" value="<%=nombre%>" style="width:250px;" maxlength="50"/>
				</div>
			</div>
		</div>
