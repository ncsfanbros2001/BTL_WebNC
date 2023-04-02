using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_WebNC.ModelClasses
{
    public class Persons
    {
        public int ID { get; set; }
        public string Fullname { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string DOB { get; set; }
        public string Gender { get; set; }
        public string Position { get; set; }
    }
}