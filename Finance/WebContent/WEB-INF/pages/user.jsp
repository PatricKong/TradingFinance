<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/css/user.css" />">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script>google.load("visualization", "1.1", {packages:["bar","corechart"]});</script>
    <script src="js\stupidtable.min.js"></script>
    <script>
    
//*************************************Google Chart****************************************************************************************//
//*****************************************************************************************************************************************//
// Load the Visualization API and the piechart package.

      // Set a callback to run when the Google Visualization API is loaded.
    
    //******************************main function**************************************///
   	$(document).ready(function() {
	$(".portfolioContent").hide();
	$(".liveStocksContent").hide();
	$(".purchaseContent").hide();
	$(".historyContent").hide();
	$(".moneyContent").hide();
	});
/******************************Personal Live Stock*************************************************************************************************************///
//*************************************************************************************************************************************************************///
    function addStock(){
    	$.ajax({
    		url: "http://localhost:8080/Finance/rest/user/addstock",
    		type: "POST",
    		data: {
    			sname:$("#sname").val()
    		},
    		success: function(){
    			
    		}
    	});
    }
  
    function getLiveStocks(){
		$(".historyContent").hide();
		$(".portfolioContent").hide();
		$(".purchaseContent").hide();
		$(".moneyContent").hide();
		$(".liveStocksContent").show();
	}
	
	angular.module("mainModule", []).controller("mainController", function($scope, $interval, $http) {
		// Initialization
		var promise;
		var promise2;
		$scope.amount;
		$scope.stock = [];
		$scope.stock2 = [];
		$scope.start = function(){
		promise = $interval(function() {
			$http({
				method: "GET",
				url: "http://localhost:8080/Finance/rest/finance/getstocks",
			}).success(function(data) {
				$scope.stock = data.stock;
			}).error(function(data) {
				//alert("AJAX Error!");
			});
		}, 2000);
		};	
		$scope.stop = function(){
			$interval.cancel(promise);
		};
		$scope.allStocks = function(){
			promise2 = $interval(function(){
				$http({
					method: "GET",
					url: "http://localhost:8080/Finance/rest/finance/getstocks",
				}).success(function(data2) {
					$scope.stock2 = data2.stock;
					//alert($scope.stock2);
				}).error(function(data) {
					//alert("AJAX Error!");
				});
			}, 2000);
		};
		$scope.stop2 = function(){
			$interval.cancel(promise2);
		};
		//ng-click="addMoney(amount);getMoney()"
		$scope.addMoney = function(data) {
        	$http({
				method: "post",
				url: "http://localhost:8080/Finance/rest/user/addmoney" + "?amount=" + data
			}).success(function() {
				//alert("succ");
			}).error(function(data) {
			});
        };
        $scope.getMoney = function() {
        	//alert("getmoney");
        	$http({
				method: "GET",
				url: "http://localhost:8080/Finance/rest/user/getmoney"
			}).success(function(amount){
				//alert(amount);
				$scope.amount = amount;
			}).error(function(){
				//alert("AJAX Error!");
			});
        };
	});
	
    function Ctrl($scope, $http) {
        $scope.setAtts = function(sname) {
        	var name = purchase;
        	$http({
				method: "post",
				url: "http://localhost:8080/Finance/rest/user/deletestock" + "?sname=" + sname
			});
        };
		$scope.purchaseStock = function(purchase, qty, type) {
			$http({
				method: "POST",
				url: "http://localhost:8080/Finance/rest/user/purchasestock?sname=" + purchase + "&qty=" + qty + "&type=" + type
			}).success(function(data) {
				if(data=="false")
					alert("Not Enough Money");
			}).error(function(data) {
			});;
	    };
      }

/******************************Get Transaction History*************************************************************************************************************///
/*****************************************************************************************************************************************************************///
	function getHistory(){
		$("#simpleTable").stupidtable();
		$(".portfolioContent").hide();
		$(".liveStocksContent").hide();
		$(".purchaseContent").hide();
		$(".moneyContent").hide();
		$(".historyContent").show();
		getMarketData();
	}
	function getMarketData() {	
		$.ajax({
			url: "http://localhost:8080/Finance/rest/user/gethistory",
			type: "get",
			dataType: "json", //output and data is input
			success: showData
		});	
	}
	function showData(data) {
		var rows = "";
		$("#history").empty();		
		$(data.transaction).each(function(i, item) {
			var trans_id = item.trans_id;
			var qty = item.qty;
			var status = item.status;
			var t_date = item.t_date;
			var process = item.process;
			var price = item.price;
			var sname = item.sname;
			var color;
			var color2;
			if (status=="buy") color = "green";
			else if (status=="sell") color="red";
			if (process=="complete") color2 = "green";
			else if (process=="pending") color2="red";
			
			rows = "<tr><td>" + trans_id + "</td><td>" + qty + "</td><td>" + 
			"<font color=" + color + ">" + status + "</font></td>" + 
			"<td>" + t_date + "</td><td>" + "<font color=" + color2 + ">" + process + "</font></td><td>" + price + "</td><td>" + sname + "</td></tr>";
		    $(rows).appendTo("#history");
		});		
	}
/******************************Get Portfolio**********************************************************************************************************************///
/*****************************************************************************************************************************************************************///
	
	function getPortfolio(){
		$(".historyContent").hide();
		$(".liveStocksContent").hide();
		$(".purchaseContent").hide();
		$(".moneyContent").hide();
		$(".portfolioContent").show();
		getStockValue();
		getStockQty();
	}
	function getStockValue() {
		$.ajax({
			url: "http://localhost:8080/Finance/rest/user/getpie",
			type: "get",
			dataType: "json", //output and data is input
			success:processData
		});	
	}
	function processData(stockData){
		var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('number', 'Value');
 		data.addRows($(stockData.pieInfo).length);
        $(stockData.pieInfo).each(function(i,item){
        	data.setValue(i,0,item.sname);
        	data.setValue(i,1,item.value);
        });
        var options = {'title':'value of each stock',
                       'width':400,
                       'height':300};
		
        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
	}
	
	function getStockQty(){
		$.ajax({
			url: "http://localhost:8080/Finance/rest/user/getcolumn",
			type: "get",
			dataType: "json", //output and data is input
			success:getColumn
		});
	}
	function getColumn(columnData){
        var sname=[];
        var sell=[];
        var buy=[];
        $(columnData.columnInfo).each(function(i,item){
        	sname.push(item.sname);
        	sell.push(item.sell);
        	buy.push(item.buy);
        });
        var data = new google.visualization.DataTable();
        data.addColumn('string','Stock');
        data.addColumn('number', 'Sold');
        data.addColumn('number', 'Bought');
        data.addRows(sname.length);
        for (var i = 0; i < sname.length; i++) {
            data.setValue(i,0,sname[i]);
            data.setValue(i,1,sell[i]);
            data.setValue(i,2, buy[i]);
        }
        var options = {
                chart: {
                  title: 'Stock History',
                }
        };
		var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
		chart.draw(data, options);
	}
	
/******************************Get Transaction History*************************************************************************************************************///
/*****************************************************************************************************************************************************************///	
	function purchaseContent(){
		$(".historyContent").hide();
		$(".liveStocksContent").hide();
		$(".portfolioContent").hide();
		$(".moneyContent").hide();
		$(".purchaseContent").show();
	}
/******************************Get Money Content*************************************************************************************************************///
/*****************************************************************************************************************************************************************///	
	function getMoney(){
		$(".historyContent").hide();
		$(".liveStocksContent").hide();
		$(".portfolioContent").hide();
		$(".purchaseContent").hide();
		$(".moneyContent").show();
	}
	</script>
</head>

<body ng-controller="mainController" ng-app="mainModule">

<section id="container" >
    <!-- **********************************************************************************************************************************************************
    TOP BAR CONTENT & NOTIFICATIONS
    *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
        <div class="sidebar-toggle-box">
            <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
        </div>
        <!--logo start-->
        <a href="" class="logo"><b>Trading System</b></a>
        <!--logo end-->


        </div>
        <div class="top-menu">
            <ul class="nav pull-right top-menu">
                <li><a class="logout" href="<c:url value="j_spring_security_logout" />">Logout</a></li>
            </ul>
        </div>
    </header>
    <!--header end-->

    <!-- **********************************************************************************************************************************************************
    MAIN SIDEBAR MENU
    *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <!-- sidebar menu start-->
            <ul class="sidebar-menu" id="nav-accordion">
                <p class="centered"><a href="user.html"><img src="http://vector.me/files/images/7/4/74456/pittsburgh_pirates.png" width="60"></a></p>
                <h5 class="centered">${trader.getFname()}</h5>
				<li class="mt">
                    <a  href="#" onclick="getPortfolio();" ng-click="stop();stop2()">
                        <i class="glyphicon glyphicon-th"></i>
                        <span>Portfolio</span>
                    </a>
                </li>
                <li class="sub-menu" >
                    <a href="#" onclick="purchaseContent();" ng-click="allStocks();stop()">
                        <i class="glyphicon glyphicon-dashboard"></i>
                        <span>Buy&Sell Stocks</span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="#" onclick="getLiveStocks();" ng-click="start();stop2()">
                        <i class="glyphicon glyphicon-book"></i>
                        <span>Live Stocks</span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="#" onclick="getHistory();" ng-click="stop();stop2()">
                        <i class="glyphicon glyphicon-tasks"></i>
                        <span>Transactions History</span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="#" onclick="getMoney();" ng-click="getMoney();stop();stop2()">
                        <i class="glyphicon glyphicon-signal"></i>
                        <span>My Money</span>
                    </a>
                </li>

            </ul>
            <!-- sidebar menu end-->
        </div>
    </aside>
    <!--sidebar end-->

    <!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content" class="portfolioContent">
        <section class="wrapper">
            <div class="row mt">
                <div class="col-md-6">
                    <div class="content-panel">
                        <table class="table table-striped table-advance table-hover" >
                            <h4><i class="fa fa-angle-right"></i> Stock Value</h4>
                            <div id="chart_div" align="center"></div>
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
                <div class="col-md-6">
                    <div class="content-panel">
                        <table class="table table-striped table-advance table-hover" >
                        	<div id="chart_div"></div>
                            <h4><i class="fa fa-angle-right"></i> Bought&Sold</h4>
                            <div id="columnchart_material"></div>
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
            </div><!-- /row -->
        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    <!--main content end-->
    
    <section id="main-content" class="purchaseContent">
        <section class="wrapper">
        <br>
        <span ng-controller="Ctrl">
        	<div class="form-group col-xs-5 col-lg-1 ">
			<input class="form-control input-normal" type="text" ng-model="purchase" placeholder="Stock"></input>
			</div>
			<div class="form-group col-xs-5 col-lg-1 ">
			<input class="form-control input-normal" type="text" ng-model="qty" placeholder="Qty"></input>
			</div>
			<div class="form-group col-xs-5 col-lg-1 ">
			<input class="form-control input-normal" type="text" ng-model="type" placeholder="Buy/Sell"></input>
			</div>
			<div class="form-group col-xs-5 col-lg-1 ">
			<button ng-click="purchaseStock(purchase, qty, type)" class="btn btn-info">Action</button>
			</div>
		</span>
            <div class="row mt">
                <div class="col-md-12">
                    <div class="content-panel">
                       <table class="table table-striped table-advance table-hover" >
                            <h4><i class="fa fa-angle-right"></i>Buy and Sell</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th>Stock ID</th>
								<th>Price</th>
								<th>Change</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr ng-repeat="s in stock2">
								<td>{{s.sname}}</td>
								<td>{{s.price}}</td>
								<td>
									<b ng-if="s.change>0" style="color:green">{{s.change}}</b>
									<b ng-if="s.change<0" style="color:red">{{s.change}}</b>
									<b ng-if="s.change==0" style="color:black">{{s.change}}</b>
								</td>
							</tr>
                            </tbody> 
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
            </div><!-- /row -->
        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    
    <!-- Transactions Histroy start -->
	<section id="main-content" class="historyContent">
        <section class="wrapper">
            <div class="row mt">
                <div class="col-md-12">
                    <div class="content-panel">
                        <table class="table table-striped table-advance table-hover" id="simpleTable">
                            <h4><i class="fa fa-angle-right"></i>Transactions History</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th data-sort="int">Transaction ID</th>
                                <th data-sort="int">Quantity</th>
                                <th data-sort="string">Status</th>
                                <th data-sort="string">Purchase Date</th>
                                <th data-sort="string">Process</th>
                                <th data-sort="float">Price</th>
                                <th data-sort="string">Stock Name</th>
                            </tr>
                            </thead>
                            <tbody id="history"></tbody> 
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
            </div><!-- /row -->

        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    <!-- Transactions Content end -->
    
    <!-- Get Live Stocks -->
    <section id="main-content" class="liveStocksContent">
        <section class="wrapper">
            <div class="row mt">
                <div class="col-md-12">
                    <div class="content-panel">
                        <table class="table table-striped table-advance table-hover" >
                            <h4><i class="fa fa-angle-right"></i>Live Stocks</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th>Stock ID</th>
								<th>Price</th>
								<th>Change</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr ng-repeat="s in stock">
								<td>{{s.sname}}</td>
								<td>{{s.price}}</td>
								<td>
									<b ng-if="s.change>0" style="color:green">{{s.change}}</b>
									<b ng-if="s.change<0" style="color:red">{{s.change}}</b>
									<b ng-if="s.change==0" style="color:black">{{s.change}}</b>
								</td>
							</tr>
                            </tbody> 
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
            </div><!-- /row -->

        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    
    <!-- Get my account infor such as money -->
    <section id="main-content" class="moneyContent">
        <section class="wrapper">
            <div class="row mt">
                <div class="col-md-6">
                        	<form role="form" id="creditcard" class="well">
						        <div class="form-group">
						            <label for="name">Name on Card</label>
						            <input type="text" name="name" placeholder="Name on card" class="form-control" id="name">
						        </div>
						        <div class="form-group">
						            <label for="cardnumber">Card number</label>
						            <input type="text" name="cardnumber" placeholder="Card Number" class="form-control" id="cardnumber">
						        </div>
						        <div class="row">
						            <div class="col-xs-6 col-sm-6 col-md-6">
						                <label for="expiration">Expiry Date</label>
						                <div class="row">
						                    <div class="col-xs-6 col-sm-6 col-md-6">
						                        <div class="form-group">
						                            <input type="text" name="month" size="2" maxlength="2" placeholder="MM" class="form-control" id="expiration">
						                        </div>
						                    </div>
						                    <div class="col-xs-6 col-sm-6 col-md-6">
						                        <div class="form-group">
						                            <input type="text" name="year" size="4" maxlength="4" placeholder="YYYY" class="form-control" id="year">
						                        </div>
						                    </div>
						                </div>
						            </div>
						            <div class="col-xs-3 col-sm-3 col-md-3">
						                <div class="form-group">
						                    <label for="cvv">CVV</label>
						                    <input type="text" name="cvv" placeholder="CVV" size="4" maxlength="4" class="form-control" id="cvv">
						                </div>
						            </div>
						            <div class="col-xs-3 col-sm-3 col-md-3">
						                <div class="form-group">
						                    <label for="amount">Amount</label>
						                    <input ng-model="amount1" type="text" name="amount" placeholder="Money" size="4" maxlength="4" class="form-control" id="amount">
						                </div>
						            </div>
						        </div>
        						<button ng-click="addMoney(amount1);getMoney()" type="submit" class="btn btn btn-danger btn-block btn-lg">Pay Now</button>
    						</form>
                </div><!-- /col-md-12 -->
                <div class="col-md-6">
                    <h2><b>$ {{amount}}</b></h2>
                </div><!-- /col-md-12 -->
            </div><!-- /row -->

        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    
    
    <!-- Live Stocks End-->
    
    <!--footer start-->
    <footer class="site-footer">
        <div class="text-center">
            2014 - Alvarez.is
            <a href="basic_table.html#" class="go-top">
                <i class="fa fa-angle-up"></i>
            </a>
        </div>
    </footer>
    <!--footer end-->
</section>
</body>
</html>
