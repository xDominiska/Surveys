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
    
    public partial class PatientsQuestionnaires
    {
        public int PatientId { get; set; }
        public int QuestionnaireId { get; set; }
        [DataType(DataType.Date)]
        [DisplayName("Data wypełnienia")]
        public System.DateTime FillingDate { get; set; }
        [DataType(DataType.Date)]
        [DisplayName("Data badania")]
        public System.DateTime ExaminationDate { get; set; }
    
        public virtual Patients Patients { get; set; }
        public virtual Questionnaires Questionnaires { get; set; }
    }
}
