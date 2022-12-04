<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%if(session.getAttribute("login")==null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("login.jsp");
}
%>
<%
String user_id =String.valueOf(session.getAttribute("login"));
try{
	
      //create connection
	if(request.getParameter("booking")!=null)//check order button click event not null
	{
        System.out.print("helo");
		Class.forName("com.mysql.jdbc.Driver"); //load driver
		
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/adp_project","root","4362");
		String event,date,music,seater,mem;
		event=request.getParameter("party");
		String f1=request.getParameter("nonveg_stat");
		String f2=request.getParameter("vegstat");
		String f3=request.getParameter("soup");
		String f4=request.getParameter("biriyani");
		String f5=request.getParameter("rotis");
		String f6=request.getParameter("ricenood");
		String f7=request.getParameter("cury");
		String f8=request.getParameter("desert");
		String f9=request.getParameter("drinks");
		date=request.getParameter("date");
		music=request.getParameter("music");
		
		mem=request.getParameter("mem");
		PreparedStatement pstmti=null;
		
		pstmti=con.prepareStatement("insert into party_details(event,date,non_veg_stat,veg_stat,soup,biriyani,roti,rice_noodles,curies,desert,drinks,music,no_members,mail) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		pstmti.setString(1,event);
		pstmti.setString(2,date);
		pstmti.setString(3,f1);
		pstmti.setString(4,f2);
		pstmti.setString(5,f3);
		pstmti.setString(6,f4);
		pstmti.setString(7,f5);
		pstmti.setString(8,f6);
		pstmti.setString(9,f7);
		pstmti.setString(10,f8);
		pstmti.setString(11,f9);
		pstmti.setString(12,music);
		pstmti.setString(13,mem);
		pstmti.setString(14,user_id);
		pstmti.executeUpdate();
				con.close();
				RequestDispatcher rd=request.getRequestDispatcher("confirmparty.jsp");  
				rd.forward(request, response);
	}}
catch(Exception e)
{
	out.println(e);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="partyhall.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Party Hall</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="partyhall.css">
</head>
<body onload="myFunction()">
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
        <div class="navigation">
         <ul>
            <img src="home_images/logo.png" height="50px" alt="Logo">
            <li><a href="foodorder.jsp">Food Order</a></li>
            <li><a class="active">Party Hall Booking</a></li>
            <li><a href="logout.jsp">Logout</a></li>
            <li><a href="home.jsp">Home</a></li>
        </ul>
        </div>
    </header>
    <!--End of header-->
    <!--Hero section-->
    <section  class="hero">
        <div class="container">
            <h2 class="sub_headline">
                <span class="first_letter">F</span>ind Perfect Venue For Every Event
            </h2>
            <h1 class="headline">Party Hall</h1>
        </div>
    </section>
    <!--End of hero-->
    <!--Icon space-->
    <form method="POST">
    <section class="icon">
        <div class="container-fluid">
            <div class="row" style="display: inline-flex; align-items: center;">
            <div class="box"> 
            <input type="radio" name="party" id="bday" value="birthday" class="p1"/>
            <label for="bday"><img  src="images/cake.png"  alt="Wedding" /></label>
            <p>Birthday</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="marriage"  value="marriage"class="p2" />
            <label for="marriage"><img  src="images/wedding-couple.png"  alt="Wedding" /></label>
            <p>Marriage</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="cocktail" value="cocktail" class="p3" />
            <label for="cocktail"><img  src="images/cocktail.png"  alt="Cocktail" /></label>
            <p>Cocktail</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="engagement" value="engagement" class="p4" />
            <label for="engagement"><img  src="images/diamond-ring.png"  alt="Engagement" /></label>
            <p>Engagement</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="pool" value="pool" class="p5" />
            <label for="pool"><img  src="images/swimming-pool.png"  alt="Pool" /></label>
            <p>Pool</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="farm" value="farm" class="p6" />
            <label for="farm"><img  src="images/barn.png"  alt="Farm" /></label>
            <p>Farm</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="banquet" value="banquet" class="p7" />
            <label for="banquet"><img  src="images/wedding-arch.png"  alt="Banquet" /></label> 
            <p>Banquet</p>
            </div>
            <div class="box">
            <input type="radio" name="party" id="farewell" value="farewell" class="p8" />
            <label for="farewell"><img  src="images/farwell.png"  alt="Banquet" /></label>
            <p>Farewell</p> <br> 
            </div>
             </div>
            </div>
    </section>
    <section class="booking">
        <div class="container">
            <p>
                <span>H</span>ey, you wanna pick a date
            </p>
            </br>
            <img src="images/calendar.png" style="width:30px;height:30px;">
            <div class="date_picker">
                <input type="date">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                
                <input type="text" name="mem" placeholder="No of members" >
            </div>
            
            <div class="booking_images">
               <img src="https://images.unsplash.com/photo-1627301044133-5f7dc97d559b?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60">
            </div>
        </div>
    </section>
     <!--food order section-->
    <section class="food_order">
         <div class="container-fluid">
            <h1>Select the food  :)</h1>
         </br>
            <div class="row">
             <div class="col-lg-12">
                <select name="food_category" id="food_category" onchange="myFunction()">
                    <option value="Non Veg Starters">Non Veg Starters</option>
                    <option value="Veg Starters">Veg Starters</option>
                    <option value="Soups">Soups</option>
                    <option value="Biriyani">Biriyani</option>
                    <option value="Rotis">Rotis</option>
                    <option value="Rice & Noodles">Rice & Noodles</option>
                    <option value="curies">curies</option>
                    <option value="Dessert">Dessert</option>
                    <option value="Drinks and Beverages">Drinks and Beverages</option>
                  </select><br>
                  
<div id="nonveg_stat" class="tabcontent">
       <c:forEach items="${rs1.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="nonveg_stat" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="vegstat" class="tabcontent">
         <c:forEach items="${rs2.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="vegstat" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Soup" class="tabcontent">
         <c:forEach items="${rs3.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="soup" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Briyani" class="tabcontent">
        <c:forEach items="${rs4.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="biriyani" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Rotis" class="tabcontent">
      <c:forEach items="${rs5.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="rotis" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Rice and Noodles" class="tabcontent">
      <c:forEach items="${rs6.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="ricenood" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Curies" class="tabcontent">
        <c:forEach items="${rs7.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="cury" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Dessert" class="tabcontent">
        <c:forEach items="${rs8.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="desert" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
<div id="Drinks and Beverages" class="tabcontent">
        <c:forEach items="${rs9.rows}" var="qn">
       <input type="checkbox" id='<c:out value="${qn.fname}"/>' name="drinks" value='<c:out value="${qn.fname}"/>'>
        <label for='<c:out value="${qn.fname}"/>'> <c:out value="${qn.fname}"/></label><br>
    </c:forEach>
</div>
                  
                  
             </div>
             </div>
            </div>  
     </section>
     <!--music-->    
     <section class="music">
        <div class="container-fluid">
            <h1>Select the type of music needed:</h1>
            </br>
            <div class="row food-grid">
                <div class="card" style="width:12rem;">
                    <input type="radio" name="music" id="rock" value="rock" class="m1"/>
                    <label for="rock"><img class="card-img-top" src="images/rock.jpg">
                    <div class="info">Rock</div>
                </div>
                <div class="card" style="width:12rem;">
                    
                        <input type="radio" name="music" id="romantic" value="romantic" class="m1"/>
                        <label for="romantic"><img class="card-img-top" src="images/romantic.jpg" >
                            <div class="info">Romantic</div>
                </div>
                <div class="card" style="width:12rem;">
                    
                    
                        <input type="radio" name="music" id="classic" value="classic" class="m1"/>
                        <label for="classic"><img class="card-img-top" src="images/classic.jpg">
                            <div class="info">Classic</div>
                </div>
                <div class="card" style="width:12rem;">
                  
                    <input type="radio" name="music" id="hiphop" value="hiphop" class="m1"/>
                    <label for="hiphop"><img class="card-img-top" src="images/hiphop.jfif">
                        <div class="info">Hiphop</div>
                </div>
                <div class="card" style="width:12rem;">
                    
                        <input type="radio" name="music" id="metal" value="metal" class="m1"/>
                        <label for="metal"><img class="card-img-top" src="images/metal.jpg">
                            <div class="info">Metal</div>
                </div>
            </div>
        </div>
    </section>
    
    
    <div class="submit">
        <button type="submit" name="booking">Confirm Booking</button>
    </div>
    <section class="confirm">
        <input type="button" class="btn-group-lg btn-dark">
    </section>
     
    </form>
</body>
</html>