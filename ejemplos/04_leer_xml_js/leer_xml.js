$(function() {
    function appendToDom(xml_response) {
        var stations = $(xml_response).find('Estacion');
        var $body = $('body');
        $body.append('<h1>Disponibilidad de ecobicis</h1>');
        for (var i=0; i<stations.length; i++) {
            var nombre = $(stations[i]).find('EstacionNombre').text();
            var bicis = $(stations[i]).find('BicicletaDisponibles').text();
            $body.append('<p>' + nombre + ' ' + bicis + '</p>');
        }
    }

    $.ajax({
        method: "GET",
        url: "../../data/example.xml",
        success: appendToDom
    });
});