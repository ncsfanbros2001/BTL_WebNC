<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BTL_WebNC.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link rel="stylesheet" href="Bootstrap5/bootstrap.min.css" type="text/css" />
    <script src="Bootstrap5/bootstrap.bundle.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Bootstrap5/bootstrap-icons-1.10.3/bootstrap-icons.css" type="text/css" />
    <link rel="stylesheet" href="Bootstrap5/register.css" type="text/css" />
    <script type="text/javascript">
        function registerValidation() {
            var firstname = document.getElementById('firstname').value.trim();
            var lastname = document.getElementById('lastname').value.trim();
            var email = document.getElementById('email').value.trim();
            var password = document.getElementById('password').value.trim();
            var confirmPassword = document.getElementById('confirmPassword').value.trim();
            var dob = document.getElementById('DOB').value.trim();
            var phoneNumber = document.getElementById('phoneNumber').value.trim();
            document.getElementById('firstErrorCol').innerHTML = '';
            document.getElementById('secondErrorCol').innerHTML = '';

            var emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
            var phoneNumberRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;
            var noNumberRegex = /^([^0-9]*)$/;
            var reformattedDOB = new Date(dob);
            var todayDate = new Date();
            
            var errorCount = 0;

            var firstErrorList = '';
            if (firstname == '') {
                firstErrorList += '<li>First name is required</li>';
                errorCount++;
            }
            else if (!firstname.toLowerCase().match(noNumberRegex)) {
                firstErrorList += '<li>First name cannot contain numbers</li>';
                errorCount++;

            }

            if (lastname == '') {
                firstErrorList += '<li>Last name is required</li>';
                errorCount++;
            }
            else if (!lastname.toLowerCase().match(noNumberRegex)) {
                firstErrorList += '<li>Last name cannot contain numbers</li>';
                errorCount++;;
            }

            if (email == '') {
                firstErrorList += '<li>Email is required</li>';
                errorCount++;
            }
            else if (!email.toLowerCase().match(emailRegex)) {
                firstErrorList += '<li>Your Email is not valid</li>';
                errorCount++;
            }
             
            if (dob == '') {
                firstErrorList += '<li>Date of Birth is required</li>';
                errorCount++;
            }
            else if (todayDate <= reformattedDOB) {
                firstErrorList += '<li>Date of Birth cannot be greater than today</li>';
                errorCount++;
            }


            var secondErrorList = '';
            if (password == '') {
                secondErrorList += '<li>Password is required</li>';
                errorCount++;
            }

            if (confirmPassword != password) {
                secondErrorList += '<li>The Password Confirm has to match with the Password</li>';
                errorCount++;
            }
            else if (confirmPassword == '') {
                secondErrorList += '<li>Password Confirm is required</li>';
                errorCount++;
            }

            if (phoneNumber == '') {
                secondErrorList += '<li>Phone Number is required</li>';
                errorCount++;
            }
            else if (!phoneNumber.match(phoneNumberRegex)) {
                firstErrorList += '<li>Your Phone Number is not valid</li>';
                errorCount++;
            }
            


            if (errorCount == 0) {
                return true;
            }
            else {
                document.getElementById('firstErrorCol').innerHTML = firstErrorList;
                document.getElementById('secondErrorCol').innerHTML = secondErrorList;
                return false;
            }
        }
    </script>
</head>
<body>
    <div class="login">
        <h1 class="text-center">REGISTER</h1>

        <div class="container" id="errorSummary">
            <div class="row">
                <div class="col">
                    <ul id="firstErrorCol" runat="server">
                        
                    </ul>
                </div>
                <div class="col">
                    <ul id="secondErrorCol" runat="server">
                        
                    </ul>
                </div>
            </div>
        </div>

        <form id="loginForm" runat="server">
            <div class="form-group">
                <div class="row">
                    <div class="col">
                        <label class="form-label" for="firstname">First name</label>
                        <asp:TextBox class="form-control" runat="server" type="text" ID="firstname"
                            placeholder="First Name"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label class="form-label" for="lastname">Last name</label>
                        <asp:TextBox class="form-control" runat="server" type="text" ID="lastname"
                            placeholder="Last Name"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="col-9">
                        <label class="form-label" for="email">Email</label>
                        <asp:TextBox class="form-control" runat="server" type="text" ID="email"
                            placeholder="Email"></asp:TextBox>
                    </div>
                    <div class="col-3">
                        <label class="form-label" for="gender">Gender</label>
                        <br />
                        <asp:DropDownList ID="gender" runat="server">
                            <asp:ListItem Selected="True">Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="col">
                        <label class="form-label" for="password">Password</label>
                        <asp:TextBox class="form-control" runat="server" type="password" ID="password"
                            placeholder="Password"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label class="form-label" for="confirmPassword">Confirm Password</label>
                        <asp:TextBox class="form-control" runat="server" type="password" ID="confirmPassword"
                            placeholder="Confirm Password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="col">
                        <label class="form-label" for="phoneNumber">Phone Number</label>
                        <asp:TextBox class="form-control" runat="server" type="number" ID="phoneNumber"
                            placeholder="Phone Number"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label class="form-label" for="DOB">Date of Birth</label>
                        <asp:TextBox class="form-control" runat="server" type="date" ID="DOB"
                            placeholder="Date of Birth"></asp:TextBox>
                    </div>
                </div>
            </div>

            <asp:Button ID="register" class="btn btn-success w-100" Text="SIGN UP" runat="server"
                OnClientClick="return registerValidation()" OnClick="register_Click"></asp:Button>
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
