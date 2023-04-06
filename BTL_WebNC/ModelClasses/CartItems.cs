using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_WebNC.ModelClasses
{
    public class CartItems
    {
        public int ID { get; set; }
        public int PersonID { get; set; }
        public int BookID { get; set; }
        public int quantity { get; set; }
    }
}