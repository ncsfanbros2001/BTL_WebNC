<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="BTL_WebNC.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="CSS/checkoutCSS.css" />
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
                    let itemSummaryTableCode = `<tr>
                            <td><b>Title</b></td>
                            <td><b>Quantity</b></td>
                            <td><b>Total</b></td>
                        </tr>`;
                    for (let cartItem of cartItems) {
                        totalPayment += parseFloat(cartItem.TotalPrice);
                        itemSummaryTableCode += `<tr>
                                <td>` + cartItem.BookTitle + `</td>
                                <td>` + cartItem.quantity + `</td>
                                <td>$` + cartItem.TotalPrice + `</td>
                            </tr>`;
                    }
                    document.getElementById('totalPrice').innerText = "$" + totalPayment.toFixed(2);
                    document.getElementById('itemSummaryTable').innerHTML = itemSummaryTableCode;
                }
            }
        }
    </script>
</head>
<body onload="getCartItems()">
    <form id="checkoutForm" runat="server">
        <header>
            <a href="LandingPage.aspx" class="logo"><span style="color: #ffc107;">BOOK</span><span
                    style="color: white;">LIFE</span></a>
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

        <section class="checkoutRegion">
            <div class="receipt">
                <div class="innerReceipt">
                    <h1>RECEIPT</h1>
                    <hr />
                    <table class="itemList" id="itemSummaryTable" border="1">
                        
                    </table>
                    <hr />
                    <h2>Total Price: <span id="totalPrice" runat="server"></span></h2>
                    <div class="optionButtons">
                        <button id="back2Cart" runat="server" onserverclick="back2Cart_ServerClick">
                            Keep on Shopping</button>
                        <button id="checkout" runat="server" onserverclick="checkout_ServerClick">Checkout</button>
                    </div>
                </div>
            </div>
            <div class="deliveryInfo">
                <h1>DELIVERY INFO</h1>
                <hr />
                <div id="infos">
                    <div class="inputField">
                        <label for="customerName">Full name</label>
                        <br />
                        <input type="text" id="customerName" runat="server" disabled/>
                    </div>

                    <div class="inputField">
                        <label for="customerEmail">Email</label>
                        <br />
                        <input type="text" id="customerEmail" runat="server" disabled/>
                    </div>

                    <div class="inputField">
                        <label for="customerPhoneNumber">Phone Number</label>
                        <br />
                        <input type="text" id="customerPhoneNumber" runat="server" disabled/>
                    </div>

                    <div class="inputField">
                        <label for="orderDate">Order Date</label>
                        <br />
                        <input type="text" id="orderDate" runat="server" disabled/>
                    </div>

                    <div class="inputField">
                        <label for="estimatedReceiveDate">Estimated Receive Date</label>
                        <br />
                        <input type="text" id="estimatedReceiveDate" runat="server" disabled/>
                    </div>

                    <div class="inputField">
                        <label for="address">Address</label>
                        <br />
                        <input type="text" id="address" runat="server"/>
                    </div>

                    <div class="inputField">
                        <label for="note">Note (Optional)</label>
                        <br />
                        <textarea id="note" runat="server"></textarea>
                    </div>
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
