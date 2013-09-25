using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Surveys.Models
{
    public class Answers
    {
        [Key]
        public int Id { get; set; }
        public int AnswerTypeId { get; set; }
        public int NumberOfPossibilities { get; set; }
        public int QuestionId { get; set; }
    }

    public class AnswersTypes
    {
        [Key]
        public int Id { get; set; }
        public string Description { get; set; }
    }

    public class Options
    {
        [Key]
        public int Id { get; set; }
        public string Text { get; set; }
        public Nullable<int> NextQuestionId { get; set; }
        public int AnswerId { get; set; }
    }

    public class Questionnaires
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class Questions
    {
        [Key]
        public int Id { get; set; }
        public int QuestionnaireId { get; set; }
        public string Text { get; set; }
        public int NumberOfAnswers { get; set; }
    }
}