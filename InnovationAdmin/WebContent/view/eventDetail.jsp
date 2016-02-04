<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	window.onload = function() {
		console.log('Activate');
		activateTab('Event-Information');
	};

	function activateTab(tab) {
		$('.nav-tabs a[href="#' + tab + '"]').tab('show');
	};
</script>

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
					<li class='active'><a href="./EventMainAction">Event</a></li>
					<li><a href="./UserMainAction">User</a></li>
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
			<div class='col-sm-6'>
				<h2>Event Detail</h2>
			</div>
		</div>
		<ul class="nav nav-tabs">
			<li><a href="#Event-Information" data-toggle="tab">Event
					Information</a></li>
			<li><a href="#Register-Customers" data-toggle="tab">Register
					Customers</a></li>
		</ul>
		<div class="tab-content" id="tabs">
			<!-- Start tab Event Information -->
			<div class="tab-pane fade" id="Event-Information">
				<div class="panel-body">
					<table class="table table-condensed">

						<tr>
							<td width="25%" bgcolor="#D9D8D8">Event Name</td>
							<td width="75%">
								<div class="col-md-6" id="eventName">Test Event</div>
							</td>
						</tr>
						<tr>
							<td width="25%" bgcolor="#D9D8D8">Description</td>
							<td width="75%">
								<div class="col-md-6" id="description">Test</div>
							</td>
						</tr>
						<tr>
							<td width="25%" bgcolor="#D9D8D8">Start Date</td>
							<td width="75%">
								<div class="col-md-6" id="startDate">01/01/2016</div>
							</td>
						</tr>
						<tr>
							<td width="25%" bgcolor="#D9D8D8">End Date</td>
							<td width="75%">
								<div class="col-md-6" id="endDate">02/01/2016</div>
							</td>
						</tr>
						<tr>
							<td width="25%" bgcolor="#D9D8D8">Location</td>
							<td width="75%">
								<div class="col-md-6" id="location">IBM Building</div>
							</td>
						</tr>
						<tr>
							<td width="25%" bgcolor="#D9D8D8">Status</td>
							<td width="75%">
								<div class="col-md-6" id="status">Active</div>
							</td>
						</tr>
					</table>
	<div class='row'>
			<div class='col-md-3 text-center'>
			</div>
			<div class='col-md-2 text-center'>
				<button type="button" class="btn btn-primary btn-block">
					<i class="glyphicon glyphicon-pencil"></i> Edit
				</button>
			</div>
			<div class='col-md-2 text-center'>
				<button type="button" class="btn btn-primary btn-block">
					<i class="glyphicon glyphicon-qrcode"></i> Gen QR Code
				</button>

			</div>
			<div class='col-md-2 text-center'>
				<button type="button" class="btn btn-primary btn-block">
					<i class="glyphicon glyphicon-gift"></i> Gen Lucky Draw
				</button>
			</div>
			<div class='col-md-3 text-center'>
			</div>
		</div>
					<div class='col-sm-9'>
						<h3>Lucky Draw</h3>
					</div>
					<table class="table table-striped table-hover ">
						<thead>
							<tr>
								<th width="10%"><div align="center">#</div></th>
								<th width="20%"><div align="center">Lucky Number</div></th>
								<th><div align="left">Customer Name</div></th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<td><div align="center">1</div></td>
								<th width="20%"><div align="center">555</div></th>
								<td><div align="left">Test Name</div></td>
							</tr>

						</tbody>
					</table>

				</div>
			</div>
			<!-- End tab Event Information -->
			<!-- Start tab Register Customers -->
			<div class="tab-pane fade" id="Register-Customers">
				<div class="panel-body">
					<table class="table table-striped table-hover ">
						<thead>
							<tr>
								<th width="10%"><div align="center">#</div></th>
								<th><div align="left">Customer Name</div></th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<td><div align="center">1</div></td>
								<td><div align="left">Test Name</div></td>
							</tr>

						</tbody>
					</table>
				</div>
			</div>
			<!-- End tab Register Customer -->
		</div>
	</div>

	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>