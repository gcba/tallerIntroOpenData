$(function() {
    $.ajax({
        url:'./data/example.xml',
        success: function(response) {
            var xml_string = new XMLSerializer().serializeToString(response);
            $('code.xml').text(xml_string);
        },
        async: false
    });
    $.ajax({
        url:'./data/example.json',
        dataType:'text',
        success: function(response) {
            $('code.json').text(response);
        },
        async: false
    });
    $('pre code').each(function(i, block) {
        hljs.highlightBlock(block);
    });
});