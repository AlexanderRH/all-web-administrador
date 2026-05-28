<!-- #INCLUDE FILE="./inc/conexion.asp" -->
<%
idusuario = session("idusuario") 
if isnull(idusuario) or isempty(idusuario) or idusuario = "" then
    response.End()
end if
%>
<html>
<head>
    <title>New Transport Security</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/styles.css">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="script.js"></script>

    <style>
        #divcentral
        {
            position:absolute;
            padding:0px;
            border-collapse:collapse;
            border: none;

            top: 0px;
            left: 50%;
            margin-left: -475px;
            
            width: 950px;
            height: 100%;
            background-color: white;
        }
    </style>
    <script>
        function Validar()
        {
            try
            {
                var usuario = document.getElementById("txtUsuario").value
                var password = document.getElementById("txtPassword").value
                alert(password)
            }
            catch(e)
            {
                
            }
        }
    </script>
</head>
<body style="margin: 0px; font-family: arial; font-size: 14px; background-color: #35639B">
    <form id="frmLogin" name="frmLogin" action="index.asp" onsubmit="return Validar();" style="margin:0px;">
        <div style="width:100%; height: 129px; background-color: #567AA5">

        </div>
<!--
        <div id="divcentral">
            <div style="width:100%; height:90px;">
            </div>
            <div id='cssmenu'>
                <ul>
                   <li class="active"><a href='#'><span>HOME</span></a></li>
                   <li><a href='#'><span>USUARIOS</span></a></li>
                   <li><a href='#'><span>SISTEMAS</span></a></li>
                   <li class='last'><a href='#'><span>PERFILES</span></a></li>
                </ul>
            </div>
        </div>
-->
        <table id="divcentral">
            <tr>
                <td style="padding:0px">
                    <div style="width:100%; height:90px;">
                    </div>
                    <div id='cssmenu'>
                        <ul>
                           <li class="active"><a href='#'><span>HOME</span></a></li>
                           <li><a href='#'><span>USUARIOS</span></a></li>
                           <li><a href='#'><span>SISTEMAS</span></a></li>
                           <li class='last'><a href='#'><span>PERFILES</span></a></li>
                        </ul>
                    </div>
                    <div style="width:100%; height:990px;">
                    </div>

                </td>
            </tr>
        </table>
    </form>
</body>
</html>