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
    public partial class UserInfo : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["id"]);
            List<Persons> userList = (List<Persons>)Application["users"];
            List<CartItems> ItemList = (List<CartItems>)Application["cartitems"];

            if (Session["name"] == null)
            {
                Response.Redirect("LandingPage.aspx");
            }

            if(Session["role"].ToString() == "Admin")
            {
                userName.InnerText = Session["name"].ToString() + " (Admin)";
                adminOnly.Visible = true;
                toCart.Visible = false;
            }
            else
            {
                userName.InnerText = Session["name"].ToString();
                adminOnly.Visible = false;
                toCart.Visible = true;
            }

            foreach(Persons person in userList)
            {
                if(person.ID == userId)
                {
                    fullName.InnerText = person.Fullname;
                    email.InnerText = person.Email;
                    phoneNumber.InnerText = person.PhoneNumber;
                    dob.InnerText = person.DOB;
                    position.InnerText = person.Position;
                }
            }
        }
        protected void logoutBTN_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }

}
