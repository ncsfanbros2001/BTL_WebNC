using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class CPH : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            toUserInfo.HRef = "UserInfo.aspx?id=" + Session["id"];
        }
        protected void logoutBTN_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}