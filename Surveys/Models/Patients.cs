//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Surveys.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    
    public partial class Patients
    {
        public Patients()
        {
            this.PatientsChoices = new HashSet<PatientsChoices>();
            this.PatientsQuestionnaires = new HashSet<PatientsQuestionnaires>();
        }
    
        public int Id { get; set; }
        public string Code { get; set; }
        public int UserId { get; set; }
        [DisplayName("Opienkun")]
        public string Guardian { get; set; }
        [DataType(DataType.Date)]
        [DisplayName("Data urodzenia")]
        public System.DateTime BirthDate { get; set; }
        [MinLength(1), MaxLength(1)]
        [DisplayName("P�e�")]
        public string Gender { get; set; }
    
        public virtual ICollection<PatientsChoices> PatientsChoices { get; set; }
        public virtual ICollection<PatientsQuestionnaires> PatientsQuestionnaires { get; set; }


        [NotMapped]
        public QuestionarriesInfo Info { get; set; }

        [ComplexType]
        public class QuestionarriesInfo
        {
            [DataType(DataType.Date)]
            public Nullable<DateTime> ExaminationDate0 { get; set; }
            [DataType(DataType.Date)]
            public Nullable<DateTime> ExaminationDate1 { get; set; }
            [DataType(DataType.Date)]
            public Nullable<DateTime> ExaminationDate2 { get; set; }
        }
    
    }
}
