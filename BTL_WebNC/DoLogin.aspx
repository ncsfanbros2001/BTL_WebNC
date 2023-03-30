<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoLogin.aspx.cs" Inherits="BTL_WebNC.DoLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>Hello <%Response.Write(Session["name"]); %></p>
        </div>
    </form>
</body>
</html>
