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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />

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
							<h5 class="panel-title pull-left" style="padding-top: 7.5px;">Event
								Information</h5>
						</div>
						<div class="panel-body" id="editForm">

							<div class="form-group">
								<label class="col-md-2 control-label">Event Name</label>
								<div class="col-md-4">
									<input class="form-control" name="eventName" type="text"
										id="eventName" value="${event.eveName }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Description </label>
								<div class="col-md-4">
									<textarea rows="5" name="description" id="description"
										cols="45" class="form-control">${event.eveDescription }</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Start Date</label>
								<div class="col-md-4">
									<div class="input-group date" id="startDate">
										<input type='text' class="form-control" name="startDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${event.eveStartDate }" />"/> <span
											class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">End Date</label>
								<div class="col-md-4">
									<div class="input-group date" id="endDate">
										<input type='text' class="form-control" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${event.eveEndDate }" />"/> <span
											class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Location</label>
								<div class="col-md-4">
									<input class="form-control" name="location" type="text"
										id="location" value="${event.eveLocation }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">Status</label>
								<div class="col-md-4">
									<select class="form-control" id="status" name="status" onchange="checkStatus()">
										<option selected="selected" value="active">Active</option>
										<option value="closed">Closed</option>
										<option value="cancel">Cancel</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col-md-4 text-center'></div>
						<div class='col-md-2 text-center'>
							<button type="submit" class="btn btn-primary btn-block" id="save">
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
			<input type="hidden" name = "eventId" id="eventId">
			<input type="hidden" name = "status" id="statusHide" value="${event.eveStatus }">
			<input type="hidden" name = "actionType" id="actionType">
		</form>

		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript">
		window.onload = function() {
			
			if('${type}' == 'Add'){
				$('#frm').attr('action', '${pageContext.request.contextPath}/EventMainAction');
				$('#title').text('Add Event');
				document.getElementById('actionType').value = 'add';
				document.getElementById('status').disable = true;
			}else if('${type}' == 'Edit'){
				$('#frm').attr('action', '${pageContext.request.contextPath}/EventDetailAction');
				$('#title').text('Edit Event');
				document.getElementById('actionType').value = 'edit';
				document.getElementById('eventId').value = '${event.eveId}';
				document.getElementById('status').value = '${event.eveStatus}';
				document.getElementById('statusHide').disable = true;
				checkStatus();
			}
			
			var msg = "${msg}";
			if(msg){
				alert(msg);
			}
		};

		$(function () {
	        $('#startDate').datetimepicker({
	        	format : 'YYYY-MM-DD HH:mm'
	        });
	        $('#endDate').datetimepicker({
	        	format : 'YYYY-MM-DD HH:mm',
	            useCurrent: false //Important! See issue #1075
	        });
	        $("#startDate").on("dp.change", function (e) {
	            $('#endDate').data("DateTimePicker").minDate(e.date);
	        });
	        $("#endDate").on("dp.change", function (e) {
	            $('#startDate').data("DateTimePicker").maxDate(e.date);
	        });
	    });
		
		function cancel(){
			if(confirm("Are you sure you want to cancel")){
				window.location = '${pageContext.request.contextPath}/EventMainAction';
			}
		}
		
		function checkStatus(){
			var status = document.getElementById('status').value;
			console.log(document.getElementById("remarkForm"));
			if(document.getElementById("remarkForm") == null)
			{
				if(status == 'cancel'){
					var html = '<div class="form-group" id="remarkForm"><label class="col-md-2 control-label">Remark </label><div class="col-md-4">';
						html+= '<textarea rows="5" name="remark" id="remark"cols="45" class="form-control"></textarea>';
						html+= '</div></div>';
					$( "#editForm" ).append( html );
				}
			}else{
				if(status !== 'cancel'){
					$('#remarkForm').remove();
				}
			}
			
		}
	</script>
</body>
</html>