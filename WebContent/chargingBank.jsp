<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Charging Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<link href="images/cloud.ico" rel="icon" type="image/x-icon">
<!-- css -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
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
<div class="upload" style="background: #e8e8e8;">
	<div class="container">
		<div class="col-md-8 col-md-offset-2 charge-box">
			<div class="charge-box-top">
				<span class="title">Choose the amount of diamonds</span>
			</div>
			<div class="charge-box-remain">
				<span>The charging account is : <strong><label><%=username %></label></strong>.</span>
			</div>
				<!-- <form method="post" action="../AccountServlet"> -->
					<ul class="charge-ul">
						<li>
							<input type="checkbox" name="chk01" id="chk01" class="checkbox">
							<label for="chk01" value="10" class="label1">10 diamonds</label>
						</li>
						<li>
							<input type="checkbox" name="chk02" id="chk02" class="checkbox">
							<label for="chk02" value="20" class="label1">20 diamonds</label>
						</li>
						<li>
							<input type="checkbox" name="chk03" id="chk03" class="checkbox">
							<label for="chk03" value="30" class="label1">30 diamonds</label>
						</li>
						<li>
							<input type="checkbox" name="chk04" id="chk04" class="checkbox">
							<label for="chk04" value="50" class="label1">50 diamonds</label>
						</li>
						<li>
							<input type="checkbox" name="chk05" id="chk05" class="checkbox">
							<label for="chk05" value="100" class="label1">100 diamonds</label>
						</li>
						<div class="clearfix"></div>
						<input type="submit" name="submit_btn" value="submit" class="submit-btn" id = "submit">
						<a href="index.jsp"><input type="submit" name="submit_btn" value="back" class="submit-btn"></a>
					</ul>
				<!-- </form> -->
			
		</div>
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
<script type="text/javascript">
	 (function(){
		$(".charge-ul label").click(function(){	
			$('#chk01').attr("checked",false);
			$('#chk02').attr("checked",false);
			$('#chk03').attr("checked",false);
			$('#chk04').attr("checked",false);
			$('#chk05').attr("checked",false);
   			$(this).siblings("input").attr("checked",false);
   			$(this).addClass("on").parent().siblings().children("label").removeClass("on");
		});
	})(); 
	
	
	$("#submit").click(function(){
		
		var value = 0;
 		if($('#chk01').is(":checked")){
			value = 10;
		}else if($('#chk02').is(":checked")){
			value = 20;
		}else if($('#chk03').is(":checked")){
			value = 30;
		}else if($('#chk04').is(":checked")){
			value = 50;
		}else if($('#chk05').is(":checked")){
			value = 100;
		}
 		var chargeValue = {chargeValue:value};
 		
 		$.ajax({
			url : "http://143.167.9.237:8080/SENG/AccountServlet",   //*******************************************************************
			data : chargeValue,
			type: 'post',
			success : function(data){
				var newBalance = JSON.parse(data).newBalance;
				document.getElementById("balance").innerHTML = newBalance;			
			},
			error : function(result){
				alert("error");
				/* console.log(result); */
			}
		});
	})
	
	
	
	
	
</script>
</html>