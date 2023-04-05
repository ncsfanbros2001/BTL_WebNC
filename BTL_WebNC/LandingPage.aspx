<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="BTL_WebNC.LandingPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookLife</title>
    <link rel="stylesheet" type="text/css" href="CSS/landingPageCSS.css" />
    <script type="text/javascript">
        
        function getFilteredProducts() {
            var getGenreList = document.getElementById('genreList');
            var genre = getGenreList.options[getGenreList.selectedIndex].value;
            var title = document.getElementById('searchBox').value;

            var url = 'https://localhost:44374/WebService.asmx/GetBooks?genre=' + genre + '&title=' + title;

            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();

            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    const books = JSON.parse(xhttp.responseText);
                    let bookCardCode = '';
                    if (books.length == 0) {
                        bookCardCode += `<h1 class="emptyAlert">Nothing<h1>`
                    }
                    else {
                        for (let book of books) {
                            bookCardCode += `<div class="product">
                                <img src="` + book.ImageLink + `" />
                                <div class="product-info">
                                    <h4 class="product-title">` + book.Title + `</h4>
                                    <p class="product-price">$` + book.Price + `</p>
                                    <a class="product-btn" href="BookDetails.aspx?id=` + book.Id +`">Buy Now</a>
                                </div>
                            </div>`
                        }
                    }
                    document.getElementById('productList').innerHTML = bookCardCode;
                }
            }
        }
    </script>
</head>
<body onload="getFilteredProducts()">
    <form id="landingPage" runat="server">
        <header>
            <a href="#" class="logo"><span style="color: #ffc107;">BOOK</span><span style="color: white;">LIFE</span></a>
            <div class="buttons" id="authenticationControls" runat="server">
                <button class="loginBTN button" id="loginBtn" runat="server" onserverclick="loginBtn_ServerClick">
                    Log In</button>
                <button class="signupBTN button" id="signupBtn" runat="server" onserverclick="signupBtn_ServerClick">
                    Sign Up</button>
            </div>
            <label class="dropdown" id="accountControls" runat="server">
                <div class="dd-button">
                    <% Response.Write(Session["name"]); %> &nbsp;
                </div>
                <input type="checkbox" class="dd-input" id="test" />

                <ul class="dd-menu">
                    <div id="toCart" runat="server"><li><a href="#">Shopping Cart</a></li></div>
                    <li><a href="#">Account Info</a></li>
                    <div id="adminOnly" runat="server">
                        <li class="divider"></li>
                        <li><a href="#">Products</a></li>
                        <li><a href="#">Users</a></li>
                    </div>
                    <li class="divider"></li>
                    <li><a runat="server" id="logoutBtn" onserverclick="logoutBTN_ServerClick">Logout</a></li>
                </ul>

            </label>
        </header>

        <section class="products">
            <div class="product-filter">
                <div class="search-by-name">
                    <asp:TextBox ID="searchBox" runat="server" placeholder="Search by title ..." type="search">

                    </asp:TextBox>
                    <button id="searchBtn" onclick="getFilteredProducts()">Search</button>
                </div>
                <div class="search-by-genre">
                    <label for="cars" class="genreLabel">Search by genre:</label>
                    <asp:DropDownList ID="genreList" runat="server" onchange="getFilteredProducts()">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="all-products" id="productList">
                
            </div>
        </section>

        <footer>
            <div class="copyright">
                <p>© 2023 Copyright: <a class="text-white" href="#">BookLife.com</a></p>
            </div>
        </footer>
    </form>
</body>
</html>
