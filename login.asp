<%
response.buffer = true
Response.AddHeader "pragma", "no-cache" 
Response.CacheControl = "Private" 
Response.Expires = -1000
Session.LCID = 10250
%>
<html>
<head>
    <title>New Transport Security - Login</title>

    <link rel="stylesheet" type="text/css" href="css/login.css">
    
    <!-- jscripts generales -->
    <script type="text/javascript" src="js/ajax.js"></script>
    <script type="text/javascript" src="js/funciones_ajax.js"></script>
    <script type="text/javascript" src="js/validaciones.js"></script>
    <script type="text/javascript" src="js/login.js"></script>
</head>
<body style="margin: 0px; font-family: arial; font-size: 14px; background-color: #35639B">
    <form id="frmLogin" name="frmLogin" action="." onSubmit="return Validar();">
        <div id="divcentral">
            <div id="divladoizquierdo">
                <img src="img/internet_candado.jpg">
            </div>
            <div id="divladoderecho">
                <div id="divlogo">
                    <img src="img/logo.jpg" class="imglogo">
                </div>
                <div id="divusuario">
                    <input type="text" id="txtSUUsuario" class="txtcajas" maxlength="15" placeholder="Usuario" value=""/>
                </div>
                <div id="divpassword">
                    <input type="password" id="txtSUPassword" class="txtcajas" maxlength="15" placeholder="Password" value=""/>
                </div>
                <div id="divlogin">
                    <div style="width: 80px; float: left">
                        <input type="submit" id="cboLogin" class="btnlogin" value="Login"/>
                    </div>
                    <div id="divProceso" style="float: left;">
                        
                    </div>
                </div>
            </div> 
        </div>
    </form>
</body>
</html>