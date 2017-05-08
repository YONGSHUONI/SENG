package cloud.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cloud.clouddb.cloud_user.User;
import cloud.clouddb.cloud_user.UserDAO;

/**
 * Servlet implementation class ConfirmPasswordServlet
 */
@WebServlet("/ConfirmPasswordServlet")
public class ConfirmPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try 
		{
			
			UserDAO userdao=new UserDAO();
			User user =new User();
			user.setPassword(request.getParameter("pass1"));
			user.setUsername(request.getParameter("username"));
			
			
			userdao.updateUserPassword(user);
			
			response.setContentType("text/plain");
			response.getWriter().write("{}");
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		
	}

}
