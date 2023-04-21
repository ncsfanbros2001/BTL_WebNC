<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="BTL_WebNC.Users" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" type="text/css" href="CSS/usersCSS.css" />

</head>
<body>
    <form id="form1" runat="server">
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
        <div>
            <h1>User List</h1>
            <p>
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        Fullname:
                        <asp:Label ID="FullnameLabel" runat="server" Text='<%# Eval("Fullname") %>' />
                        <br />
                        Email:
                        <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                        <br />
                        PhoneNumber:
                        <asp:Label ID="PhoneNumberLabel" runat="server" Text='<%# Eval("PhoneNumber") %>' />
                        <br />
                        Gender:
                        <asp:Label ID="GenderLabel" runat="server" Text='<%# Eval("Gender") %>' />
                        <br />
                        Position:
                        <asp:Label ID="PositionLabel" runat="server" Text='<%# Eval("Position") %>' />
                        <br />
<br />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BTL_WebNCConnectionString2 %>" SelectCommand="SELECT [Fullname], [Email], [PhoneNumber], [Gender], [Position] FROM [Persons]"></asp:SqlDataSource>
            </p>
        </div>
    </form>
    <footer>
        <div class="copyright">
            <p>© 2023 Copyright: <a class="text-white" href="#">BookLife.com</a></p>
        </div>
    </footer>
</body>
</html>
