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
    public partial class Checkout : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Persons> userList = (List<Persons>)Application["users"];
            List<CartItems> cartItemList = (List<CartItems>)Application["cartItems"];

            if (Session["name"] == null)
            {
                Response.Redirect("LandingPage.aspx");
            }

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

            foreach (Persons person in userList)
            {
                if (person.ID == Convert.ToInt32(Session["id"]))
                {
                    customerName.Value = person.Fullname;
                    customerEmail.Value = person.Email;
                    customerPhoneNumber.Value = person.PhoneNumber;
                    orderDate.Value = DateTime.Now.ToString("dd-MM-yyyy");
                    estimatedReceiveDate.Value = DateTime.Now.AddDays(3).ToString("dd-MM-yyyy");
                    break;
                }
            }
        }

        protected void logoutBtn_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void checkout_ServerClick(object sender, EventArgs e)
        {
            List<CartItems> cartItemList = (List<CartItems>)Application["cartItems"];
            int currentID = 1;
            
            SqlCommand getCurrentPurchaseID = cnn.CreateCommand();
            getCurrentPurchaseID.CommandType = CommandType.Text;
            getCurrentPurchaseID.CommandText = "SELECT ISNULL(MAX(PurchasedItemID), 0) FROM PurchaseList";

            cnn.Open();
            if ((int)getCurrentPurchaseID.ExecuteScalar() != 0) // IS NULL = false
            {
                currentID = (int)getCurrentPurchaseID.ExecuteScalar() + 1;
            }

            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;

            cmd.CommandText = $"INSERT INTO PurchaseHistory (PersonID, OrderDate, EstimateReceiveDate, Address," +
                    $"Note, TotalPrice) VALUES ({Session["id"]}, '{orderDate.Value}', " +
                    $"'{estimatedReceiveDate.Value}', '{address.Value}', '{note.Value}'," +
                    $"{totalPrice.InnerText.Trim('$')})";

            cmd.ExecuteNonQuery();

            foreach (CartItems cartItem in cartItemList)
            {
                if (cartItem.PersonID == Convert.ToInt32(Session["id"]))
                {
                    cmd.CommandText = $"INSERT INTO PurchaseList (ReceiptID, BookID, Quantity) VALUES" +
                        $"({currentID}, '{cartItem.BookID}', {cartItem.quantity})";
                    cmd.ExecuteNonQuery();
                }
            }

            cnn.Close();
            Response.Redirect("LandingPage.aspx");
        }

        protected void back2Cart_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("ShoppingCart.aspx");
        }
    }
}