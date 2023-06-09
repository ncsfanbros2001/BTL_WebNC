﻿using BTL_WebNC.ModelClasses;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;

namespace BTL_WebNC
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    /// 
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        SqlConnection cnn = new SqlConnection(StaticValues.MINH_connectionString);

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void GetPersons()
        {
            List<Persons> personList = new List<Persons>();

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;

            cmd.CommandText = "SELECT * FROM Persons ";


            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Persons person = new Persons();

                person.ID = Convert.ToInt32(reader["ID"]);
                person.Fullname = reader["Fullname"].ToString();
                person.Email = reader["Email"].ToString();
                person.Password = reader["Password"].ToString();
                person.PhoneNumber = reader["PhoneNumber"].ToString();
                person.DOB = reader["DOB"].ToString();
                person.Gender = reader["Publisher"].ToString();
                person.Position = reader["Position"].ToString();

                personList.Add(person);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(personList));

            cnn.Close();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void GetProducts(string title)
        {
            List<Books> bookList = new List<Books>();

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand(); 
            cmd.CommandType = CommandType.Text;

            if (title == "")
            {
                cmd.CommandText = "SELECT * FROM Books  ";
                //ORDER BY Title desc
            }
            else if (title != "")
            {
                cmd.CommandText = $"SELECT * FROM Books WHERE Title LIKE '%{title}%'";
            }


            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Books book = new Books();

                book.Id = Convert.ToInt32(reader["ID"]);
                book.Title = reader["Title"].ToString();
                book.Author = reader["Author"].ToString();
                book.Price = Convert.ToDouble(reader["Price"]);
                book.Genre = reader["Genre"].ToString();
                book.Publisher = reader["Publisher"].ToString();
                book.ImageLink = reader["ImageLink"].ToString();

                bookList.Add(book);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(bookList));

            cnn.Close();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void GetCartItems(int personId)
        {
            List<CartItems> cartItemList = new List<CartItems>();

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"SELECT * FROM CartItems WHERE PersonID = {personId}";

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                CartItems cartItem = new CartItems();

                cartItem.CartItemID = Convert.ToInt32(reader["CartItemID"]);
                cartItem.PersonID = Convert.ToInt32(reader["PersonID"]);
                cartItem.PersonFullname = reader["PersonFullname"].ToString();
                cartItem.PersonPhoneNumber = reader["PersonPhoneNumber"].ToString();
                cartItem.BookID = Convert.ToInt32(reader["BookID"]);
                cartItem.BookTitle = reader["BookTitle"].ToString();
                cartItem.BookPrice = Convert.ToDouble(reader["BookPrice"]);
                cartItem.BookImageLink = reader["BookImageLink"].ToString();
                cartItem.quantity = Convert.ToInt32(reader["Quantity"]);
                cartItem.TotalPrice = Convert.ToDouble(reader["TotalPrice"]);

                cartItemList.Add(cartItem);
            }


            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(cartItemList));

            cnn.Close();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void DeleteCartItem(int itemId)
        {
            List<CartItems> cartItemList = (List<CartItems>)Application["cartItems"];

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"DELETE FROM CartItems WHERE CartItemID = {itemId}";

            cmd.ExecuteNonQuery();

            cartItemList.RemoveAll(u => u.CartItemID == itemId);

            cnn.Close();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void DeleteBook(int bookId)
        {
            List<Books> bookList = (List<Books>)Application["books"];

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"DELETE FROM Books WHERE ID = {bookId}";

            cmd.ExecuteNonQuery();

            bookList.RemoveAll(u => u.Id == bookId);

            cnn.Close();
        }



        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void UpdateQuantity(int newQuantity, int itemId)
        {
            List<CartItems> cartItemList = (List<CartItems>)Application["cartItems"];

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"UPDATE CartItems SET Quantity = {newQuantity}," +
                $" TotalPrice = {newQuantity} * BookPrice WHERE CartItemID = {itemId}";

            cmd.ExecuteNonQuery();

            CartItems itemToUpdate = cartItemList.FirstOrDefault(p => p.CartItemID == itemId);

            itemToUpdate.quantity = newQuantity;
            itemToUpdate.TotalPrice = itemToUpdate.BookPrice * newQuantity;

            cartItemList[cartItemList.FindIndex(p => p.CartItemID == itemId)] = itemToUpdate;

            cnn.Close();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void GetBooks(string genre, string title)
        {
            List<Books> bookList = new List<Books>();

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;

            if (genre == "All" && title == "")
            {
                cmd.CommandText = "SELECT * FROM Books";
            }
            else if (genre != "All" && title == "")
            {
                cmd.CommandText = $"SELECT * FROM Books WHERE Genre = '{genre}'";
            }
            else if (genre == "All" && title != "")
            {
                cmd.CommandText = $"SELECT * FROM Books WHERE Title LIKE '%{title}%'";
            }
            else if (genre != "All" && title != "")
            {
                cmd.CommandText = $"SELECT * FROM Books WHERE Genre = '{genre}' AND Title LIKE '%{title}%'";
            }

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Books book = new Books();

                book.Id = Convert.ToInt32(reader["ID"]);
                book.Title = reader["Title"].ToString();
                book.Author = reader["Author"].ToString();
                book.Price = Convert.ToDouble(reader["Price"]);
                book.Genre = reader["Genre"].ToString();
                book.Publisher = reader["Publisher"].ToString();
                book.ImageLink = reader["ImageLink"].ToString();

                bookList.Add(book);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(bookList));

            cnn.Close();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void GetBooksByPriceRange(float minValue, float maxValue)
        {
            List<Books> bookList = new List<Books>();

            cnn.Open();
            SqlCommand cmd = cnn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = $"SELECT * FROM Books Where Price Between {minValue} and {maxValue}";

            if (minValue.ToString() == "" && minValue.ToString() == "")
            {
                cmd.CommandText = $"SELECT * FROM Books";
            }

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Books book = new Books();

                book.Id = Convert.ToInt32(reader["ID"]);
                book.Title = reader["Title"].ToString();
                book.Author = reader["Author"].ToString();
                book.Price = Convert.ToDouble(reader["Price"]);
                book.Genre = reader["Genre"].ToString();
                book.Publisher = reader["Publisher"].ToString();
                book.ImageLink = reader["ImageLink"].ToString();

                bookList.Add(book);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(bookList));

            cnn.Close();
        }
    }
}
