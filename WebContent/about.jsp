<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>About</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<link href="images/cloud.ico" rel="icon" type="image/x-icon">
<!-- css -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />	
<link rel="stylesheet" type="text/css" href="css/iconfont.css">
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
 						<li class="hover-effect dropdown"><%if (login==true){
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

<!-- team -->
	<div class="team-w3layouts">
		<div class="container">
			<h3>Our Team</h3>
			<div class="w3l_team_grids-agile">
				<div class="col-md-3 w3l_team_grid">
					<div class="view view-second">
						<img src="images/team01.jpg" alt=" " class="img-responsive" />
						<div class="mask"></div>
						<div class="content">
							<div class="w3l_social_icons w3l_social_icons1">
								<ul>
									<li><a href="#" class="linkedin"></a></li>
									<li><a href="#" class="google"></a></li>
									<li><a href="#" class="twitter"></a></li>
									<li><a href="#" class="facebook"></a></li>
								</ul>
							</div>
							<p>What is broken can be reforged!</p>
						</div>
					</div>
					<h4 style="color: #262c54;">Yongshuo Ni</h4>
					<p>Handsome Programmer</p>
				</div>
				<div class="col-md-3 w3l_team_grid">
					<div class="view view-second">
						<img src="images/team02.jpg" alt=" " class="img-responsive" />
						<div class="mask"></div>
						<div class="content">
							<div class="w3l_social_icons w3l_social_icons1">
								<ul>
									<li><a href="#" class="linkedin"></a></li>
									<li><a href="#" class="google"></a></li>
									<li><a href="#" class="twitter"></a></li>
									<li><a href="#" class="facebook"></a></li>
								</ul>
							</div>
							<p>What is broken can be reforged!</p>
						</div>
					</div>
					<h4 style="color: #262c54;">Sefa Akca</h4>
					<p>Programmer</p>
				</div>
				<div class="col-md-3 w3l_team_grid">
					<div class="view view-second">
						<img src="images/team03.jpg" alt=" " class="img-responsive" />
						<div class="mask"></div>
						<div class="content">
							<div class="w3l_social_icons w3l_social_icons1">
								<ul>
									<li><a href="#" class="linkedin"></a></li>
									<li><a href="#" class="google"></a></li>
									<li><a href="#" class="twitter"></a></li>
									<li><a href="#" class="facebook"></a></li>
								</ul>
							</div>
							<p>What is broken can be reforged!</p>
						</div>
					</div>
					<h4 style="color: #262c54;">Xiaoxiao Wang</h4>
					<p>Programmer</p>
				</div>
				<div class="col-md-3 w3l_team_grid">
					<div class="view view-second">
						<img src="images/team04.jpg" alt=" " class="img-responsive" />
						<div class="mask"></div>
						<div class="content">
							<div class="w3l_social_icons w3l_social_icons1">
								<ul>
									<li><a href="#" class="linkedin"></a></li>
									<li><a href="#" class="google"></a></li>
									<li><a href="#" class="twitter"></a></li>
									<li><a href="#" class="facebook"></a></li>
								</ul>
							</div>
							<p>What is broken can be reforged!</p>
						</div>
					</div>
					<h4 style="color: #262c54;">Shou Zhou</h4>
					<p>Programmer</p>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
<!-- //team -->

<!-- About -->
	<div class="about-Info">
			<div class="about-grids-agileits-w3layouts">
				<div class="col-md-4 col-sm-4 about-left">
					
				</div>
				<div class="col-md-8 col-sm-8 about-right">
					<div class="col-md-4 col-sm-4 about-grid about-text about-grid-1">
						<img src="images/c1.png" alt="">
						<h3>Relaxation</h3>
						<p>In trending applications, you will find relaxed after hard-working.</p>
					</div>
					<div class="col-md-4 col-sm-4 about-grid about-image about-grid-2">
						
					</div>
					<div class="col-md-4 col-sm-4 about-grid about-text about-grid-3">
						<img src="images/c2.png" alt="" />
						<h3>Education</h3>
						<p>It is a good place to help you for learning.</p>
					</div>
					<div class="col-md-4 col-sm-4 about-grid about-image about-grid-4">
						
					</div>
					<div class="col-md-4 col-sm-4 about-grid about-text about-grid-5">
						<img src="images/c3.png" alt="" />
						<h3>Social</h3>
						<p>You can find some common favourite hobbies' friend on this platform.</p>
					</div>
					<div class="col-md-4 col-sm-4 about-grid about-image about-grid-6">
					
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
	</div>
<!-- About -->

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