<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Apps Center</title>
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
		<h3>Apps Center</h3>
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
		
	</div>
</div>

<script type="text/javascript">
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
</script>

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