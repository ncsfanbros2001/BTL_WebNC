<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BTL_WebNC.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log In</title>
    <link rel="stylesheet" href="Bootstrap5/bootstrap.min.css" type="text/css" />
    <script src="Bootstrap5/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="Bootstrap5/bootstrap-icons-1.10.3/bootstrap-icons.css" type="text/css" />
    <link rel="stylesheet" href="Bootstrap5/login.css" type="text/css" />
    <script>
        function loginValidation() {
            var email = document.getElementById("email").value;
            var password = document.getElementById("password").value;

            if (email == '' || password == '') {
                document.getElementById("validationWarning").innerHTML = 'Both email and password are required !';
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
        <h1 class="text-center">LOGIN</h1>
        <form id="loginForm" runat="server">
            <div class="form-group">
                <label class="form-label" for="email">Email address</label>
                <asp:TextBox class="form-control" runat="server" type="text" id="email"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <asp:TextBox class="form-control" runat="server" type="password" id="password"></asp:TextBox>
            </div>

            <div class="form-group form-check">
                <input class="form-check-input" type="checkbox" id="check" />
                <label class="form-check-label" for="check">Remember me</label>
            </div>
            <asp:Button ID="login" class="btn btn-success w-100" Text="SIGN IN" runat="server"
                OnClientClick="return loginValidation()" OnClick="login_Click"></asp:Button>
            
            <p id="validationWarning" runat="server" class="mt-3"></p>
        </form>
    </div>
</body>
</html>
