package cloud.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import cloud.clouddb.DatabaseOperations;
import cloud.clouddb.cloud_account.Account;
import cloud.clouddb.cloud_account.AccountDAO;
import cloud.clouddb.cloud_user.User;
import cloud.clouddb.cloud_user.UserDAO;
import cloud.clouddb.cloud_user.UserDB;

/**
 * Servlet implementation class CreateDatabaseServlet
 */
@WebServlet("/CreateDatabaseServlet")
public class CreateDatabaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateDatabaseServlet() {
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
			
			DatabaseOperations dboperations = new DatabaseOperations();
			UserDAO userdao =new UserDAO();
			User user = new User();
			user = userdao.getUser(request.getParameter("username1"), user);
			Collection<UserDB> userdb_col = new ArrayList<UserDB>();
			
			AccountDAO accountDAO = new AccountDAO();
			
			double curBalance = accountDAO.getBalanceById(user.getId());
			
			if(curBalance >= 40){
				String dbname=request.getParameter("username1")+"_"+request.getParameter("dbInput");
				if(dboperations.checkDbNameExist(dbname)){
					String trueJson = "{\"status\":\"false\"}";
					response.setContentType("text/plain");
					response.getWriter().write(trueJson);
				}else{
					accountDAO.deductDia(40, user.getId());		
					
					//Create database
					dboperations.createDatabase(dbname, request.getParameter("username1"));
							
					//check whether user have a database user name or not
					if(dboperations.checkDbUserExist(request.getParameter("username1")))
					{
						//user exist
						//Assign the privileges of created database to user
						dboperations.assignPriviliges(dbname, request.getParameter("username1"));
						
						userdb_col = userdao.getdbCollection(user.getId());
					}
					else
					{
						//User not exist
						//Create database user then assign the privileges of created database to this user
						dboperations.createUser(request.getParameter("username1"));
						dboperations.assignPriviliges(dbname, request.getParameter("username1"));
						
						user = userdao.getUser(request.getParameter("username1"), user);
						userdb_col = userdao.getdbCollection(user.getId());
					}
					
					double newBalance = accountDAO.getBalanceById(user.getId());
					//Return created database name
					String passparam="{\"status\":\"true\", \"newBalance\":\""+newBalance+"\",\"dbname\":"+"\""+dbname+"\"}";
					response.setContentType("text/plain");
					response.getWriter().write(passparam);
					
				}
			}else{
				
				String Json = "{\"status\":\"balance\"}";
				response.setContentType("text/plain");
				response.getWriter().write(Json);
			}
			
			//Arrange Database Name
			
			
			
			
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}

}
