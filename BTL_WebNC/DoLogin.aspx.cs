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
    public partial class DoLogin : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request.Form["email"];
            string password = Request.Form["password"];

            if (cnn.State == ConnectionState.Open)
            {
                cnn.Close();
            }
            cnn.Open();

            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"SELECT * FROM Persons WHERE Email = '{email}' " +
                $"AND Password = '{password}'";
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Response.Redirect("LandingPage.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}