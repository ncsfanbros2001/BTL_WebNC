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
            DataTable dt1 = new DataTable(); 
            SqlDataAdapter adapter = new SqlDataAdapter(getGenreCommand);

            // Get all book's genre
            getGenreCommand.CommandType = CommandType.Text;
            getGenreCommand.CommandText = "SELECT DISTINCT Genre FROM Books";

            adapter.Fill(dt1);
            categoryList.DataSource = dt1;
            categoryList.DataTextField = "Genre";
            categoryList.DataValueField = "Genre";
            categoryList.DataBind();
            categoryList.Items.Add("All");

            // Get all books
            SqlCommand getProductCommand = cnn.CreateCommand();
            DataTable dt2 = new DataTable();
            SqlDataAdapter adapter2 = new SqlDataAdapter(getProductCommand);

            getProductCommand.CommandType = CommandType.Text;
            getProductCommand.CommandText = "SELECT * FROM Books";
            adapter2.Fill(dt2);
            productList.DataSource = dt2;
            productList.DataBind();

            cnn.Close();
        }
    }
}