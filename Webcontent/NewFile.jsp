<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    if(request.getParameter("sub_btn")!=null)
    {
    	System.out.print(" sn");
    	String fe="";
    	
    
    		if(request.getParameter("vegstat")!=null)
    		fe+=request.getParameter("vegstat");
    		
    	
    	
    	out.print(fe);
    }



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form method="post">
<input type="checkbox"  id="f1"name="vegstat" value=ji>
 <label for="f1">fe</label><br>
 <input type="checkbox"  id="f2"name="vegstat" value=ki>
 <label for="f2">jjj</label><br>
<button name="sub_btn" type="submit">submit</button>

</form>
<script>document.getElementById()</script>
</body>
</html>