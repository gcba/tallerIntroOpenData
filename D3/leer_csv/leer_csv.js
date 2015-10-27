$(function() {
    function parseCSV(csv_text) {
        var lines = csv_text.split(/\r\n|\n/);
        var csv_rows = [];
        for (var i=0; i<lines.length; i++) {
            csv_rows.push(lines[i].split(','));
        }
        return csv_rows
    }

    function appendToDom(csv_rows) {
        var count = {};
        for (var i=1; i<csv_rows.length; i++) {
            var barrio = csv_rows[i][csv_rows[i].length-1];
            if (isNaN(count[barrio])) {
                count[barrio] = 1;
            } else {
                count[barrio] += 1;
            }
        }
        for (var name in count) {
            if (count.hasOwnProperty(name)) {
                $('body').append(name + ' ' + count[name] + '<br>');
            }
        }
    }

    $.ajax({
        method: "GET",
        url: "../../data/147_enero.csv",
        dataType: "text",
        success: function(response) {
            var csv = parseCSV(response);
            appendToDom(csv);
        }
    });
});