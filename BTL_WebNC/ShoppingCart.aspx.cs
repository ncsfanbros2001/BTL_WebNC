using BTL_WebNC.ModelClasses;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace BTL_WebNC
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null || Session["role"].ToString() == "Admin")
            {
                Response.Redirect("LandingPage.aspx");
            }

            toUserInfo.HRef = "UserInfo.aspx?id=" + Session["id"];

            if (Session["role"].ToString() == "Admin")
            {
                userName.InnerText = Session["name"].ToString() + " (Admin) ";
                adminOnly.Visible = true;
                toCart.Visible = false;
            }
            else
            {
                userName.InnerText = Session["name"].ToString();
                adminOnly.Visible = false;
                toCart.Visible = true;
            }
        }

        protected void logoutBtn_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void continueShopping_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("LandingPage.aspx");
        }

        protected void checkout_ServerClick(object sender, EventArgs e)
        {
            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"SELECT COUNT(PersonID) FROM CartItems WHERE PersonID = {Session["id"]}";
            
            if (Convert.ToInt32(cmd.ExecuteScalar()) == 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "emptyAlert", "emptyCartAlert()", true);
            }
            if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
            {
                cnn.Close();
                Response.Redirect("Checkout.aspx");
            }
        }
    }
}