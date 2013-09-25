using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Surveys.Models
{
    public class Patient
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Code { get; set; }
        public int UserId { get; set; }
        public string Guardian { get; set; }
        public DateTime BirthDate { get; set; }
        [MinLength(1), MaxLength(1)]
        public string Gender { get; set; }
        [NotMapped]
        public QuestionarriesInfo Info { get; set; }

        [ComplexType]
        public class QuestionarriesInfo
        {
            public Nullable<DateTime> ExaminationDate0 { get; set; }
            public Nullable<DateTime> ExaminationDate1 { get; set; }
            public Nullable<DateTime> ExaminationDate2 { get; set; }
        }

    }

    public class PatientsChoices
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int PatientId { get; set; }
        public int AnswerId { get; set; }
        public string Answer { get; set; }
    }

    public class PatientsQuestionnaires
    {
        [Key, Column(Order = 0)]
        public int PatientId { get; set; }
        [Key, Column(Order = 1)]
        public int QuestionnaireId { get; set; }
        public DateTime FillingDate { get; set; }
        public DateTime ExaminationDate { get; set; }
    }
}