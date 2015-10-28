$(function() {
    function parseCSV(csv_text) {
        var lines = csv_text.split(/\r\n|\n/);
        var csv_rows = [];
        for (var i=0; i<lines.length; i++) {
            csv_rows.push(lines[i].split(','));
        }
        return csv_rows
    }

    function segmentByHours(csv_rows) {
        console.log(csv_rows);
        var count = [];
        for (var day=0; day<7; day++) {
            for (var hour=0; hour<24; hour++) {
                count.push({day: day+1, hour: hour+1, value: 0})
            }
        }
        for (var i=1; i<csv_rows.length; i++) {
            var date = new Date(csv_rows[i][3]);
            var h = date.getHours();
            var d = date.getDay();
            d = d == 0 ? 7 : d;
            count[24*(d-1)+h].value++;
        }
        for (var j=0; j<count.length; j++) {

        }
        return count;
    }

    function renderHeatmap(csv_rows) {
        var margin = { top: 50, right: 0, bottom: 100, left: 30 };
        var width = $('#heatmap-147').width() - margin.left - margin.right;
        var height = width * 9/16 - margin.top - margin.bottom;
        var gridSize = Math.floor(width / 24);
        var legendElementWidth = gridSize*2;
        var buckets = 9;
        var colors = ["#ffffd9","#edf8b1","#c7e9b4","#7fcdbb","#41b6c4","#1d91c0","#225ea8","#253494","#081d58"];
        var days = ["Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"];
        var times = ["0am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12am", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"];

        var svg = d3.select("#heatmap-147").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        svg.selectAll(".dayLabel").data(days)
            .enter().append("text").text(function (d) { return d; })
            .attr("x", 0).attr("y", function (d, i) { return i * gridSize; })
            .style("text-anchor", "end").attr("transform", "translate(-6," + gridSize / 1.5 + ")");

        svg.selectAll(".timeLabel").data(times)
            .enter().append("text").text(function(d) { return d; })
            .attr("x", function(d, i) { return i * gridSize; })
            .attr("y", 0).style("text-anchor", "middle")
            .attr("transform", "translate(" + gridSize / 2 + ", -6)");

        var data = segmentByHours(csv_rows);
        var colorScale = d3.scale.quantile()
            .domain([0, buckets - 1, d3.max(data, function (d) { return d.value; })])
            .range(colors);

        var cards = svg.selectAll(".hour")
            .data(data, function(d) {return d.day+':'+d.hour;});
        cards.append("title");
        cards.enter().append("rect")
            .attr("x", function(d) { return (d.hour - 1) * gridSize; })
            .attr("y", function(d) { return (d.day - 1) * gridSize; })
            .attr("rx", 4)
            .attr("ry", 4)
            .attr("class", "hour bordered")
            .attr("width", gridSize)
            .attr("height", gridSize)
            .style("fill", function(d) { return colorScale(d.value); });
        cards.exit().remove();

        var legend = svg.selectAll(".legend")
            .data([0].concat(colorScale.quantiles()), function(d) { return d; });
        legend.enter().append("g")
            .attr("class", "legend");
        legend.append("rect")
            .attr("x", function(d, i) { return legendElementWidth * i; })
            .attr("y", height)
            .attr("width", legendElementWidth)
            .attr("height", gridSize / 2)
            .style("fill", function(d, i) { return colors[i]; });
        legend.append("text")
            .attr("class", "mono")
            .text(function(d) { return "≥ " + Math.round(d); })
            .attr("x", function(d, i) { return legendElementWidth * i; })
            .attr("y", height + gridSize);
        legend.exit().remove();

    }

    $.ajax({
        method: "GET",
        url: "./data/147_enero.csv",
        dataType: "text",
        success: function(response) {
            var csv = parseCSV(response);
            renderHeatmap(csv);
        }
    });
});