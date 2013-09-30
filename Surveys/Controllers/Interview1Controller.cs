using Surveys.DTOs;
using Surveys.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.Controllers
{
    public class Interview1Controller : Controller
    {
        private SurveysEntities db = new SurveysEntities();

        //
        // GET: /Inteview1/Edit/5

        public ActionResult Edit(int id)
        {
            var sur = new SurveyDTO(SurveyType.Wywiad1, id, db);
            return View(sur);
        }

        //
        // POST: /Inteview1/Edit

        [HttpPost]
        public ActionResult Edit(SurveyDTO sur)
        {
            foreach (var questions in sur.Questions)
            {
                foreach (var answers in questions.Answers)
                {
                    var pc = db.PatientsChoices.Where(x => x.AnswerId == answers.Answer.Id && x.PatientId == sur.PatientId).FirstOrDefault();
                    if (pc != null)
                    {
                        pc.Answer = answers.Text;
                        db.Entry(pc).State = System.Data.EntityState.Modified;
                    }
                    else
                    {
                        db.PatientsChoices.Add(new PatientsChoices()
                        {
                            AnswerId = answers.Answer.Id,
                            PatientId = sur.PatientId,
                            Answer = answers.Text
                        });
                    }

                    db.SaveChanges();
                }
            }


            //TODO redirect do 2 ankiety (sprawdzenie warunków wyświetlenia Interview2)
            //return RedirectToAction("Index");
            return View(sur);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
