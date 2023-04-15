<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="BTL_WebNC.UserInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="CSS/userInfoCSS.css" />
    <title></title>
</head>
<body>
    <form id="userInfo" runat="server">
        <header>
            <a href="LandingPage.aspx" class="logo"><span style="color: #ffc107;">BOOK</span><span style="color: white;">LIFE</span></a>
            <label class="dropdown" id="accountControls" runat="server">
                <div class="dd-button" id="userName" runat="server">
                </div>
                <input type="checkbox" class="dd-input" id="test" />

                <ul class="dd-menu">
                    <div id="toCart" runat="server">
                        <li><a href="ShoppingCart.aspx">Shopping Cart</a></li>
                    </div>
                    <li><a id="toUserInfo" runat="server">Account Info</a></li>
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

        <h1 style="font-size: 45px; margin-left: 50%; margin-bottom: 30px">Profile</h1>

        <div id="Info" style="margin-left: 650px;margin-right:500px; margin-bottom: 100px; border: 15px solid white; background: white">
            <img src="images/avatar.jpg" alt="avatar" style="height: 313px; width: 340px; margin-bottom: 25px" />
            <br />
            <p>Fullname: <span id="fullName" runat="server"></span></p>
            <br />
            <p>Email: <span id="email" runat="server"></span></p>
            <br />
            <p>Phone Number: <span id="phoneNumber" runat="server"></span></p>
            <br />
            <p>DOB: <span id="dob" runat="server"></span></p>
            <br />
            <p>Position: <span id="position" runat="server"></span></p>
            <br />
        </div>
        </div>
    </form>

    <footer>
        <div class="copyright">
            <p>© 2023 Copyright: <a class="text-white" href="#">BookLife.com</a></p>
        </div>
    </footer>
</body>
</html>
