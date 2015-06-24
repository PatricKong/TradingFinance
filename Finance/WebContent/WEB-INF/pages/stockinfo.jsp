<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Market Data</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">
</script>
<script>
	$(document).ready(function() {
		setInterval("getMarketData()", 2000);	// Send request every 2 seconds
	});
	function getMarketData() {	
		$.ajax({
			url: "http://localhost:8080/Finance/rest/finance",
			type: "post",
			dataType: "json", //output and data is input
			success: showData
		});	
	}
	function showData(data) {
		var rows = "";
		$("#stocks").empty();		
		$(data.stock).each(function(i, item) {
			var sid = item.sname;
			var price = item.price;
			var change = item.change;
			var color;
			if (change>0) color = "green";
			else if (change<0) color="red";
			else color="black";
			rows = "<tr><td>" + sid + "</td><td>" + price + "</td><td>" + 
				"<font color=" + color + ">" + change + "</font></td></tr>";
			$(rows).appendTo("#stocks");
		});		
	}
</script>
</head>
<body>
<h2><font color="blue">Sample12: Market Data + REST</font></h2>
<table id="stockList" border="1" width="300">
	<tr>
		<th>Stock ID</th>
		<th>Price</th>
		<th>Change</th>
	</tr>
	<tbody id="stocks"></tbody>
</table>
</body>
</html>