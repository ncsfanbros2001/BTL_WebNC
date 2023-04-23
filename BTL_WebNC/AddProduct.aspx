<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="BTL_WebNC.AddProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Product</title>
    <script type="text/javascript">
        function addProductValidation() {
            var Title = document.getElementById('Title').value.trim();
            var Author = document.getElementById('Author').value.trim();
            var Price = document.getElementById('Price').value.trim();
            var Genre = document.getElementById('Genre').value.trim();
            var Publisher = document.getElementById('Publisher').value.trim();
            document.getElementById('firstErrorCol').innerHTML = '';

            var priceRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;
            var noNumberRegex = /^([^0-9]*)$/;

            var errorCount = 0;

            var fisrtErrorList = '';

            if (Title == '') {
                fisrtErrorList += '<li>title is required</li>';
                errorCount++;
            }
            else if (!Title.toLowerCase().match(noNumberRegex)) {
                fisrtErrorList += '<li>Tile cannot contain numbers</li>';
                errorCount++;
            }
            if (Author == '') {
                fisrtErrorList += '<li>author is required</li>';
                errorCount++;
            }
            else if (!Author.toLowerCase().match(noNumberRegex)) {
                fisrtErrorList += '<li>name of author cannot contain numbers</li>';
                errorCount++;
            }
            if (Price == '') {
                fisrtErrorList += '<li>Price is required</li>';
                errorCount++;
            }
            else if (!Price.toLowerCase().match(priceRegex)) {
                fisrtErrorList += '<li>your price is not valid</li>';
                errorCount++;
            }
            if (Genre == '') {
                fisrtErrorList += '<li>genre is required</li>';
                errorCount++;
            }
            else if (!Genre.toLowerCase().match(noNumberRegex)) {
                fisrtErrorList += '<li>genre cannot contain numbers</li>';
                errorCount++;
            }
            if (Publisher == '') {
                fisrtErrorList += '<li>publisher is required</li>';
                errorCount++;
            }
            else if (!Publisher.toLowerCase().match(noNumberRegex)) {
                fisrtErrorList += '<li>publisher cannot contain numbers</li>';
                errorCount++;
            }


            if (errorCount == 0) {
                return true;
            }
            else {
                document.getElementById('firstErrorCol').innerHTML = fisrtErrorList;
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: 300px;">
            <asp:TextBox ID="Title" runat="server"></asp:TextBox>
            <br />
            <asp:TextBox ID="Author" runat="server" Style="margin-bottom: 0px"></asp:TextBox>
            <br />
            <asp:TextBox ID="Price" runat="server"></asp:TextBox>
            <br />
            <asp:TextBox ID="Genre" runat="server"></asp:TextBox>
            <br />
            <asp:TextBox ID="Publisher" runat="server"></asp:TextBox>
            <br />
            <asp:FileUpload ID="Image" runat="server" />
            <br />
            <asp:Button runat="server" Text="ADD" ID="btn_add" OnClick="btn_add_Click" 
                                             OnClientClick="return addProductValidation()" />

       </div>
    </form>
     
        <div class="firstErrorList">
            <ul id="firstErrorCol" runat="server">
            </ul>
        </div>
</body>
</html>
