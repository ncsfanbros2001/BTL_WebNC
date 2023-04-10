using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_WebNC
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] != null)
            {
                Response.Redirect("LandingPage.aspx");
            }
        }

        protected void register_Click(object sender, EventArgs e)
        {
            cnn.Open();

            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"INSERT INTO Persons (Fullname, Email, Password, PhoneNumber, DOB, Gender, Position)"
                + $"VALUES (N'{firstname.Text} {lastname.Text}', '{email.Text}', '{password.Text}', " +
                $"'{phoneNumber.Text}', '{DOB.Text}', '{genderSelector.SelectedItem.Text}', 'Customer')";

            List<Persons> userList = (List<Persons>)Application["users"];

            bool isMatch = false;
            string inputErrorList = "";
            foreach (Persons person in userList)
            {
                if (email.Text == person.Email || password.Text == person.Password
                    || phoneNumber.Text == person.PhoneNumber)
                {
                    isMatch = true;
                    if (person.Email == email.Text)
                    {
                        inputErrorList += "<li>Email already exist</li>";
                    }
                    if (person.Password == password.Text)
                    {
                        inputErrorList += "<li>Password already exist</li>";
                    }
                    if (person.PhoneNumber == phoneNumber.Text)
                    {
                        inputErrorList += "<li>PhoneNumber already exist</li>";
                    }
                    break;
                }
            }

            if (isMatch)
            {
                firstErrorCol.InnerHtml = inputErrorList;
            }
            else
            {
                SqlCommand getCurrentID = cnn.CreateCommand();
                getCurrentID.CommandType = CommandType.Text;
                getCurrentID.CommandText = $"SELECT MAX(Id) FROM Persons";

                Persons person = new Persons();

                person.ID = (int)getCurrentID.ExecuteScalar() + 1;
                person.Fullname = firstname.Text.ToString() + lastname.Text.ToString();
                person.Email = email.Text.ToString();
                person.Password = password.Text.ToString();
                person.PhoneNumber = phoneNumber.Text.ToString();
                person.DOB = DOB.Text.ToString();
                person.Gender = genderSelector.Text.ToString();
                person.Position = "Customer";

                userList.Add(person);

                cmd.ExecuteNonQuery();
                cnn.Close();
                Response.Write("<script>alert('Register Successful');</script>");
                Response.Redirect("Login.aspx");
            }
        }

    }
}