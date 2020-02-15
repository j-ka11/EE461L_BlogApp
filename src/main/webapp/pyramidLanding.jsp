<%@ page contentType ="text/html;charset=UTF-8" language ="java"%>
<%@ page import ="java.util.List" %>
<%@ page import = "com.google.appengine.api.users.User"%>
<%@ page import ="com.google.appengine.api.users.UserService" %>
<%@ page import ="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import = "com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import ="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import ="com.google.appengine.api.datastore.Query" %>
<%@ page import ="com.google.appengine.api.datastore.Entity" %>
<%@ page import ="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import ="com.google.appengine.api.datastore.Key" %>
<%@ page import ="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix = "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
	
	</head>
<body>
<%
String blogAppName= request.getParameter("blogAppName");
if(blogAppName ==null){
	blogAppName="default";
	
}

pageContext.setAttribute("blogAppName",blogAppName);
UserService userService=UserServiceFactory.getUserService();
User user =userService.getCurrentUser();
if(user!=null){
	pageContext.setAttribute("user",user);
%>
<p> Hello,${fn:escapeXml(user.nickname)}!(You can 
<a href= "<%=userService.createLogoutURL(request.getRequestURI())%>" >sign out</a>.)</p>

<% 
}else{

%>
<p>Hello!
<a href ="<%=userService.createLoginURL(request.getRequestURI()) %>">Sign In</a>
to include your name with greetings you post.</p>
<%
}
%>
<%
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
Key blogAppKey = KeyFactory.createKey("Pyramid", blogAppName);
Query query = new Query("Greeting", blogAppKey).addSort("date",Query.SortDirection.DESCENDING);
List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
if(greetings.isEmpty()){
%>
<p> PyramidBlog '${fn:escapeXml(blogAppName)}' has no messages.</p>
<% 
}else{
	%>
	<p>Messages in PyramidBlog '${fn:escapeXml(blogAppName)}'.</p>
	<% 
	for(Entity greeting : greetings){
	pageContext.setAttribute("greeting_content",greeting.getProperty("content"));
		if(greeting.getProperty("user")==null){
		%>
		<p> Anonymous person wrote:</p>
		<%
		}else{
		pageContext.setAttribute("greeting_user",greeting.getProperty("user"));
		%>	
		<p><b>${fn:escapeXml(greeting_user.nickname)}</b>wrote:</p>
		<%
		}
		%>
		<blockquote>${fn:escapeXml(greeting_content)}</blockquote>
			<%
			}
		}
%>	

	
	



<form action= "/sign" method=""post> 
<div> <textarea name="content" rows="3" cols="60"></textarea></div>
<div><input type="submit" value ="Post Greeting"></div>
</form>

</body>
</html>