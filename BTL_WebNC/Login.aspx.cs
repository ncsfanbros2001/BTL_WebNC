using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (cnn.State == ConnectionState.Open)
            {
                cnn.Close();
            }
        }

        protected void login_Click(object sender, EventArgs e)
        {
            cnn.Open();

            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"SELECT * FROM Persons WHERE Email = '{email}' " +
                $"AND Password = '{password}'";
            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);

            int i = cmd.ExecuteNonQuery();

            if (dt.Rows.Count > 0)
            {
                Response.Redirect("LandingPage.aspx");
                Session.RemoveAll();
            }
            else
            {
                validationWarning.InnerText = "Your username or password is incorrect";
            }

            cnn.Close();
        }
    }
}