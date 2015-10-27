$(function() {
    function selectDayFromCsv(csv_text, day) {
        var data = [];
        var lines = csv_text.split(/\r\n|\n/);
        for (var j=0; j<lines[0].split(',').length-2; j++) {
            data.push([]);
        }
        for (var i=0; i<lines.length; i++) {
            var row = lines[i].split(',');
            if (row[0] == day) {
                for (var k=2; k<row.length; k++) {
                    data[k-2].push(parseInt(row[k]))
                }
            }
        }
        return data;
    }

    function getDataForDay(day) {
        var csv_text;
        $.ajax({
            url: "../data/subte_julio2014.csv",
            method: "GET",
            dataType: "text",
            async: false,
            success: function(response) {
                csv_text = response;
            }
        });
        return selectDayFromCsv(csv_text, day);
    }

    function drawStreampgraph(day, containerSelector) {
        var width = $(containerSelector).width();
        var height = width*9/16;
        var data = getDataForDay(day);

        var sum = new Array(data[0].length);
        for (var time=0; time<data[0].length; time++) {
            sum[time] = 0;
            for (var station=0; station<data.length; station++) {
                sum[time] += data[station][time];
            }
        }

        data = data.map(function (d) {
            return d.map(function (p, i) {
                return {
                    x: i,
                    y: p,
                    y0: 0
                };
            });
        });


        var color = d3.scale.linear().range(["#0A3430", "#1E5846"]);

        var x = d3.scale.linear().range([0, width])
            .domain([0, data[0].length]);

        var y = d3.scale.linear().range([height, 0]).domain([0, d3.max(sum)]);

        var svg = d3.select(containerSelector).append("svg")
            .attr("width", width).attr("height", height).append("g");

        var stack = d3.layout.stack().offset("wiggle");

        var layers = stack(data);

        var area = d3.svg.area().interpolate('cardinal')
            .x(function (d, i) {
                return x(i);
            })
            .y0(function (d) {
                return y(d.y0);
            })
            .y1(function (d) {
                return y(d.y0 + d.y);
            });

        svg.selectAll(".layer").data(layers).enter().append("path").attr("class", "layer")
            .attr("d", function (d) {
                return area(d);
            })
            .style("fill", function (d, i) {
                return color(i);
            });

    }

    drawStreampgraph('2014-07-13', "#streamgraph-mundial");
    drawStreampgraph('2014-07-20', "#streamgraph-normal");

});