<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<a class="navbar-brand" href="${pageContext.request.contextPath}/HelloAction">Lucky Draw Admin</a>
			</div>

			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class='active'><a
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
							<li><a
								href="${pageContext.request.contextPath}/ReportMainAction">Report</a></li>
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
			<div class='col-sm-11'>
				<h2>Event Management</h2>
			</div>
			<div class='col-sm-1' style="margin-top: 20px">
				<button type="button" class="btn btn-primary btn-block" id="add" onclick="add()">
					<i class="glyphicon glyphicon-plus"></i> Add
				</button>
			</div>
		</div>
		<div class='row'>
			<div class='col-sm-12'>
				<form class="form-inline" method='get' action='EventMainAction'>
					<input type="text" class="form-control" id="eventname"
						name='keyword' placeholder='Event Name'></input>
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
					<th><div align="center">Gen QR-Code</div></th>
					<th><div align="center">Lucky Draw</div></th>
					<th><div align="center">Delete</div></th>
					<th><div align="center">Archive</div></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty evnList}">
					<c:forEach var="event" items="${evnList}" varStatus="status">
						<tr>
							<td><div align="center">${status.index + 1}</div></td>
							<td><div align="left"><a href="${pageContext.request.contextPath}/EventDetailAction?eventId=${event.eveId }">${event.eveName }</a></div></td>
							<td><div align="center">
									<fmt:formatDate pattern="dd/MM/yyyy"
										value="${event.eveStartDate }" />
								</div></td>
							<td><div align="center">
									<fmt:formatDate pattern="dd/MM/yyyy"
										value="${event.eveEndDate }" />
								</div></td>
							<td class="text-capitalize"><div align="center">${event.eveStatus }</div></td>
							<td align="center"><button type="button" name="Gen-QR-Code"
									id="genQR" class="btn btn-default btn-sm"
									aria-label="Left Align"onclick="genQR(${event.eveId })">
									<span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span>
								</button></td>
							<td align="center"><button type="button"
									name="Gen-Lucky-Draw" class="btn btn-default btn-sm"
									aria-label="Left Align" data-event-id="${event.eveId }" data-toggle="modal" data-target="#luckyDrawModal">
									<span class="glyphicon glyphicon-gift" aria-hidden="true"></span>
								</button></td>
							<td align="center"><button type="button" name="Delete" 
									class="btn btn-default btn-sm" aria-label="Left Align" onclick="del(${event.eveId })">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								</button></td>
							<td align="center"><button type="button" name="archive" 
									class="btn btn-default btn-sm" aria-label="Left Align" onclick="archive(${event.eveId })">
									<span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
								</button></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty evnList}">
					<tr>
						<td colspan="9"><div align="center">No items to
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
										<li><a href="?keyword=${param.keyword}&page=${param.page-1}" aria-label="Previous"> <span
												aria-hidden="true">&laquo;</span>
										</a></li>
									</c:if>
									<c:forEach begin="${startPage}" end="${endPage}" var="p">
										<li><a href="?keyword=${param.keyword}&page=${p}">${p}</a></li>
									</c:forEach>
									<c:if test="${param.page < endPage }">
										<li><a href="?keyword=${param.keyword}&page=${param.page+1}" aria-label="Next"> <span
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

	
	<form action="" method="post" id="frm">
		<input type="hidden" name="actionType" id="actionType" value="">
		<input type="hidden" name="eventId" id="eventId" value="">
	</form>
	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		window.onload = function() {
			var msg = "${msg}";
			if(msg){
				alert(msg);
			}
		};
	
		function genQR(evnid){
						
			var imgWindow = window.open('', 'QR Code', 'height=400,width=400');
			imgWindow.document.write('<html><head><title>QR Code</title></head><body></body></html>');

			var img = imgWindow.document.createElement('img');
			img.src = 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=innovationadmin.eu-gb.mybluemix.net/EventDetailAction?eventid=' + evnid;
			imgWindow.document.body.appendChild(img);
			imgWindow.document.close();
		}
		
		function del(evnid){
			var frm = document.getElementById('frm');
			document.getElementById('eventId').value = evnid;
			document.getElementById('actionType').value='delete';
			if(confirm("Are you sure you want to delete this event?")){
				frm.submit();
			}
		}
		
		function add(){
			var frm = document.getElementById('frm');
			document.getElementById('actionType').value='redirectAdd';
			frm.submit();
		}
		
		function archive(evnid){
			var frm = document.getElementById('frm');
			document.getElementById('eventId').value = evnid;
			document.getElementById('actionType').value='archive';
			if(confirm("Are you sure you want to archive this event?")){
				frm.submit();
			}
		}
		
	</script>
		<!-- Add gen LuckyDraw modal -->
	<%@include file="/view/genLuckyNo.jsp"%>
</body>
</html>