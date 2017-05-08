<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="" />
        <link href="images/cloud.ico" rel="icon" type="image/x-icon">   
        <title>Personal Page</title>
        <!-- css -->
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />  
        <link rel="stylesheet" type="text/css" href="css/iconfont.css">
        <!--css -->
        <!-- font -->
        <link href='http://fonts.googleapis.com/css?family=Josefin+Sans:400,100,100italic,300,300italic,400italic,600,600italic,700,700italic' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script src="js/file.js"></script>
        
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
	 String firstname = "";
	 String lastname = "";
	 String Email = "";
	 int role = 0;
	 String rolename = "";
	 session = request.getSession();
	 if (session.getAttribute("currentSessionUser")!=null){
	 	a = (User)session.getAttribute("currentSessionUser");
	 	login = true;
	 	username = a.getUsername();
	 	firstname = a.getForename();
	 	lastname = a.getSurname();
	 	Email = a.getEmail();
	 	role =a.getRole_id();
	 }
	 if(role==1)
	 {
		 rolename = "User";	 
	 }
	 else if (role == 2)
	 {
		 rolename = "Developer";
	 }
	 AppDAO dao = new AppDAO();
	 Collection<App> allApps  = dao.getAllApps();
	 
	 
	 UserDAO ud = new UserDAO();
	 Collection<UserDB> db_collection = ud.getdbCollection(a.getId());

%>

<% 
	//session = request.getSession(); 
	//Collection<App> allApps = (ArrayList<App>)session.getAttribute("allApps");
%>
<%@ page import="cloud.clouddb.cloud_account.*" %>
<% double balance = 0;
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
			<h2>Personal Page</h2>
			<div class="col-md-8 upload-Info" style="border-right: 1px dashed #262c54;">
				<ul>
                    <li>
                        <label>User Image :</label>
                        <!-- <input type="file" name="file" id="ipt-file" class="fileImg"> -->
                        <label for="ipt-file" class="file-label" style="width:130px; padding: 0;">
                            <img src=<%if(login==true){
                            	out.println("'"+a.getUser_icon()+"'");
                            	}else{
                            		out.println("'images/add_image.png'");
                            	}
                            	%>>
                            
                        </label>
                    </li>
					<li>
						<label>Username :</label>
						<input type='text' value='<%=username %>' id='username' class="text" readonly="readonly" />
					</li>	
					<li>
						<label>First Name :</label>
						<input type='text' value='<%=firstname %>' id='firstName' class="text" />
					</li>
					<li>
						<label>Last Name :</label>
						<input type='text' value='<%=lastname %>' id='lastName' class="text" />
					</li>
					<li>
						<label>E-mail :</label>
						<input type='text' value='<%=Email %>' id='email' class="text" />
						
					</li>	
					<input type="button" class="submit_btn" value="Update" id="save-btn" style="margin-right: 10px;">
					<!--<input type="button" class="submit_btn" value="Reset" style="margin-right: 10px;" id="reset-btn">-->
				</ul>
			</div>
			<div class="col-md-4">
				<ul id="existingDB" class="existingDB" >
                    
                    <label style="font-weight:bold;">Existing Databases for you : </label><br><br>
                    
                    	<% 
                    		if(db_collection!=null){
	                    		Iterator<UserDB> it = db_collection.iterator();
	                    		while(it.hasNext())
	                    		{
	                    			UserDB userdb = it.next();
	                    			
	                    			out.println("<li><label>"+userdb.getDbName()+"</label></li>");
	                    
	                    		} 
	                    		 
                    		}
                    		                 		
                    	%>      	
                </ul>
			</div>
			<div class="col-md-4">
				<ul class="existingDB" >       
					<br><li><a href="databaseGuide.html" target="_blank"><label style='font-weight:bold; text-decoration: underline;'>View database guide</label></a></li><br>           	
               </ul>
			</div>
			
			
			
            <div class="col-md-4">
                <input type="button" id="modal-644307" href="#modal-container-644307" data-toggle="modal" value="Create a database" class="apply-btn">
                    <div class="modal fade" id="modal-container-644307" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog" id="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <i class="iconfont icon-tishi"></i>
                                    <span style="line-height: 40px;">
                                        Do you confirm to create a database on this platform?<br>
                                    </span>
                                    <span style="line-height: 40px; padding-left: 20px;">
                                        If yes, you will pay 40 diamonds for your app's database.
                                    </span>
                                </div>
                                <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
                                     <input type="button" class="btn btn-primary" data-dismiss="modal" value="Continue" id="continue-btn">
                                </div>
                            </div>
                        </div> 
                    </div>
                    
                    <div id="dbName" class="dbName">
                        <ul>
                            <li>
                                <label>Database Name :</label><br>
                                <label class="username" id="getUsername"></label>
                                <span>_</span>
                                <input type="text" name="db1" id="db1" class="db1">
                            </li>
                            <li>
                                <input type="button" name="newDb" id="newDb" value="submit" class="newDb">
                            </li>
                        </ul>
                    </div>
            </div>
      
		</div>
	</div>
    <script type="text/javascript">
    /*upload image*/
    (function(){
        $.imageFileVisible({wrapSelector: ".file-label", fileSelector: "#ipt-file",width : '100%',height: '100%'});    
        $(document).on("click",".file-label>p",function(){
            $(this).parent().parent().empty().append("<li><label>User Image :</label><input class='fileImg' id='ipt-file' type='file'/><label for='ipt-file' class='file-label' style='width:130px; padding: 0;'><img src='images/add_image.png'/></label></li>");
            return false;   
        });
    })();

    $("#save-btn").click(function(){
     //   var userImg = $("#ipt-file").val();
        var username = $("#username").val();
        var userrole = $("#userrole").val();
        var firstName = $("#firstName").val();
        var lastName = $("#lastName").val();
        var email = $("#email").val();

        var update = {
            //userImg : userImg,
            username : username,
            userrole : userrole,
            firstName : firstName,
            lastName : lastName,
            email : email,
        };
        console.log(update);
        $.ajax({
            type : "POST",
            url : "http://143.167.9.237:8080/SENG/UpdatePersonalInfoServlet",
            data : update,
            success : function(){
                alert("Your information has been updated successfully!")
                window.location.href = 'userpage.jsp';
            }
        })
    });
    
    $("#continue-btn").click(function(){
        var div = $("#dbName");
        div.show();
        document.getElementById('getUsername').innerHTML = document.getElementById('curUsername').innerHTML;
    });
    $("#newDb").click(function(){
        var div1 = $("#showDb");
        var div2 = $("#dbName");
        
          var username1 = document.getElementById('curUsername').innerHTML;
          
          var dbInput = $("#db1").val();
          var dbData = {
            username1 : username1,
            dbInput : dbInput
          };
          console.log(dbData);
          $.ajax({
            url : 'http://143.167.9.237:8080/SENG/CreateDatabaseServlet',
            data : dbData,
            type : 'post',
            //dataType : 'json',
            success : function(data){
                /* div2.show(); */
              
                var json = JSON.parse(data);
                if(json.status=="true"){
                	var db = json.dbname;
               		$("#existingDB").append("<li><label>"+db+"</label></li>");
               		document.getElementById("balance").innerHTML = json.newBalance;
                }else if(json.status=="false"){
                	alert("Database name existed!");
                }else if(json.status=="balance"){
                	alert("Insufficient balance");
                }
            },
            error : function(){
                alert("Applying for database is fail.");
            }
          })
    })

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
