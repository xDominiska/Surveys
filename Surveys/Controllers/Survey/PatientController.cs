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
    [Authorize]
    public class PatientController : Controller
    {
        private SurveysEntities db = new SurveysEntities();
        private UsersContext userdb = new UsersContext();
        private const TimeSpan SIX_MONTHS = new TimeSpan(30 * 6, 0, 0, 0);
        private const TimeSpan TWELVE_MONTHS = new TimeSpan(30 * 12, 0, 0, 0);

        //
        // GET: /Patient/

        public ActionResult Index(int id = -1)
        {
            IList<Patients> patients;
            if (User.Identity.IsAuthenticated && User.Identity.Name.ToLower() == "admin")
            {
                patients = db.Patients.Where(x => !x.IsDeleted).ToList();
            }
            else
            {
                int userId = GetUserId();
                patients = db.Patients.Where(x => !x.IsDeleted && x.UserId == userId).ToList();
            }

            foreach (var p in patients)
            {
                p.Info = new Patients.QuestionarriesInfo();
                if (db.PatientsQuestionnaires.Where(x => x.PatientId == p.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Wywiad1).Select(x => x.ExaminationDate).Count() > 0)
                {
                p.Info.ExaminationDate0 = db.PatientsQuestionnaires.Where(x => x.PatientId == p.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Wywiad1).Select(x => x.ExaminationDate).First();
                }
                else
                {
                    p.Info.ExaminationDate0 = null;
                }

                if (db.PatientsQuestionnaires.Where(x => x.PatientId == p.Id && (x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6A
                                                                                     || x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6B)).Select(x => x.ExaminationDate).Count() > 0)
                {
                    p.Info.ExaminationDate1 = db.PatientsQuestionnaires.Where(x => x.PatientId == p.Id && (x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6A
                                                                                     || x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6B)).Select(x => x.ExaminationDate).First();
                }
                else
                {
                    p.Info.ExaminationDate1 = null;
                }

                if (db.PatientsQuestionnaires.Where(x => x.PatientId == p.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja12).Select(x => x.ExaminationDate).Count() > 0)
                {
                    p.Info.ExaminationDate2 = db.PatientsQuestionnaires.Where(x => x.PatientId == p.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja12).Select(x => x.ExaminationDate).First();
                }
                else
                {
                    p.Info.ExaminationDate2 = null;
                }
            }

            if (id == 0)
            {
                patients = patients.Where(p => p.Info.ExaminationDate0 == null).ToList() ;
            }
            else if (id == 1)
            {
                patients = patients.Where(p => p.Info.ExaminationDate0 != null
                                            && (DateTime.Now - p.Info.ExaminationDate0 > SIX_MONTHS)
                                            && p.Info.ExaminationDate1 == null).ToList();
            }
            else if (id == 2)
            {
                patients = patients.Where(p => p.Info.ExaminationDate1 != null
                                            && (DateTime.Now - p.Info.ExaminationDate1 > TWELVE_MONTHS)
                                            && p.Info.ExaminationDate2 == null).ToList();
            }

            return View(patients);
        }

        //
        // GET: /Patient/Details/5

        public ActionResult Details(int id = 0)
        {
            Patients patient = db.Patients.Find(id);
            if (patient == null || patient.IsDeleted)
            {
                return HttpNotFound();
            }

            patient.Info = new Patients.QuestionarriesInfo();
            patient.Info.ExaminationDate0 = db.PatientsQuestionnaires.Where(x => x.PatientId == patient.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Wywiad1).Select(x => x.ExaminationDate).FirstOrDefault();
            patient.Info.ExaminationDate1 = db.PatientsQuestionnaires.Where(x => x.PatientId == patient.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6A
                                                                                               && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja6B).Select(x => x.ExaminationDate).FirstOrDefault();
            patient.Info.ExaminationDate2 = db.PatientsQuestionnaires.Where(x => x.PatientId == patient.Id && x.QuestionnaireId == (int)Surveys.DTOs.SurveyType.Aplikacja12).Select(x => x.ExaminationDate).FirstOrDefault();

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
        public ActionResult Create(Patients patient)
        {
            if (ModelState.IsValid)
            {
                patient.UserId = GetUserId();
                db.Patients.Add(patient);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(patient);
        }

        //
        // GET: /Patient/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Patients patient = db.Patients.Find(id);
            if (patient == null || patient.IsDeleted)
            {
                return HttpNotFound();
            }

            InitializeDataBag();

            return View(patient);
        }

        //
        // POST: /Patient/Edit/5

        [HttpPost]
        public ActionResult Edit(Patients patient)
        {
            if (ModelState.IsValid)
            {
                patient.UserId = GetUserId();
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
            Patients patient = db.Patients.Find(id);
            if (patient == null || patient.IsDeleted)
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
            Patients patient = db.Patients.Find(id);
            patient.IsDeleted = true;
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

        private int GetUserId()
        {
            return userdb.UserProfiles.Where(x => x.UserName == User.Identity.Name).FirstOrDefault().UserId;
        }
    }
}