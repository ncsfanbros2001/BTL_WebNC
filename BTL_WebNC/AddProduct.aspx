<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="BTL_WebNC.AddProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Product</title>
    <link rel="stylesheet" type="text/css" href="CSS/addProductCSS.css" />
    <script type="text/javascript">
        function addProductValidation() {
            var Title = document.getElementById('Title').value.trim();
            var Author = document.getElementById('Author').value.trim();
            var Price = document.getElementById('Price').value.trim();
            var Genre = document.getElementById('Genre').value.trim();
            var Publisher = document.getElementById('Publisher').value.trim();
            document.getElementById('firstErrorCol').innerHTML = '';

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
        <div class="container">
            <h1 style="text-align: center; margin-bottom: 55px">Add Product</h1>
            <div id="form">
                <div style="display: inline-flex">
                    <label for="Title" style="margin-right: 45px;">Title</label>
                    <asp:TextBox ID="Title" runat="server"></asp:TextBox>
                </div>
                <br />
                <div style="display: inline-flex">
                    <label for="Author" style="margin-right: 30px;">Author</label>
                    <asp:TextBox ID="Author" runat="server"></asp:TextBox>
                </div>
                <br />
                <div style="display: inline-flex">
                    <label for="Price" style="margin-right: 40px;">Price</label>
                    <asp:TextBox ID="Price" runat="server" type="number"></asp:TextBox>
                </div>
                <br />
                <div style="display: inline-flex">
                    <label for="Genre" style="margin-right: 35px;">Genre</label>
                    <asp:TextBox ID="Genre" runat="server"></asp:TextBox>
                </div>
                <br />
                <div style="display: inline-flex">
                    <label for="Publisher" style="margin-right: 10px;">Publisher</label>
                    <asp:TextBox ID="Publisher" runat="server"></asp:TextBox>
                </div>
                <br />
                <div style="display: inline-flex">
                    <label for="Image">Image Link</label>
                    <asp:FileUpload ID="Image" runat="server" />
                </div>
                <br />
                <asp:Button runat="server" Text="ADD" ID="btn_add" OnClick="btn_add_Click"
                    OnClientClick="return addProductValidation()" />

                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" OnClick="btn_cancel_Click" />

            </div>

            <div id="firstErrorList">
                <ul id="firstErrorCol" runat="server">
                </ul>
            </div>
        </div>
    </form>

</body>
</html>


