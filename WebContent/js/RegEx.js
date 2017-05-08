// JavaScript Document

//reminder info
function notice(id,text){
	$(id).html(text).animate({"color":"#262c54"},1800,function(){
		$(this).html("");
	});
};

var regEx = /^[^ ]{0,}$/; //If null or not

/*check the username*/
function checkUser(id,noticeId){
	var user = document.getElementById(id).value;
	if(!regEx.test(user)){
		notice(noticeId,"Reminder :The username cannot include space.");
		return false;
	}else if(user.length<1 || user.length>16){
		notice(noticeId,"Reminder :The length of username is from 1 to 16.");
		return false;
	}else{
		$.post("#",{userName:user},function(data){
				if(false){ 
					return false;
				}else{
					return true;	
				}
		})	
	}
	return true;
};

/*check password*/
function checkPwd(id,noticeId){
	var password = document.getElementById(id).value;
	if(!regEx.test(password)){
		notice(noticeId,"Reminder :The password cannot include space.");
		return false;
	}else if( password.length==0 )
	{
		notice(noticeId,"Reminder :The password cannot be null.");
		return false;
	}
	else if( password.length<6 || password.length>16  ) 
	{
		notice(noticeId,"Reminder :The length of password is from 6 to 16.");
		return false;
	}
	return true;
};

/*check repeat password*/
function repeatPwd(id1,id2,noticeId){
	var password1 = document.getElementById(id1).value;
	var password2 = document.getElementById(id2).value;
	if( !(password1 == password2) )
	{
		notice(noticeId,"Reminder :These two passwords are not the same.");
		return false;
	}
	return true;
};

/*FirstName*/
function checkFirst(id,noticeId){
	var firstName = document.getElementById(id).value;
	if(!regEx.test(firstName)){
		notice(noticeId,"Reminder :The FirstName cannot include space.");
		return false;
	}else if( firstName.length==0 )
	{
		notice(noticeId,"Reminder :The FirstName cannot be null.");
		return false;
	}
	else if( firstName.length<1 || firstName.length>16  ) 
	{
		notice(noticeId,"Reminder :The length of firstname is from 1 to 16.");
		return false;
	}
	return true;
};

/*LastName*/
function checkLast(id,noticeId){
	var LastName = document.getElementById(id).value;
	if(!regEx.test(LastName)){
		notice(noticeId,"Reminder :The LastName cannot include space.");
		return false;
	}else if( LastName.length==0 )
	{
		notice(noticeId,"Reminder :The LastName cannot be null.");
		return false;
	}
	else if( LastName.length<1 || LastName.length>16  ) 
	{
		notice(noticeId,"Reminder :The length of LastName is from 1 to 16.");
		return false;
	}
	return true;
};

//check email address
function checkEmail(id,noticeId){
	var myEmail = document.getElementById(id).value;
	//myEmail = myEmail.replace(/\s+/g,"");
	if( myEmail.length==0 )
	{
		notice(noticeId,"Reminder :The email cannot be null.");
	   	return false;
	}
	var re= /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if(!re.test(myEmail)){
		notice(noticeId,"Reminder :The format of email is wrong.");
	   	return false;
	}
	return true;
};

























