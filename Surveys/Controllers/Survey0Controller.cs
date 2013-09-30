using Surveys.DTOs;
using Surveys.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.Controllers
{
    public class Survey0Controller : Controller
    {
        //
        // GET: /Survey0/

        public ActionResult Index()
        {

            var pyt1 = new QuestionDTO(1001, 2, new Models.SurveysEntities());
            var sur1 = new SurveyDTO(SurveyType.Wywiad1, -1, new Models.SurveysEntities());


            return View(sur1);
        }

        [HttpPost]
        public ActionResult Index(SurveyDTO choice)
        {
            return View();
        }

        //
        // GET: /Survey0/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // GET: /Survey0/Edit

        public ActionResult Edit()
        {
            return View();
        }

    }
}
