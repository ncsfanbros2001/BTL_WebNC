<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BTL_WebNC.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log In</title>
    <link rel="stylesheet" href="CSS/loginCSS.css" type="text/css" />
    <script>
        function loginValidation() {
            var email = document.getElementById("email").value.trim();
            var password = document.getElementById("password").value.trim();
            var count = 3;
            //const showBtnLogin = document.querySelector('#login')
            //const div = document.querySelector('#btn')

            if (email == '' || password == '') {
                document.getElementById("validationWarning").innerHTML = 'Both email and password are required !';
                //showBtnLogin.addEventListener('click', () => {
                    //div.style.visibility = 'hidden'
                //})
                return false;
            }
            
            else {
                document.getElementById("validationWarning").innerHTML = '';
                return true;
            }
        }

    </script>
</head>
<body>
    <div class="login">
        <h1>LOGIN</h1>
        <h3 id="validationWarning" runat="server"></h3>

        <form id="loginForm" runat="server">
            <div class="emailField">
                <label for="email">Email address</label>
                <br />
                <asp:TextBox ID="email" runat="server" type="text"></asp:TextBox>
            </div>

            <div class="passwordField">
                <label for="password">Password</label>
                <br />
                <asp:TextBox ID="password" runat="server" type="password"></asp:TextBox>
            </div>

            <div class="rememberMeField">
                <input type="checkbox" id="rememberMe" runat="server" />
                <label for="rememberMe">Remember me</label>
            </div>
            <div id="btn">
            <asp:Button ID="login" OnClientClick="return loginValidation()" OnClick="login_Click" runat="server"
                Text="SIGN IN">
            </asp:Button>
            </div>
        </form>

        <div class="otherOptions">
            <button type="button" id="toHomePage" runat="server" onclick="window.location.href='LandingPage.aspx'">
                HOME PAGE</button>
            <button type="button" id="toRegister" runat="server" onclick="window.location.href='Register.aspx'">
                REGISTER</button>
        </div>
    </div>
</body>
</html>
