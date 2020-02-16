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
</head>
<body>
	<%
		//Josh Driving
		String blogAppName = "Schemes";

		pageContext.setAttribute("blogAppName", blogAppName);
	%>
	<div id="blogContainer">
		<div id="upperToolbar">
			<div id="titlePicture">
				<img id="landingImg" src="/landingImage.jpg" alt="Girl holding money" width="97" height="145">
			</div>
			<div id="buttons">
				<button type="button">Sign In</button>
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