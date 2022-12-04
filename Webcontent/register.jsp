<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import="java.io.IOException" %> 
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/adp_project","root","4362"); //create connection
	
//registration	
 String email="";
if(request.getParameter("btn_register")!=null)
{
   	System.out.print("kai");
	 email=request.getParameter("mail");
	 PreparedStatement st=null;
	 st=con.prepareStatement("select * from user_details where email=?"); //sql select query 
	 st.setString(1,email);
	 ResultSet rs=st.executeQuery();

	 if(rs.next()) //if email id already exist
	 {
	 	request.setAttribute("err","This mail id already exists...! ");
	 }
	 
	else{
		String name,con_no,pass_word;
		name=request.getParameter("name"); 
		con_no=request.getParameter("con_no"); 
		pass_word=request.getParameter("password");
        
            PreparedStatement pstmti=null;
			
			pstmti=con.prepareStatement("insert into user_details values(?,?,?,?)");
			pstmti.setString(1,email);
			pstmti.setString(2,pass_word);
			pstmti.setString(3,name);
			pstmti.setString(4,con_no);
	        
			
			pstmti.executeUpdate(); //execute query
			
			request.setAttribute("successMsg","Register Successfully...! Please login"); //register success messeage
			
			    String to = email;
			    String from = "mandarinorientaladp@gmail.com";
			    final String username="mandarinorientaladp@gmail.com";
			    final String password="14072003jp";
			    String msg="Dear "+name+",Thank you for registering in our restaurant! Welcome to Mandarin Oriental, where no silver spoons are required for good food! Please have a look at our menu and choose your taste! We also have take-outs available. For more details, visit our website.Please do not reply to this automatically generated email. For enquires please contact support@mandarinorientaladp.com ";
			    
			    
			    String host="smtp.gmail.com";
			    Properties props = new Properties();
			    props.put("mail.smtp.auth","true");
			    props.put("mail.smtp.starttls.enable","true");
			    props.put("mail.smtp.host",host);
			    props.put("mail.smtp.port","587");
			    
			    
			    Session session1=Session.getInstance(props,new javax.mail.Authenticator()
			    		{
			    	protected PasswordAuthentication getPasswordAuthentication(){
			    		return new PasswordAuthentication(username,password);
			    	}
			    });
			    try{
			    	
			    	Message message = new MimeMessage(session1);
			    	message.setFrom(new InternetAddress(from));
			    	message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
			    	message.setSubject("Registration");
			    	message.setText(msg);
			    	Transport.send(message);
			   } catch (MessagingException e){
				   throw new RuntimeException(e);
			   }
			 }

			con.close(); 
			
		}

}
catch(Exception e)
{
	out.println(e);
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Registration</title>
<link rel="stylesheet" href="register.css">
</head>
<body>

  <div class="full-page">
            <div class="form-box">
                <div class='button-box'>
                    <div id='btn'></div>
                    
                    <button type='button'onclick='register()'class='toggle-btn'>Register</button>
                </div>
                <form  id="register" method="post" onsubmit="return validation();">
    <%
      if(request.getAttribute("err")!=null)
		{
			out.println(request.getAttribute("err")); //error message for email or password 
		}
  if(request.getAttribute("successMsg")!=null)
	{
		out.println(request.getAttribute("successMsg")); //error message for email or password 
	}
%>          
    
              
    <input type='email'class='input-field' placeholder='Email Id' name="mail" id="email_id">
	<span id="msg_1" class="js-hidden">*Enter a valid email</span>
    <input type='text'class='input-field'placeholder='Name' name="name" id="name">
	<span id="msg_3" class="js-hidden">*Name must contain alphabets only!!!</span>
    <input type="text"  class='input-field'placeholder='Contact No '  name="con_no" id="con_no" >
	<span id="msg_2" class="js-hidden">*Enter a valid phone number</span>
    <input type='password'class='input-field'placeholder='Enter Password' name="password" id="password" >
    <input type='password'class='input-field'placeholder='Confirm Password' name="con_pass" id="con_pass">
	<span id="msg_4" class="js-hidden">*password not matching with confirm password</span>
    <input type='checkbox'class='check-box'>I agree to the terms and conditions
    <input type='submit'class='submit-btn' value="Register" name="btn_register" >
    <a href="login.jsp">Already a user.!login</a>
    </form>
	</div>
    </div>

<script>
let mail =document.getElementById("email_id");
let name = document.getElementById("name");
let conno = document.getElementById("con_no");
let pw = document.getElementById("password");
let pw1 =document.getElementById("con_pass");
let msg = document.getElementById("msg_1");
let msg2 = document.getElementById("msg_2");
let msg3 = document.getElementById("msg_3");
let msg4 = document.getElementById("msg_4");

let name_ = /^[a-z A-Z]+$/;
let email=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
let contno =/^[0-9]{10}$/;
    
const mailVerify = (input, msg) => {
	let a = email.test(input.value);
	if(!a){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}

const conVerify = (input, msg) => {
	let a = contno.test(input.value);
	if(!a){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}

const nameVerify = (input, msg) => {
	let a = name_.test(input.value);
	if(!a){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}
const passVerify = (input, input2, msg) => {
	if(input!=input2){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}
  
mail.addEventListener("input",() => {
	mailVerify(mail, msg);
})
conno.addEventListener("input",() => {
	conVerify(conno, msg2);
})
name.addEventListener("input",() => {
	nameVerify(name, msg3);
})
pw1.addEventListener("input", () => {
	passVerify(pw1.value, pw.value, msg4);
})


</script>
</body>
</html>