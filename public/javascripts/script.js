var req;

function loadXMLDoc(url)
{
    req = null;
    // Procura por um objeto nativo (Mozilla/Safari)
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
        req.onreadystatechange = processReqChange;
        req.open("GET", url, true);
        req.send(null);
    // Procura por uma versão ActiveX (IE)
    } else if (window.ActiveXObject) {
        try {
req = new ActiveXObject("Msxml2.XMLHTTP.4.0"); //alert(req);
} catch(e) {
try {
req = new ActiveXObject("Msxml2.XMLHTTP.3.0"); //alert(req);
} catch(e) {
try {
req = new ActiveXObject("Msxml2.XMLHTTP"); //alert(req);
} catch(e) {
try {
req = new ActiveXObject("Microsoft.XMLHTTP"); //alert(req);
} catch(e) {
req = false;
}
}
}
}
        if (req) {
            req.onreadystatechange = processReqChange;
            req.open("GET", url, true);
            req.send();
        }
    }
}

function processReqChange()
{
    // apenas quando o estado for "completado"
    if (req.readyState == 4) {
        // apenas se o servidor retornar "OK"
        if (req.status == 200) {
            // procura pela div id="news" e insere o conteudo
            // retornado nela, como texto HTML
            document.getElementById('relogio').innerHTML = req.responseText;
        } else {
            alert("Houve um problema ao obter os dados:n" + req.statusText);
        }
    }
}

function buscarTempo()
{
    loadXMLDoc("relogio.php");
}

// Recarrega a cada 60000 milissegundo (60 segundos)
setInterval("buscarTempo()", 1000);