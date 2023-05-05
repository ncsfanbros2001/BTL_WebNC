using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;


namespace BTL_WebNC
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] != null)
            {
                Response.Redirect("LandingPage.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.Cookies["rememberEmail"] != null)
                {
                    email.Text = Request.Cookies["rememberEmail"].Value;
                }
                if (Request.Cookies["rememberPassword"] != null)
                {
                    password.Text = Request.Cookies["rememberPassword"].Value;
                }
                if (Request.Cookies["rememberEmail"] != null && Request.Cookies["rememberPassword"] != null)
                {
                    rememberMe.Checked = true;
                }
            }
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
                    Session["role"] = person.Position;
                    Session["id"] = person.ID;
                    Session["password"] = person.Password;

                    Response.Cookies["rememberEmail"].Value = person.Email;
                    Response.Cookies["rememberPassword"].Value = person.Password;

                    break;
                }
            }

            if (!isCorrect)
            {
                validationWarning.InnerText = "Your username or password is incorrect";
            }
            else if (isCorrect && rememberMe.Checked)
            {
                Session.Timeout = 60;
                Response.Cookies["rememberEmail"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["rememberPassword"].Expires = DateTime.Now.AddDays(15);

                Response.Redirect("LandingPage.aspx");
            }
            else if (isCorrect && !rememberMe.Checked)
            {
                Session.Timeout = 60;
                Response.Cookies["rememberEmail"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["rememberPassword"].Expires = DateTime.Now.AddDays(-1);

                Response.Redirect("LandingPage.aspx");
            }
        }
    }
}