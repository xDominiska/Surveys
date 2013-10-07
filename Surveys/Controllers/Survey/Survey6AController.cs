using Surveys.DTOs;
using Surveys.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.Controllers
{
    [Authorize]
    public class Survey6AController : Controller
    {
        private SurveysEntities db = new SurveysEntities();
        private UsersContext userdb = new UsersContext();

        //
        // GET: /Survey6A/Edit/5

        public ActionResult Edit(int id)
        {
            if (id != GetUserId() && User.Identity.Name.ToLower() != "admin")
            {
                return View("NotAuthorized");
            }
            var sur = new SurveyDTO(SurveyType.Aplikacja6A, id, db);
            return View(sur);
        }

        //
        // POST: /Survey6A/Edit

        [HttpPost]
        public ActionResult Edit(SurveyDTO sur)
        {
            foreach (var questions in sur.Questions)
            {
                SaveChoice(questions, sur.PatientId);
            }

            ViewBag.Title = "Ankieta \"6\"";

            return View("Saved");
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

        private int GetUserId()
        {
            return userdb.UserProfiles.Where(x => x.UserName == User.Identity.Name).FirstOrDefault().UserId;
        }

    }
}
