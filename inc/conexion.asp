<%
on error resume next

response.Charset="ISO-8859-1"

set cn = Server.CreateObject("ADODB.Connection")
'cn.ConnectionString = "Driver={SQL Server};Server=172.19.39.191;Database=bdusuariofegnt; UID=pblogic;PWD=4A8E8310"
'cn.ConnectionString = "Driver={SQL Server};Server=172.19.39.191;Database=bdusuario; UID=pblogic;PWD=4E9805ED"
'cn.ConnectionString = "Driver={SQL Server};Server=.;Database=bdusuario; UID=pblogic;PWD=4E9805ED"
'cn.ConnectionString = "Driver={SQL Server};Server=172.19.39.245;Database=bdusuariofelip; UID=pblogic;PWD=4A8E8310"
'cn.ConnectionString = "Driver={SQL Server};Server=172.19.39.191;Database=bdusuariolip; UID=pblogic; PWD=4E9805ED"
'cn.ConnectionString = "Driver={SQL Server};Server=172.19.39.191;Database=bdusuariontsp; UID=pblogic; PWD=4E9805ED"
cn.ConnectionString = "Driver={SQL Server};Server=.;Database=all-bdusuario; UID=UserApp; PWD=B8009c5FD718"
cn.CursorLocation = 3 'adUseClient
cn.Open

if err.number <> 0 then
	response.write("Error Nro " & err.number & ": " & err.description)
	response.End()
end if

session_idusuario = "su_idusuario"
session_nickname = "su_nickname"

dim params2(10)
dim returnreserva, returnstatus

Const adParamInput = 1
Const adParamOutput = 2

Const adCmdStoredProc = 4
Const adExecuteNoRecords = 128
Const adChar = 129
Const adTinyInt = 16
Const adInteger = 3
Const adCurrency = 6
Const adDate = 7
const adDBDate = 133
const adDBtimeStamp = 135
const adDBTime = 134
const adDouble = 5
const adVarChar = 200
const adLongVarChar = 201
Const adNumeric = 131
Const adBoolean = 11

Const adUseClient = 3

Const adParamReturnValue = 4


' ancho del espacio que distingue a cada nivel del menu
ancho = 14

%>
