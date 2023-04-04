using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class LandingPage : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            cnn.Open();

            SqlCommand getGenreCommand = cnn.CreateCommand();
            getGenreCommand.CommandType = CommandType.Text;
            getGenreCommand.CommandText = "SELECT DISTINCT Genre FROM Books";
            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(getGenreCommand);

            adapter.Fill(dt);
            genreList.DataSource = dt;
            genreList.DataTextField = "Genre";
            genreList.DataValueField = "Genre";
            genreList.DataBind();
            if (genreList.Items.FindByText("All") == null)
            {
                genreList.Items.Add("All");
            }
            genreList.SelectedValue = "All";

            cnn.Close();

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

        protected void logoutBTN_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void loginBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void signupBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}