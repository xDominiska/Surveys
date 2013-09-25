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
    public class PatientController : Controller
    {
        private SurveysContext db = new SurveysContext();
        private UsersContext userdb = new UsersContext();

        //
        // GET: /Patient/

        public ActionResult Index()
        {
            return View(db.Patient.ToList());
        }

        //
        // GET: /Patient/Details/5

        public ActionResult Details(int id = 0)
        {
            Patient patient = db.Patient.Find(id);
            if (patient == null)
            {
                return HttpNotFound();
            }

            patient.Info = new Patient.QuestionarriesInfo();
            patient.Info.ExaminationDate0 = db.PatientsQuestionnaires.Where(x => x.PatientId == patient.Id && (x.QuestionnaireId >= (int)Surveys.DTOs.SurveyType.Wywiad1
                                                                                                                && x.QuestionnaireId <= (int)Surveys.DTOs.SurveyType.Obrazowe)).Select(x => x.ExaminationDate).Min();
            patient.Info.ExaminationDate1 = db.PatientsQuestionnaires.Where(x => x.PatientId == patient.Id && (x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6A
                                                                                                                || x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6B)).Select(x => x.ExaminationDate).Min();
            patient.Info.ExaminationDate2 = db.PatientsQuestionnaires.Where(x => x.PatientId == patient.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja12).Select(x => x.ExaminationDate).Min();

            return View(patient);
        }

        //
        // GET: /Patient/Create

        public ActionResult Create()
        {
            InitializeDataBag();

            return View();
        }

        //
        // POST: /Patient/Create

        [HttpPost]
        public ActionResult Create(Patient patient)
        {
            if (ModelState.IsValid)
            {
                patient.UserId = userdb.UserProfiles.Where(x => x.UserName == User.Identity.Name).FirstOrDefault().UserId;
                db.Patient.Add(patient);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(patient);
        }

        //
        // GET: /Patient/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Patient patient = db.Patient.Find(id);
            if (patient == null)
            {
                return HttpNotFound();
            }

            InitializeDataBag();

            return View(patient);
        }

        //
        // POST: /Patient/Edit/5

        [HttpPost]
        public ActionResult Edit(Patient patient)
        {
            if (ModelState.IsValid)
            {
                patient.UserId = userdb.UserProfiles.Where(x => x.UserName == User.Identity.Name).FirstOrDefault().UserId;
                db.Entry(patient).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(patient);
        }

        //
        // GET: /Patient/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Patient patient = db.Patient.Find(id);
            if (patient == null)
            {
                return HttpNotFound();
            }
            return View(patient);
        }

        //
        // POST: /Patient/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Patient patient = db.Patient.Find(id);
            db.Patient.Remove(patient);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        private void InitializeDataBag()
        {
            List<SelectListItem> genders = new List<SelectListItem>()
            {
                new SelectListItem { Text="Kobieta", Value="K"},
                new SelectListItem { Text="Mężczyzna", Value="M"}
            };

            ViewBag.GenderChoice = genders;

            List<SelectListItem> guardians = new List<SelectListItem>()
            {
                new SelectListItem { Text="Ojciec", Value="Ojciec"},
                new SelectListItem { Text="Matka", Value="Matka"},
                new SelectListItem { Text="Opiekun prawny", Value="Opiekun prawny"}
            };

            ViewBag.GuardianChoice = guardians;
        }
    }
}