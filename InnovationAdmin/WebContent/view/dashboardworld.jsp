<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
	<%@ page import="com.ibm.innovationadmin.model.MerakiModel"  %>
	<%@ page import="java.util.List"  %>
<html>
<head>
	<title>IBM Innovation Center</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	  
	<!-- EDIT the styles to fit your design-->	
	  <link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,700" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/css/dashboard/star.css" rel="stylesheet"/>	
	 
	<!-- Including jQuery and cloud plugin -->
	<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/dashboard/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/dashboard/jquery.tags-cloud.min.js"></script> -->
	
	 
</head>


<body>
	<div class="artbackground">
		<div class="ibmlogo"></div>
		<div class="stars" id = "stars">
			<div class="smallstar1 blue"></div>
			<div class="smallstar2 blue"></div>
			<div class="smallstar3"></div>
			<div class="smallstar4 blue"></div>
			<div class="smallstar5 yellow"></div>
			<div class="smallstar6"></div>
			<div class="smallstar7 violet"></div>
			<div class="smallstar8 violet"></div>
			<div class="smallstar9 yellow"></div>
			<div class="smallstar10 green"></div>
			<div class="smallstar11 green"></div>
			<div class="smallstar12 green"></div>
		</div>
		<div class="ibmworld"></div>

	</div>
	
    <script type="text/javascript">
/*
        var starStyle =   ["star1 small pulse",
                          "star2 med yellow",
                          "star3 med yellow",
                          "star4 small green pulse",
                          "star5 med",
                          "star6 med pulse-2",
                          "star7 med yellow pulse-1",
                          "star8 pulse",
                          "star9 med blue",
                          "star10 med yellow",
                          "star11 med blue pulse-2",
                          "star12 small pulse-3",
                          "star13 med yellow pulse-2",
                          "star14 med yellow pulse-2",
                          "star15 med violet blue",
                          "star16 med yellow",
                          "star17 yellow pulse",
                          "star18 yellow pulse-2",
                          "star19 blue pulse-3",
                          "star20 med yellow" ,
                          "star21 small blue pulse-1" ,
                          "star22 med yellow" ,
                          "star23 med pulse-3",
                          "star24 med blue" ,
                          "star25 small violet pulse-2",
                          "star26 med green" ,
                          "star27 small blue pulse-2"   ,
                          "star28 med green",
                          "star29 small pulse-1" ,
                          "star30 small pulse-3"];
                 */         
           var starStyle =   ["star1 small pulse",
                          "star2 med yellow",
                          "star3 med yellow",
                          "star30 small green pulse",
                          "star24 med",
                          "star20 med pulse-2",
                          "star7 med yellow pulse-1",
                          "star8 pulse",
                          "star9 med blue",
                          "star10 med yellow",
                          "star22 med blue pulse-2",
                          "star12 small pulse-3",
                          "star29 med yellow pulse-2",
                          "star14 med yellow pulse-2",
                          "star26 med violet blue",
                          "star16 med yellow",
                          "star17 yellow pulse",
                          "star18 yellow pulse-2",
                          "star19 blue pulse-3",
                          "star6 med yellow" ,
                          "star21 small blue pulse-1" ,
                          "star11 med yellow" ,
                          "star23 med pulse-3",
                          "star5 med blue" ,
                          "star25 small violet pulse-2",
                          "star15 med green" ,
                          "star27 small blue pulse-2"   ,
                          "star28 med green",
                          "star13 small pulse-1" ,
                          "star4 small pulse-3"];
        
        var stars = document.getElementById("stars");
		var currentStar = 0;
       <% List<MerakiModel> deviceList = (List<MerakiModel>) request.getAttribute("deviceList");

    		for(int i=0; i<deviceList.size() ; i++){ %>
    				var newElement = document.createElement("div");
          			newElement.setAttribute('class', starStyle[<%=i%>]);
         			newElement.style.cssText = "background-image:url('http://graph.facebook.com/<%=deviceList.get(i).getMedFbId()%>/picture?width=85&height=85')";
          			stars.appendChild(newElement);
          			currentStar = currentStar+1;
    		<%}%>
    	<%List<String> otherList = (List<String>) request.getAttribute("otherList");
    		for(int j=0; j<otherList.size() ; j++){%>
					var newElement1 = document.createElement("div");
 			        newElement1.setAttribute('class', starStyle[currentStar]);
          			newElement1.style.cssText = "background-image:url('<%=otherList.get(j)%>')";
					stars.appendChild(newElement1);
					currentStar = currentStar+1;
			<%}%>
    </script>
	
</body>

</html>