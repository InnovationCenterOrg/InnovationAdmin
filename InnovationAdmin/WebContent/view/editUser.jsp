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
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/HelloAction">Lucky
					Draw Admin</a>
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
							<li><a href="${pageContext.request.contextPath}/DashboardMainAction">Dashboard</a></li>
							<li><a href="${pageContext.request.contextPath}/ReportMainAction">Report</a></li>
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
		<form class="form-horizontal" id="frm" action="" method="post">

			<div class="panel panel-default">
				<div class="panel-heading clearfix">
					<div class="col-md-4" >
						<h4 id="title"></h4>
					</div>
					<div class="col-md-4"></div>
				</div>

				<div class="panel-body">

					<div class="panel panel-default">
						<div class="panel-heading clearfix">
							<h5 class="panel-title pull-left" style="padding-top: 7.5px;">User
								Information</h5>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-md-2 control-label">Title</label>
								<div class="col-md-4">
									<select class="form-control" id="titleName" name="title">
										<option selected="selected" value="MR">MR</option>
										<option value="MS">MS</option>
										<option value="MRS">MRS</option>
										<option value="ETC">ETC</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">First Name</label>
								<div class="col-md-4">
									<input class="form-control" name="firstName" type="text"
										id="firstName" value="${user.proFirstName }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Last Name</label>
								<div class="col-md-4">
									<input class="form-control" name="lastName" type="text"
										id="lastName" value="${user.proLastName }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Company</label>
								<div class="col-md-4">
									<input class="form-control" name="company" type="text"
										id="company" value="${user.proCompanyName }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Contact Number</label>
								<div class="col-md-4">
									<input class="form-control" name="contactNo" type="text" onkeypress="return isNumberKey(event);"
										id="contactNo" value="${user.proContactNo }" >
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Email</label>
								<div class="col-md-4">
									<input class="form-control" name="email" type="text"
										id="email" value="${user.proEmail }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Username</label>
								<div class="col-md-4">
									<input class="form-control" name="username" type="text"
										id="username" value="${user.proUsername }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Password</label>
								<div class="col-md-4">
									<input class="form-control" name="password" type="password"
										id="password" value="${user.proPassword }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Role</label>
								<div class="col-md-4">
									<input class="form-control" name="role" type="text"
										id="role" value="${user.proRole }" readonly="readonly">
								</div>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col-md-4 text-center'></div>
						<div class='col-md-2 text-center'>
							<button type="button" class="btn btn-primary btn-block" id="save" onclick="update()">
								<i class="glyphicon glyphicon-floppy-disk"></i> Save
							</button>
						</div>
						<div class='col-md-2 text-center'>
							<button type="button" class="btn btn-danger btn-block" onclick="cancel()">
								<i class="glyphicon glyphicon-remove"></i> Cancel
							</button>

						</div>
						<div class='col-md-4 text-center'></div>
					</div>
				</div>
			</div>
			<input type="hidden" name = "proId" id="proId">
			<input type="hidden" name = "actionType" id="actionType">
			<input type="hidden" name = "title" id="titleHidden" value="${user.proTitle }">
		</form>

		<script
			src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

		<script type="text/javascript">
		window.onload = function() {
			
			if('${type}' == 'Add'){
				$('#frm').attr('action', '${pageContext.request.contextPath}/UserMainAction');
				$('#title').text('Add User');
				document.getElementById('role').value = 'Admin';
				document.getElementById('actionType').value = 'add';
				document.getElementById('titleHidden').disabled = true;
			}else if('${type}' == 'Edit'){
				$('#frm').attr('action', '${pageContext.request.contextPath}/UserDetailAction');
				$('#title').text('Edit User');
				document.getElementById('actionType').value = 'edit';
				document.getElementById('proId').value = '${user.proId}';
				document.getElementById('titleName').disabled = true;
				document.getElementById('firstName').readOnly = true;
				document.getElementById('lastName').readOnly = true;
				document.getElementById('company').readOnly = true;
				document.getElementById('username').readOnly = true;
				document.getElementById('password').readOnly = true;
			}
		};

		function cancel(){
			if(confirm("Are you sure you want to cancel")){
				window.location = '${pageContext.request.contextPath}/UserMainAction';
			}
		}
		
		function update(){
			if(document.getElementById('actionType').value == 'add'){
				var username = document.getElementById('username').value;
				$.post("${pageContext.request.contextPath}/UserMainAction",
					    {
					        actionType: "check",
					        username: username
					    },
					    function(duplicate){
					        console.log(duplicate);
					        if(duplicate == 'false'){
					        	alert("Username is duplicate!");
					        }else{
					        	document.getElementById('frm').submit();
					        }
					    });
			}else{
				document.getElementById('frm').submit();
			}
			
		}
		
		function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : evt.keyCode
		    return !(charCode > 31 && (charCode < 48 || charCode > 57));
		}
	</script>
</body>
</html>