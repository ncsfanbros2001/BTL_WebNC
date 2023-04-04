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
    public partial class BookDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int bookID = Convert.ToInt32(Request.QueryString["id"]);
            List<Books> bookList = (List<Books>)Application["books"];

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
            }

            if (Session["role"].ToString() == "Admin")
            {
                adminOnly.Visible = true;
                toCart.Visible = false;
            }
            else
            {
                adminOnly.Visible = false;
                toCart.Visible = true;
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
    }

    
}