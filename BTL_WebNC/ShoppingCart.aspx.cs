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
    public partial class ShoppingCart : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {
                Response.Redirect("LandingPage.aspx");
            }
            List<Persons> userList = (List<Persons>)Application["users"];

            if (Session["name"] == null)
            {
                authenticationControls.Visible = true;
                accountControls.Visible = false;
            }
            else
            {
                authenticationControls.Visible = false;
                accountControls.Visible = true;

                foreach (Persons person in userList)
                {
                    if (person.Fullname == Session["name"].ToString())
                    {
                        toUserInfo.HRef = "UserInfo.aspx?id=" + person.ID;
                        break;
                    }
                }

                if (Session["role"].ToString() == "Admin")
                {
                    userName.InnerText = Session["name"].ToString() + " (Admin) ";
                }
                else
                {
                    userName.InnerText = Session["name"].ToString();
                }
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

        protected void loginBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void signupBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
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

            int count = Convert.ToInt32(cmd.ExecuteScalar());
            
            if (count == 0)
            {
                emptyCartAlert.InnerText = "Your cart is empty";
            }
            else if (count > 0)
            {
                cnn.Close();
                Response.Redirect("Checkout.aspx");
            }
        }
    }
}