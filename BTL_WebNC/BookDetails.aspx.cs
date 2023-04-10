using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class Details : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            int bookID = Convert.ToInt32(Request.QueryString["id"]);
            List<Books> bookList = (List<Books>)Application["books"];
            List<Persons> userList = (List<Persons>)Application["users"];

            foreach (Books book in bookList)
            {
                if (book.Id == bookID)
                {
                    title.InnerText = book.Title;
                    price.InnerText = "$" + book.Price.ToString();
                    author.InnerText = book.Author;
                    genre.InnerText = book.Genre;
                    publisher.InnerText = book.Publisher;
                    image.Src = book.ImageLink;
                    break;
                }
            }

            if (Session["name"] == null)
            {
                authenticationControls.Visible = true;
                accountControls.Visible = false;
            }
            else
            {
                authenticationControls.Visible = false;
                accountControls.Visible = true;

                toUserInfo.HRef = "UserInfo.aspx?id=" + Session["id"];

                if (Session["role"].ToString() == "Admin")
                {
                    userName.InnerText = Session["name"].ToString() + " (Admin) ";
                    adminOnly.Visible = true;
                    toCart.Visible = false;
                    checkoutRegion.Visible = false;
                }
                else
                {
                    userName.InnerText = Session["name"].ToString();
                    adminOnly.Visible = false;
                    toCart.Visible = true;
                    checkoutRegion.Visible = true;
                }
            }
        }

        protected void loginBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void signupBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void logoutBtn_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void add2Cart_ServerClick(object sender, EventArgs e)
        {
            List<Books> bookList = (List<Books>)Application["books"];
            List<Persons> userList = (List<Persons>)Application["users"];
            List<CartItems> cartItemList = (List<CartItems>)Application["cartItems"];
            int bookID = Convert.ToInt32(Request.QueryString["id"]);
            bool existed = false;
            int highestID = 1;

            if (cartItemList.Count > 0)
            {
                highestID = cartItemList.Max(u => u.CartItemID);
            }

            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;

            if (Session["name"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                cnn.Open();

                foreach (CartItems cartItem in cartItemList) // Check if item has existed in cart or not
                {
                    if (cartItem.BookID == bookID &&
                        cartItem.PersonID == Convert.ToInt32(Session["id"])) // Item already existed
                    {
                        existed = true;
                        cartItem.quantity += Convert.ToInt32(amount.Value);
                        cmd.CommandText = $"UPDATE CartItems SET Quantity = Quantity " +
                            $"+ {Convert.ToInt32(amount.Value)}, TotalPrice = TotalPrice + " +
                            $"({Convert.ToInt32(amount.Value)} * {cartItem.BookPrice}) WHERE BookID = {bookID}";
                        break;
                    }
                }

                if (!existed) // Item not yet existed
                {
                    CartItems cartItem = new CartItems();
                    cmd.CommandText = "INSERT INTO CartItems (PersonID, PersonFullname, PersonPhoneNumber, BookID," +
                            "BookTitle, BookPrice, BookImageLink, Quantity, TotalPrice)";

                    foreach (Persons person in userList)
                    {
                        if (person.Fullname == Session["name"].ToString())
                        {
                            cmd.CommandText += $"VALUES ({person.ID}, N'{person.Fullname}', '{person.PhoneNumber}',";

                            cartItem.CartItemID = highestID + 1;
                            cartItem.PersonID = person.ID;
                            cartItem.PersonFullname = person.Fullname;
                            cartItem.PersonPhoneNumber = person.PhoneNumber;
                            break;
                        }
                    }

                    foreach (Books book in bookList)
                    {
                        if (book.Id == bookID)
                        {
                            cmd.CommandText += $"{bookID}, N'{book.Title}', {book.Price}, '{book.ImageLink}', " +
                                $"{amount.Value}, {Convert.ToInt32(amount.Value) * book.Price})";

                            cartItem.BookID = bookID;
                            cartItem.BookTitle = book.Title;
                            cartItem.BookPrice = book.Price;
                            cartItem.quantity = Convert.ToInt32(amount.Value);
                            cartItem.TotalPrice = Convert.ToInt32(amount.Value) * book.Price;
                            cartItem.BookImageLink = book.ImageLink;
                            break;
                        }
                    }

                    cartItemList.Add(cartItem);
                }

                cmd.ExecuteNonQuery();

                cnn.Close();

                Response.Redirect("ShoppingCart.aspx");
            }
        }
    }
}