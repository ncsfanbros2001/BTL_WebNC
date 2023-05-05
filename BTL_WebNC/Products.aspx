<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="BTL_WebNC.Products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products</title>
    <link rel="stylesheet" type="text/css" href="CSS/productsCSS.css" />
    <script type="text/javascript">
        function getProducts() {
            //var title = document.getElementById('searchBox').value;
            var title = '';
            var count = 0;
            var url = 'https://localhost:44374/WebService.asmx/GetProducts?title=' + title;

            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();

            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    const books = JSON.parse(xhttp.responseText);
                    let bookTableCode = `<tr style="background-color: lightgreen; height: 25px;">
                            <td><b>Title</b></td>
                            <td style="width:30%"><b>Price</b></td>
                            <td><b>Author</b></td>
                            <td><b>Remove</b></td>
                        </tr>`;
                    for (let book of books) {
                        bookTableCode += `<tr>
                                <td style="border-top: 1px solid #ccc;
                                    border-bottom: 1px solid #ccc;">` + book.Title + `</td>
                                <td style="border-top: 1px solid #ccc;
                                    border-bottom: 1px solid #ccc;">$` + book.Price + `</td>
                                <td style="border-top: 1px solid #ccc;
                                    border-bottom: 1px solid #ccc;">` + book.Author + `</td>
                                <td style="border-top: 1px solid #ccc;
                                    border-bottom: 1px solid #ccc;width: 6%;"><button id="btn_delbook" onClick="myFunction(` + book.Id +`)">Remove</button></td>
                            </tr>`;
                        count++;
                    }

                    document.getElementById('bookTable').innerHTML = bookTableCode;
                    document.getElementById('count1').innerHTML = count;
                }
            }
        }

        function myFunction(bookId) {
            let text = "Bạn muốn xóa sản phẩm này?";
            if (confirm(text) == true) {
                deleteBook(bookId);
            }
        }

        function deleteBook(bookId) {
            var url = 'https://localhost:44374/WebService.asmx/DeleteBook?bookId=' + bookId;
            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();
        }

    </script>
</head>
<body onload="getProducts()">
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
                    </div>
                    <li class="divider"></li>
                    <li><a runat="server" id="logoutBtn" onserverclick="logoutBTN_ServerClick">Logout</a></li>
                </ul>
            </label>
        </header>
        <!--<h1 id="count1"></h1>-->
        <!--<asp:TextBox ID="searchBox" placeholder="search by title..." type="search" oninput="getProducts()" runat="server"></asp:TextBox>-->

        <div style="margin-top:80px; margin-bottom: 150px;">
            <h1 style="text-align:center; margin-bottom: 15px; color: white; font-size: 45px;">All Products
            <button id="btn_Add"><a href="AddProduct.aspx" id="hrefadd">+Add Product</a></button>
            </h1>
            <table id="bookTable" class="table">
             </table>
        </div>
        <p id="text"></p>


        <footer>
            <div class="copyright">
                <p>© 2023 Copyright: <a class="text-white" href="#">BookLife.com</a></p>
            </div>
        </footer>
    </form>
</body>
</html>
