<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>SENG API</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<link href="images/cloud.ico" rel="icon" type="image/x-icon">
<!-- css -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />	
<link href="css/iconfont.css" rel="stylesheet" type="text/css" >
<!-- css -->
<!-- font -->
<link href='http://fonts.googleapis.com/css?family=Josefin+Sans:400,100,100italic,300,300italic,400italic,600,600italic,700,700italic' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<!-- font -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<%@ page import="cloud.clouddb.cloud_user.*" %>
<%@ page import="cloud.clouddb.cloud_app.*, java.util.*" %>
<% 
	int ranNum=5; // for output application
	session = request.getSession(); 
	//User a = (User)session.getAttribute("currentSessionUser");
	//String username = a.getUsername();
	//sz code
	 boolean login = false;
	 User a = new User();
	 String username = "Login";
	 int userId = 0;
	 session = request.getSession();
	 if (session.getAttribute("currentSessionUser")!=null){
	 	a = (User)session.getAttribute("currentSessionUser");
	 	login = true;
	 	userId = a.getId();
	 	username = a.getUsername();
	 }
	 AppDAO dao = new AppDAO();
	 Collection<App> allApps  = dao.getAllApps();

%>
<% 
	//session = request.getSession(); 
	//Collection<App> allApps = (ArrayList<App>)session.getAttribute("allApps");
%>
<%@ page import="cloud.clouddb.cloud_account.*" %>
<% 
double balance = 0;
if (login==true){
	AccountDAO account = new AccountDAO();
	balance = account.getBalanceById(a.getId());
}
%>



</head>
<body style="background: #262c54;"> 
<!-- Header -->
<div class="sub-banner">
		<!-- Navbar -->
			<nav class="navbar navbar-default">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a  href="index.jsp"><h1>SENG</h1></a>
				</div>

				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="hover-effect"><a href="index.jsp">Home</a></li>
						<li class="hover-effect"><a href="apps.jsp">Apps Center</a></li>
						<li class="hover-effect"><a href="about.jsp">About</a></li>
						<li class="hover-effect"><a href="API.jsp">API</a></li>
						<li class="hover-effect"><%if (login==true){
							out.print("<a href='userpage.jsp' id='curUsername'>"+username+"</a>");
 							}else{
 								out.print("<a href='login.html'>"+username+"</a>");
 							}%>
 						</li>
 						<li class="dropdown"><%if (login==true){
                			out.print("<a href='#' class='dropdown-toggle' data-toggle='dropdown' style='background:transparent; color: #FFF;'>"
                			+"<i class='iconfont icon-diamond'></i><label style='padding-left: 5px;' id='balance'>"+balance+"<span class='caret'></span></label></a>");
			                out.print("<ul class='dropdown-menu' style='border: none;'>");
			                out.print("<li><a href='chargingBank.jsp'>Top Up</a></li>");    	
			                out.print("<li><a href='transaction.jsp'>View Transaction</a></li>");   	
			                out.print("</ul>");
 							}else{
 								out.print("<a href='login.html'>Diamonds</a>");
 							}%>
            			</li>
						<li class="hover-effect"><a href="login.html"><i class="iconfont icon-close"></i></a></li>
					</ul>
				</div>

			</div>
		</nav>
		</div>
<!-- Header -->

<div class="new-apps-grid" style="background: #e8e8e8;">
	<div class="container">
		<h3>SENG API</h3>
		<div class="col-md-10 col-md-offset-1">
			<table class="table table-hover">
					<thead>
						<tr>
							<th>
								Name
							</th>
							<th>
								Return Type
							</th>
							<th>
								Parameter
							</th>
							<th>
								Description
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								Get Platform User Information
							</td>
							<td>
							var username
							var userID
							</td>
							<td>
								<a href="http://143.167.9.237:8080/SENG/ApiDoc.html" target="_blank">For getting user info copy this script in your first page</a>
							</td>
							<td>
								The ajax function to get current username and userId. Copy the code inside your first html/jsp page, and be sure you have jquery.js file
							</td>
						</tr>
						<tr class="warning">
							<td>
								Server Link
							</td>
							<td>
								http://143.167.9.237:8080/SENG/YourApp
							</td>
							<td>
							</td>
							<td> 
								If the absolute path is needed in your project, notice your App is under SENG platform.
							</td>
						</tr>
						<tr>
							<td>
								getUsernameFromId()
							</td>
							<td>
								String username
							</td>
							<td>
								int userId
							</td>
							<td>
								This method takes the user id as an input and it returns user name as an output.
							</td>
						</tr>
						<tr class="warning">
							<td>
								getBalanceById()
							</td>
							<td>
								double balance 
							</td>
							<td>
								int userId
							</td>
							<td>
								This method takes the user id as an input and it returns user' balance as an output.
							</td>
						</tr>
						
			</table>
			
		</div>
		<div class="clearfix"></div>
		
	</div>
</div>

<!-- footer -->
<div class="footer">
	<div class="container">
		<div class="clearfix"></div>
		<div class="copyright" style="border-top: 1px dashed #FFF;" >
			<p style="color: #FFF;">Copyright &copy; 2017.Cloud Computing Team 02 All rights reserved.</p>
		</div>
	</div>
</div>
<!-- footer -->
</body>
</html>