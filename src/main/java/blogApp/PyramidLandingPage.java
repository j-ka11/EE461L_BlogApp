package blogApp;
//Chris Driving
import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class PyramidLandingPage extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		if(user!=null) {
			resp.setContentType("text/plain");
			resp.getWriter().println("Welcome to Pyramid Schemes," +user.getNickname());
			
		}else
		{
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		}
		
		
	}
	
}
//Chris Stopped Driving
