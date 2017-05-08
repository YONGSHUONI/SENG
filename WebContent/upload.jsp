<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="" />
		<link href="images/cloud.ico" rel="icon" type="image/x-icon">	
		<title>Upload Your Apps</title>
		<!-- css -->
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />	
		<link rel="stylesheet" type="text/css" href="css/iconfont.css">
		<!--css -->
		<!-- font -->
		<link href='http://fonts.googleapis.com/css?family=Josefin+Sans:400,100,100italic,300,300italic,400italic,600,600italic,700,700italic' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
		<script src="js/jquery.min.js"></script>
		<script src="js/file.js"></script>
		<%@ page import="cloud.clouddb.cloud_user.*" %>
		<%
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
		
<div class="upload" style="background: #e8e8e8;">
	<div class="container">
		<h2>Upload Apps</h2>
		<div class="col-md-8 col-md-offset-2 upload-Info">
			<form action="UploadServlet" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label>Apps Name :</label>
					<input type="text" class="text" name="AppsName" id="AppsName" placeholder="Apps Name" required>
				</li>
<%
			session = request.getSession();
			if (session.getAttribute("existAppName")!=null){
				String appName=(String)session.getAttribute("existAppName");
				session.removeAttribute("existAppName");
				out.println("<div><p style='margin-left:50px;'><strong>Warning!</strong> "+appName+" already exist.</p></div>");	
			}
			%>
				<li>
					<label>Price:</label>
					<input type="text" class="text" name="price" id="price" placeholder="Price of your app (per use, must be a number)" required>
				</li>
				<li>
					<label>Required API Service :</label>
					<input type="text" class="text" name="firstImportApp" id="firstImportApp" placeholder="Specify the App Name imported in your app (if any)">
				</li>
			<%		
				if (session.getAttribute("noFirstApp")!=null){
					String firstAppName=(String)session.getAttribute("noFirstApp");
					session.removeAttribute("noFirstApp");
					out.println("<div><p style='margin-left:50px;'><strong>Warning!</strong> "+firstAppName+" do not exist.</p></div>");	
				}
			%>
				<li>
				<label></label>
					<input type="text" class="text" name="secondImportApp" id="secondImportApp" placeholder="App Name 2 (if any)">
				</li>
				<%		
			if (session.getAttribute("noSecondApp")!=null){
				String secondAppName=(String)session.getAttribute("noSecondApp");
				session.removeAttribute("noSecondApp");
				out.println("<div><p style='margin-left:50px;'><strong>Warning!</strong> "+secondAppName+" do not exist.</p></div>");	
			}
			%>
				<li>
				<label></label>
					<input type="text" class="text" name="thirdImportApp" id="thirdImportApp" placeholder="App Name 3 (if any)">
				</li>
				<%		
			if (session.getAttribute("noThirdApp")!=null){
				String thirdAppName=(String)session.getAttribute("noThirdApp");
				session.removeAttribute("noThirdApp");
				out.println("<div><p style='margin-left:50px;'><strong>Warning!</strong> "+thirdAppName+" do not exist.</p></div>");	
			}
			%>
				<li>
					<label>Icon image :</label>
					<input type="file" name="icon_file" id="ipt-file" class="fileImg2">
					<label for="ipt-file" class="fileLabel" style="padding: 0; margin: 0; text-align: center; line-height: 38px; border: 2px solid #262c54;">Scan from local</label>
					<span class="ipt-input2" id="ipt-input"></span><!-- class="fileImg">
                    <label for="ipt-file" class="file-label" style="width:130px; padding: 0; background: url(images/add_image.png)">
                         <img src="images/add_image.png">
                    </label> -->
				</li>
				<li>
					<label>Applications :</label>
					<input type="file" name="app_file" id="ipt-file1" class="fileImg1">
					<label for="ipt-file1" class="fileLabel" style="padding: 0; margin: 0; text-align: center; line-height: 38px; border: 2px solid #262c54;">Scan from local</label>
					<span class="ipt-input2" id="ipt-input2"></span>
				</li>
				<li>
					<label>Description :</label>
					<textarea name="description" id="description" placeholder="Description"></textarea>
				</li>
			</ul>
				<div class="clearfix"></div>
				<input type="submit" class="submit_btn" value="Confirm Upload" <%if(login==false){out.println("disabled"); }%>>
			</form>
		</div>
		<div class="clearfix"></div>
	</div>
</div>	
<script type="text/javascript">
	/*upload image*/
	(function(){
		$.imageFileVisible({wrapSelector: ".file-label", fileSelector: "#ipt-file",width : '100%',height: '100%'});	
		$(document).on("click",".file-label>p",function(){
			$(this).parent().parent().empty().append("<li><label>User Image :</label><input type='file' name='icon_file' id='ipt-file' class='fileImg'><label for='ipt-file' class='file-label' style='width:130px; padding: 0;'><img src='images/add_image.png'/></label></li>");
			return false;	
		});
	})();

	/*File type*/
	(function(){
		$(document).on("change","#ipt-file1",function(){
			
			var file_type = $(".upload-Info .fileImg1").val();
			var fileArr = new Array("jar","war","JAR","WAR");
			var newFileName = file_type.split('.');
			newFileName = newFileName[newFileName.length-1];	
			if( newFileName==fileArr[0] || newFileName==fileArr[1] || newFileName==fileArr[2] || newFileName==fileArr[3] ){
				console.log($(".upload-Info .fileImg1").val());
				$("#ipt-input2").html($('.upload-Info .fileImg1').val());
			}else{
				$(".upload-Info .fileImg1").val('');
				alert("The file type must be .jar or .war.");
				return false;
			}
		});
	})();
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







