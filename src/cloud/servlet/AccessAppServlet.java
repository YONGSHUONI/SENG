package cloud.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cloud.clouddb.cloud_account.*;
import cloud.clouddb.cloud_app.*;
import cloud.clouddb.cloud_user.*;

/**
 * Servlet implementation class AccessAppServlet
 */
@WebServlet("/AccessAppServlet")
public class AccessAppServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AccessAppServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		int userId = Integer.valueOf(request.getParameter("userId"));
		int curAppId = Integer.valueOf(request.getParameter("curAppId"));
		
		AppDAO ad = new AppDAO();
		App curApp = new App();
		ad.getApp(curAppId,curApp);
		
		AccountDAO acd = new AccountDAO();
		double userBalance = acd.getBalanceById(userId);
		double appPrice = curApp.getPrice();
		
		if(userBalance<appPrice){
			String falseJson = "{\"status\":\"false\"}";
			response.setContentType("text/plain");
			response.getWriter().write(falseJson);	
			
		}else{
			int developerId = curApp.getDeveloper_id();
			String url = curApp.getUrl();
			int num, firstApiDeveloperId, secondApiDeveloperId, thirdApiDeveloperId;
			double developerCharge, firstAPICharge,secondAPICharge,thirdAPICharge;
			if(!curApp.getFirstImportApp().equals("")){
				firstApiDeveloperId = ad.getDeveloperIdByAppName(curApp.getFirstImportApp());
				if(!curApp.getSecondImportApp().equals("")){
					secondApiDeveloperId = ad.getDeveloperIdByAppName(curApp.getSecondImportApp());
					
					if(!curApp.getThirdImportApp().equals("")){
						thirdApiDeveloperId = ad.getDeveloperIdByAppName(curApp.getThirdImportApp());
						developerCharge = appPrice * 0.5;
						firstAPICharge = appPrice * 0.1;
						secondAPICharge = appPrice * 0.1;
						thirdAPICharge = appPrice * 0.1;
						
						acd.addDia(developerCharge, developerId);
						acd.addDia(firstAPICharge, firstApiDeveloperId);
						acd.addDia(secondAPICharge, secondApiDeveloperId);
						acd.addDia(thirdAPICharge, thirdApiDeveloperId);
						
						num=3;
					}else{
						developerCharge = appPrice * 0.6;
						firstAPICharge = appPrice * 0.1;
						secondAPICharge = appPrice * 0.1;
						
						acd.addDia(developerCharge, developerId);
						acd.addDia(firstAPICharge, firstApiDeveloperId);
						acd.addDia(secondAPICharge, secondApiDeveloperId);
						num=2;
					}
				}else{
					
					developerCharge = appPrice * 0.7;
					firstAPICharge = appPrice * 0.1;
					
					acd.addDia(developerCharge, developerId);
					acd.addDia(firstAPICharge, firstApiDeveloperId);
					num=1;
				}	
			}else{
				developerCharge = appPrice * 0.8;
				acd.addDia(developerCharge, developerId);
				num=0;
			}
			
			
			switch(num){
			case 0:
				
				break;
			case 1:
				
				break;
			case 2:
				break;
			case 3:
				break;
			}
			// platform charge
			double platformCharge = appPrice * 0.2;
			acd.addPlatformAccount(platformCharge);
			
			// charge user money
			ad.addUseTime(curApp.getApp_id());
			acd.deductDia(appPrice, userId);
			double curUserBalance = acd.getBalanceById(userId);
			
			String jsonString = "{\"status\":\"true\", \"newBalance\":\""+curUserBalance+"\", \"url\":\""+url+"\"}";
			response.setContentType("text/plain");
			response.getWriter().write(jsonString);
		

		}
		
	}

}
