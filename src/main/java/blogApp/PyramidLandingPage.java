package blogApp;

import java.io.IOException;

import javax.servlet.http.*;

public class PyramidLandingPage extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		resp.setContentType("text/plain");
		
		resp.getWriter().println("hello, Welcome to our blog about Pyramid Schemes");
	}
}
	
