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
	function customize(){
		document.getElementById("customizationBar").style.display = "block";
		document.getElementById("post").style.display = "none";
		document.getElementById("customization").style.display = "none";
	}
	function exitCustomization(){
		document.getElementById("customizationBar").style.display = "none";
		document.getElementById("post").style.display = "block";
		document.getElementById("customization").style.display = "block";
	}
	function goToAllPosts(){
		window.location.assign("/allPosts");
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
			}else{
				pageContext.setAttribute("user", "anonymous");
			}
		%>
			<input type="hidden" name="loginURL" id="hiddenurl" value="<%=loginUrl%>">
			<input type="hidden" name="logoutURL" id="hiddenSignOut" value="<%=logoutUrl%>">
			
			<div id="titlePicture">
				<img id="landingImg" src="/landingImage.jpg" alt="Girl holding money" width="97" height="145">
			</div>
			<div id="tools">
				<div id="customizationBar">
					<div id="customBarExit">
						<button type="button" onclick="exitCustomization()">x</button>
					</div>
					<div id="customizations">
						<div id="defaultStyle">
							<button type="button">Default</button>
						</div>
						<div id="style1">
							<button type="button">Hook 'em Horns</button>
						</div>
					</div>
				</div>
				<div id="post">
				<%
					if(user != null){
				%>
					<button type="button" onclick="makeAPost()">Make a new Post</button>
				</div>
				<div id="customization">
					<button type="button" onclick="customize()">Customize</button>
				</div>
				<%
					}
				%>
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
			<% 
 				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 				Key blogAppKey = KeyFactory.createKey("blogApp", blogAppName);
 			
				Query query = new Query("Posting", blogAppKey).addSort("date", Query.SortDirection.DESCENDING);
 				List<Entity> postings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
 				if(postings.isEmpty()){
			%>
			<p>Pyramid Blog Schemes has no messages.</p>
			<%
				}else{
			%>
			<p>(These still need to be turned into previews.)</p>
			<%
					for(int posting = 0; posting < 3 && posting < postings.size(); posting++){
						pageContext.setAttribute("posting_user", postings.get(posting).getProperty("user"));
						pageContext.setAttribute("posting_title", postings.get(posting).getProperty("heading"));
						pageContext.setAttribute("posting_date", postings.get(posting).getProperty("date"));
						pageContext.setAttribute("posting_content", postings.get(posting).getProperty("content"));
			%>
			<div class="post">
				<div class="postTitle">
					<h1>${fn:escapeXml(posting_title)}</h1>
				</div>
				<div class="postBody">
					<div class="postMeta">
						<h2>${fn:escapeXml(posting_user.nickname)}</h2>
						<h4>${fn:escapeXml(posting_date)}</h4>
					</div>
					<div class="postContent">
						<p>${fn:escapeXml(posting_content)}</p>
					</div>
				</div>
			</div>
			<%
					}
				}
			%>
			<button type="button" onclick="goToAllPosts()">See all posts</button>
		</div>
	</div>
</body>
</html>