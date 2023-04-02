﻿using BTL_WebNC.ModelClasses;
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
                Response.Cookies["rememberEmail"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["rememberPassword"].Expires = DateTime.Now.AddDays(15);

                Response.Redirect("LandingPage.aspx");
            }
            else if (isCorrect && !rememberMe.Checked)
            {
                Response.Cookies["rememberEmail"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["rememberPassword"].Expires = DateTime.Now.AddDays(-1);

                Response.Redirect("LandingPage.aspx");
            }
        }
    }
}