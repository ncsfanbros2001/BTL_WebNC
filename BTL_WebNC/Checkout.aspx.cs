using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Persons> userList = (List<Persons>)Application["users"];

            if (Session["name"] == null)
            {
                Response.Redirect("LandingPage.aspx");
            }

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

        }

        protected void checkout_ServerClick(object sender, EventArgs e)
        {

        }
    }
}