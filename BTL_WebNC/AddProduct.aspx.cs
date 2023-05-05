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
    public partial class AddProduct : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            if (Image.HasFile)
            {
                Image.SaveAs(Server.MapPath("images//" + Image.FileName));
            }
            SqlConnection con = new SqlConnection(@"SERVER=(localdb)\MSSQLLocalDB; DATABASE=BTL_WebNC;");
            SqlCommand cmd = new SqlCommand("sp_addProductt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Title", Title.Text);
            cmd.Parameters.AddWithValue("@Author", Author.Text);
            cmd.Parameters.AddWithValue("@Price", Convert.ToDouble(Price.Text).ToString("F2"));
            cmd.Parameters.AddWithValue("@Genre", Genre.Text);
            cmd.Parameters.AddWithValue("@Publisher", Publisher.Text);
            cmd.Parameters.AddWithValue("@year", Year.Text);
            cmd.Parameters.AddWithValue("@ImageLink", "images/" + Image.FileName);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("Products.aspx");
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Products.aspx");
        }
    }
}

/*string message = "Simple MessageBox";
string title = "Title";
MessageBox.Show(message, title);*/