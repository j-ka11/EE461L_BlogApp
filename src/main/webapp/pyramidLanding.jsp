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

<%-- <% 
 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 Key guestbookKey = KeyFactory.createKey("blogAppName",blogAppName);
 
 Query query = new Query("Greeting",guestbookKey).addSort("user",Query.SortDirection.DESCENDING).addSort("date",Query.SortDirection.DESCENDING);
 List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
 if(greetings.isEmpty()){
	%>
	<p>Pyramid Blog '${fn: escapeXml(guestbookName)}'has no messages.</p>
	<%
	}else{
	%>
	<p>Messages in Pyramid Blog ' ${fn:escapeXml(guestbookName)}'.</p>
	<%
	for(Entity greeting: greetings){
		pageContext.setAttribute("greeting_content",greeting.getProperty("content"));
		if(greeting.getProperty("user")==null){
			%>
			<p> An anonymous person wrote: </p>
			<%
			}else{
			pageContext.setAttribute("greeting_user",greeting.getProperty("user"));
			%>
			<p><b>${fn:escapeXml(greeting_user.nickname)} }</b>wrote:</p>
			<% 
		}
		}
	}
	%>	
	<blockquote>${fn:escapeXml(greeting_content)} }</blockquote>
	 --%>
		<div id="previews">
			<h3>Most recent posts:</h3>
			
			<% 
 			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 			Key blogAppKey = KeyFactory.createKey("blogApp",blogAppName);
 			
			 Query query = new Query("Posting",blogAppKey).addSort("date",Query.SortDirection.DESCENDING);
 			List<Entity> postings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
 			System.out.println(postings);
 			
 			if(postings.isEmpty()){
			%>
			<p>Pyramid Blog Schemes has no messages.</p>
			<%
			}else{
			%>
			<p>Messages in Pyramid Blog Schemes.</p>
			<%
			for(int posting=0;posting<3&&posting<postings.size();posting++){
				pageContext.setAttribute("greeting_content",postings.get(posting).getProperty("content"));
				pageContext.setAttribute("greeting_heading",postings.get(posting).getProperty("heading"));
				if(postings.get(posting).getProperty("user")==null){
					%>
					<p> An anonymous person wrote: </p>
					<%
					}else{
					pageContext.setAttribute("greeting_user",postings.get(posting).getProperty("user")); 
					%>
					<p><b>${fn:escapeXml(greeting_user.nickname)} </b>wrote:</p>
					
					<% 
				}
			%>
			<blockquote>${fn:escapeXml(greeting_heading)} </blockquote>
			<blockquote>${fn:escapeXml(greeting_content)} </blockquote>
			<% 
				}
		}
 			
 			
	%>
	
			
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