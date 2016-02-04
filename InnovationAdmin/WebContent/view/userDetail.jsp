<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
				<a class="navbar-brand" href="#">Lucky Draw Admin</a>
			</div>

			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="./EventMainAction">Event</a></li>
					<li calss='active'><a href="./UserMainAction">User</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="true">Report
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./DashboardMainAction">Dashboard</a></li>
							<li><a href="./ReportMainAction">Report</a></li>
						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class='hidden-xs hidden-sm'>
						<p class="navbar-text">Hi, ----</p>
					</li>
					<li><a href="/logout">Logout</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	<div class="container">
		<div class='row'>
			<div class='col-sm-9'>
				<h2>User Profile - Detail</h2>
			</div>
		</div>
		<table class="table table-condensed">

						<tr>
							<td width="10%" bgcolor="#D9D8D8">First Name</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="firstName">Test</div>
							</td>
						</tr>
						<tr>
							<td width="10%" bgcolor="#D9D8D8">Last Name</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="lastName">Name</div>
							</td>
						</tr>
						<tr>
							<td width="10%" bgcolor="#D9D8D8">Company</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="company">IBM</div>
							</td>
						</tr>
						<tr>
							<td width="10%" bgcolor="#D9D8D8">Contact Number</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="contaceNo">02/01/2016</div>
							</td>
						</tr>
						<tr>
							<td width="10%" bgcolor="#D9D8D8">Email</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="email">IBM Building</div>
							</td>
						</tr>
						<tr>
							<td width="10%" bgcolor="#D9D8D8">Username</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="username">Active</div>
							</td>
						</tr>
						<tr>
							<td width="10%" bgcolor="#D9D8D8">Role</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="85%">
								<div class="col-md-6" id="role">Customer</div>
							</td>
						</tr>
					</table>
					<div class='row'>
			<div class='col-md-4 text-center'>
			</div>
			<div class='col-md-2 text-center'>
				<button type="button" class="btn btn-primary btn-block">
					<i class="glyphicon glyphicon-pencil"></i> Edit
				</button>
			</div>
			<div class='col-md-2 text-center'>
				<button type="button" class="btn btn-primary btn-block">
					<i class="glyphicon glyphicon-random"></i> Reset Password
				</button>
			</div>
			<div class='col-md-4 text-center'>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>