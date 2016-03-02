<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>IBM Innovation Center</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<!-- Including buttons styles -->
	<link type="text/css" href="css/dashboard/controls.css" rel="stylesheet" />	
	  
	<!-- EDIT the styles to fit your design-->	
	<link href="${pageContext.request.contextPath}/css/dashboard/cloud.css" rel="stylesheet"/>	
	
	<!-- Including jQuery and cloud plugin -->
	<script type="text/javascript" src="js/dashboard/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/dashboard/jquery.tags-cloud.min.js"></script>
	
	<script type="text/javascript">
	   
		$(document).ready(function(){
	
			//START cloud			
			$('#mycloud').cloud({

				//all settings are optional, you can delete them or provide your values
			
				hwratio				: 1,		//height/width ratio
				enable				: true,		//enable effect on mouse move
				draggable			: true,		//enable mouse drag
				gravitydriven		: true,	//enable effect on mobile device movement
				template			: 1,		//number of template (0-10) or function
				scale				: 1,		//scale template
				maxspeed			: 1,		//maximum rotation speed
				attenuation			: 0.01,		//attenuation
				perspective			: 0.4,		//perspective koefficient
				sensitivityx		: 0.05,		//if sensitivity=0 no effect will be applied
				sensitivityy		: 0.05,		//negative values invert mouse			
				fadein				: 800,		//fadein on start (in ms)
				fog					: 0.5,		//fog index
				zsort				: true,		//sort by z
				fps					: 60,		//default fps limit
				fpsmobile			: 30,		//default fps limit on mobile devices
				imgscale			: 0,		//scale images (works only if they are direct children of cloud)
				onclick             : onclickFunction	//function to execute on tag click
				
			}); 

			
			hide('play');
			
		});

		
		function onclickFunction(v) {
			if(typeof v == 'undefined') v='tag';
			alert('you clicked '+v);  //v = value of data-onclick attribute	(see below)
		};
		
		
		function optionSwitch(optionName, optionValue){
		  	if(typeof optionValue == 'undefined'){
				optionValue=document.getElementById(optionName).checked;
			}
		  	$('#mycloud').cloud('option',optionName,optionValue);						
		}
		
		function optionChange(optionName, optionValue){		  	
			var checked=document.getElementById(optionName).checked;			
		  	$('#mycloud').cloud('option',optionName,checked?optionValue[0]:optionValue[1]);						
		}
		
	
		
		
		function show(id){
			var ele = document.getElementById(id);
			ele.style.display = "block";
		}
		
		function hide(id){
			var ele = document.getElementById(id);
			ele.style.display = "none";
		}
		
		
	</script>	

	
</head>

	
<body onmousedown="$('#mycloud').cloud('mouseTo', {x:100, y:0})" onClick="return false">
	<h1>IBM Innovation Center</h1>				

		<div class="containercloud">        	
			<ul id="mycloud">
			  <c:if test="${not empty deviceList}">
				<c:forEach var="device" items="${deviceList}" varStatus="status">
    				<li><img src="http://graph.facebook.com/${device.medFbId}/picture?width=85&height=85"></img></li>
    				
    			</c:forEach>
    			
			</c:if>
						  <c:if test="${not empty otherList}">
				<c:forEach var="other" items="${otherList}" varStatus="status">
    				<li><img src="${other}"></img></li>
    				
    			</c:forEach>
    			
			</c:if>
			</ul>
		</div>
		<div class="male"><div class="label">${male}</div></div>
		<div class="female"><div class="label">${female}</div></div>
		<div class="apple"><div class="label">${apple}</div></div>
		<div class="android"><div class="label">${android}</div></div>
		<div class="windows"><div class="label">${windows}</div></div>

<!--		
		<div id="log"></div>
		<div>External control example. See source of this html file</div>
		<div class="controls">	
				
			<table>				  
			  <tr>					
				<td>
					<ul><h5>Mouse emulation</h5>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseTo', {x:100, y:0})" onClick="return false"> mouse to the right</a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseTo', {x:-100, y:0})" onClick="return false"> mouse to the left</a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseTo', {x:0, y:100})" onClick="return false"> mouse to the up</a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseTo', {x:0, y:-100})" onClick="return false"> mouse to the down</a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseTo', {x:70, y:-90})" onClick="return false"> mouse to (70%,-90%) right-bottom corner</a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseTo', {x:0, y:0})" onClick="return false"> mouse to (0px,0px) </a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('mouseToRandom')" onClick="return false"> mouse to random position </a></li>
					<li><a href="#" onmousedown="$('#mycloud').cloud('reset')" onClick="return false"> reset</a></li>
					</ul>
				</td>
				<td>
					<h5>Some properties change</h5>
					<form>
						<input type="checkbox" id="enable" checked onclick="optionSwitch('enable')"/><label for="enable"> activate on mouse move</label><br>
						<input type="checkbox" id="draggable" checked onclick="optionSwitch('draggable')"/><label for="draggable"> activate on drag</label><br>
						<input type="checkbox" id="gravitydriven" checked onclick="optionSwitch('gravitydriven')"/><label for="gravitydriven"> activate on mobile device turn</label><br>
						<input type="checkbox" id="zsort" checked onclick="optionSwitch('zsort')"/><label for="zsort"> Z-sorting</label><br>
						<input type="checkbox" id="fog" checked onclick="optionChange('fog',[0.5,0])"/><label for="fog"> fog effect</label><br>
						<input type="checkbox" id="sensitivityx" checked onclick="optionChange('sensitivityx',[0.05,0])"/><label for="sensitivityx"> H rotation</label><br>
						<input type="checkbox" id="sensitivityy" checked onclick="optionChange('sensitivityy',[0.05,0])"/><label for="sensitivityy"> W rotation</label><br>
					</form>
				</td>
			  </tr>
			 
			 
			  <tr>
				
				<td>
					<ul><h5>Playback control</h5>						
						<li><a id="stop" class="button" href="#" onmousedown="$('#mycloud').cloud('stop')" onClick="return false"> stop </a></li>
						<li><a id="play" class="button" href="#" onmousedown="$('#mycloud').cloud('unpause');show('pause');hide('play');" onClick="return false"> start auto play </a></li>
						<li><a id="pause" class="button" href="#" onmousedown="$('#mycloud').cloud('triggerPause');show('play');hide('pause');" onClick="return false"> trigger pause </a></li>
						<li><a id="pause3s" class="button" href="#" onmousedown="$('#mycloud').cloud('pause',3000)" onClick="return false"> pause 3s </a></li>
					</ul>
				</td>
				<td>
					
					<p>read HOW-TO file for complete list of settings</p>
				</td>
			  </tr>				  
			</table>
				
		</div>
	-->	
		<script type="text/javascript">
			setInterval(function(){ 
				$('#mycloud').cloud('mouseTo', {x:100, y:0});

			}, 500);
			
		</script>
		
	</body>

</html>