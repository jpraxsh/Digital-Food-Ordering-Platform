<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<% 
if(session.getAttribute("login")==null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("login.jsp");
}


String user_id = String.valueOf(session.getAttribute("login"));

String fooname, price;
int q=0,qn=1;
fooname=request.getParameter("fooname"); 
price=request.getParameter("quan");
if(fooname!=null&&price!=null)
{
	System.out.print(fooname);
	System.out.print(price);
	try{
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/adp_project","root","4362"); //create connection
    	PreparedStatement checkcart=null;	
    	checkcart=con.prepareStatement("SELECT * FROM cart_details WHERE user_email=? AND food_name=?");
    	checkcart.setString(1,user_id);
    	checkcart.setString(2,fooname);
        ResultSet rs=checkcart.executeQuery();
    	if(rs.next()){
    		System.out.print("in rs if");
    		q=rs.getInt("quantity");
    		q++;

    		PreparedStatement pstmti=null;
    		pstmti=con.prepareStatement("UPDATE cart_details SET quantity=? WHERE user_email = ? AND food_name=?");
    		pstmti.setInt(1,q);
    		pstmti.setString(2,user_id);
    		pstmti.setString(3,fooname);
    		pstmti.executeUpdate();
    	}
    	else{
    		System.out.print("in rs if else");
    		PreparedStatement addcart=null;
    		addcart=con.prepareStatement("INSERT INTO cart_details VALUES(?,?,?,?)");
    		addcart.setString(1,user_id);
    		addcart.setString(2,fooname);
    		addcart.setInt(3,qn);
    		addcart.setInt(4,Integer.parseInt(price));
    		addcart.executeUpdate();
    		
    	   }
    	con.close();
	}
	catch(Exception e)
		{
			out.println(e);
		}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Order</title>
    <link rel="stylesheet" href="foodorder.css">
    <script type="text/javascript" src="foodorder.js"></script>
    
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/adp_project" user="root" password="4362" />
<sql:query var ="rs1" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Non Veg Starters" </sql:query>
<sql:query var ="rs2" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Veg Starters" </sql:query>
<sql:query var ="rs3" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Soups" </sql:query>
<sql:query var ="rs4" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Biriyani" </sql:query>
<sql:query var ="rs5" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Rotis" </sql:query>
<sql:query var ="rs6" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Rice & Noodles" </sql:query>
<sql:query var ="rs7" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="curies" </sql:query>
<sql:query var ="rs8" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Dessert" </sql:query>
<sql:query var ="rs9" dataSource="${db}" >SELECT * FROM food_details WHERE subcategory="Drinks and Beverages" </sql:query>
  <header>
  
  <ul>
    <img src="home_images/logo.png" height="50px" alt="Logo">
    <li><a href="cart.jsp">Cart</a></li>
    <li><a class="active"href="#news">Food Order</a></li>
    <li><a href="logout.jsp">Logout</a></li>
    <li><a href="home.jsp">Home</a></li>
  </ul>
  </header>

<section class="one">
<div class="tab" onload="load()"> 
  <input type="text" id="mySearch" class="tablinks" onkeyup="myFunction()" placeholder="Search.." title="Type in a category">
  <ul id="myMenu">
  <li><button class="tablinks" onclick="openfood(event, 'nonveg_stat')" id="defaultOpen"><img src="food_images/non-veg starters.png" style="width:30px;height:30px"> Non Veg Starters</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'vegstat')"><img src="food_images/veg-food.png" style="width:30px;height:30px">Veg starters</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Soup')"><img src="food_images/soup.png" style="width:30px;height:30px">Soup</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Briyani')"><img src="food_images/biryani.png" style="width:30px;height:30px">Briyani</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Rotis')"><img src="food_images/roti.png" style="width:30px;height:30px">Rotis</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Rice and Noodles')"><img src="food_images/noodles.png" style="width:30px;height:30px">Rice and Noodles</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Curies')"><img src="food_images/curries.png" style="width:30px;height:30px">Curies</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Dessert')"><img src="food_images/dessert.png" style="width:30px;height:30px">Desert</button></li>
  <li><button class="tablinks" onclick="openfood(event, 'Drinks and Beverages')"><img src="food_images/soft-drink.png" style="width:30px;height:30px">Drinks and Beverages</button></li>
</ul>
</div>
</section>

<div id="nonveg_stat" class="tabcontent">
  
  <div id="container">
    <c:forEach items="${rs1.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>
  </div>
</div>

<div id="vegstat" class="tabcontent">
  <div id="container">
          
    <c:forEach items="${rs2.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>
      
  </div>
</div>

<div id="Soup" class="tabcontent">
  <div id="container">
        <c:forEach items="${rs3.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach> 
  
      
  </div>
</div>

<div id="Briyani" class="tabcontent">
  <div id="container">
   <c:forEach items="${rs4.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>
      
  </div>
</div>

<div id="Rotis" class="tabcontent">
  <div id="container">
      <c:forEach items="${rs5.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>
  </div>
</div>

<div id="Rice and Noodles" class="tabcontent">
  <div id="container">
      <c:forEach items="${rs6.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>

  </div>
</div>

<div id="Curies" class="tabcontent">
  <div id="container">
        <c:forEach items="${rs7.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>

  </div>
</div>

<div id="Dessert" class="tabcontent">
  <div id="container">
        <c:forEach items="${rs8.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>
  </div>
</div>

<div id="Drinks and Beverages" class="tabcontent">
  <div id="container">
        <c:forEach items="${rs9.rows}" var="qn">
      <div class="prod">
          <img width="180" height="180" border="1px" src='<c:out value="${qn.isrc}"/>'>
          <p class="v_n">
              <c:out value="${qn.fname}"  />
              <c:if test="${qn.type=='nonveg'}"><img width="20px" height="20px" src="food_images/nonveg.jpg"></c:if>
              <c:if test="${qn.type=='veg'}"><img width="20px" height="20px" src="food_images/veg.jpg"></c:if>
            </p>
             &#8377;<c:out value="${qn.price}"  />
             <div><p hidden><c:out value="${qn.price}"  /></p>         
             <input type="hidden" value='<c:out value="${qn.fname}"/>'>
             <p class="jamesdond">    
             <button class="jamesbond" name="add_cart">
             <img src="food_images/add-to-cart.png" width="30px" height="30px" >
             </button>
              </p></div> </div>
    </c:forEach>

  </div>
</div>

    <script type="text/javascript"> document.getElementById("defaultOpen").click();</script>
<script src="https://code.jquery.com/jquery-2.2.4.js" charset="utf-8"></script>
<script>

$('.jamesbond').on('click', function(e) 
        {
                     e.preventDefault();
                     var $this = $(this);
                 	var $input = $this.closest('div').find('input');
                 	var name = $input.val();
                    var value=$(this).closest('div').text();
                    value=parseInt(value);
                    var cart=new XMLHttpRequest();
                    cart.open("GET","foodorder.jsp?fooname="+name+"&&quan="+value);
                    cart.send();
                    console.log(name,value);
                    
                       
                       
	         });


</script>
</body>
</html>