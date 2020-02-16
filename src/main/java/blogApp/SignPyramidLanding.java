package blogApp;

import java.io.IOException;
import java.util.Date;

import java.util.logging.Logger;

import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;


public class SignPyramidLanding extends HttpServlet{
	//Chris Driving
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String blogAppName = req.getParameter("blogAppName");
		Key blogAppKey = KeyFactory.createKey("blogApp", blogAppName);
		String content = req.getParameter("content");
		Date date = new Date();
		Entity greeting = new Entity("Greeting", blogAppKey);
		greeting.setProperty("user", user);
		greeting .setProperty("date", date);
		greeting.setProperty("content", content);
		System.out.println(greeting);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(greeting);
		
		resp.sendRedirect("/pyramidLanding.jsp?blogAppName="+blogAppName);
		//Chris Driving
		
		
	}
	
//	public void doGet(HttpServletRequest req,HttpServletResponse resp) 
//			throws IOException{
//		System.out.println("reached doGet in SignLanding");
//		UserService userService = UserServiceFactory.getUserService();
//		User user = userService.getCurrentUser();
//		
//	


		//resp.sendRedirect("/pyramidLanding.jsp?blogAppName="+blogAppName);
	
	
//		}
//			
//	}
}
