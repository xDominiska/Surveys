using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Surveys.Models
{
    public class SurveysContext : DbContext
    {
        public SurveysContext()
            : base("DefaultConnection")
        {
        }

        public DbSet<Answers> Answers { get; set; }
        public DbSet<AnswersTypes> AnswersTypes { get; set; }
        public DbSet<Options> Options { get; set; }
        public DbSet<Questionnaires> Questionnaires { get; set; }
        public DbSet<Questions> Questions { get; set; }
        public DbSet<Patient> Patient { get; set; }
        public DbSet<PatientsChoices> PatientsChoices { get; set; }
        public DbSet<PatientsQuestionnaires> PatientsQuestionnaires { get; set; }
    }
}