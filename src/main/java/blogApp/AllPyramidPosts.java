package blogApp;

import java.io.IOException;
import java.util.Scanner;

import javax.servlet.http.*;

public class AllPyramidPosts extends HttpServlet{
	private String styleFile = "/allPosts.css";
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws IOException{
		System.out.println("redirecting " + styleFile);
		resp.sendRedirect("/allPosts.jsp?blogAppName=Schemes&stylePage=" + styleFile);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		Scanner s = new Scanner(req.getInputStream(), "UTF-8");
		styleFile = "/".concat(s.next());
		s.close();
	}
}
