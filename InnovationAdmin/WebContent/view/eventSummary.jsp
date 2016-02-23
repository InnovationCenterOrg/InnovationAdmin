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
					<li><a href="/Login?logout">Logout</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	<div class="container">
		<div class='row'>
			<div class='col-sm-11'>
				<h2>Summary Event Information</h2>
			</div>
		</div>
		<div class='row' style="margin-top: 20px">
			<div class='col-sm-12'>
				<form class="form-inline" method='get' action=''>
					
					<input type="hidden" name="reportId" value="1">
					<div class="form-group col-sm-2">
					    <label for="year">Year  :  </label>
					    <select class="form-control" name="year" id="year" style="width: 70%">
							</select>
					  </div>
					<div class="form-group col-sm-3">
					    <label for="month">Month  :  </label>
					    <select class="form-control" name="month" id="month" style="width: 70%">
								<option value="1">January</option>
								<option value="2">February</option>
								<option value="3">March</option>
								<option value="4">April</option>
								<option value="5">May</option>
								<option value="6">June</option>
								<option value="7">July</option>
								<option value="8">August</option>
								<option value="9">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
							</select>
					  </div>
					<div class="form-group col-sm-2">
							<button type="submit" class="btn btn-primary btn-block">GO</button>
					</div>

				</form>
			</div>
		</div>
		<div class='row' style="margin-top: 20px">
			<div class="col-sm-6">
				<h5>Found ${eventSize } events.</h5>
			</div>
		</div>
		<table class="table table-striped table-hover " style="margin-top: 20px">
			<thead>
				<tr>
					<th><div align="center">Event Name</div></th>
					<th width="20%"><div align="center">Event Description</div></th>
					<th><div align="center">Event Location</div></th>
					<th><div align="center">Event Start Date</div></th>
					<th><div align="center">Event End Date</div></th>
					<th><div align="center">Event Status</div></th>
					<th><div align="center">Event Register User</div></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty eventList}">
					<c:forEach var="event" items="${eventList}" varStatus="status">
						<tr>
							<td><div align="center">${event.eveName }</div></td>
							<td><div align="center">${event.eveDescription }</div></td>
							<td><div align="center">${event.eveLocation }</div></td>
							<td><div align="center">
									<fmt:formatDate pattern="dd/MM/yyyy HH:mm"
										value="${event.eveStartDate }" />
								</div></td>
							<td><div align="center">
									<fmt:formatDate pattern="dd/MM/yyyy HH:mm"
										value="${event.eveEndDate }" />
								</div></td>
							<td class="text-capitalize"><div align="center">${event.eveStatus }</div></td>	
							<td><div align="center">${event.eveRegisterUser }</div></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty eventList}">
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
										<li><a href="?month=${param.month}&year=${param.year}&page=${param.page-1}" aria-label="Previous"> <span
												aria-hidden="true">&laquo;</span>
										</a></li>
									</c:if>
									<c:forEach begin="${startPage}" end="${endPage}" var="p">
										<li><a href="?month=${param.month}&year=${param.year}&page=${p}">${p}</a></li>
									</c:forEach>
									<c:if test="${param.page < endPage }">
										<li><a href="?month=${param.month}&year=${param.year}&page=${param.page+1}" aria-label="Next"> <span
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
	</div>

	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		window.onload = function() {
			var selectYear = document.getElementById("year");
		    var startYear = new Date().getFullYear();
		    for(i=0;i<5;i++){
		    	var option = document.createElement("option");
		    	option.value = startYear;
			    option.text = startYear;
			    selectYear.add(option);
			    startYear--;
		    }
		    console.log('${year}');
		    document.getElementById('month').value = '${month}';
		    document.getElementById('year').value = '${year}';
		};
		
	</script>
</body>
</html>