<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/HelloAction">Lucky
					Draw Admin</a>
			</div>

			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="./EventMainAction">Event</a></li>
					<li><a href="./UserMainAction">User</a></li>
					<li class='active' class="dropdown"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-expanded="true">Report <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./DashboardMainAction">Dashboard</a></li>
							<li><a href="./ReportMainAction">Report</a></li>
						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class='hidden-xs hidden-sm'>
						<p class="navbar-text">Hi, ${name }</p>
					</li>
					<li><a href="${pageContext.request.contextPath}/LogoutAction">Logout</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	<div class="container">

		<div class='row'>
			<div class='col-sm-8'>
				<h2>Report</h2>
			</div>
		</div>
		<div class='row' style="margin-top: 20px">
			<div class='col-sm-3'></div>
			<div class='col-sm-6'>
				<button type="button" class="btn btn-primary btn-block" id="save" onclick="goReport(1)">
					<i class="glyphicon glyphicon-list-alt"></i> Event Summary Information
				</button>
			</div>
			<div class='col-sm-3'></div>
		</div>
		<div class='row' style="margin-top: 20px">
			<div class='col-sm-3'></div>
			<div class='col-sm-6'>
				<button type="button" class="btn btn-primary btn-block" id="save" onclick="goReport(2)">
					<i class="glyphicon glyphicon-user"></i> Event Detail Information
				</button>
			</div>
			<div class='col-sm-3'></div>
		</div>
		<div class='row' style="margin-top: 20px">
			<div class='col-sm-3'></div>
			<div class='col-sm-6'>
				<button type="button" class="btn btn-primary btn-block" id="save" onclick="goReport(3)">
					<i class="glyphicon glyphicon-signal"></i> Event Wifi Connected User
				</button>
			</div>
			<div class='col-sm-3'></div>
		</div>
		
		
	</div>
	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function goReport(i){
			window.location = "${pageContext.request.contextPath}/ReportMainAction?reportId="+i;
		}
	</script>
</body>
</html>