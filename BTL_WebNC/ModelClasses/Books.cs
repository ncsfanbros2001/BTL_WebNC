using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_WebNC.ModelClasses
{
    public class Books
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public double Price { get; set; }
        public string Genre { get; set; }
        public string Publisher { get; set; }
        public string ImageLink { get; set; }
    }
}