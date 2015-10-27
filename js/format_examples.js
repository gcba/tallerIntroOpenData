$(function() {
    $.ajax({
        url:'./data/example.xml',
        datatype:'text',
        success: function(response) {
            var xml_string = new XMLSerializer().serializeToString(response);
            $('code.xml').text(xml_string);
        },
        async: false
    });
    $('pre code').each(function(i, block) {
        hljs.highlightBlock(block);
    });
});