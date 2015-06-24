<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
    
</head>
<style type="text/css">
    body{
        background-image: -ms-linear-gradient(top, #FFFFFF 0%, #D3D8E8 100%);
        /* Mozilla Firefox */
        background-image: -moz-linear-gradient(top, #FFFFFF 0%, #D3D8E8 100%);
        /* Opera */
        background-image: -o-linear-gradient(top, #FFFFFF 0%, #D3D8E8 100%);
        /* Webkit (Safari/Chrome 10) */
        background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #FFFFFF), color-stop(1, #D3D8E8));
        /* Webkit (Chrome 11+) */
        background-image: -webkit-linear-gradient(top, #FFFFFF 0%, #D3D8E8 100%);
        /* W3C Markup, IE10 Release Preview */
        background-image: linear-gradient(to bottom, #FFFFFF 0%, #D3D8E8 100%);
        background-repeat: no-repeat;
        background-attachment: fixed;
    }

    .navbar-default{
        background-color:#ffd777;
        border-bottom:none;
    }
    .navbar-form label{
        color:#fff;
        font-size:13px;
        font-weight:normal;
    }
    .navbar-form  .input-sm{
        border-radius:0;
        width: 250px;
    }
    legend a{
        color:black;
        font-size:40px;
        font-weight:bold;
    }
    .login-btn {
        -webkit-border-radius: 0;
        -moz-border-radius: 0;
        border-radius: 4px;
        cursor:pointer;
        text-shadow: 1px 1px 4px #8a8a8a;
        font-family: Arial;
        color: #f2f2f2;
        font-size: 13px;
        background: #68dff0;
        line-height:21px;
        font-weight:bold;
        padding: 3px 6px 3px 6px;
        border: 1px solid #64c3c2 !important;
        text-decoration: none;
    }

    .login-btn:hover {
        background: #ffd777;
        text-decoration: none;
    }
    .signup-btn {
        background: #68dff0;
		text-shadow: 1px 1px 4px #8a8a8a;
        font-family: Arial;
        line-height:21px;
        font-weight:bold;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
        -webkit-box-shadow: 0px 0px 0px #a4e388;
        -moz-box-shadow: 0px 0px 0px #a4e388;
        box-shadow: 0px 0px 0px #a4e388;
        color: #ffffff;
        font-size: 20px;
        padding: 10px 20px 10px 20px;
        border: solid #3b6e22  1px;
        text-decoration: none;
    }

    .signup-btn:hover {
        background: #ffd777;
        text-decoration: none;
    }
    .navbar-default .navbar-brand{
        color:#fff;
        font-size:30px;
        font-weight:bold;
    }
    .navbar-default .navbar-brand:hover{
        color:#fff;
        font-size:30px;
        font-weight:bold;
    }
    .form .form-control { margin-bottom: 10px; }
    @media (min-width:768px) {
        #wrap{
            margin-bottom:0px;
        }
        .navbar-form .lt-left{
            float:left !important;
        }
        .navbar-form .lt-right{
            float:right !important;
        }
        .navbar-form .checkbox{
            display:block;
        }
        .navbar-form input[type="password"]{
            margin-left:3px;
            width:200px;
        }
        .navbar-form input[type="text"]{
            width:200px;
        }
        .navbar-form .login-btn{
            margin-left: 10px;
        }
        #home{
            margin-top:30px;
        }
        #home .slogan{
            color: #0e385f;
            line-height: 29px;
            font-weight:bold;
        }

        .navbar-brand{
            padding:35px 15px;
        }
    }
    span.glyphicon {
        font-size: 3.5em;
        margin-left: 0px;
    }
    
    #infor{
        margin-top: -35px;
        margin-left: 70px;
    }
    #changFont{
        color:#141823;
        font-size:30px;
        font-weight:bold;
    }
    #glyphiconId{
        margin-bottom: 40px;
    }
    #rightside{
    	margin-right: 70px;
    }
</style>
<script>
    function validateCtrl($scope) {
    	$scope.password = "";
        $scope.username = "";
        $scope.email = "";
        $scope.firstname = "";
        $scope.lastname = "";
    }
    $('document').ready(function(){
    	if("<c:out value='${param.login_error}'/>"==1)
    		$("#loginError").show();
    	
    	if("<c:out value='${param.emailsend}'/>"=="yes")
    		$("#emailAlert").show();
    });
</script>

<body>
<div id="wrap">
    <div class="navbar navbar-default navbar-inverse">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="http://wsnippets.com">Trading Sys</a>
            </div>
            <div class="collapse navbar-collapse">
                <form class="navbar-form navbar-right" id="header-form" role="form" action=<c:url value='/Finance/j_spring_security_check' /> method="post">
                    <div class="lt-left">
                        <div class="form-group">
                            <input type="text" class="form-control input-sm" name="j_username" placeholder="Username">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control input-sm" name="j_password" placeholder="Password">
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" id="j_remember" name="_spring_security_remember_me"> Remember me
                            </label>
                        </div>
                        <span class="alert" style="display:none;" id="loginError">
							<span style="color:red;font-weight:bold;margin-left:-20px;">*invalid username and password</span>
						</span>
						<span class="alert" style="display:none;" id="emailAlert">
							<span style="color:red;font-weight:bold;margin-left:-20px;">*please verify your email to log in</span>
						</span>
                    </div>
                    <div class="lt-right">
                        <button type="submit" class="login-btn" >Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="container" id="home">
        <div class="row">
            <div id="rightside" class="col-md-6">
                <form role="form">
                    <br><br>
                    <div id="glyphiconId" class="form-group">
                        <p id="changFont">
                            Extend your trading potential with
                            Yahoo Finance Trading System.
                        </p>
                    </div>
                    <div id="glyphiconId" class="form-group">
                        <span class="glyphicon glyphicon-calendar"></span><h4 id="infor">Easy to start investing!(Minimum deposit just $10)</h4>
                    </div>
                    <div id="glyphiconId" class="form-group">
                        <span class="glyphicon glyphicon-ok"></span><h4 id="infor">Perfect your trading strategy on a totally free Demo account</h4>
                    </div>
                    <div id="glyphiconId" class="form-group">
                        <span class="glyphicon glyphicon-eye-open"></span><h4 id="infor">24/7trading on turbo and binary options</h4>
                    </div>
                </form>
            </div>
            <div class="col-md-4">
                <form action="/Finance/rest/register/register" method="post" class="form" role="form" ng-app="" ng-controller="validateCtrl" name="myForm" novalidate>
                    <legend><a>Sign Up</a></legend>
                    <h4>It's free and always will be.</h4>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                        	<span style="color:red" ng-show="myForm.firstname.$dirty && myForm.firstname.$invalid">
								<span style="font-weight:bold" ng-show="myForm.firstname.$error.required">firstName is required.</span>
							</span>
                            <input ng-model="firstname" required class="form-control input-lg" name="firstname" placeholder="First Name" type="text" autofocus />	
                        </div>
                        <div class="col-xs-6 col-md-6">
                        	<span style="color:red" ng-show="myForm.lastname.$dirty && myForm.lastname.$invalid">
								<span style="font-weight:bold" ng-show="myForm.lastname.$error.required">lastName is required.</span>
							</span>
                            <input ng-model="lastname" required class="form-control input-lg" name="lastname" placeholder="Last Name" type="text" />
                        </div>
                    </div>
                    <span style="color:red" ng-show="myForm.email.$dirty && myForm.email.$invalid">
						<span style="font-weight:bold" ng-show="myForm.email.$error.required">email is required.</span>
						<span style="font-weight:bold" ng-show="myForm.email.$error.email">invalid email address.</span>
					</span>
                    <input ng-model="email" required class="form-control input-lg" name="email" placeholder="Your Email" type="email" />
                    <span style="color:red" ng-show="myForm.username.$dirty && myForm.username.$invalid">
						<span style="font-weight:bold" ng-show="myForm.username.$error.required">username is required.</span>
					</span>
                    <input ng-model="username" required class="form-control input-lg" name="username" placeholder="Username" type="text" />
                    <span style="color:red" ng-show="myForm.password.$dirty && myForm.password.$invalid">
						<span style="font-weight:bold" ng-show="myForm.password.$error.required">password is required.</span>
					</span>
                    <input ng-model="password" required class="form-control input-lg" name="password" placeholder="New Password" type="password" />
                    <label class="radio-inline">
                        <input type="radio" name="sex" id="inlineCheckbox1" value="male" />
                        Male
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="sex" id="inlineCheckbox2" value="female" />
                        Female
                    </label>
                    <br />
                    <span class="help-block">By clicking Create my account, you agree to our Terms and that you have never read our Data Use Policy, including our Cookie Use.</span>
                    <button class="btn btn-lg btn-primary btn-block signup-btn" type="submit" ng-disabled="myForm.username.$dirty && myForm.username.$invalid || myForm.email.$dirty && myForm.email.$invalid
                    	|| myForm.firstname.$dirty && myForm.firstname.$invalid|| myForm.lastname.$dirty && myForm.lastname.$invalid|| myForm.password.$dirty && myForm.passord.$invalid">
                        Create my account</button>
                </form>
            </div>
            <div class="col-md-1"></div>
        </div>
    </div>
</div>
</body>
</html>
