using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Surveys.Models;

namespace Surveys.Controllers
{
    public class QuestionnaireController : Controller
    {
        private SurveysEntities db = new SurveysEntities();
        
        //
        // GET: /Questionnaire/Create

        public ActionResult Create(int patientId, int questionnaireId)
        {
            var pq = new PatientsQuestionnaires()
            {
                PatientId = patientId,
                QuestionnaireId = questionnaireId,
                FillingDate = DateTime.Now
            };

            return View(pq);
        }

        //
        // POST: /Questionnaire/Create

        [HttpPost]
        public ActionResult Create(PatientsQuestionnaires patientsquestionnaires)
        {
            if (ModelState.IsValid)
            {
                db.PatientsQuestionnaires.Add(patientsquestionnaires);
                db.SaveChanges();

                switch (patientsquestionnaires.QuestionnaireId)
                {
                    case (int)Surveys.DTOs.SurveyType.Wywiad1 :
                        return RedirectToAction("Edit", new { controller = "Interview1", id = patientsquestionnaires.PatientId });
                    case (int)Surveys.DTOs.SurveyType.Aplikacja6A:
                        return RedirectToAction("Edit", new { controller = "Survey6A", id = patientsquestionnaires.PatientId });
                    case (int)Surveys.DTOs.SurveyType.Aplikacja6B:
                        return RedirectToAction("Edit", new { controller = "Survey6B", id = patientsquestionnaires.PatientId });
                    case (int)Surveys.DTOs.SurveyType.Aplikacja12:
                        return RedirectToAction("Edit", new { controller = "Survey12", id = patientsquestionnaires.PatientId });

                }

            }

            return View(patientsquestionnaires);
        }

        //
        // GET: /Questionnaire/Edit/5

        public ActionResult Edit(int patientId, int questionnaireId)
        {
            PatientsQuestionnaires patientsquestionnaires = db.PatientsQuestionnaires.Where(x => x.PatientId == patientId && x.QuestionnaireId == questionnaireId).FirstOrDefault();
            if (patientsquestionnaires == null)
            {
                return HttpNotFound();
            }
            return View(patientsquestionnaires);
        }

        //
        // POST: /Questionnaire/Edit/5

        [HttpPost]
        public ActionResult Edit(PatientsQuestionnaires patientsquestionnaires)
        {
            if (ModelState.IsValid)
            {
                db.Entry(patientsquestionnaires).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Edit", new { controller = "Interview1", id = patientsquestionnaires.PatientId });
            }
            return View(patientsquestionnaires);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}