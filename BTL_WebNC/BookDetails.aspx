<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="BTL_WebNC.BookDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Details</title>
    <link rel="stylesheet" href="Bootstrap5/bootstrap.min.css" type="text/css" />
    <script src="Bootstrap5/bootstrap.bundle.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Bootstrap5/bootstrap-icons-1.10.3/bootstrap-icons.css" type="text/css" />
    <link rel="stylesheet" href="Bootstrap5/style.css" type="text/css" />
</head>
<body>
    <form id="bookDetails" runat="server">
        <header class="p-3 text-bg-dark bg-dark fixed-top">
            <div class="container">
                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                    <a class="navbar-brand" href="#">
                        <span class="text-warning">BOOK</span><span class="text-white">LIFE</span></a>

                    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                        <li><a href="#" class="nav-link px-2 text-white">Home</a></li>
                        <li><a href="#" class="nav-link px-2 text-white">Features</a></li>
                    </ul>

                    <div class="text-end">
                        <div id="authenticationControls" runat="server">
                            <button type="button" class="btn btn-light" onclick="window.location='Login.aspx'">
                                Log In</button>
                            <button type="button" class="btn btn-warning" onclick="window.location='Register.aspx'">
                                Sign Up</button>
                        </div>
                        <div class="dropdown" id="userControls" runat="server">
                            <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-square"></i> &nbsp; <% Response.Write(Session["name"]); %>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" runat="server" id="toCart">
                                    <i class="bi bi-cart3"></i> Shopping Cart</a>
                                <a class="dropdown-item" href="#"><i class="bi bi-info-circle"></i> Account Info</a>
                                <div id="adminOnly" runat="server">
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#"><i class="bi bi-book"></i> Products</a>
                                    <a class="dropdown-item" href="#"><i class="bi bi-people"></i> Users</a>
                                </div>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" id="logoutBTN" runat="server">
                                    <i class="bi bi-door-open"></i> Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6">
                        <img class="card-img-top mb-5 mb-md-0" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg"
                            runat="server" id="productImg"/>
                    </div>
                    <div class="col-md-6">
                        <h1 class="display-5 fw-bolder">Shop item template</h1>
                        <div class="fs-5 mb-5">
                            <span>$40.00</span>
                        </div>
                        <p class="lead">
                            Gridview Goes Here</p>
                        <div class="d-flex">
                            <label for="inputQuantity">Amount</label>
                            <input class="form-control text-center me-3" id="inputQuantity" type="number" min="1" value="1" style="max-width: 5rem"/>
                            <button class="btn btn-warning" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                Add to cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="footer">
            <footer class="text-center text-white" style="background-color: #1b1b1b;">
                <div class="container p-4 pb-0">
                    <section class="">
                        <p class="d-flex justify-content-center align-items-center">
                            <span class="me-3">Register for free</span>
                            <button type="button" class="btn btn-warning btn-rounded"
                                onclick="window.location='Register.aspx'">
                                Sign up!
                            </button>
                        </p>
                    </section>
                </div>

                <div class="text-center p-3" style="background-color: #000000;">
                    © 2023 Copyright:
                    <a class="text-white" href="#">BookLife.com</a>
                </div>
            </footer>
        </section>
    </form>
</body>
</html>
