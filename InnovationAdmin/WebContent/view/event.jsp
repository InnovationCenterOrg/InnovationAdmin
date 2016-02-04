<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">

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
			<div class='col-sm-9'>
				<h2>Event Management</h2>
			</div>
		</div>
		<div class='row'>
			<div class='col-sm-12'>
				<form class="form-inline" method='get' action='EventMainAction'>
					<input type="text" class="form-control" id="eventname"
						name='eventName' placeholder='Event Name'></input>
					<button type="submit" class='btn btn-primary'>Search</button>
				</form>
			</div>
		</div>
		<table class="table table-striped table-hover ">
			<thead>
				<tr>
					<th><div align="center">#</div></th>
					<th><div align="center">Event Name</div></th>
					<th><div align="center">Start Date</div></th>
					<th><div align="center">End Date</div></th>
					<th><div align="center">Status</div></th>
					<th></th>
					<th><div align="center">Gen QR-Code</div></th>
					<th><div align="center">Lucky Draw</div></th>
					<th><div align="center">Delete</div></th>
					<th><div align="center">Archive</div></th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${not empty evnList}">
				<c:forEach var="evn" items="${evnList}" varStatus="status">
					<tr>
						<td><div align="center">${status.index + 1}</div></td>
						<td><div align="center">${evn.eveName }</div></td>
						<td><div align="center">${evn.eveStartDate }</div></td>
						<td><div align="center">${evn.eveEndDate }</div></td>
						<td><div align="center">${evn.eveStatus }</div></td>
						<td><div align="center">
								<a
									href="${pageContext.request.contextPath}/view/eventDetail.jsp?eventid=${evn.eveId }">View
									Detail</a>
							</div></td>
						<td align="center"><button type="button" name="Gen-QR-Code"
								class="btn btn-default btn-sm" aria-label="Left Align">
								<span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span>
							</button></td>
						<td align="center"><button type="button"
								name="Gen-Lucky-Draw" class="btn btn-default btn-sm"
								aria-label="Left Align">
								<span class="glyphicon glyphicon-gift" aria-hidden="true"></span>
							</button></td>
						<td align="center"><button type="button" name="Delete"
								class="btn btn-default btn-sm" aria-label="Left Align">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
							</button></td>
						<td align="center"><span class="glyphicon glyphicon-ok"
							aria-hidden="true"></span></td>
					</tr>
				</c:forEach></c:if>
				<c:if test="${empty evnList}">
					<tr><td colspan="10"><div align="center">No items to display</div></td></tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>