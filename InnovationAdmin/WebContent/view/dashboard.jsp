<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>home</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
     <nav class="navbar navbar-default navbar-static-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Lucky Draw Admin</a>
            </div>
            
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="./EventMainAction">Event</a></li>
                    <li><a href="./UserMainAction">User</a></li>
                    <li class='active' class="dropdown">
          				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="true">Report <span class="caret"></span></a>
     				    <ul class="dropdown-menu" role="menu">
            				<li><a href="./DashboardMainAction">Dashboard</a></li>
            				<li><a href="./ReportMainAction">Report</a></li>
            			</ul>
            		</li>
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
				<h2>Dashboard</h2>
			</div>
		</div>
		<div class='row'></div>
		<div class='row'></div>
		<form class="form-inline" method='get' action='DashboardDetailAction' target="_blank">
		<div class='row'>
    		<div class="col-sm-3"></div>
   			<div class="col-sm-6">
				<div class="col-sm-3">Event Name:</div>
				<div class="col-sm-6">
					<div class="btn-group btn-input clearfix" style="text-align: center">
 						<button type="button" class="btn btn-default dropdown-toggle" style="width:250px;" data-toggle="dropdown"><span data-bind="label"  id="eventspan" style="text-align: center">--- Select One ---</span><span class="caret" style="position:absolute;right:4%;top:50%;transform:translateY(-50%);"></span></button>
  						<ul class="dropdown-menu dropdown-event" role="menu" style="width:250px;">
  							<c:if test="${not empty evnList}">
								<c:forEach var="event" items="${evnList}" varStatus="status">
    								<li id="${event.eveId}"><a href="#">${event.eveName }</a></li>
    							</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="col-sm-3"></div>
			</div>
    		<div class="col-sm-3"></div>
  		</div>
		
		<!-- 
			<div class='col-sm-4' style='padding-left:20%'>Event Name :</div>
			<div class='col-sm-4'>
			<div class='row'>
				<div class='col-sm-8'>
					<div class="btn-group btn-input clearfix" style="text-align: center">
 						<button type="button" class="btn btn-default dropdown-toggle" style="width:250px;" data-toggle="dropdown"><span data-bind="label"  id="eventspan" style="text-align: center">--- Select One ---</span><span class="caret" style="position:absolute;right:4%;top:50%;transform:translateY(-50%);"></span></button>
  						<ul class="dropdown-menu dropdown-event" role="menu" style="width:250px;">
  							<c:if test="${not empty evnList}">
								<c:forEach var="event" items="${evnList}" varStatus="status">
    								<li id="${event.eveId}"><a href="#">${event.eveName }</a></li>
    							</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				<div class='col-sm-4'>
				</div>
			</div>
			</div>
			<div class='col-sm-4'></div>
			 -->
		
		<div class='row'><br>
		</div>
		<div class='row'>
    		<div class="col-sm-3"></div>
   			<div class="col-sm-6">
				<div class="col-sm-3">Dashboard Style:</div>
				<div class="col-sm-6">
					<div class="btn-group btn-input clearfix" style="text-align: center">
 						<button type="button" class="btn btn-default dropdown-toggle" style="width:250px;" data-toggle="dropdown"><span data-bind="label" id="dashboardspan" style="text-align: center">--- Select One ---</span><span class="caret" style="position:absolute;right:4%;top:50%;transform:translateY(-50%);"></span></button>
  						<ul class="dropdown-menu dropdown-dashboardstyle" role="menu" style="width:250px;">
  							<li><a href="#">IBM Cloud 3D</a></li>
  							<li><a href="#">IBM World</a></li>
						</ul>	
					</div>
				</div>
				<div class="col-sm-3"><input type="button" class='btn btn-primary' value="Open" onclick="checkEventAndDahsboard()" /></div>
			</div>
    		<div class="col-sm-3"></div>
  		</div>
		<!-- 
			<div class='col-sm-4'  style='padding-left:20%'>Dashboard Style :</div>
			<div class='col-sm-4'>
			<div class='row'>
				<div class='col-sm-8'>
					<div class="btn-group btn-input clearfix" style="text-align: center">
 						<button type="button" class="btn btn-default dropdown-toggle" style="width:250px;" data-toggle="dropdown"><span data-bind="label" id="dashboardspan" style="text-align: center">--- Select One ---</span><span class="caret" style="position:absolute;right:4%;top:50%;transform:translateY(-50%);"></span></button>
  						<ul class="dropdown-menu dropdown-dashboardstyle" role="menu" style="width:250px;">
  							<li><a href="#">IBM Cloud 3D</a></li>
  							<li><a href="#">IBM World</a></li>
						</ul>	
					</div>
				</div>
				<div class='col-sm-4'><input type="button" class='btn btn-primary' value="Open" onclick="checkEventAndDahsboard()" /></div>
			</div>
			</div>
			<div class='col-sm-4'></div>
			 -->
		 <input type="hidden" id="selectedEveId" name="selectedEveId" value=""/>
		 <input type="hidden" id="selectedDashboardStyle" name="selectedDashboardStyle" value=""/>
		 
		</form>
	</div>
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
	/*
	 	$(document.body).on( 'click', '.dropdown-menu li', function( event ) {
      		var $target = $( event.currentTarget );
			$target.closest( '.btn-group' ).find( '[data-bind="label"]' ).text( $target.text() ).end().children( '.dropdown-toggle' ).dropdown( 'toggle' );
      		return false;
      	});
      	*/
      	/*
      	$('.dropdown-event li > a').click(function(e){
    		$('.eventname').text(this.innerHTML);
    		$('#eventname').val(this.innerHTML);
   
    		console.log("event name"+$('#eventname').val());
    		var i = $(this).parents('.select').attr('id');
		});
		$('.dropdown-dashboardstyle li > a').click(function(e){
    		$('.dashboardstyle').text(this.innerHTML);
		});*/

		$('body').on('click', '.dropdown-event li', function() {
			var i = $(this).parents('.clearfix').attr('id');
			var value = $(this).children().text();
			$(this).parents('.clearfix').find('#eventspan').text(value);
			var selectedEveId = $(this).attr('id');
			$('#selectedEveId').val(selectedEveId);
			//var val = $('#selectedEveId').val();
		});
		$('body').on('click', '.dropdown-dashboardstyle li', function() {
			//var i = $(this).parents('.clearfix').attr('id');
			var dashboardStyle = $(this).children().text();
			$(this).parents('.clearfix').find('#dashboardspan').text(dashboardStyle);
			//var selectedEveId = $(this).attr('id');
			$('#selectedDashboardStyle').val(dashboardStyle);
			//var val = $('#selectedDashboardStyle').val();
		});
		
		function checkEventAndDahsboard(){
			var selectedEveId = $('#selectedEveId').val() ;
			var selectedDashboardStyle = $('#selectedDashboardStyle').val();
			if (selectedEveId =! "" && selectedDashboardStyle != ""){
				$('.form-inline').submit();
				//return true;
			}else{
				alert("Please select event and dahsboard style");
				//return false;
			}
		}
	</script>
</body>
</html>