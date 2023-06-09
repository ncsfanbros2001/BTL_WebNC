﻿using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace BTL_WebNC
{
    public partial class Checkout : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Persons> userList = (List<Persons>)Application["users"];

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"SELECT COUNT(PersonID) FROM CartItems WHERE PersonID = {Session["id"]}";

            if (Session["name"] == null || Convert.ToInt32(cmd.ExecuteScalar()) == 0
                || Session["role"].ToString() == "Admin")
            {
                Response.Redirect("LandingPage.aspx");
            }
            cnn.Close();

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
                    orderDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
                    estimatedReceiveDate.Value = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd");
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
            double totalPrice = 0;

            foreach (CartItems cartItem in cartItemList)
            {
                if (cartItem.PersonID == Convert.ToInt32(Session["id"]))
                {
                    totalPrice += cartItem.TotalPrice;
                }
            }

            SqlCommand getCurrentPurchaseID = cnn.CreateCommand();
            getCurrentPurchaseID.CommandType = CommandType.Text;
            getCurrentPurchaseID.CommandText = "SELECT ISNULL(MAX(PurchasedItemID), 0) FROM PurchaseList";

            cnn.Open();
            if ((int)getCurrentPurchaseID.ExecuteScalar() != 0) // IS NULL = false
            {
                currentID = (int)getCurrentPurchaseID.ExecuteScalar() + 1;
            }

            if (address.Value.Length == 0) {
                addressRequired.InnerText = "Address is required";
            }
            else
            {
                SqlCommand insertReceiptCommand = cnn.CreateCommand();
                insertReceiptCommand.CommandType = CommandType.Text;

                insertReceiptCommand.CommandText = "INSERT INTO PurchaseHistory (PersonID, OrderDate, EstimateReceiveDate, Address," +
                    "Note, TotalPrice) VALUES (@PersonID, @OrderDate, @EstimateReceiveDate, @Address, @Note," +
                    "@TotalPrice)";
                insertReceiptCommand.Parameters.AddWithValue("@PersonID", Session["id"]);
                insertReceiptCommand.Parameters.AddWithValue("@OrderDate", orderDate.Value);
                insertReceiptCommand.Parameters.AddWithValue("@EstimateReceiveDate", estimatedReceiveDate.Value);
                insertReceiptCommand.Parameters.AddWithValue("@Address", address.Value);
                insertReceiptCommand.Parameters.AddWithValue("@Note", note.Value);
                insertReceiptCommand.Parameters.AddWithValue("@TotalPrice", totalPrice);

                insertReceiptCommand.ExecuteNonQuery();

                foreach (CartItems cartItem in cartItemList)
                {
                    if (cartItem.PersonID == Convert.ToInt32(Session["id"]))
                    {
                        SqlCommand insertBooksCommand = cnn.CreateCommand();
                        insertBooksCommand.CommandType = CommandType.Text;

                        insertBooksCommand.CommandText = $"INSERT INTO PurchaseList (ReceiptID, BookID, Quantity) VALUES" +
                            $"({currentID}, '{cartItem.BookID}', {cartItem.quantity})";
                        insertBooksCommand.ExecuteNonQuery();
                    }
                }

                SqlCommand deleteCartItemsCommand = cnn.CreateCommand();
                deleteCartItemsCommand.CommandType = CommandType.Text;

                deleteCartItemsCommand.CommandText = $"DELETE FROM CartItems WHERE PersonID = {Session["id"]}";
                deleteCartItemsCommand.ExecuteNonQuery();

                cnn.Close();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text",
                    "alert(\"Checkout completed! Thank you for shopping with BookLife!\");" +
                    "window.location ='LandingPage.aspx';", true);
            }
        }

        protected void back2Cart_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("ShoppingCart.aspx");
        }
    }
}