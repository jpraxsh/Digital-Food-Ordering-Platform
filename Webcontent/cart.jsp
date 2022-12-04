<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%String user_id = String.valueOf(session.getAttribute("login"));
if(session.getAttribute("login")==null)
{
response.sendRedirect("login.jsp");	
}
else{
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/adp_project","root","4362"); //create connection
PreparedStatement checkcart=null;
checkcart=con.prepareStatement("SELECT * from cart_details WHERE user_email=?");
checkcart.setString(1,user_id);
ResultSet rs=checkcart.executeQuery();
if(!rs.next())
{
	RequestDispatcher rd=request.getRequestDispatcher("emptycart.jsp");  
	rd.forward(request, response);//method may be include or forward      
}
//updating cart
String fooname, quan;
fooname=request.getParameter("fooname"); 
quan=request.getParameter("quan");
if(fooname!=null&&quan!=null)
{
	System.out.print(quan);
	System.out.print(fooname);
	System.out.print(user_id);
	try{
	
    if(Integer.parseInt(quan)==0){
    	
    	PreparedStatement clearcart=null;	
    	clearcart=con.prepareStatement("DELETE from cart_details WHERE user_email=? AND food_name=?");
    	clearcart.setString(1,user_id);
    	clearcart.setString(2,fooname);
    	clearcart.executeUpdate();
    	
    }
	
	
	PreparedStatement pstmti=null;
	pstmti=con.prepareStatement("UPDATE cart_details SET quantity=? WHERE user_email = ? AND food_name=? ;");
	pstmti.setInt(1,Integer.parseInt(quan));
	pstmti.setString(2,user_id);
	pstmti.setString(3,fooname);
	pstmti.executeUpdate();
	con.close();

}catch(Exception e)
{
	e.printStackTrace();
}

}}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-2.2.4.js" charset="utf-8"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="cart.css">


<title>Cart</title>
</head>
<body>
       <header>
        <ul>
           <img src="home_images/logo.png" height="50px" alt="Logo">
           <li><a class="active"href="#news">Cart</a></li>
          <li><a href="foodorder.jsp">Food Order</a></li>
          <li><a href="logout.jsp">Logout</a></li>
          <li><a href="home.jsp">Home</a></li>
        </ul>
        </header>

<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/adp_project" user="root" password="4362" />
<sql:query var ="rs" dataSource="${db}" >select * from cart_details where user_email="<%=user_id %>" </sql:query>
   <script> var total=0; var sno=1;</script>
   <section class="one">
        <div class="container">
        <div class="table_class" style="overflow-x:auto;">
             <table id="table">
                <tr>
                    <th scope="col"> S no</th>
                    <th> Food name</th>
                    <th> Price</th>
                    <th> Quantity</th>
                    <th>Total</th>
                </tr>
   
   <c:forEach items="${rs.rows}" var="qn"> 
   <tr>
   <td><script> document.writeln(sno); sno++;</script></td>
   <td><c:out value="${qn.food_name}"> </c:out>          </td><!-- for food name -->
   <td>&#8377;<c:out value="${qn.price}"></c:out></td>          <!-- for  price -->
   <td>                                                  <!-- for quantity -->
        <div class="quantity">
        <p hidden><c:out value="${qn.food_name}"> </c:out></p>
            <button class="plus-btn" type="button" name="button">
            <i class='fas fa-plus'></i>
            </button>
                        <input type="text" name="name" size="1" value="<c:out value="${qn.quantity}"> </c:out>">
             <button class="minus-btn" type="button" name="button">
             <i class='fas fa-minus'></i>
             </button> 
         </div>
   </td>
   <td>&#8377;<c:out value="${qn.quantity*qn.price}"> </c:out></td>    <!-- for total -->
   <script> total +=${qn.quantity*qn.price};</script>
   </tr>
  </c:forEach>
   
   </table>
        </div>
        </div>

 <div class="col-lg-4 offset-lg-4">
        <div class="checkout">
            <ul>
                <li class="subtotal"> Subtotal
                    <span>&#8377;<script> document.writeln(total);</script></span>
                </li>
                <li class="cart-total">Total
                <span>&#8377;<script> document.writeln(total);</script></span>
                </li>
            </ul>
            <a href="checkout.jsp" class="proceed-btn"> Proceed to Checkout</a>
        </div>
    </div>

<script type="text/javascript" >

var request;
//on click of minus button in quantity
$('.minus-btn').on('click', function(e) {
	e.preventDefault();
	var $this = $(this);
	var $input = $this.closest('div').find('input');
	var name=$(this).closest('div').text();
	name=name.trim();
	console.log(name);
    
	var value = parseInt($input.val());

	if (value > 0) {
		value = value - 1;
		
	} else {
		value = 0;
	}
    var xhr=new XMLHttpRequest();
    xhr.open("GET","cart.jsp?fooname="+name+"&&quan="+value);
    xhr.send();
$input.val(value);
setTimeout(load,100);
});
//on click of plus button in quantity
$('.plus-btn').on('click', function(e) {
	
	e.preventDefault();
	var $this = $(this);
	var $input = $this.closest('div').find('input');
	var value = parseInt($input.val());
	var name=$(this).closest('div').text();
	name=name.trim();
	if (value < 100) {
		value = value + 1;
	} else {
		value =100;
	}
	 var xhr=new XMLHttpRequest();
	    xhr.open("GET","cart.jsp?fooname="+name+"&&quan="+value);
	    xhr.send();
	
	$input.val(value);
	setTimeout(load,100);
});
//for refresh the page
function load(){
	location.reload();
} 
</script>

</body>
</html>