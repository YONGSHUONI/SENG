package cloud.servlet;

import cloud.clouddb.cloud_user.*;
import java.io.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		try {
			login(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} 
			
	}
	
	// login function
	private void login(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException, NoSuchAlgorithmException, InvalidKeySpecException{
		
		UserDAO dao = new UserDAO();
		User loginUser = new User();
		
		loginUser.setUsername(request.getParameter("username"));
		
		String pswd=Hash.hashFunction(request.getParameter("password"));
		loginUser.setPassword(pswd);
		
		// password is true for the login username
		if(dao.verifyPassword(loginUser)==true){
			
			dao.getUser(loginUser.getUsername(), loginUser);
			
			HttpSession session = request.getSession(true); 
			session.setAttribute("currentSessionUser",loginUser);
			
			ServletContext context = getServletContext();
			context.getRequestDispatcher("/AppServlet").forward(request, response);
			
		}else{
			String trueJson = "{\"status\":\"false\"}";
			response.setContentType("text/plain");
			response.getWriter().write(trueJson);
		}
		
//		StringBuffer requestURL = request.getRequestURL();
//		String url = requestURL+ URLEncoder.encode("index.jsp","UTF-8");
//		response.sendRedirect(url);  
	}

}
