<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%if(session.getAttribute("login")!=null)
{
	String dbname=String.valueOf(session.getAttribute("dbname"));
	request.setAttribute("welmsg",dbname);
}
	%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  
  <!-- Font Awesome -->
  <script src="https://kit.fontawesome.com/f158d309d9.js" crossorigin="anonymous"></script>
  <!-- Scroll Reveal JS -->
  <script src="https://unpkg.com/scrollreveal"></script>
  <!-- Custom CSS -->
  <link rel="stylesheet" href="home.css">
  <title>Mandarin Oriental</title>
</head>

<body>
  <header>
    <div class="container">
      <nav class="nav">
        <div class="menu_toggle">
          <i class="fas fa-bars"></i>
          <i class="fas fa-times"></i>
        </div>
        <a  class="logo"><img src="home_images/logo1.png" height="50px" alt="Logo"></a>
        <ul class="nav_list">
          <li class="nav_items">
          <%if(session.getAttribute("login")!=null)
                    	{
                    	out.println("<a href='logout.jsp' class='nav_link '>Logout</a>");
                    	}
                    else
                    	out.println("<a href='login.jsp'class='nav_link'>Login</a>");
                    %>
          </li>
          <li class="nav_items">
            <a href="home.jsp" class="nav_link active">Home</a>
          </li>
          <li class="nav_items">
            <a href="cart.jsp" class="nav_link">Cart</a>
          </li>
          <li class="nav_items">
            <a href="foodorder.jsp" class="nav_link">Food Order</a>
          </li>
          <li class="nav_items">
            <a href="partyhall.jsp" class="nav_link">Party Hall</a>
          </li>
        </ul>
      </nav>
    </div>
  </header>
  <!-- End-Of-Header -->
  <!-- Hero -->
  <section id="hero" class="hero">
    <div class="container">
      <h2 class="sub_headline">
        <span class="first_letter">W</span>elcome
      </h2>
      <h1 class="headline">
      <%
       if(request.getAttribute("welmsg")!=null)
		{
			out.println(request.getAttribute("welmsg")); //error message for email or password 
		}
      else out.println("To Mandarian");
      %>
      </h1>
      <div class="headline_drescription">
        <div class="seperator">
          <div class="line line_left"></div>
          <div class="asterisk"><i class="fas fa-asterisk"></i></div>
          <div class="line line_right"></div>
        </div>
        <div class="single_animation">
          <h5>Ready to be Opened</h5>
          <a href="home.jsp" class="btn cta_btn">Explore</a>
        </div>
      </div>
    </div>
  </section>
  <!-- End-Of-Hero -->
  <!-- Restaurant Info -->
  <section class="discover_our_story">
    <div class="container">
      <div class="restaurant_info">
        <div class="restaurant_drescription padding_right animate_left">
          <div class="gloabl_headline">
            <h2 class="sub_headline">
              <span class="first_letter">D</span>iscover
            </h2>
            <h1 class="headline">Our Restaurant</h1>
            <div class="asterisk"><i class="fas fa-asterisk"></i></div>
          </div>
          <p>The only thing we love more than food is YOU!</p>
          <a href="#footer" class="btn body_btn">About us</a>
        </div>
        <div class="restaurant_info_img animate_right">
          <img src="home_images/discover_home.jpg" alt="OurStory">
        </div>
      </div>
    </div>
  </section>
  <!-- End-Of-Restaurant Info -->
  <!-- Our Recipes -->
  <section class="our_recipes between">
    <div class="container">
      <div class="gloabl_headline">
        <div class="animate_top">
          <h2 class="sub_headline">
            <span class="first_letter">O</span>ur Recipes
          </h2>
        </div>
        <div class="animate_bottom">
          <h1 class="headline">We Care</h1>
        </div>
      </div>
    </div>
  </section>
  <!-- End-Of-Our Recipes -->
  <!-- Discover Our Menu -->
  <section class="Discover_our_menu">
    <div class="container">
      <div class="restaurant_info">
        <div class="image_group padding_right animate_left">
          <img src="home_images/2.PNG" alt="Menu Group 1">
          <img src="home_images/3.jpg" alt="Menu Group 2">
          <img src="home_images/4.jpg" alt="Menu Group 3">
          <img src="home_images/5.jfif" alt="Menu Group 4">
        </div>
        <div class="restaurant_drescription animate_right">
          <div class="gloabl_headline">
            <h2 class="sub_headline">
              <span class="first_letter">D</span>iscover
            </h2>
            <h1 class="headline">Menu</h1>
            <div class="asterisk"><i class="fas fa-asterisk"></i></div>
          </div>
          <p>
            Explore the plethora of cuisine known to man,along with US
          </p>
          <a href="foodorder.jsp" class="btn body_btn">View Full Menu</a>
        </div>
      </div>
    </div>
  </section>
  <!-- End-Of-Discover Our Menu -->
  <!-- The Perfect Blend -->
  <section class="Perfect_blend between">
    <div class="container">
      <div class="gloabl_headline">
        <div class="animate_top">
          <h2 class="sub_headline">
            <span class="first_letter">Our Family</span>
          </h2>
        </div>
        <div class="animate_bottom">
          <h1 class="headline">We CREATE </h1>
        </div>
      </div>
    </div>
  </section>
  <!-- End-Of-The Perfect Blend -->
  <section class="culinary_delight">
    <div class="container">
      <div class="restaurant_info">
        <div class="restaurant_drescription padding_right animate_left">
          <div class="gloabl_headline">
            <h2 class="sub_headline">
              <span class="first_letter">P</span>arty 
            </h2>
            <h1 class="headline">Hall</h1>
            <div class="asterisk"><i class="fas fa-asterisk"></i></div>
          </div>
          <p>Beautiful designs make the problems invisible</p>
          <a href="partyhall.jsp" class="btn body_btn">Make Reservation</a>
        </div>
        <div class="image_group">
          <img class="animate_top" src="home_images/home_party_1.jpg" height="200px" alt="Delight 1">
          <img class="animate_bottom" src="home_images/home_party_2.jpg" style="width:auto;height:auto" alt="Delight 2">
        </div>
      </div>
    </div>
  </section>
  <!-- Footer -->
  <Footer>
    <div class="container" id="footer">
      <div class="back_to_top">
        <a href="#hero"><i class="fas fa-chevron-up"></i></a>
      </div>
      <div class="footer_content">
        <div class="footer_content_about">
          <h4>About US</h4><br>
          <img src="home_images/home_about us.png" height="auto" ></img>
          <p></p>
        </div>
        <div class="footer_content_divider">
          <div class="social_media">
            <h4>Follow along</h4>
            <ul class="social_icons">
              <li><a href="#"><i class="fab fa-twitter"></i></a></li>
              <li><a href="#"><i class="fab fa-instagram"></i></a></li>
              <li><a href="#"><i class="fab fa-facebook-square"></i></a></li>
            </ul>
            <p><i class="fab fa-creative-commons"></i>  Created By Jayaprakash And Muhesh</p>
          </div>
        </div>
      </div>
    </div>
  </Footer>
  <!-- Custom JavaScript -->
  <script src="home.js"></script>
</body>
</html>
           
           
           