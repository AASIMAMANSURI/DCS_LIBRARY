aasima

ksdns
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="project.connection"%>
<%-- aasima--%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%

    HttpSession s = request.getSession(false);

    String username = (String) s.getAttribute("username");
    String user_id = (String) s.getAttribute("user_id");

    if (username == null || user_id == null) {

    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>DCS Library </title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
            rel="stylesheet">

        <!-- Font Awesome -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css"
              rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <style>
            
.card {
  max-height: 400px; /* Adjust as needed */
  display: flex;
  flex-direction: column;
}

.card-img-top {
  max-height: 200px; /* Adjust as needed */
  width: 100%;
  object-fit: contain;
}


.card-body {
  flex-grow: 1;
  overflow: hidden;
}


        </style>
    </head>
    <body>
        <!-- Topbar Start -->
        <div class="container-fluid">
            <div
                class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex">
                <div class="col-lg-4">
                    <a href="" class="text-decoration-none"> <span
                            class="h1 text-uppercase text-primary bg-dark px-2">DCS</span> <span
                            class="h1 text-uppercase text-dark bg-primary px-2 ml-n1">Library</span>
                    </a>
                </div>

                <div class="col-lg-8 col-6 text-right">
                    <p class="m-0"></p>
                    <h5 class="mr-0">
                        <%
                            boolean is_logged = false;
                            if (username != null) {
                                out.print("Welcome " + username);
                                // 						out.print(user_id + username+user_email);
                                is_logged = true;
                            } else {
                                out.print("Welcome User");
                                is_logged = false;
                            }
                        %>
                    </h5>

                </div>
            </div>
        </div>
        <!-- Topbar End -->


        <!-- Navbar Start -->
        <%
            // Declare all variables outside the try block to avoid redeclaration
            Connection conn = null;
            Statement stmtParent = null;
            Statement stmtSub = null;
            ResultSet rsParent = null;
            ResultSet rsSub = null;
        %>

        <div class="container-fluid bg-dark mb-30">
            <div class="row px-xl-5">
                <div class="col-lg-3 d-none d-lg-block">
                    <a
                        class="btn d-flex align-items-center justify-content-between bg-primary w-100"
                        data-toggle="collapse" href="#navbar-vertical"
                        style="height: 65px; padding: 0 30px;">
                        <h6 class="text-dark m-0"><i class=" mr-2"></i>Subjects</h6> <i class="fa fa-angle-down text-dark"></i>
                    </a>
                    <nav
                        class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 bg-light"
                        id="navbar-vertical"
                        style="width: calc(100% - 30px); z-index: 999;">
                        <div class="navbar-nav w-100">
                            <%
                                try {
                                    // Get the connection using your project connection class
                                    conn = connection.getcon();

                                    // Parent categories query
                                    stmtParent = conn.createStatement();
                                    rsParent = stmtParent.executeQuery("SELECT * FROM parent_category");

                                    // Loop through parent categories
                                    while (rsParent.next()) {
                                        int parentCatId = rsParent.getInt("p_cat_id");
                                        String parentCategoryName = rsParent.getString("p_cat_name");
                            %>
                            <div class="nav-item">
                                <a href="shop.jsp?filter_option_gender=<%=parentCatId%>"
                                   class="nav-link"> <%=parentCategoryName%>
                                </a>
                            </div>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    // Close resources
                                    if (rsParent != null) {
                                        rsParent.close();
                                    }
                                    if (stmtParent != null) {
                                        stmtParent.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                }
                            %>
                        </div>
                    </nav>



                </div>

                <div class="col-lg-9">
                    <nav
                        class="navbar navbar-expand-lg bg-dark navbar-dark py-3 py-lg-0 px-0">

                        <button type="button" class="navbar-toggler" data-toggle="collapse"
                                data-target="#navbarCollapse">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-between"
                             id="navbarCollapse">
                            <div class="navbar-nav mr-auto py-0">
                                <a href="index.jsp" class="nav-item nav-link active">Home</a>
                            </div>
                            <div class="navbar-nav ml-auto py-2 d-none d-lg-block">
                                <div class="btn-group mr-2 ">
                                    <button type="button"
                                            class="btn btn-sm btn-light dropdown-toggle rounded"
                                            data-toggle="dropdown">My Account</button>
                                    <div class="dropdown-menu dropdown-menu-right">



                                        <%
                                            if (is_logged) {
                                        %>
                                        <a href="logout.jsp"><button class="dropdown-item"
                                                                     type="button">Logout</button></a>
                                        <a href="order_history.jsp"><button class="dropdown-item"
                                                                            type="button">Borrowed History</button></a> <a
                                            href="profile_page.jsp"><button class="dropdown-item"
                                                                        type="button">Your profile</button></a>
                                            <%
                                            } 
                                            %> 

                                    </div>
                                </div>
                                <%
                                    int wishListCount = 0;

                                    // If customer_id is available, query the database for wishlisted and cart items
                                    if (user_id != null) {
                                        try {
                                            Connection con = connection.getcon();

                                            // Query to count wishlist items
                                            String wishlistSQL = "SELECT COUNT(*) FROM wishlist WHERE c_id = ?";
                                            PreparedStatement psWishlist = con.prepareStatement(wishlistSQL);
                                            psWishlist.setString(1, user_id);
                                            ResultSet rsWishlist = psWishlist.executeQuery();
                                            if (rsWishlist.next()) {
                                                wishListCount = rsWishlist.getInt(1); // Get the wishlist count
                                            }

                                        } catch (Exception e) {
                                            System.out.println("Error: " + e);
                                        }
                                    }
                                %>

                                <!-- Display the wishlist and cart counts -->
                                <a href="wish_list.jsp" class="btn px-0"> <i
                                        class="fas fa-heart text-primary"></i> <span
                                        class="badge text-secondary border border-secondary rounded-circle"
                                        style="padding-bottom: 2px;"> <%=wishListCount%>
                                    </span>
                                </a> 
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar End -->

        <!-- Start: Search Section -->
        <section class="search-filters py-4 bg-light">
            <div class="container">
                <div class="filter-box p-4 shadow-sm bg-white rounded">
                    <h3 class="text-center text-dark mb-4">What are you looking for at the library?</h3>
                    <form action="search.jsp" method="get" class="row g-3">
                        <!-- Search by Keyword -->
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="keywords" class="form-label">Search by Title</label>
                                <input type="text" class="form-control" id="keywords" name="keywords" placeholder="Enter keyword...">
                            </div>
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="keywords" class="form-label">Search by Author</label>
                                <input type="text" class="form-control" id="keywords" name="keywords" placeholder="Enter keyword...">
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="keywords" class="form-label">Search by Subject</label>
                                <input type="text" class="form-control" id="keywords" name="keywords" placeholder="Enter keyword...">
                            </div>
                        </div>


                        <!-- Search Button -->
                        <div class="col-md-2 col-sm-6 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!-- End: Search Section -->
        
        
        <div class="container">
            
            
        <!-- Start:  suggestion Section -->
        <div class="card-group">
  <div class="card">
      <img src="img/cat-1.jpg" class="card-img-top" alt="..." width="100px" hight="200px">
    <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
    </div>
    <div class="card-footer">
      <small class="text-muted">Last updated 3 mins ago</small>
    </div>
  </div>
  <div class="card">
    <img src="img/cat-1.jpg" class="card-img-top" alt="...">
    <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
    </div>
    <div class="card-footer">
      <small class="text-muted">Last updated 3 mins ago</small>
    </div>
  </div>
  <div class="card">
    <img src="img/cat-1.jpg" class="card-img-top" alt="...">
    <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
    </div>
    <div class="card-footer">
      <small class="text-muted">Last updated 3 mins ago</small>
    </div>
  </div>
</div>
        <!-- End: Search Section -->
        </div>


        

        <!-- Start: Footer -->
        <footer class="container-fluid bg-dark text-secondary mt-5 pt-5">
            <div class="container">
                <div id="footer-widgets">
                    <div class="row">
                        <div class="col-md-5 col-sm-6 widget-container">
                            <div id="text-2" class="widget widget_text">
                                <h3 class="text-secondary text-uppercase mb-4">About DCS Library</h3>
                                <span class="underline left"></span>

                                <address>
                                    <div class="info">
                                        <i class="fa fa-location-arrow"></i>
                                        <span>Department of Computer Science, Gujarat University</span>
                                    </div>
                                    <div class="info">
                                        <i class="fa fa-envelope"></i>
                                        <span><a href="mailto:aasimamansuri56@gmail.com">aasimamansuri56@gmail.com</a></span>
                                    </div>
                                    <div class="info">
                                        <i class="fa fa-phone"></i>
                                        <span><a href="tel:+91 1234567890">+91 1234567890</a></span>
                                    </div>
                                </address>
                            </div>  
                        </div>
                        <!--                        <div class="col-md-2 col-sm-6 widget-container">
                                                    <div id="nav_menu-3" class="widget widget_nav_menu">
                                                        <h3 class="text-secondary text-uppercase mb-4">Services</h3>
                                                        <span class="underline left"></span>
                                                        <div class="menu-quick-links-container">
                                                            <ul id="menu-quick-links" class="menu">
                                                                <li>Borrow books </li>
                                                                <li class="text-light">Download ebooks</li>
                                                                
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>-->
                        <div class="clearfix hidden-lg hidden-md hidden-xs tablet-margin-bottom"></div>
                        <div class="col-md-3 col-sm-6 widget-container">
                            <div id="text-4" class="widget widget_text">
                                <h3 class="text-secondary text-uppercase mb-4">Timing</h3>
                                <span class="underline left"></span>
                                <div class="timming-text-widget">
                                    <time datetime="2017-02-13">Mon - Thu: 12 am - 4 pm</time>

                                </div>
                            </div>			
                        </div>

                    </div>
                </div>                
            </div>

        </footer>
        <!-- End: Footer -->

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>