package blogApp;

import java.io.IOException;
import java.util.Scanner;

import javax.servlet.http.*;

public class AllPyramidPosts extends HttpServlet{
	private static String styleSheet = "allPosts";
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws IOException{
		resp.sendRedirect("/allPosts.jsp?blogAppName=Schemes&styleSheet=" + styleSheet);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		Scanner s = new Scanner(req.getInputStream());
		styleSheet = s.next();
		s.close();
	}
}
