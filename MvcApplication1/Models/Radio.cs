using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication1.Models
{
    public class Radio
    {
        public Tuple<string, string> El1 { get; set; }
        public Tuple<string, string> El2 { get; set; }
    }

    public class RadioList
    {
        public List<Radio> Radios { get; set; }
    }
}