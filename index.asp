<!-- #INCLUDE FILE="./inc/conexion.asp" -->
<%
response.buffer = true
Response.AddHeader "pragma", "no-cache" 
Response.CacheControl = "Private" 
Response.Expires = -1000
Session.LCID = 10250

su_idusuario = Session(session_idusuario) 
if isnull(su_idusuario) or isempty(su_idusuario) or su_idusuario = "" then
%>
    <!-- #INCLUDE file="login.asp" -->
<%
    'Response.Redirect "login.html"
    response.End()
end if

%>
<html>
<head>
    <title>New Transport Security</title>

    <!-- para el menu horizontal -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/styles.css">
    <script src="script.js"></script>

    <!-- estilos generales -->
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/general.css">
    <link rel="stylesheet" type="text/css" href="dateedit/src/shaded.css" />
    <link rel="stylesheet" type="text/css" href="css/gr_grilla.css">

    <!-- jscripts generales -->
    <script type="text/javascript" src="js/index.js"></script>
    <script type="text/javascript" src="js/ajax.js"></script>
    <script type="text/javascript" src="js/funciones_ajax.js"></script>
    <script type="text/javascript" src="js/validaciones.js"></script>
    <script type="text/javascript" src="js/gr_grilla.js"></script>
</head>
<body style="margin: 0px; font-family: arial; font-size: 14px; background-color: #35639B">
<!-- onbeforeunload="event.returnValue = 'Si cierras la ventana no se guardaran los cambios.'" -->
	<input type="hidden" id="txtToken" value="<%=session.SessionID%>">
	<div style="width:100%; height: 90px; background-color: #0D85B9">
	</div>
	<div style="width:100%; height: 37px; background-color: #2BA3D7">
	</div>
	<table id="divcentral">
		<tr>
			<td style="padding:0px; vertical-align:top">
				<div style="width:100%; height:90px;">
					<img src="img/barra.jpg" style="position:absolute;">
					<img src="img/cerrar_sesion.png" style="float:right; bottom:-64px; position:relative; cursor:pointer;" onClick="CerrarSesion();">
				</div>
				<div id='cssmenu'>
					<ul>
<!--					   <li class="active" id="mnuHome"><a onClick="CargarPagina(this, 'vacio', '');"><span>HOME</span></a></li>-->
					   <li id="mnuSistemas"><a onClick="CargarPagina(this, 'sistema_lista', '');"><span>SISTEMAS</span></a></li>
					   <li id="mnuAcciones"><a onClick="CargarPagina(this, 'accion_lista', '');"><span>ACCIONES</span></a></li>
					   <li id="mnuMenus"><a onClick="CargarPagina(this, 'menu', '');"><span>MENUS</span></a></li>
					   <li id="mnuPerfiles" class='last'><a onClick="CargarPagina(this, 'grupo_lista', '');"><span>GRUPOS</span></a></li>
					   <li id="mnuUsuarios"><a onClick="CargarPagina(this, 'usuario_lista', '');"><span>USUARIOS</span></a></li>
					</ul>
				</div>
				<div id="divContenido" style="width:100%; padding:5px;">
				</div>
			</td>
		</tr>
	</table>
</body>
</html>