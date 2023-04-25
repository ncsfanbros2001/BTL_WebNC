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
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ID.Text = Session["id"].ToString();
        }

        protected void Change_Click(object sender, EventArgs e)
        {
         
            if (OldPassword.Text == Session["password"].ToString())
            {
                SqlConnection con = new SqlConnection(@"SERVER=(localdb)\MSSQLLocalDB; DATABASE=BTL_WebNC;");
                SqlCommand cmd = new SqlCommand("sp_changePW", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID.Text);
                cmd.Parameters.AddWithValue("@Password", NewPassword.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                
            }
            else
            {
                note.InnerText = "mat khau khong dung";
            }
        }
    }
}