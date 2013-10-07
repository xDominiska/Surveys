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
        private TimeSpan SIX_MONTHS { get { return new TimeSpan(30 * 6, 0, 0, 0); } }
        private TimeSpan TWELVE_MONTHS { get { return new TimeSpan(30 * 12, 0, 0, 0); } }

        //
        // GET: /Patient/

        public ActionResult Index(int id = -1)
        {
            if (id == -1)
            {
                ViewBag.CanCreate = true;
            }
            else
            {
                ViewBag.CanCreate = false;
            }

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
                patients = patients.Where(p => p.Info.ExaminationDate0 == null).ToList();
                ViewBag.ToFill = "- wypełnij ankietę \"0\"";
            }
            else if (id == 1)
            {
                patients = patients.Where(p => p.Info.ExaminationDate0 != null
                                            && (DateTime.Now - p.Info.ExaminationDate0 > SIX_MONTHS)
                                            && p.Info.ExaminationDate1 == null).ToList();
                ViewBag.ToFill = "- wypełnij ankietę \"1\"";
            }
            else if (id == 2)
            {
                patients = patients.Where(p => p.Info.ExaminationDate1 != null
                                            && (DateTime.Now - p.Info.ExaminationDate1 > TWELVE_MONTHS)
                                            && p.Info.ExaminationDate2 == null).ToList();
                ViewBag.ToFill = "- wypełnij ankietę \"2\"";
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
            if (patient.UserId != GetUserId() && User.Identity.Name.ToLower() != "admin")
            {
                return View("NotAuthorized");
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
            if (patient.UserId != GetUserId() && User.Identity.Name.ToLower() != "admin")
            {
                return View("NotAuthorized");
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
            if (patient.UserId != GetUserId() && User.Identity.Name.ToLower() != "admin")
            {
                return View("NotAuthorized");
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