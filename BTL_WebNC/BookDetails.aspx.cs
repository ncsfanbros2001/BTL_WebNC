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
                    productImg.Src = book.ImageLink;
                    break;
                }
            }

            if (Session["name"] == null)
            {
                authenticationControls.Visible = true;
                userControls.Visible = false;
            }
            else
            {
                authenticationControls.Visible = false;
                userControls.Visible = true;
            }

            if (Session["role"].ToString() != "Admin")
            {
                adminOnly.Visible = false;
                toCart.Visible = true;
            }
            else
            {
                adminOnly.Visible = true;
                toCart.Visible = false;
            }
        }
    }
}