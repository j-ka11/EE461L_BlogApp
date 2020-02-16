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
		System.out.println("in get and name is: " + blogAppName);
		resp.sendRedirect("/pyramidPosting.jsp?blogAppName="+blogAppName);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		UserService userService=UserServiceFactory.getUserService();
		User user= userService.getCurrentUser();
		
		String blogAppName = req.getParameter("blogAppName");
		//System.out.println(blogAppName);
		Key blogAppKey = KeyFactory.createKey("blogApp", blogAppName);
		String content = req.getParameter("content");
		String heading = req.getParameter("heading");
		
		Date date = new Date();
		Entity posting = new Entity("Posting", blogAppKey);
		posting.setProperty("user", user);
		posting.setProperty("date", date);
		posting.setProperty("content", content);
		posting.setProperty("heading", heading);
		System.out.println(posting);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(posting);
		System.out.println();
		System.out.println("put post in datastore");
		resp.sendRedirect("/pyramidLanding.jsp?blogAppName="+blogAppName);
		
	}
}
