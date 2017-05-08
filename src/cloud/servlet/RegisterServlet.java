package cloud.servlet;

import cloud.clouddb.cloud_user.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;


/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    public RegisterServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
			
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("data received");
		try 
		{
			User user = new User(); 
			UserDAO userdao=new UserDAO();
			
			user.setUsername(request.getParameter("username")); 
			user.setPassword(request.getParameter("password"));
			user.setEmail(request.getParameter("email"));
			user.setForename(request.getParameter("first"));
			user.setSurname(request.getParameter("last"));
			
			if(userdao.ifSameUsername(user))
			{
				user = register(user);
				
				if (user.isValid()) 
				{ 				
					userdao.getUser(user.getUsername(), user);
					HttpSession session = request.getSession(true); 
					session.setAttribute("currentSessionUser",user);
					 
					String trueJson = "{\"status\":\"true\"}";
					
					response.setContentType("text/plain");
					response.getWriter().write(trueJson);
				}
				//error page 
			}else{
				String falseJson = "{\"status\":\"false\"}";
				response.setContentType("text/plain");
				response.getWriter().write(falseJson);
			}
		}
		catch (Exception e) {
			e.getMessage();
		}
	}

	//Method for registration operation.
	public User register(User user) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
			
		UserDAO userdao=new UserDAO();
					
		String password = user.getPassword(); 
		password=Hash.hashFunction(password);
		user.setPassword(password);
				
		if(userdao.storeUser(user)){
			user.setValid(true);
		}else{
			user.setValid(false);
		}
		return user;
	}	
}
