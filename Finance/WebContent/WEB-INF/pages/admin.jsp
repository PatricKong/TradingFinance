<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/css/admin.css" />">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
   	
    
    <script>
	$(document).ready(function() {
		$(".stockContent").hide();
		$(".transactionContent").hide();
	});
    angular.module("mainModule", []).controller("mainController", function($scope, $interval, $http) {
		// Initialization
		var promise2;
		$scope.stock2 = [];

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
		$scope.addStock = function(sname) {
			//alert(sname);
			$http({
				method: "POST",
				url: "http://localhost:8080/Finance/rest/finance/addstock?sname=" + sname
			}).error(function(data) {
			});;
	    };
	    $scope.deleteStock = function(sname) {
			//alert("delete stock");
			//alert(sname);
			$http({
				method: "POST",
				url: "http://localhost:8080/Finance/rest/finance/deletestock?sname=" + sname
			}).error(function(data) {
			});;
	    };
		
	});
    //*****************************************************************************************************************************************
    //*****************************************************************************************************************************************
    //*****************************************************************************************************************************************

    function addStock(){
    	$.ajax({
    		url: "http://localhost:8080/Finance/rest/finance/addstock",
    		type: "POST",
    		data: {
    			sname:$("#sname").val()
    		},
    		success: function(){
    			
    		}
    	});
    }
    function commitTransactions(){
    	$.ajax({
    		url: "http://localhost:8080/Finance/committransactions.html",
    		type: "POST"
    	});
    }
	function deleteStock(){
		getSname();
		$.ajax({
			type: "POST",
			url: "http://localhost:8080/Finance/rest/finance/deletestock",
			data:{
    			sname:$("#sname").val()
    		},
		});
	}
	/*
	function getSname(){
		var line = $("button[name='selectedItems']:onClick").val();
		var myname ="ABC";
		$("#sname").val($("tr:nth-child("+line+") td:nth-child(1)").html());
		alert(myname);
		alert(myname);
	}
	*/
	function getStocks(){
		$(".transactionContent").hide();
		$(".stockContent").show();
	}
	
	//Get Transaction from back end
	function getTransactions(){
		$(".stockContent").hide();
		$(".transactionContent").show();
        $.get('transactions.csv', function(data) {
    		var html = '';
    		$("#transactions").empty();
            var rows = data.split("\n");
            //alert(rows.length);
            rows.splice(0,1);
            rows.splice(rows.length - 1,1);
            //alert(1);
            rows.forEach( function getvalues(ourrow) {
            	//alert(2);
                html += "<tr>";
                var columns = ourrow.split(",");
                html += "<td>" + columns[0] + "</td>";
                html += "<td>" + columns[1] + "</td>";
                html += "<td>" + columns[2] + "</td>";
                html += "<td>" + columns[4] + "</td>";
                html += "<td>" + columns[3] + "</td>";
                html += "<td>" + columns[5] + "</td>";
                html += "</tr>";
            });
            $(html).appendTo("#transactions");
        }).error(function(){
        	//alert("save me");
        	$("#transactions").empty();
        });
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
                <p class="centered"><a href="profile.html"><img src="http://cdn.hiconsumption.com/wp-content/uploads/2012/12/The-Evolution-of-the-Batman-Logo-1.jpg" class="img-circle" width="60"></a></p>
                <h5 class="centered">Admin</h5>
				<li class="mt">
                    <a  href="#" onclick="getStocks();" ng-click="allStocks()">
                        <i class="glyphicon glyphicon-th"></i>
                        <span>Stocks</span>
                    </a>
                </li>
                <li class="sub-menu" >
                    <a href="#" onclick="getTransactions();" ng-click="stop2()">
                        <i class="glyphicon glyphicon-dashboard"></i>
                        <span>Transactions</span>
                    </a>
                </li>
                <li class="sub-menu">
                    <a href="#" ng-click="stop2()">
                        <i class="glyphicon glyphicon-book"></i>
                        <span>Extra Pages</span>
                    </a>
                    <ul class="sub">
                        <li><a  href="blank.html">Blank Page</a></li>
                        <li><a  href="login.html">Login</a></li>
                        <li><a  href="lock_screen.html">Lock Screen</a></li>
                    </ul>
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
    <!-- 
    <section id="main-content" class="stockContent">
        <section class="wrapper">
            <input type="text" id="sname"></input>
            <button onclick="addStock();">Add</button>
            <div class="row mt">
                <div class="col-md-12">
                    <div class="content-panel">
                    <form ng-submit="submit()" ng-controller="Ctrl" ng-app="">
                        <table class="table table-striped table-advance table-hover">
                            <h4><i class="fa fa-angle-right"></i> Stocks</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th>Stock Name</th>
                                <th>Price</th>
                                <th>Change</th>
                                <th>Delete</th>
                            </tr>
                            </thead>
                            <tbody id="stocks"></tbody> 
                        </table>
                  	</form>
                    </div>
                </div>
            </div>
        </section>
    </section>
    -->
    <!-- /MAIN CONTENT -->
    <!--main content end-->
     
    <!-- Transactions Content start -->
	<section id="main-content" class="transactionContent">
        <section class="wrapper">
        <br>
            <button onclick="commitTransactions();" type="button" class="btn btn-info">Commit Transactions</button>
            <div class="row mt">
                <div class="col-md-12">
                    <div class="content-panel">
                        <table class="table table-striped table-advance table-hover">
                            <h4><i class="fa fa-angle-right"></i> Transactions</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>Trader ID </th>
                                <th>Quantity</th>
                                <th>Purchase Date</th>
                                <th>Status</th>
                                <th>Price</th>
                            </tr>
                            </thead>
                            <tbody id="transactions"></tbody> 
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
            </div><!-- /row -->

        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    
    <!-- Transactions Content end -->
    <section id="main-content" class="stockContent" ng-app>
        <section class="wrapper">
        <br>
        <button ng-click="addStock(sname)" class="btn btn-info">ADD Stock</button>
		<div class="form-group col-xs-5 col-lg-1 ">
      		<input type="text" ng-model="sname" class="form-control input-normal" />
  		</div>
  		
		
            <div class="row mt">
                <div class="col-md-12">
                    <div class="content-panel">
                       <table class="table table-striped table-advance table-hover" >
                            <h4><i class="fa fa-angle-right"></i>Personal Interest</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th>Stock ID</th>
								<th>Price</th>
								<th>Change</th>
								<th>Delete</th>
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
								<td>
									<button ng-click="deleteStock(s.sname)" class="btn"><span class="glyphicon glyphicon-trash"></span></button>
								</td>
							</tr>
                            </tbody> 
                        </table>
                    </div><!-- /content-panel -->
                </div><!-- /col-md-12 -->
            </div><!-- /row -->
        </section><! --/wrapper -->
    </section><!-- /MAIN CONTENT -->
    
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
