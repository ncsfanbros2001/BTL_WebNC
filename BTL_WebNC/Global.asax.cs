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
            SqlCommand getAllUsersCommand = cnn.CreateCommand();
            getAllUsersCommand.CommandType = CommandType.Text;
            getAllUsersCommand.CommandText = "SELECT * FROM Persons";

            SqlDataReader usersReader = getAllUsersCommand.ExecuteReader();

            while (usersReader.Read())
            {
                Persons person = new Persons();

                person.ID = Convert.ToInt32(usersReader["ID"]);
                person.Fullname = usersReader["Fullname"].ToString();
                person.Email = usersReader["Email"].ToString();
                person.Password = usersReader["Password"].ToString();
                person.PhoneNumber = usersReader["PhoneNumber"].ToString();
                person.DOB = usersReader["DOB"].ToString();
                person.Gender = usersReader["Gender"].ToString();
                person.Position = usersReader["Position"].ToString();

                userList.Add(person);
            }
            
            List<Books> bookList = new List<Books>();
            Application["books"] = bookList;

            SqlCommand getAllBooksCommand = cnn.CreateCommand();
            getAllBooksCommand.CommandType = CommandType.Text;
            getAllBooksCommand.CommandText = "SELECT * FROM Books";
            cnn.Close();

            cnn.Open();
            SqlDataReader booksReader = getAllBooksCommand.ExecuteReader();

            while (booksReader.Read())
            {
                Books book = new Books();

                book.Id = Convert.ToInt32(booksReader["ID"]);
                book.Title = booksReader["Title"].ToString();
                book.Author = booksReader["Author"].ToString();
                book.Price = Convert.ToDouble(booksReader["Price"]);
                book.Genre = booksReader["Genre"].ToString();
                book.Publisher = booksReader["Publisher"].ToString();
                book.ImageLink = booksReader["ImageLink"].ToString();

                bookList.Add(book);
            }
            cnn.Close();
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["role"] = "none";
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