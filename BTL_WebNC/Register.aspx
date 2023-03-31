<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BTL_WebNC.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link rel="stylesheet" href="Bootstrap5/bootstrap.min.css" type="text/css" />
    <script src="Bootstrap5/bootstrap.bundle.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Bootstrap5/bootstrap-icons-1.10.3/bootstrap-icons.css" type="text/css" />
    <link rel="stylesheet" href="Bootstrap5/register.css" type="text/css" />
</head>
<body>
    <div class="login">
        <h1 class="text-center">REGISTER</h1>
        <h3 id="validationWarning" runat="server"></h3>

        <form id="loginForm" runat="server">
            <div class="form-group">
                <div class="row">
                    <div class="col">
                        <label class="form-label" for="firstname">First name</label>
                        <asp:TextBox class="form-control" runat="server" type="text" id="firstname"
                            placeholder="First Name"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label class="form-label" for="lastname">Last name</label>
                        <asp:TextBox class="form-control" runat="server" type="text" id="lastname"
                            placeholder="Last Name"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <asp:TextBox class="form-control" runat="server" type="text" id="email"
                    placeholder="Email"></asp:TextBox>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="col">
                        <label class="form-label" for="password">Password</label>
                        <asp:TextBox class="form-control" runat="server" type="password" id="password"
                            placeholder="Password"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label class="form-label" for="confirmPassword">Confirm Password</label>
                        <asp:TextBox class="form-control" runat="server" type="password" id="confirmPassword"
                            placeholder="Confirm Password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="col">
                        <label class="form-label" for="phoneNumber">Phone Number</label>
                        <asp:TextBox class="form-control" runat="server" type="number" id="phoneNumber"
                            placeholder="Phone Number"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label class="form-label" for="DOB">Date of Birth</label>
                        <asp:TextBox class="form-control" runat="server" type="date" id="DOB"
                            placeholder="Date of Birth"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row"> 
                    <label class="form-label" for="cars">Phone Number</label>
                    <select name="cars" id="cars">
                        <option value="volvo">Volvo</option>
                        <option value="saab">Saab</option>
                        <option value="opel">Opel</option>
                        <option value="audi">Audi</option>
                    </select>
                </div>
            </div>

            <asp:Button ID="login" class="btn btn-success w-100" Text="REGISTER" runat="server"></asp:Button>
        </form>
        
        <div class="container mt-3">
            <div class="row">
                <div class="col">
                    <button type="button" class="btn btn-danger w-100" onclick="window.location='LandingPage.aspx'">
                        HOME PAGE</button>
                </div>
                <div class="col">
                    <button type="button" class="btn btn-info w-100" onclick="window.location='Login.aspx'">
                        LOGIN</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
