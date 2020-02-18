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
	function subscribe(){
		document.getElementById("subscribeButton").style.display = "none";
		document.getElementById("unsubscribeButton").style.display = "block";
		
		var msg = "subscribe\n";
		var user = document.getElementById("hiddenUser").value;
		msg = msg.concat(user);
		var subscription = new XMLHttpRequest();
		subscription.onreadystatechange = function(){
			if(subscription.readyState == 4 && subscription.status == 200){
				console.log("user subscribed");
			}
		}
		subscription.open('POST', '/subscribe', true);
		subscription.send(msg);
	}
	function unsubscribe(){
		document.getElementById("subscribeButton").style.display = "block";
		document.getElementById("unsubscribeButton").style.display = "none";
		
		var msg = "unsubscribe\n";
		var user = document.getElementById("hiddenUser").value;
		msg = msg.concat(user);
		var subscription = new XMLHttpRequest();
		subscription.onreadystatechange = function(){
			if(subscription.readyState == 4 && subscription.status == 200){
				console.log("user subscribed");
			}
		}
		subscription.open('POST', '/subscribe', true);
		subscription.send(msg);
	}
	function makeAPost(){
		
		window.location.assign("/post");
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
			<input type="hidden" name="user" id="hiddenUser" value="${fn:escapeXml(user)}">
			
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
					userService = UserServiceFactory.getUserService();
					user = userService.getCurrentUser();
					Key subKey = KeyFactory.createKey("subscription", "sub");
					DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
					Query query = new Query("NewSubs", subKey);
					List<Entity> subs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
					String subscribed = "display: block;";
					String unsubscribed = "display: none;";
					for(Entity e : subs) {
						if(e.getProperty("email").equals(user.getNickname())) {
							subscribed = "display: none;";
							unsubscribed = "display: block;";
						}
					}
					pageContext.setAttribute("subscribeDisplay", subscribed);
					pageContext.setAttribute("unsubscribeDisplay", unsubscribed);
				%>
				<button id="subscribeButton" type="button" onclick="subscribe()" style="${fn:escapeXml(subscribeDisplay)}">Subscribe</button>
				<button id="unsubscribeButton" type="button" onclick="unsubscribe()" style="${fn:escapeXml(unsubscribeDisplay)}">Unsubscribe</button>
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
						pageContext.setAttribute("posting_preview", postings.get(posting).getProperty("preview"));
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
						<p>${fn:escapeXml(posting_preview)}</p>
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