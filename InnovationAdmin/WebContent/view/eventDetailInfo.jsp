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
					<li><a
						href="${pageContext.request.contextPath}/EventMainAction">Event</a></li>
					<li><a
						href="${pageContext.request.contextPath}/UserMainAction">User</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="true">Report
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a
								href="${pageContext.request.contextPath}/DashboardMainAction">Dashboard</a></li>
							<li class='active'><a
								href="${pageContext.request.contextPath}/ReportMainAction">Report</a></li>
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
			<div class='col-sm-11'>
				<h2>Event Detail Information</h2>
			</div>
		</div>
		<div class='row' style="margin-top: 20px">
			<div class='col-sm-12'>
				<form class="form-inline" method='get' action=''>
					
					<input type="hidden" name="reportId" value="2">
					<div class="form-group col-sm-4">
					    <label for="event">Event  :  </label>
					    <select class="form-control" name="eventId" id="event" required style="width: 80%">
					    	<option value="">Please select</option>
							<c:forEach var="event" items="${eventOption}">
								<option value=${event.eveId }>${event.eveName }</option>
							</c:forEach>
						</select>
					  </div>
					<div class="form-group col-sm-2">
							<button type="submit" class="btn btn-primary btn-block">GO</button>
					</div>

				</form>
			</div>
		</div>
		<c:if test="${not empty eventDetail }">
			<div class='panel-body' style="margin-top: 10px">
				<p><b>Event Description : </b>${eventDetail.eveDescription }</p>
				<p><b>Start Date : </b><fmt:formatDate pattern="dd/MM/yyyy HH:mm"
											value="${eventDetail.eveStartDate }" /></p>
				<p><b>End Date : </b><fmt:formatDate pattern="dd/MM/yyyy HH:mm"
											value="${eventDetail.eveEndDate }" /></p>
				<p><b>Status : </b>${eventDetail.eveStatus }</p>
			</div>
			<div class='row' style="margin-top: 20px">
				<div class="col-sm-6">
					<h5>Found ${userSize } customers.</h5>
				</div>
			</div>
		
		<table class="table table-striped table-hover " style="margin-top: 20px">
			<thead>
				<tr>
					<th><div align="center">Title</div></th>
					<th><div align="center">Customer Name</div></th>
					<th><div align="center">Company Name</div></th>
					<th><div align="center">Contact No</div></th>
					<th><div align="center">Email</div></th>
					<th><div align="center">Lucky No</div></th>
					<th><div align="center"><i class="glyphicon glyphicon-gift"></i> Got Prize Flag</div></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty userList}">
					<c:forEach var="user" items="${userList}">
						<tr>
							<td><div align="center">${user.proTitle }</div></td>
							<td><div align="center">${user.proFullName }</div></td>
							<td><div align="center">${user.proCompanyName }</div></td>
							<td><div align="center">${user.proContactNo }</div></td>
							<td><div align="center">${user.proEmail }</div></td>
							<td><div align="center">${user.reeLuckyNo }</div></td>
							<c:choose>
								<c:when test="${user.reeGotPrize == 'Y' }">
									<td><div align="center"><i class="glyphicon glyphicon-ok"></i></div></td>
								</c:when>
								<c:otherwise>
									<td><div align="center"></div></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty userList}">
					<tr>
						<td colspan="7"><div align="center">No items to
								display</div></td>
					</tr>
				</c:if>
			</tbody>
			<c:if test="${endPage > 1}">
				<tfoot>
					<tr>
						<td colspan="9" class="text-right">
							<nav>
								<ul class="pagination">
									<c:if test="${not empty param.page and param.page > 1}">
										<li><a href="?eventId=${param.eventId}&page=${param.page-1}" aria-label="Previous"> <span
												aria-hidden="true">&laquo;</span>
										</a></li>
									</c:if>
									<c:forEach begin="${startPage}" end="${endPage}" var="p">
										<li><a href="?eventId=${param.eventId}&page=${p}">${p}</a></li>
									</c:forEach>
									<c:if test="${param.page < endPage }">
										<li><a href="?eventId=${param.eventId}&page=${param.page+1}" aria-label="Next"> <span
												aria-hidden="true">&raquo;</span>
										</a></li>
									</c:if>
								</ul>
							</nav>
						</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
		</c:if>
	</div>

	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		window.onload = function() {
			document.getElementById('event').value = '${eventDetail.eveId}';
		};
		
	</script>
</body>
</html>