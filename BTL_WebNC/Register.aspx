<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BTL_WebNC.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link rel="stylesheet" href="CSS/registerCSS.css" type="text/css" />
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
    <div class="register">
        <h1>REGISTER</h1>

		<div id="errorSummary">
			<div class="firstErrorList">
				<ul id="firstErrorCol" runat="server">
				</ul>
			</div>
			<div class="secondErrorList">
				<ul id="secondErrorCol">
				</ul>
			</div>
		</div>

        <form id="registerForm" runat="server">
            <div class="firstAndLastName">
				<div class="firstName Col">
					<label for="firstname">First name</label>
					<br/>
                    <asp:TextBox ID="firstname" runat="server" type="text" placeholder="First Name"></asp:TextBox>
				</div>
				<div class="lastName Col">
					<label for="lastname">Last name</label>
					<br/>
					<asp:TextBox ID="lastname" runat="server" type="text" placeholder="Last Name"></asp:TextBox>
				</div>
			</div>

			<div class="emailAndGender">
				<div class="email Col">
					<label for="email">Email</label>
					<br/>
					<asp:TextBox ID="email" runat="server" type="text" placeholder="Email"></asp:TextBox>
				</div>
				<div class="gender Col">
					<label for="gender">Gender</label>
					<br/>
					<asp:DropDownList ID="genderSelector" runat="server">
                        <asp:ListItem Selected="True">Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                    </asp:DropDownList>
				</div>
			</div>

			<div class="passwords">
				<div class="password Col">
					<label for="password">Password</label>
					<br/>
					<asp:TextBox ID="password" runat="server" type="password" placeholder="Password"></asp:TextBox>
				</div>
				<div class="confirmPassword Col">
					<label for="confirmPassword">Confirm Password</label>
					<br/>
					<asp:TextBox ID="confirmPassword" runat="server" type="password" placeholder="Retype Password">

					</asp:TextBox>
				</div>
			</div>

			<div class="phoneNumberAndDOB">
				<div class="phoneNumber Col">
					<label for="phoneNumber">Phone Number</label>
					<br/>
					<asp:TextBox ID="phoneNumber" runat="server" type="number" placeholder="Phone Number">

					</asp:TextBox>
				</div>
				<div class="dateOfBirth Col">
					<label for="dob">Date of Birth</label>
					<br/>
					<asp:TextBox ID="DOB" runat="server" type="date"></asp:TextBox>
				</div>
			</div>

            <asp:Button ID="register" Text="SIGN UP" runat="server" OnClick="register_Click"
                OnClientClick="return registerValidation()"></asp:Button>
        </form>

        <div class="otherOptions">
            <button type="button" id="toHomePage" runat="server" onclick="window.location.href='LandingPage.aspx'">
                HOME PAGE</button>
            <button type="button" id="toLogin" runat="server" onclick="window.location.href='Login.aspx'">
                LOG IN</button>
        </div>
    </div>
</body>
</html>
