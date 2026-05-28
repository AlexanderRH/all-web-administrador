//autor Ivan Cachicatari

function MostrarSegmento(block) 
{
	elm = document.getElementById(block);
	if (elm.style.display == 'block')	
		elm.style.display='none';
	else 
		elm.style.display='block';
}
function NuevoAjax()
{ 
    var xmlhttp=false;
    try{
        xmlhttp=new ActiveXObject("Msxml2.XMLHTTP"); // Creacion del objeto AJAX para navegadores no IE
    }
    catch(e){
        try{        
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");    // Creacion del objet AJAX para IE
        }
        catch(E){
            if (!xmlhttp && typeof XMLHttpRequest!="undefined") 
                xmlhttp=new XMLHttpRequest();
        }
    }
    return xmlhttp; 
};

function IsNumeric(strString) //  check for valid numeric strings	
{
 	if(!/\D/.test(strString)) return true;//IF NUMBER
 	else if(/^(-)?\d+\.\d+$/.test(strString)) return true;//IF A DECIMAL NUMBER HAVING AN INTEGER ON EITHER SIDE OF THE DOT(.)
	else return false;
}


function ltrim(s) {
	return s.replace(/^\s+/, "");
}

function rtrim(s) {
	return s.replace(/\s+$/, "");
}

function trim(s) {
	return rtrim(ltrim(s));
}