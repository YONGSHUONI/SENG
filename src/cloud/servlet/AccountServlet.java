package cloud.servlet;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cloud.clouddb.cloud_account.AccountDAO;
import cloud.clouddb.cloud_user.User;
import cloud.clouddb.cloud_user.UserDAO;

/**
 * Servlet implementation class AccountServlet
 */
@WebServlet("/AccountServlet")
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true); 
		User user = (User)session.getAttribute("currentSessionUser");
		
		int diamond = Integer.valueOf(request.getParameter("chargeValue"));
		AccountDAO accountDAO = new AccountDAO();
		accountDAO.addDia(diamond, user);
		
		double newBalance = accountDAO.getBalanceById(user.getId());

		String json = Double.toString(newBalance);
		String jsonString = "{\"newBalance\":"+json+"}";
		
		response.setContentType("text/plain");
		response.getWriter().write(jsonString);
		
		
	}

}
