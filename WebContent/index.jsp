<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Home Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<link href="images/cloud.ico" rel="icon" type="image/x-icon">
<!-- css -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen"/>
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />	
<link rel="stylesheet" type="text/css" href="css/iconfont.css">
<!--css -->
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
<body> 
<!-- Header -->
	<div class="header">
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
			                out.print("<ul class='dropdown-menu'>");
			                out.print("<li><a href='chargingBank.jsp'>Top Up</a></li>");    	
			                out.print("<li><a href='transaction.jsp'>View Transaction</a></li>");   	
			                out.print("</ul>");
 							}else{
 								out.print("<a href='login.html'>Diamonds</a>");
 							}%>
            			</li>
						
						<li class="hover-effect" ><a href="#"><i class="iconfont icon-close"  onclick="Logout()"></i></a></li>
					</ul>
				</div>

			</div>
		</nav>
		<!-- //Navbar -->

		<!-- Slider -->
		<div class="slider">
			<ul class="rslides" id="slider">
				<li>
					<img src="images/03.jpg" alt="" />
				</li>
				<li>
					<img src="images/02.jpg" alt="" />
				</li>
				<li>
					<img src="images/01.jpg" alt="" />
				</li>
			</ul>
		</div>
		<!-- Slider -->
	</div>
	<!-- Banner-Slider-JavaScript -->
	<script src="js/responsiveslides.min.js"></script>
	<script>
		$(function () {
			$("#slider").responsiveSlides({
				auto: true,
				nav: true,
				speed: 800,
				namespace: "callbacks",
				pager: true,
			});
		});
	</script>
	<!-- Banner-Slider-JavaScript -->
<!-- Header -->

<!-- trend -->
<div class="trend-apps">
	<div class="container">
		<h3>Trending Applications</h3>
		<div class="col-md-3 trend-apps-Info trend-apps-Info-top">
			<span class="glyphicon glyphicon-bell" aria-hidden="true"></span>
			<h4>DUE</h4>
			<p>Keep your DUE date in mind and record your work time every day.Help you never forget your assignment.</p>
			<% if(login==false){
				out.print("<a id='modal-661221' href='login.html' role='button'  data-toggle='modal'>Click Here</a>");
			}else{
				out.print("<a id='modal-661221' href='#modal-container-661224' role='button'  data-toggle='modal'>Click Here</a>");
			}
			%>
			<div class="modal fade" id="modal-container-661221" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						</div>
						<div class="modal-body">
							<i class="iconfont icon-tishi"></i>
							<span style="padding: 0 auto; line-height: 50px;">
								Do you confirm that you will pay <label>3</label> diamonds for this applications?
							</span>
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							 <input type="button" name="submit" id="51" value="continue" class="btn btn-default" onclick="accessApp()">
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		<div class="col-md-3 trend-apps-Info">
			<span class="glyphicon glyphicon-cloud-download" aria-hidden="true"></span>
			<h4>File Upload</h4>
			<p>This application is target to save files and play multimedia online.It is a good place for both study and relaxing.</p>
			<% if(login==false){
				out.print("<a id='modal-661222' href='login.html' role='button'  data-toggle='modal'>Click Here</a>");
			}else{
				out.print("<a id='modal-661222' href='#modal-container-661224' role='button'  data-toggle='modal'>Click Here</a>");
			}
			%>
			<div class="modal fade" id="modal-container-661222" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						</div>
						<div class="modal-body">
							<i class="iconfont icon-tishi"></i>
							<span style="padding: 0 auto; line-height: 50px;">
								Do you confirm that you will pay <label>1</label> diamonds for this applications?
							</span>
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							 <input type="button" name="submit" id="30" value="continue" class="btn btn-default" onclick="accessApp()">
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		<div class="col-md-3 trend-apps-Info trend-apps-Info-bottom">
			<span class="glyphicon glyphicon-education" aria-hidden="true"></span>
			<h4>Tandem Partner</h4>
			<p>This application offers you to learn a new language and international friend.Find best "MATE" for you here. </p>
			<% if(login==false){
				out.print("<a id='modal-661223' href='login.html' role='button'  data-toggle='modal'>Click Here</a>");
			}else{
				out.print("<a id='modal-661223' href='#modal-container-661224' role='button'  data-toggle='modal'>Click Here</a>");
			}
			%>
			<div class="modal fade" id="modal-container-661223" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						</div>
						<div class="modal-body">
							<i class="iconfont icon-tishi"></i>
							<span style="padding: 0 auto; line-height: 50px;">
								Do you confirm that you will pay <label>1</label> diamonds for this applications?
							</span>
						</div>
						<div class="modal-footer">
							 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							 <input type="button" name="submit" id="60" value="continue" class="btn btn-default" onclick="accessApp()">
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		<div class="col-md-3 trend-apps-Info trend-apps-Info-bottom">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
			<h4>MyCommands</h4>
			<p>A personal command line note Application for helping programmer making easier record and search.</p>
			<% if(login==false){
				out.print("<a id='modal-661224' href='login.html' role='button'  data-toggle='modal'>Click Here</a>");
			}else{
				out.print("<a id='modal-661224' href='#modal-container-661224' role='button'  data-toggle='modal'>Click Here</a>");
			}
			%>
			<div class="modal fade" id="modal-container-661224" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						</div>
						<div class="modal-body">
							<i class="iconfont icon-tishi"></i>
							<span style="padding: 0 auto; line-height: 50px;">
								Do you confirm that you will pay <label>1</label> diamonds for this applications?
							</span>
						</div>
						<div class="modal-footer">
		 					 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							 <input type="button" name="submit" id="61" value="continue" class="btn btn-default" onclick="accessApp()"> 
							 <!-- onclick="window.location.href = 'http://143.167.9.237:8080/MyCommands/'"> -->
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		<div class="clearfix"></div>
	</div>
</div>
<!-- trend -->

<!-- new apps -->
<div class="new-apps-grid">
	<div class="container">
		<div>
		<h3>New Applications</h3>
		<div style="clear: both;"></div>
		<button class="new-apps-button" onclick=<%if (login==false){
			out.print("\"javascript:window.location.href='login.html'\"");
		}else{
			out.print("\"javascript:window.location.href='upload.jsp'\"" );
		} %>>Add Your apps</button>
		</div>
		<div style="clear: both;"></div>
		
		<%
			/* int clickPosition=0; */
			Iterator<App> it=allApps.iterator();
			while(it.hasNext()){
				App curApp = it.next();
				out.println("<div class='col-md-3 new-grid-w3l view view-eighth' id='test'><div class='viewImg'>");
				out.println("<img src='"+curApp.getIconUrl()+"' alt=' '/>");
				out.println("<div class='span'>"+curApp.getApp_name()+"</div></div>");
				out.println("<a id='modal-66122"+ranNum+"' href='#modal-container-66122"+ranNum+"' role='button'  data-toggle='modal'>");
				out.println("<div class='mask'>");
				out.println("<h4>Click here</h4>");
				/* System.out.println(curApp.getUrl()); */
				out.println("<p>Please start to experience it</p>");
				out.println("<p>"+curApp.getApp_name()+"</p>");
				out.println("<p>use times: "+curApp.getUse_times()+"</p>");
				out.println("</div><a>");
				
				out.println("<div class='modal fade' id='modal-container-66122"+ranNum+"' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>");
				out.println("<div class='modal-dialog'>");
				out.println("<div class='modal-content'>");
				out.println("<div class='modal-header'>");
				out.println("<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>");
				out.println("</div>");
				out.println("<div class='modal-body'>");
				out.println("<i class='iconfont icon-tishi'></i>");
				out.println("<span style='padding: 0 auto; line-height: 50px;'>");
				out.println("Do you confirm that you will pay <label id='appPrice'>"+curApp.getPrice()+"</label> diamonds for this applications?");
				out.println("</span></div>");
				out.println("<div class='modal-footer'>");
				out.println(" <button type='button' class='btn btn-default' data-dismiss='modal'>Close</button>");
				if (login==false){
					out.print("<input type='button' name='submit' value='continue' class='btn btn-default' onclick=\"javascript:window.location.href='login.html'\" data-dismiss='modal'>");
				}else{
					out.println(" <input type='button' name='submit' id='"+curApp.getApp_id()+"' value='continue' class='btn btn-default' onclick='accessApp()' data-dismiss='modal'>");
				}
				out.println("</div></div></div></div></div>");
				
				/* clickPosition++; */
				ranNum++;
			}
		%>
				
		<div class="clearfix"></div>
		<a href="apps.jsp" class="more-click">More >></a>
	</div>
</div>

<script>
	function accessApp(){

		var curAppId = event.target.id;
		var userId = "<%=userId%>";
		var accessAppData = {curAppId : curAppId, userId : userId};
		
		$.ajax({
			url : "http://143.167.9.237:8080/SENG/AccessAppServlet",    //*******************************************************************
			/* url : "http://143.167.9.237:8080/CloudServer/AccessAppServlet", */
			data : accessAppData,
			type: 'post',
			success : function(data){
				var json = JSON.parse(data);
				if(json.status=="true"){
					var newBalance = json.newBalance;
					document.getElementById("balance").innerHTML = newBalance;
					window.open(json.url);
					//window.location.href = json.url;
				}else{
					alert("Insufficient balance");
				}

			},
			error : function(){
				alert("ajax error");
			}
		});
		
	}


	function Logout(){
		
		$.ajax({
			//url : "http://143.167.9.237:8080/SENG/LogoutServlet",    //*******************************************************************
			url : "http://143.167.9.237:8080/SENG/AccessAppServlet",
			data : {logout:""},
			type: 'post',
			success : function(data){
				window.location.href = "login.html";
			},
			error : function(){
				window.location.href = "login.html";
			}
		});
	}
</script>


<!-- new apps-->
<!-- footer -->
<div class="footer" style="padding-bottom:35px;">
	<div class="container">
		<div class="clearfix"></div>
		<div class="copyright">
			<p>Copyright &copy; 2017.Cloud Computing Team 02 All rights reserved.</p>
		</div>
	</div>
</div>
<!-- footer -->
</body>
</html>