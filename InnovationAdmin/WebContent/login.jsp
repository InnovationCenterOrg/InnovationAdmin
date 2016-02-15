<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="includes/meta.jsp"%>
<title>InnvationAdmin</title>
<!-- Bootstrap -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  -->

</head>

<body>
	<div class="container">
  <div class="container" style="float:left;width: 35%">
  	<div align="center" style="margin-top:60%">
      <img class="img-responsive" src="${pageContext.request.contextPath}/images/ibm_logo.png">
  <h2 align="center">Innovation Center</h2>
  </div>
  </div>
  <div class="container" style="float: right;width: 35%;margin-top:20%;margin-left: 30%">
		<form class="form-signin" action="Login" method="post">
			
			<div class="form-group">
				<label>Username</label> <input type="text" placeholder="Username" id="username" name="username" class="form-control">
			</div>
			<div class="form-group">
				<label>Password</label> <input type="password" placeholder="Password" id="password" name="password" class="form-control">
					<a style="margin-left:70%" href="#">Forgot password</a>
			</div>
			<div style="margin-top: 40px;" class="form-group">
				<button type="submit" class="btn btn-primary btn-block">
					<i class="glyphicon glyphicon-log-in"></i> Log in
				</button>
			</div>
			
		</form>
  </div>
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="/js/bootstrap.min.js"></script>

	</div>
	<script type="text/javascript">
		window.onload = function() {
			var msg = "${error}";
			if(msg){
				alert(msg);
			}
		};
	</script>
	
</body>
</html>