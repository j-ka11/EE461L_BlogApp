<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
	<link rel="stylesheet" type="text/css" href="/pyramidLanding.css">
	<%
	UserService userService = UserServiceFactory.getUserService();
	String loginUrl = userService.createLoginURL(request.getRequestURI());
	String logoutUrl = userService.createLogoutURL(request.getRequestURI());
	%>
	<script>
	function goToSignIn(){
		window.location.assign(document.getElementById("hiddenurl").value);
	}
	function goToSignOut(){
		window.location.assign(document.getElementById("hiddenSignOut").value);
	}
	function makeAPost(){
		window.location.assign("/post");
	}
	</script>
	
</head>
<body>
	<%
		//Josh Driving
		String blogAppName = "Schemes";

		pageContext.setAttribute("blogAppName", blogAppName);
	%>
	<div id="blogContainer">
		<div id="upperToolbar">
		<%
		User user = userService.getCurrentUser();
		if(user != null){
			pageContext.setAttribute("user", user);
		}
		%>
			<input type="hidden" name="loginURL" id="hiddenurl" value="<%=loginUrl%>">
			<input type="hidden" name="logoutURL" id="hiddenSignOut" value="<%=logoutUrl%>">
			
			<div id="titlePicture">
				<img id="landingImg" src="/landingImage.jpg" alt="Girl holding money" width="97" height="145">
			</div>
			<div id="tools">
				<div id="post">
					<%
					if(user != null){
					%>
					<button type="button" onclick="makeAPost()">Make a new Post</button>
					<%
					}
					%>
				</div>
				<div id="profile">
				<%
				if(user == null){
				%>
					<button type="button" onclick="goToSignIn()">Sign In</button>
				<% 
				}else{
				%>
					<p id="welcomeMsg">Hello, ${fn:escapeXml(user.nickname)}!</p>
					<button id="signOutButton" type="button" onclick="goToSignOut()">Sign Out</button>
				<%
				}
				%>
			</div>
			</div>
		</div>
		<div id="title">
			<h1 id="landingHeader" class="foreground">Stay up to date with
			the latest ways to get scammed!</h1>
		</div>

		<div id="previews">
			<h3>Most recent posts:</h3>
			<div id="preview1" style="background-color: red;">
				<p>Preview 1</p>
			</div>
			<div id="preview2" style="background-color: blue;">
				<p>Preview 2</p>
			</div>
			<div id="preview3" style="background-color: green;">
				<p>Preview 3</p>
			</div>
		</div>
	</div>

</body>
</html>