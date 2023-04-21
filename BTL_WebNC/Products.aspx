<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="BTL_WebNC.Products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products</title>
    <link rel="stylesheet" type="text/css" href="CSS/productsCSS.css" />
    <script type="text/javascript">
        function getproducts() {
            var url = 'https://localhost:44374/WebService.asmx/GetBooks?genre=All&title=';

            const xhttp = new XMLHttpRequest();
            xhttp.open("GET", url, true);
            xhttp.send();

            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    const books = JSON.parse(xhttp.responseText);
                    let bookTableCode = `<tr>
                            <td><b>Title</b></td>
                            <td><b>Price</b></td>
                            <td><b>Author</b></td>
                            <td><b>Remove</b></td>
                        </tr>`;
                    for (let book of books) {
                        bookTableCode += `<tr>
                                <td>` + book.Title + `</td>
                                <td>$` + book.Price + `</td>
                                <td>` + book.Author + `</td>
                                <td><button id="btn_delbook" onClick="deleteBook(`+ book.Id + `)">Remove</button></td>
                            </tr>`;
                    }
                    document.getElementById('bookTable').innerHTML = bookTableCode;
                }
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
<body onload="getproducts()">
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
                        <!--<li><a href="CPH.aspx">Customer Purchase History</a></li>-->
                    </div>
                    <li class="divider"></li>
                    <li><a runat="server" id="logoutBtn" onserverclick="logoutBTN_ServerClick">Logout</a></li>
                </ul>
            </label>
        </header>

        <div style="margin-top:120px; margin-bottom: 180px;">
        <h1 style="text-align:center; margin-bottom: 15px;">All Products</h1>

        <table id="bookTable" border="1";>
        </table>
        </div>


        <footer>
            <div class="copyright">
                <p>© 2023 Copyright: <a class="text-white" href="#">BookLife.com</a></p>
            </div>
        </footer>
    </form>
</body>
</html>
