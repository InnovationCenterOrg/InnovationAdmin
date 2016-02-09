<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<li class='active'><a href="./UserMainAction">User</a></li>
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
			<div class='col-sm-11'>
				<h2>User Profile</h2>
			</div>
			<div class='col-sm-1' style="margin-top: 20px">
				<button type="button" class="btn btn-primary btn-block" onclick="add()">
					<i class="glyphicon glyphicon-plus"></i> Add
				</button>
			</div>
		</div>
		<div class='row'>
			<div class='col-sm-12'>
				<form class="form-inline" method='get' action='./UserMainAction'>
					<input type="text" class="form-control" id="keyword"
						name='keyword' placeholder='Search'></input>
					<button type="submit" class='btn btn-primary'>Search</button>
				</form>
			</div>
		</div>
		<table class="table table-striped table-hover ">
			<thead>
				<tr>
					<th><div align="center">#</div></th>
					<th><div align="center">Title</div></th>
					<th><div align="center">Name</div></th>
					<th><div align="center">Company</div></th>
					<th><div align="center">Username</div></th>
					<th><div align="center">Reset Password</div></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty userList}">
					<c:forEach var="user" items="${userList}" varStatus="status">
						<tr>
							<td><div align="center">${status.index + 1}</div></td>
							<td><div align="center">${user.proTitle }</div></td>
							<td><div align="left">
									<a href="${pageContext.request.contextPath}/UserDetailAction?proId=${user.proId}">${user.proFullName }</a>
								</div></td>
							<td><div align="center">${user.proCompanyName }</div></td>
							<td><div align="center">${user.proUsername }</div></td>
							<td align="center"><button type="button" name="resetpwd" onclick="resetpwd(${user.proId})"
									class="btn btn-default btn-sm" aria-label="Left Align">
									<span class="glyphicon glyphicon-random" aria-hidden="true"></span>
								</button></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty userList}">
					<tr>
						<td colspan="6"><div align="center">No items to
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
	
	<form action="" method="Post" id="frm">
		<input type="hidden" name="actionType" id="actionType" value="">
		<input type="hidden" name="proId" id="proId" value=""> 
	</form>
	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
		window.onload = function() {
			var msg = "${msg}";
			console.log(msg);
			if(msg){
				alert('Reset password complete. Default password is '+msg+'.');
			}
		};
		
		function resetpwd(proId){
			var frm = document.getElementById('frm');
			document.getElementById('proId').value = proId;
			document.getElementById('actionType').value='resetpwd';
			if(confirm('Are you sure want to reset password.')){
				frm.submit();
			}
		}
		
		function add(){
			var frm = document.getElementById('frm');
			document.getElementById('actionType').value='redirectAdd';
			frm.submit();
		}
	</script>
</body>
</html>