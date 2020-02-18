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
<script>
function goMainBack(){
	window.location.assign("/");
}
</script>
<head>
	<link rel="stylesheet" type="text/css" href="/pyramidPosting.css">
</head>
<body>
	<%
		String blogAppName = "Schemes";
		pageContext.setAttribute("blogAppName", blogAppName);
	%>
	<div id="postingWrapper">
		<h1>What new scheme have you come up with?</h1>
		<div id="blogPost">
			<form action="/post" method="post">
				<div id="headings">
					<input type="text" name="heading" value="Scheme Title"/>
				</div>
				<div id="mainPost">
					<textarea name="content" rows="10" cols="80"></textarea>
				</div>
				<div id="submit">
					<input type="submit" value="Post Article"/>
					<input type="hidden" name="blogAppName" value="${fn:escapeXml(blogAppName)}"/>
				</div>
				<button type="button" onclick="goMainBack()">Go Back To Home</button>
			</form>
	
		</div>
	</div>
</body>
</html>