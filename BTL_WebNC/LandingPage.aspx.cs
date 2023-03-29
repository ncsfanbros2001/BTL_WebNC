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
            if (categoryList.Items.FindByText("All") == null)
            {
                categoryList.Items.Add("All");
            }
            categoryList.SelectedValue = "All";

            cnn.Close();
        }
    }
}