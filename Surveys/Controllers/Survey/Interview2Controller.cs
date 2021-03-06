﻿using Surveys.DTOs;
using Surveys.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.Controllers
{
    [Authorize]
    public class Interview2Controller : Controller
    {
        private SurveysEntities db = new SurveysEntities();
        private UsersContext userdb = new UsersContext();

        //
        // GET: /Inteview2/Edit/5

        public ActionResult Edit(int id)
        {
            if (id != GetUserId() && User.Identity.Name.ToLower() != "admin")
            {
                return View("NotAuthorized");
            }
            var sur = new SurveyDTO(SurveyType.Wywiad2, id, db);
            return View(sur);
        }

        //
        // POST: /Inteview2/Edit

        [HttpPost]
        public ActionResult Edit(SurveyDTO sur)
        {
            foreach (var questions in sur.Questions)
            {
                SaveChoice(questions, sur.PatientId);
            }

            return RedirectToAction("Edit", new { controller = "Physical", id = sur.PatientId });
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
