$(function() {
    function appendToDom(json_response) {
        var feed = json_response['feeds'];
        var last_weather = feed[feed.length-1];
        var $body = $('body');
        $body.append('<h1>La Plata</h1>')
        $body.append('<h2>Temperatura ' + last_weather['field1'] + '</h2>');
        $body.append('<h2>Humedad ' + last_weather['field2'] + '</h2>');
        $body.append('<h2>Presion ' + last_weather['field3'] + '</h2>');
    }

    $.ajax({
        method: "GET",
        url: "http://api.thingspeak.com/channels/26840/feed.json",
        dataType: "json",
        success: appendToDom
    });
});