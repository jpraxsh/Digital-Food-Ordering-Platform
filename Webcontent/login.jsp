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

%>    
<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("home.jsp");
}
%>

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/adp_project","root","4362"); //create connection
	//login
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		String dbemail,dbpassword,dbname;
		String email,password;
		
		email=request.getParameter("txt_email"); 
		password=request.getParameter("txt_password");
		
		PreparedStatement pstmt=null; 
		
		pstmt=con.prepareStatement("select * from user_details where email=? AND password=?"); //sql select query 
		pstmt.setString(1,email);
		pstmt.setString(2,password);
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbemail=rs.getString("email");
			dbpassword=rs.getString("password");
			dbname=rs.getString("name");
			if(email.equals(dbemail) && password.equals(dbpassword))
			{
				session.setAttribute("login",dbemail);
				session.setAttribute("dbname",dbname);//session name is login and store fetchable database email address
				response.sendRedirect("home.jsp"); //after login success redirect to welcome.jsp page
			}
		}
		else
		{
			request.setAttribute("errorMsg","invalid email or password"); //invalid error message for email or password wrong
		}
		
		con.close(); //close connection	
	}
	if(request.getParameter("forget_password")!=null)//forget password
	{
		 String email=request.getParameter("txt_email"); 
		 PreparedStatement pstmte=null; 
		 String pass_word="";
		 String name="";
		 
		 pstmte=con.prepareStatement("select * from user_details where email=?"); //sql select query 
		 pstmte.setString(1,email);

		 ResultSet rs=pstmte.executeQuery();
		 if(rs.next()){
			 request.setAttribute("pass_send","Your password has been sent to your mail id...!");
		 	pass_word = rs.getString(2);
		 	name = rs.getString(3);
		 	String msg="Hello "+name+"your password for restuarant login  is  "+pass_word;// msg info
		    String to = email;
		    String from = "mandarinorientaladp@gmail.com";
		    final String username ="mandarinorientaladp@gmail.com";
		    final String password="14072003jp";
		    
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
		    	
		    	Message message = new MimeMessage(session1);           //sending password through mail
		    	message.setFrom(new InternetAddress(from));
		    	message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
		    	message.setSubject("Testing Subject");
		    	message.setText(msg);
		    	Transport.send(message);
		   } catch (MessagingException e){
			   throw new RuntimeException(e);
		   }
		 }
		 else{
			 
			 request.setAttribute("forget","This email id is not registered......!");
		 }
}}
catch(Exception e)
{
	out.println(e);
}
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <link rel="stylesheet" href="style.css">
<title>login</title>
</head>
<body>
 <script type="text/javascript">
        function validation() {
        	
        	
        	var mail = document.getElementById("email").value;
        	if(mail == "") {  
        	     document.getElementById("message").innerHTML = "**Fill the email please!";  
        	     return false;
        	}
        }
        
        </script>
  <div class="full-page">
        
            <div class="form-box">
                <div class='button-box'>
                    <div id='btn'></div>
                    <button type='button'onclick='login()'class='toggle-btn'>Log In</button>
                    
                </div>
                
                <form id='login' class='input-group-login' method="post" onsubmit="validation()"> 
                <%
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for email or password 
					}
                if(request.getAttribute("forget")!=null)
				{
					out.println(request.getAttribute("forget")); //error message for email or password 
				}
                if(request.getAttribute("pass_send")!=null)
				{
					out.println(request.getAttribute("pass_send")); //error message for email or password 
				}
					%>
					<h1><span id = "message" style="color:red"> </span></h1> <br><br>
            <input type='text'class='input-field' placeholder='Email Id'  id="email" name="txt_email" >
		    <input type='password'class='input-field' placeholder='Enter Password' name="txt_password">
		    <button type='submit'class='submit-btn' name="btn_login">Log in</button>
		    <button type="submit" class="input-field" name="forget_password" >forget password</button>
		    <a href="register.jsp" class="submit-btn">New user? Create Account</a>
		    
		 </form>
		
            </div>
        </div>
       

</body>
</html>