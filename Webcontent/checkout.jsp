<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="java.io.IOException" %> 
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

    
    
<%String user_id =String.valueOf(session.getAttribute("login"));
try{
	
      //create connection
	if(request.getParameter("place_order")!=null)//check order button click event not null
	{

		Class.forName("com.mysql.jdbc.Driver"); //load driver
		
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/adp_project","root","4362");
		String name,con_no,pin,area,street,landmark,city,addresstype,pay_info,food_detail;
		food_detail=request.getParameter("orderdetail");
		name=request.getParameter("name");
		con_no=request.getParameter("con_no");
		pin=request.getParameter("pin");
		street=request.getParameter("flat");
		area=request.getParameter("area");
		landmark=request.getParameter("landmark");
		city=request.getParameter("town");
		addresstype=request.getParameter("addresstype");
		pay_info=request.getParameter("payment");
		
		System.out.print(name);
	
		
		
		PreparedStatement pstmti=null;
		
		pstmti=con.prepareStatement("insert into order_details (food_quantity, user_mail, name, mobilenumber, pin, flat, area, landmark, town, add_type, payment) values(?,?,?,?,?,?,?,?,?,?,?)");
		pstmti.setString(1,food_detail);
		pstmti.setString(2,user_id);
		pstmti.setString(3,name);
		pstmti.setString(4,con_no);
		pstmti.setString(5,pin);
		pstmti.setString(6,street);
		pstmti.setString(7,area);
		pstmti.setString(8,landmark);
		pstmti.setString(9,city);
		pstmti.setString(10,addresstype);
		pstmti.setString(11,pay_info);
		
		
		pstmti.executeUpdate();
		PreparedStatement pstmte=null;
		pstmte=con.prepareStatement("DELETE from cart_details where user_email=?"); //sql select query 
		pstmte.setString(1,user_id);
		
		
		
			con.close();
	        String to = user_id;
		    String from = "mandarinorientaladp@gmail.com";
		    final String username="mandarinorientaladp@gmail.com";
		    final String password="14072003jp";
		    String msg="Dear,"+name+" your order for  "+food_detail+"  is been placed.We will reach your food soon at your doorsteps." ;
		    
		    
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
		    	message.setSubject("Order Confirmation");
		    	message.setText(msg);
		    	Transport.send(message);
		   } catch (MessagingException e){
			   throw new RuntimeException(e);
		   }
		    RequestDispatcher rd=request.getRequestDispatcher("confirmorder.jsp");  
			rd.forward(request, response);
		 }
}
catch(Exception e)
{
	out.println(e);
}

%>
<!DOCTYPE html >
<head><script src="https://code.jquery.com/jquery-2.2.4.js" charset="utf-8"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">       
<link rel="stylesheet" href="checkout.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Checkout</title>

</head>
<body>
<table border="1">
<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/adp_project" user="root" password="4362" />
<sql:query var ="rs" dataSource="${db}" >select * from cart_details where user_email="<%=user_id %>" </sql:query>
  <header>
    <div class="navigation">
     <ul>
        <li><a href="foodorder.jsp">Food Order</a></li>
        <li><a href="cart.jsp">Cart</a></li>
        <li><a class="active">Checkout</a></li>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="home.jsp">Home</a></li>
    </ul>
    </div>
</header>
  <div class="box">
    <div class="row">
      <div class="col-lg-8">
        <div class="container">
          <form >
            <div class="row">

              <div class="col-lg-4">
                <h3>Billing Address</h3>
            <label><i class="fa fa-user"></i> Full name(First And Last name)</label>
            <input type="text" class="input_field" name="name" required>
            <label><i class="fa fa-mobile"></i> Mobile number</label>
            <input type="text" placeholder="10-digit mobile number without prefixes" class="input_field" name="con_no" required>
            <LABEL><i class="fa fa-address-book-o"></i> PIN CODE</LABEL>
            <INPUT type="text" class="input_field" placeholder="6 DIGIT PIN CODE" name="pin" required>
            <label><i class="fa fa-address-book"></i> Flat-House no</label>
            <input type="text" class="input_field" name="flat" required>
            <label>Area/Colony/street/village</label>
            <input type="text" class="input_field" name="area" required>
            <label>Landmark</label>
            <input type="text" class="input_field" name="landmark" required>
            <input type="hidden" id="ordset" name="orderdetail" required>
            <label><i class="fa fa-location-arrow"></i> Town/city</label>
            <input type="text" class="input_field" name="town" required>
            <label><i class="fa fa-home"></i> Address Type</label>
            <select name="addresstype" id="addresstype">
                     <option value="home">Home</option>
                     <option value="office">Office</option>
                     <option value="others">others</option>
            </select>
            </div>
              <div class="col-6">
                <h3>Payment</h3>
               
              <label><i class="fa fa-money"></i> Select Payment Method</label>
              <select name="payment" id="pay" class="input_field" onchange="myFunction()">
                <option value="cod">Cash on delivery</option>
                <option value="card">Card</option>
              </select>
              <div  id="ca_rd" class="js-hidden">
              <label for="fname">Accepted Cards</label>
                <div class="icon-container">
                  <i class="fa fa-cc-visa" style="color:navy;"></i>
                  <i class="fa fa-cc-amex" style="color:blue;"></i>
                  <i class="fa fa-cc-mastercard" style="color:red;"></i>
                  <i class="fa fa-cc-discover" style="color:orange;"></i>
                </div>
                <label for="cname">Name on Card</label>
                <input type="text" id="cname" name="cardname" placeholder="Varun">
                <label for="ccnum"><i class="fa-credit-card-alt"></i> Credit card number</label>
                <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
                <label for="expmonth">Exp Month</label>
                <input type="text" id="expmonth" name="expmonth" placeholder="September">
                <div class="row">
                  <div class="col-6">
                    <label for="expyear">Exp Year</label>
                    <input type="text" id="expyear" name="expyear" placeholder="2018">
                  </div>
                  <div class="col-6">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" placeholder="352">
                  </div>
                </div>
              </div>
              </div>
            </div>
            <label>
              <input type="checkbox" checked="checked" name="sameadr"> Shipping address same as billing
            </label>
            <input type="submit" value="Make Order" name="place_order"class="btn">
          </form>
        </div>
      </div>
      <div class="col-4">
        <div class="container">
          <h4>Cart <span class="price" style="color:black"><i class="fa fa-shopping-cart"></i> <b></b></span></h4>
          <script> var total=0; var sno=1;</script>
          <c:forEach items="${rs.rows}" var="qn">
          <c:set  var = "order" value="${order}${qn.food_name}-${qn.quantity}," />
          <p><c:out value="${qn.food_name}"/><span class="price"> &#8377;<c:out value="${qn.quantity*qn.price}"/></span></p>
          <script> total +=${qn.quantity*qn.price};</script>
          </c:forEach>
          <hr>
          
          <p>Total <span class="price" style="color:black"><b> &#x20B9 <script> var orderdetail="${order}";
          document.writeln(total);document.getElementById("ordset").value=orderdetail;</script></b></span></p>
        </div>
      </div>
    </div>
    </div>
    
    <script>

    function myFunction(){
            
            var cat=document.getElementById("pay");
            var f1=document.getElementById("ca_rd");
            switch(cat.value)
            {
              case "card":f1.classList.remove("js-hidden");
               break;
              case "cod":f1.classList.add("js-hidden");
                break;

            }
          }
          
</script>
  
  </body>
</html>