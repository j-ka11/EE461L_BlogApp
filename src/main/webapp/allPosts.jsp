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

<%
	String styleSheet = "/" + request.getParameter("styleSheet") + ".css";
%>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=styleSheet%>">
</head>
<body>
	<%
		String blogAppName = "Schemes";
		pageContext.setAttribute("blogAppName", blogAppName);
	%>
	<div id="postsWrapper">
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user != null){
				pageContext.setAttribute("user", user);
			}else{
				pageContext.setAttribute("user", "anonymous");
			}
		%>
		<div id="title">
			<h1 id="titleMessage">All Pyramid Posts</h1>
		</div>
		<%
			
		%>
		<div id="posts">
			<%
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Key blogAppKey = KeyFactory.createKey("blogApp", blogAppName);
				Query query = new Query("Posting", blogAppKey).addSort("date", Query.SortDirection.DESCENDING);
				List<Entity> postings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
				if(postings.isEmpty()){
			%>
			<h2 id="noPosts">Be the first to create a post!</h2>
			<%
				}else{
			%>
			<%
					for(Entity p : postings){
						pageContext.setAttribute("posting_user", p.getProperty("user"));
						pageContext.setAttribute("posting_title", p.getProperty("heading"));
						pageContext.setAttribute("posting_date", p.getProperty("date"));
						pageContext.setAttribute("posting_content", p.getProperty("content"));
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
		</div>
	</div>
</body>
</html>