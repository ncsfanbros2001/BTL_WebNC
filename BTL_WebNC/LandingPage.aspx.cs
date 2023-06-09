﻿using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace BTL_WebNC
{
    public partial class LandingPage : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["reloadCounter"] = Convert.ToInt32(Session["reloadCounter"]) + 1;

            counter.InnerText = Session["reloadCounter"].ToString();

            List<Persons> userList = (List<Persons>)Application["users"];
            cnn.Open();

            SqlCommand getGenreCommand = cnn.CreateCommand();
            getGenreCommand.CommandType = CommandType.Text;
            getGenreCommand.CommandText = "SELECT DISTINCT Genre FROM Books";
            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(getGenreCommand);

            adapter.Fill(dt);
            genreList.DataSource = dt;
            genreList.DataTextField = "Genre";
            genreList.DataValueField = "Genre";
            genreList.DataBind();
            if (genreList.Items.FindByText("All") == null)
            {
                genreList.Items.Add("All");
            }
            genreList.SelectedValue = "All";

            cnn.Close();

            if (Session["name"] == null)
            {
                authenticationControls.Visible = true;
                accountControls.Visible = false;
            }
            else
            {
                authenticationControls.Visible = false;
                accountControls.Visible = true;

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
        }

        protected void logoutBTN_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void loginBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void signupBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}