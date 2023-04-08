using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_WebNC.ModelClasses
{
    public class CartItems
    {
        public int CartItemID { get; set; }
        public int PersonID { get; set; }
        public string PersonFullname { get; set; }
        public string PersonPhoneNumber { get; set; }
        public int BookID { get; set; }
        public string BookTitle { get; set; }
        public double BookPrice { get; set; }
        public string BookImageLink { get; set; }
        public int quantity { get; set; }
        public double TotalPrice { get; set; }
    }
}