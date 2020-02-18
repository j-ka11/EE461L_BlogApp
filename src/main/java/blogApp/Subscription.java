package blogApp;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.*;

import com.google.appengine.api.users.*;
import com.google.appengine.api.datastore.*;

public class Subscription extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		Properties props = System.getProperties();
		props.setProperty("mail.smtp.host", "localhost");
		Session session = Session.getDefaultInstance(props, null);
		
		try {
			Key subKey = KeyFactory.createKey("subscription", "sub");
			Key postKey = KeyFactory.createKey("blogApp", "Schemes");
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("NewSubs", subKey);
			List<Entity> subs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
			query = new Query("Posting", postKey);
			List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
			String content = this.createContent(posts);
			
			if(content != null) {
				for(Entity e : subs) {
					Message msg = new MimeMessage(session);
					msg.setFrom(new InternetAddress("chris.joswin@gmail.com", "Pyramid Scheme Admin"));
					msg.addRecipient(Message.RecipientType.TO, new InternetAddress(e.getProperty("email").toString(), "Mr. User"));
					msg.setSubject("New Pyramid Schemes");
					msg.setText(content);
					Transport.send(msg);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws IOException{
		Scanner s = new Scanner(req.getInputStream(), "UTF-8");
		String cmd = s.nextLine();
		String email = s.nextLine();
		
		Key subKey = KeyFactory.createKey("subscription", "sub");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		if(cmd.equals("subscribe")) {
			Entity newSubs = new Entity("NewSubs",subKey);
			newSubs.setProperty("email",email);
			datastore.put(newSubs);
		}else if(cmd.equals("unsubscribe")) {
			Query query = new Query("NewSubs", subKey);
			List<Entity> subs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
			for(Entity e : subs) {
				if(e.getProperty("email").equals(email)) {
					datastore.delete(e.getKey());
				}
			}
		}
		s.close();
	}
	
	private String createContent(List<Entity> posts) {
		String content = "Here are the new pyramid scheme posts from the last 24 hours!\n\n";
		boolean newSchemes = false;
		Date currDate = new Date();
		long currTime = currDate.getTime();
		Date oldDate = new Date(currTime - 3600000);
		for(Entity e : posts) {
			Date dateCheck = (Date) e.getProperty("date");
			if(dateCheck.after(oldDate)) {
				String newPostContent = e.getProperty("content").toString();
				String newPostAuthor = e.getProperty("user").toString();
				String newPostTitle = e.getProperty("heading").toString();
				content = content + newPostAuthor + "\n" + newPostTitle + "\n" + newPostContent + "\n\n";
				newSchemes = true;
			}
		}
		if(!newSchemes) {
			content = null;
		}
		return content;
	}
}
