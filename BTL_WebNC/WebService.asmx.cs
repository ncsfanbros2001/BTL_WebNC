using BTL_WebNC.ModelClasses;
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
    }
}
