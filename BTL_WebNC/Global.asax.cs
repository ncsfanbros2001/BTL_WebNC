using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace BTL_WebNC
{
    public class Global : System.Web.HttpApplication
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Application_Start(object sender, EventArgs e)
        {
            List<Persons> userList = new List<Persons>();
            Application["users"] = userList;

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM Persons";

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Persons person = new Persons();

                person.ID = Convert.ToInt32(reader["ID"]);
                person.Fullname = reader["Fullname"].ToString();
                person.Email = reader["Email"].ToString();
                person.Password = reader["Password"].ToString();
                person.PhoneNumber = reader["PhoneNumber"].ToString();
                person.PhoneNumber = reader["DOB"].ToString();
                person.PhoneNumber = reader["Gender"].ToString();
                person.Position = reader["Position"].ToString();

                userList.Add(person);
            }

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["name"] = null;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}