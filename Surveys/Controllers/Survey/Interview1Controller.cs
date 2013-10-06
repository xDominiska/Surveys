using Surveys.DTOs;
using Surveys.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.Controllers
{
    [Authorize]
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
                SaveChoice(questions, sur.PatientId);
            }
            if (db.PatientsChoices.Where(x => x.PatientId == sur.PatientId && x.AnswerId > 10000 && x.AnswerId < 20000 && (string)x.Answer == "Tak").Count() > 0)
            {
                return RedirectToAction("Edit", new { controller = "Interview2", id = sur.PatientId });
            }
            else
            {
                ViewBag.Title = "Ankieta \"0\"";

                return View("Saved");
            }
        }

        public void SaveChoice(QuestionDTO question, int patientId)
        {
            foreach (var answer in question.Answers)
            {
                if (answer.Text != null)
                {
                    var pc = db.PatientsChoices.Where(x => x.AnswerId == answer.Answer.Id && x.PatientId == patientId).FirstOrDefault();
                    if (pc != null)
                    {
                        pc.Answer = answer.Text;
                        db.Entry(pc).State = System.Data.EntityState.Modified;
                    }
                    else
                    {
                        db.PatientsChoices.Add(new PatientsChoices()
                        {
                            AnswerId = answer.Answer.Id,
                            PatientId = patientId,
                            Answer = answer.Text
                        });
                    }

                    db.SaveChanges();
                }

                if (answer.Options != null)
                {
                    foreach (var o in answer.Options)
                    {
                        SaveChoice(o.NextQuestion, patientId);
                    }
                }
            }
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
