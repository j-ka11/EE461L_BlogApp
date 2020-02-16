package blogApp;

import java.io.IOException;

import javax.servlet.http.*;

public class AllPyramidPosts extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws IOException{
		resp.sendRedirect("/allPosts.jsp?blogAppName=Schemes");
	}

}
