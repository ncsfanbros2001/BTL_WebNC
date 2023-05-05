using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            userName.InnerText = Session["name"].ToString() + " (Admin) ";
            adminOnly.Visible = true;
            toUserInfo.HRef = "UserInfo.aspx?id=" + Session["id"];
        }
        protected void logoutBTN_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}