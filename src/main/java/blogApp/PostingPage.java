package blogApp;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;



public class PostingPage extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws IOException{
		String blogAppName = req.getParameter("blogAppName");
		resp.sendRedirect("/pyramidPosting.jsp?blogAppName="+blogAppName);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		UserService userService=UserServiceFactory.getUserService();
		User user= userService.getCurrentUser();
		
		String blogAppName = req.getParameter("blogAppName");
		Key blogAppKey = KeyFactory.createKey("blogApp", blogAppName);
		String content = req.getParameter("content");
		String p1 = req.getParameter("content").substring(0, content.length()/2);
		System.out.println(p1);
		String preview =p1.concat("...");
		String heading = req.getParameter("title");
		
		Date date = new Date();
		Entity posting = new Entity("Posting", blogAppKey);
		posting.setProperty("user", user);
		posting.setProperty("date", date);
		posting.setProperty("content", content);
		posting.setProperty("heading", heading);
		posting.setProperty("preview", preview);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(posting);
		resp.sendRedirect("/pyramidLanding.jsp?blogAppName="+blogAppName);
		
	}
}
