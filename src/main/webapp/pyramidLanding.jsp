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
	%>
	<script>
	function goToSignIn(){
		alert(document.getElementById("hiddenurl").value);
		window.location.assign(document.getElementById("hiddenurl").value);
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
		<div id="signIn">
		<%
		//UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String reqURI = request.getRequestURI();
		System.out.println(reqURI);
		%>
			<input type="hidden" name="loginURL" id="hiddenurl" value="<%=loginUrl%>">
			<button type="button" onclick="goToSignIn()">Sign In</button>
			
		</div>
		<div id="title">
			<div id="titleHeader">
				<h1 id="landingHeader" class="foreground">Stay up to date with
				the latest ways to get scammed!</h1>
			</div>
			<div id="titlePicture">
				<img id="landingImg" src="/landingImage.jpg" alt="Girl holding money" width="145" height="217">
			</div>
		</div>
	 	<%
			//Chris Driving
			/* UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser(); */
			if (user != null) {
				pageContext.setAttribute("user", user);
		%>
		<p>
			Hello,${fn:escapeXml(user.nickname)}!(You can <a
				href="<%=userService.createLogoutURL(request.getRequestURI())%>">sign
				out</a>.)
		</p>

		<%
			} else {
		%>
		<p>
			Hello! <a
				href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
				In</a> to include your name with greetings you post.
		</p>
		<%
			}
		%>
		<%
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Key blogAppKey = KeyFactory.createKey("blogApp", blogAppName);

			Query query = new Query("Greeting", blogAppKey).addSort("date", Query.SortDirection.DESCENDING);
			List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
			if (greetings.isEmpty()) {
		%>
		<p>PyramidBlog '${fn:escapeXml(blogAppName)}' has no messages.</p>
		<%
			} else {
		%>
		<p>Messages in PyramidBlog '${fn:escapeXml(blogAppName)}'.</p>
		<%
				for (Entity greeting : greetings) {
					pageContext.setAttribute("greeting_content", greeting.getProperty("content"));
					if (greeting.getProperty("user") == null) {
		%>
		<p>Anonymous person wrote:</p>
		<%
					} else {
						pageContext.setAttribute("greeting_user", greeting.getProperty("user"));
		%>
		<p>
			<b>${fn:escapeXml(greeting_user.nickname)}</b>wrote:
		</p>
		<%
					}
		%>
		<blockquote>${fn:escapeXml(greeting_content)}</blockquote>
		<%
				}
			}
			//Chris stopped Driving
		%>

		




		<form action="/sign" method="post">
			<div>
				<textarea name="content" rows="3" cols="60"></textarea>
			</div>
			<div>
				<input type="submit" value="Post Greeting">
			</div>
			<input type="hidden" name="blogAppName"
				value="${fn:escapeXml(blogAppName) }" />
		</form>
	</div>

</body>
</html>