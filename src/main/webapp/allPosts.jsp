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
	<link rel="stylesheet" type="text/css" href="/allPosts.css">
</head>
<body>
	<div id="postsWrapper">
		<div id="title">
			<h1 id="titleMessage">All Pyramid Posts</h1>
		</div>
		<div id="posts">
			<div class="post">
				<div class="postTitle">
					<h1>post title</h1>
				</div>
				<div class="postBody">
					<div class="postMeta">
						<p>post Author</p>
						<p>post Date</p>
					</div>
					<div class="postContent">
						<h3>post content</h3>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>