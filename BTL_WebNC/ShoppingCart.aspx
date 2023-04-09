<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="BTL_WebNC.ShoppingCart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="CSS/shoppingCartCSS.css" />
    <script type="text/javascript">
        function getCartItems() {
            var getPersonId = <% Response.Write(Session["id"]); %>;
            var url = 'https://localhost:44374/WebService.asmx/GetCartItems?personId=' + getPersonId;

            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();

            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    const cartItems = JSON.parse(xhttp.responseText);
                    let totalPayment = 0;
                    let cartItemCardCode = '';
                    let itemSummaryTableCode = `<tr>
                            <td><b>Title</b></td>
                            <td><b>Quantity</b></td>
                            <td><b>Total</b></td>
                        </tr>`;
                    if (cartItems.length == 0) {
                        cartItemCardCode += `<h1 class="emptyAlert">Empty Cart<h1>`
                    }
                    else {
                        for (let cartItem of cartItems) {
                            totalPayment += parseFloat(cartItem.TotalPrice);
                            cartItemCardCode += `<div class="item">
                                <div class="itemImg">
                                    <img src="` + cartItem.BookImageLink + `" id="image" />
                                </div>
                                <div class="itemInfo">
                                    <h1 class="itemTitle">` + cartItem.BookTitle + `</h1>
                                    <div>
                                        <span style="font-size: 20px;">Quantity: </span>
                                        <input type="number" id="amount"
                                        value="` + cartItem.quantity + `" disabled/>
                                        <span id="pricePerProduct">&nbsp;x $` + cartItem.BookPrice + `</span>
                                    </div>
                                </div>
                                <div class="priceTag">
                                    <h2>$` + cartItem.TotalPrice + `</h2>
                                    <button id="remove" onclick="deleteCartItems(`+ cartItem.CartItemID +`)">
                                        Remove</button>
                                </div>
                            </div>`;
                            itemSummaryTableCode += `<tr>
                                <td>` + cartItem.BookTitle + `</td>
                                <td>` + cartItem.quantity + `</td>
                                <td>$` + cartItem.TotalPrice + `</td>
                            </tr>`;
                        }
                    }
                    document.getElementById('totalPrice').innerText = "$" + totalPayment.toFixed(2);
                    document.getElementById('items').innerHTML = cartItemCardCode;
                    document.getElementById('itemSummaryTable').innerHTML = itemSummaryTableCode;
                }
            }
        }

        function deleteCartItems(itemId) {
            var url = 'https://localhost:44374/WebService.asmx/DeleteCartItem?itemId=' + itemId;

            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();
        }
    </script>
</head>
<body onload="getCartItems()">
    <form id="shoppingCart" runat="server">
        <header>
            <a href="LandingPage.aspx" class="logo"><span style="color: #ffc107;">BOOK</span><span
                style="color: white;">LIFE</span></a>
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

        <section class="cartRegion">
            <div class="summary">
                <div class="innerSummary">
                    <h1>RECEIPT</h1>
                    <hr />
                    <table class="itemList" id="itemSummaryTable" border="1">
                        
                    </table>
                    <hr />
                    <h2>Total Price: <span id="totalPrice"></span></h2>
                    <div class="optionButtons">
                        <button id="continueShopping" runat="server" 
                            onserverclick="continueShopping_ServerClick">Keep on Shopping</button>
                        <button id="checkout" runat="server" 
                            onserverclick="checkout_ServerClick">Checkout</button>
                    </div>
                </div>
            </div>

            <div class="cartItems" id="cartItems">
                <h1>SHOPPING LIST</h1>
                <hr />
                <div id="items"></div>
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
