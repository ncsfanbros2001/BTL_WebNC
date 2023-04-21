<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPH.aspx.cs" Inherits="BTL_WebNC.CPH" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="CSS/customerPurchaseHistoryCSS.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <header>
            <a href="LandingPage.aspx" class="logo"><span style="color: #ffc107;">BOOK</span><span style="color: white;">LIFE</span></a>
            <label class="dropdown" id="accountControls" runat="server">
                <div class="dd-button" id="userName" runat="server">
                </div>
                <input type="checkbox" class="dd-input" id="test" />

                <ul class="dd-menu">
                    <li><a id="toUserInfo" runat="server">Account Info</a></li>
                    <div id="adminOnly" runat="server">
                        <li class="divider"></li>
                        <li><a href="#">Products</a></li>
                        <li><a href="Users.aspx">Users</a></li>
                        <li><a href="CPH.aspx">Customer Purchase History</a></li>
                    </div>
                    <li class="divider"></li>
                    <li><a runat="server" id="logoutBtn" onserverclick="logoutBTN_ServerClick">Logout</a></li>
                </ul>
            </label>
        </header>
        <h1>Customer Purchase History</h1>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
        <footer>
        <div class="copyright">
            <p>© 2023 Copyright: <a class="text-white" href="#">BookLife.com</a></p>
        </div>
        </footer>
        </div>
    </form>
</body>
</html>
