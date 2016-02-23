<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>Event</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
	.modal .modal-dialog { width: 80%; }
</style>
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
				<a class="navbar-brand" href="${pageContext.request.contextPath}/HelloAction">Lucky Draw Admin</a>
			</div>

			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class='active'><a href="${pageContext.request.contextPath}/EventMainAction">Event</a></li>
					<li><a href="${pageContext.request.contextPath}/UserMainAction">User</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="true">Report
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${pageContext.request.contextPath}/DashboardMainAction">Dashboard</a></li>
							<li><a href="${pageContext.request.contextPath}/ReportMainAction">Report</a></li>
						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class='hidden-xs hidden-sm'>
						<p class="navbar-text">Hi, ${name }</p>
					</li>
					<li><a href="/Login?logout">Logout</a></li>
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
							<td width="15%" bgcolor="#D9D8D8">Event Name</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="80%">
								<div class="col-md-8" id="eventName">${event.eveName }</div>
							</td>
						</tr>
						<tr>
							<td width="15%" bgcolor="#D9D8D8">Description</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="80%">
								<div class="col-md-8" id="description">${event.eveDescription }</div>
							</td>
						</tr>
						<tr>
							<td width="15%" bgcolor="#D9D8D8">Start Date</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="80%">
								<div class="col-md-8" id="startDate">
									<fmt:formatDate pattern="dd/MM/yyyy HH:mm"
										value="${event.eveStartDate }" />
								</div>
							</td>
						</tr>
						<tr>
							<td width="15%" bgcolor="#D9D8D8">End Date</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="80%">
								<div class="col-md-8" id="endDate">
									<fmt:formatDate pattern="dd/MM/yyyy HH:mm"
										value="${event.eveEndDate }" />
								</div>
							</td>
						</tr>
						<tr>
							<td width="15%" bgcolor="#D9D8D8">Location</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td width="80%">
								<div class="col-md-8" id="location">${event.eveLocation }</div>
							</td>
						</tr>
						<tr>
							<td width="15%" bgcolor="#D9D8D8">Status</td>
							<td width="5%" bgcolor="#D9D8D8">:</td>
							<td class="text-capitalize" width="80%">
								<div class="col-md-8" id="status">${event.eveStatus }</div>
							</td>
						</tr>
					</table>
					<div class='row'>
						<c:if test="${event.eveStatus == 'active' }">
							<div class='col-md-3 text-center'></div>
							<div class='col-md-2 text-center'>
								<button type="button" class="btn btn-primary btn-block" onclick="edit(${event.eveId})">
									<i class="glyphicon glyphicon-pencil"></i> Edit
								</button>
							</div>
							<div class='col-md-2 text-center'>
								<button type="button" class="btn btn-primary btn-block" id="genQR" data-link="${event.eveId }">
									<i class="glyphicon glyphicon-qrcode"></i> Gen QR Code
								</button>
	
							</div>
							<div class='col-md-2 text-center'>
								<button type="button" class="btn btn-primary btn-block"  data-event-id="${event.eveId }" data-toggle="modal" data-target="#luckyDrawModal">
									<i class="glyphicon glyphicon-gift"></i> Gen Lucky Draw
								</button>
							</div>
							<div class='col-md-3 text-center'></div>
						</c:if>
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
								<th><div align="left">Status</div></th>
							</tr>
						</thead>
						<tbody>

							<c:if test="${not empty luckyDraw}">
								<c:forEach var="luc" items="${luckyDraw}" varStatus="status">
									<tr>
										<td><div align="center">${status.index + 1}</div></td>
										<th width="20%"><div align="center">${luc.lucLuckyNo }</div></th>
										<td><div align="left">${luc.proFullName }</div></td>
										<td><div align="left">${luc.lucStatus }</div></td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty luckyDraw}">
								<tr>
									<td colspan="5"><div align="center">No items to
											display</div></td>
								</tr>
							</c:if>

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
								<th><div align="center">Title</div></th>
								<th><div align="center">Customer Name</div></th>
								<th><div align="center">Company Name</div></th>
								<th><div align="center">Email</div></th>
								<th><div align="center">Contact Number</div></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty userList}">
								<c:forEach var="user" items="${userList}" varStatus="status">
									<tr>
										<td><div align="center">${status.index + 1}</div></td>
										<td><div align="left">${user.proTitle }</div></td>
										<td><div align="left">${user.proFullName }</div></td>
										<td><div align="center">${user.proCompanyName }</div></td>
										<td><div align="center">${user.proEmail }</div></td>
										<td><div align="center">${user.proContactNo }</div></td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty userList}">
								<tr>
									<td colspan="5"><div align="center">No items to
											display</div></td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<!-- End tab Register Customer -->
		</div>
	</div>
	<form action="" method="post" id="frm">
		<input type="hidden" name="actionType" id="actionType" value="">
		<input type="hidden" name="eventId" id="eventId" value="">
	</form>
	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			activateTab('Event-Information');
		};
	
		function activateTab(tab) {
			$('.nav-tabs a[href="#' + tab + '"]').tab('show');
		};
	
		$('#genQR').click(function() {
			
			var link = $(this).data('link');
			var imgWindow = window.open('', 'QR Code', 'height=400,width=400');
			imgWindow.document.write('<html><head><title>QR Code</title></head><body></body></html>');
	
			var img = imgWindow.document.createElement('img');
			img.src = 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=innovationadmin.eu-gb.mybluemix.net/EventDetailAction?eventid=' + link;
			imgWindow.document.body.appendChild(img);
			imgWindow.document.close();
		});
		
		function edit(evnid){
			console.log(evnid);
			var frm = document.getElementById('frm');
			document.getElementById('eventId').value = evnid;
			document.getElementById('actionType').value='redirectEdit';
			frm.submit();
		}
	</script>
			<!-- Add gen LuckyDraw modal -->
	<%@include file="/view/genLuckyNo.jsp"%>
</body>
</html>