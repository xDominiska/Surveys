using MvcApplication1.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcApplication1.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            List<Radio> r = new List<Radio>()
            {
                new Radio()
                {
                 El1 = new Tuple<string,string>("", "1blah"),
                 El2 = new Tuple<string,string>("", "1blahblah")
                },
                new Radio()
                {
                 El1 = new Tuple<string,string>("", "2blah"),
                 El2 = new Tuple<string,string>("", "2blahblah")
                },
                new Radio()
                {
                 El1 = new Tuple<string,string>("", "3blah"),
                 El2 = new Tuple<string,string>("", "3blahblah")
                },
                new Radio()
                {
                 El1 = new Tuple<string,string>("", "4blah"),
                 El2 = new Tuple<string,string>("", "4blahblah")
                },
                new Radio()
                {
                 El1 = new Tuple<string,string>("", "5blah"),
                 El2 = new Tuple<string,string>("", "blahblah")
                }
            };


            return View(new RadioList()
                {
                    Radios = r
                });
        }

        [HttpPost]
        public ActionResult Index(RadioList model)
        {
            return View();
        }

    }
}
