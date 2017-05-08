package cloud.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cloud.clouddb.cloud_user.User;
import cloud.clouddb.cloud_user.UserDAO;

/**
 * Servlet implementation class UpdatePersonalInfoServlet
 */
@WebServlet("/UpdatePersonalInfoServlet")
public class UpdatePersonalInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePersonalInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			
			User user = new User();
			UserDAO userdao = new UserDAO();
			
			user.setUsername(request.getParameter("username"));
			user.setEmail(request.getParameter("email"));
			user.setForename(request.getParameter("firstName"));
			user.setSurname(request.getParameter("lastName"));

			user = userdao.updateUser(user);
			
			request.getSession().removeAttribute("currentSessionUser");
			request.getSession().setAttribute("currentSessionUser", user);
			
			//String passparam="{\"email\":"+"\""+dbname+"\""+"}";
			response.setContentType("text/plain");
			response.getWriter().write("{}");
			
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}

}
