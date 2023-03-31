<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="BTL_WebNC.LandingPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookLife</title>
    <link rel="stylesheet" href="Bootstrap5/bootstrap.min.css" type="text/css" />
    <script src="Bootstrap5/bootstrap.bundle.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Bootstrap5/bootstrap-icons-1.10.3/bootstrap-icons.css" type="text/css" />
    <link rel="stylesheet" href="Bootstrap5/style.css" type="text/css" />
    <script type="text/javascript">
        function getFilteredProducts() {
            var getCategoryList = document.getElementById('categoryList');
            var genre = getCategoryList.options[getCategoryList.selectedIndex].value;
            var title = document.getElementById('searchInput').value;

            var url = 'https://localhost:44374/WebService.asmx/GetBooks?genre=' + genre + '&title=' + title;

            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();

            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    const books = JSON.parse(xhttp.responseText);
                    console.log(books);
                    let bookCardCode = '';
                    if (books.length == 0) {
                        bookCardCode += `<div class="row p-2 bg-white border rounded mt-2">`;
                        bookCardCode += '<h1 class="text-center align-bottom">Nothing<h1>'
                        bookCardCode += `</div>`;
                    }
                    else {
                        for (let book of books) {
                            bookCardCode += `<div class="row p-2 bg-white border rounded mt-2">`;
                            bookCardCode += `<div class="col-md-3 mt-1">
                            <img class="img-fluid img-responsive rounded product-image"
                                src="` + book.ImageLink + `" />
                        </div>`;
                            bookCardCode += `<div class="col-md-6 mt-1">
                            <h2>` + book.Title + `</h2>
                            <div class="mt-1 mb-1 spec-1">
                                <span class="dot"></span><span>Author: ` + book.Author + `</span>
                            </div>
                            <div class="mt-1 mb-1 spec-1">
                                <span class="dot"></span><span>Genre: ` + book.Genre + `</span>
                            </div>
                        </div>`;
                            bookCardCode += `<div class="align-items-center align-content-center col-md-3 border-left mt-1">
                            <div class="d-flex flex-row align-items-center">
                                <h2 class="mr-1">$` + book.Price + `</h2>
                            </div>
                            <div class="d-flex flex-column mt-4">
                                <button class="btn btn-warning btn-sm" type="button">
                                    <i class="bi bi-info-square"></i>&nbsp; Details</button>
                                <button class="btn btn-dark btn-sm mt-2" type="button">
                                    <i class="bi bi-cart"></i>&nbsp; Add to cart</button>
                            </div>
                        </div>`
                            bookCardCode += `</div>`;
                        }
                    }
                    document.getElementById('productCard').innerHTML = bookCardCode;
                }
            }
        }
    </script>
</head>
<body onload="getFilteredProducts()">
    <form id="landingPage" runat="server">
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
                                <a class="dropdown-item" href="#"><i class="bi bi-cart3"></i> Shopping Cart</a>
                                <a class="dropdown-item" href="#"><i class="bi bi-info-circle"></i> Account Info</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" id="logoutBTN" runat="server"
                                    onserverclick="logoutBTN_ServerClick"><i class="bi bi-door-open"></i> Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div id="carouselExampleCaptions" class="carousel slide">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"
                    aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                    aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                    aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="images/Book1.jpg" class="d-block w-100" />
                    <div class="carousel-caption">
                        <h5>First slide label</h5>
                        <p>Some representative placeholder content for the first slide.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="images/Books.jpg" class="d-block w-100" />
                    <div class="carousel-caption">
                        <h5>Second slide label</h5>
                        <p>Some representative placeholder content for the second slide.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="images/Book3.jpg" class="d-block w-100" />
                    <div class="carousel-caption">
                        <h5>Third slide label</h5>
                        <p>Some representative placeholder content for the third slide.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <div class="container mt-5 mb-5">
            <div class="d-flex justify-content-center row">
                <div class="col-md-10">
                    <div class="row p-2 mt-2">
                        <div class="col-md-6 justify-content-end align-items-center">
                            <div class="input-group">
                                <div class="input-field form-outline w-50">
                                    <input type="search" class="form-control" id="searchInput"
                                        placeholder="Search Book By Title..."
                                        aria-label="Search Book" aria-describedby="basic-addon2" />
                                </div>
                                <div class="input-group-append">
                                    <button class="btn btn-warning searchBTN" type="button"
                                        onclick="getFilteredProducts()">
                                        <i class="bi bi-search"></i>Search</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex justify-content-end align-items-center">
                            <label for="categoryList">Search By Genre: &nbsp;</label>
                            <asp:DropDownList ID="categoryList" runat="server" onchange="getFilteredProducts()">
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div id="productCard"></div>
                </div>
            </div>
        </div>

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
