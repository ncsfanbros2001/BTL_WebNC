<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="BTL_WebNC.Details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Details</title>
    <link rel="stylesheet" type="text/css" href="CSS/detailPageCSS.css" />

    <script type="text/javascript">
        function count() {
            var count = 0;
            count++;
            //document.getElementById('count').innerHTML = count;

        }
    </script>
</head>

    
<body >
    <form id="bookDetails" runat="server">
        <header>
            <a href="LandingPage.aspx" class="logo"><span style="color: #ffc107;">BOOK</span><span style="color: white;">LIFE</span></a>
            <div class="buttons" id="authenticationControls" runat="server">
                <button class="loginBTN button" id="loginBtn" runat="server" onserverclick="loginBtn_ServerClick">
                    Log In</button>
                <button class="signupBTN button" id="signupBtn" runat="server" onserverclick="signupBtn_ServerClick">
                    Sign Up</button>
            </div>
            <label class="dropdown" id="accountControls" runat="server">
                <div class="dd-button" id="userName" runat="server"></div>

                <input type="checkbox" class="dd-input" id="test" />

                <ul class="dd-menu">
                    <div id="toCart" runat="server"><li><a href="ShoppingCart.aspx">Shopping Cart</a></li></div>
                    <li><a id="toUserInfo" runat="server">Account Info</a></li>
                    <div id="adminOnly" runat="server">
                        <li class="divider"></li>
                        <li><a href="#">Products</a></li>
                        <li><a href="#">Users</a></li>
                    </div>
                    <li class="divider"></li>
                    <li><a runat="server" id="logoutBtn" onserverclick="logoutBtn_ServerClick">Logout</a></li>
                </ul>

            </label>
        </header>

        <section class="productDetail">
            <div class="productImg">
                <img src="#" id="image" runat="server" />
            </div>
            <div class="productInfo">
                <h1 id="title" runat="server"></h1>
                <br />
                <h1 id="price" runat="server"></h1>
                <div id="infoTable">
                    <table id="infos" border="1">
                        <tr>
                            <td><b>Author</b></td>
                            <td id="author" runat="server"></td>
                        </tr>
                        <tr>
                            <td><b>Genre</b></td>
                            <td id="genre" runat="server"></td>
                        </tr>
                        <tr>
                            <td><b>Publisher</b></td>
                            <td id="publisher" runat="server"></td>
                        </tr>
                    </table>

                    <p>Count:</p><h1 id="Count" runat="server"></h1>

                </div>
                <div class="checkout" runat="server" id="checkoutRegion">
                    <label for="amount">Quantity: </label>
                    <input type="number" id="amount" min="1" value="1" runat="server" />
                    <button id="add2Cart" runat="server" onserverclick="add2Cart_ServerClick">Add To Cart</button>
                </div>
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
