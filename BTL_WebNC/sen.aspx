<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sen.aspx.cs" Inherits="BTL_WebNC.ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="ID" runat="server"></asp:TextBox>
            <asp:TextBox ID="OldPassword" runat="server"></asp:TextBox>
            <p><span id="note" runat="server"></span></p>
            <asp:TextBox ID="NewPassword" runat="server"></asp:TextBox>
            <asp:TextBox ID="NewPassword2" runat="server"></asp:TextBox>
            <asp:Button ID="Change" runat="server" Text="Update" OnClick="Change_Click" />
        </div>
    </form>
</body>
</html>
