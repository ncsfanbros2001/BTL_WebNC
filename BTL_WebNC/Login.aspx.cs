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
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            List<Persons> userList = (List<Persons>)Application["users"];

            bool isCorrect = false;
            foreach (Persons person in userList)
            {
                if (person.Email == email.Text && person.Password == password.Text)
                {
                    isCorrect = true;
                    Session["name"] = person.Fullname;
                    break;
                }
            }

            if (!isCorrect)
            {
                validationWarning.InnerText = "Your username or password is incorrect";
            }
            else
            {
                Response.Redirect("LandingPage.aspx");
            }
            
        }
    }
}