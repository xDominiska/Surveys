using Surveys.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.DTOs
{
    public class AnswerDTO
    {
        public Answers Answer { get; set; }
        public string Text { get; set; }
        public List<OptionDTO> Options { get; set; }
        public List<SelectListItem> List { get; set; }
    }

    public class OptionDTO
    {
        public Options Option { get; set; }
        public QuestionDTO NextQuestion { get; set; }
    }

    public class QuestionDTO
    {
        public int Id { get; set; }
        public string Text { get; set; }

        // answerId, answerType, PatientsChoices list
        //      optionId, optionText, answer ("CHECKED" | "UNCHECKED" | "blahblah"), nextQuestion
        //

        public List<AnswerDTO> Answers { get; set; }

        public QuestionDTO() { }

        public QuestionDTO(int id, int patientId, SurveysEntities db)
        {
            // zbuduj pytanie
            var question = db.Questions.Where(x => x.Id == id).FirstOrDefault();
            this.Answers = null;

            if (question != null)
            {
                this.Id = question.Id;
                this.Text = question.Text;

                var answers = (from a in db.Answers
                               where a.QuestionId == id
                               select a).ToList();

                if (answers != null)
                {
                    this.Answers = new List<AnswerDTO>();

                    foreach (var a in answers)
                    {
                        // odpowiedzi pacjenta
                        var patientsChoices = (from pc in db.PatientsChoices
                                               where pc.AnswerId == a.Id && pc.PatientId == patientId
                                               select pc).ToList();

                        if (patientsChoices.Count == 0)
                        {
                            switch (a.AnswerTypeId)
                            {
                                case (int)AnswerType.RadioButton:
                                    {
                                        patientsChoices.Add(new PatientsChoices()
                                        {
                                            AnswerId = a.Id,
                                            PatientId = patientId
                                        });
                                        break;
                                    }
                            }
                        }

                        // opcje
                        var options = (from o in db.Options
                                       where o.AnswerId == a.Id
                                       select o).ToList();

                        List<OptionDTO> fullOptions = new List<OptionDTO>();
                        List<SelectListItem> optionsList = new List<SelectListItem>()
                            {
                                new SelectListItem()
                                {
                                    Text = "",
                                    Value = ""
                                }
                            };

                        if (options != null)
                        {
                            foreach (var o in options)
                            {
                                fullOptions.Add(new OptionDTO()
                                {
                                    Option = o,
                                    NextQuestion = o.NextQuestionId != null ? new QuestionDTO(o.NextQuestionId.Value, patientId, db) : null
                                });

                                optionsList.Add(new SelectListItem()
                                {
                                   Text = o.Text,
                                   Value = o.Text
                                });
                            }
                        }


                        Answers.Add(new AnswerDTO()
                            {
                                Answer = a,
                                Text = patientsChoices.Count > 0 ? patientsChoices.First().Answer : null,
                                Options = fullOptions.Count > 0 ? fullOptions : null,
                                List = optionsList.Count > 0 ? optionsList : null
                            });
                    }
                }
            }
        }

    }

    public enum AnswerType
    {
        RadioButton = 1,
        CheckBox = 2,
        ComboBox = 3,
        Text = 4,
        Number = 5
    }

    public enum SurveyType
    {
        Wywiad1 = 1,
        Wywiad2 = 2,
        Fizykalne = 3,
        Laboratoryjne = 4,
        Obrazowe = 5,
        Aplikacja6A = 6,
        Aplikacja6B = 7,
        Aplikacja12 = 8
    }

    public class SurveyDTO
    {
        public SurveyType Type { get; set; }
        public int PatientId { get; set; }
        public List<QuestionDTO> Questions { get; set; }
        private SurveysEntities Db { get; set; }

        private int SurveyMinId
        {
            get { return (int)this.Type * 1000 + 1; }
        }

        private int SurveyMaxId
        {
            get { return (int)this.Type * 1000 + 100; }
        }

        public SurveyDTO() { }

        public SurveyDTO(SurveyType type, int patientId, SurveysEntities db)
        {
            this.Type = type;
            this.PatientId = patientId;
            this.Db = db;
            this.Questions = new List<QuestionDTO>();

            for (int i = this.SurveyMinId; i < this.SurveyMaxId; i++)
            {
                QuestionDTO tmp = new QuestionDTO(i, this.PatientId, this.Db);
                if (tmp.Answers != null)
                {
                    this.Questions.Add(new QuestionDTO(i, this.PatientId, this.Db));
                }
                else
                {
                    break;
                }
            }

        }

    }
}