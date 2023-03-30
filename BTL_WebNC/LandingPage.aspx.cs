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
            categoryList.DataSource = dt;
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