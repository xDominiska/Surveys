//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;

//namespace Surveys.DTOs
//{
//    public class Interview1DTO : SurveyDTO
//    {
//        public Interview1DTO(int patientId) : base(patientId)
//        {
//            //if (this.surveysContext.PatientsQuestionnaires.Count(x => x.QuestionnaireId == 1) == 1)
//            //{
//            //    // get
//            //    questions = (from q in this.surveysContext.Questions
//            //                 join qa in this.surveysContext.QuestionsAnswers on q.Id equals qa.QuestionId
//            //                 join a in this.surveysContext.Answers on qa.AnswerId equals a.Id
//            //                 join at in this.surveysContext.AnswersTypes on a.AnswerTypeId equals at.Id
//            //                 join ao in this.surveysContext.AnswersOptions on a.Id equals ao.AnswerId
//            //                 //join o in this.surveysContext.Options on ao.OptionId equals o.Id
//            //                 select new QuestionDTO
//            //                 {
//            //                     id = q.Id,
//            //                     answerType = (SurveyDTO.AnswerType)at.Id,
//            //                     options = (from o in this.surveysContext.Options
//            //                                where o.Id = ao.OptionId
//            //                                select new Tuple<string, QuestionDTO>(o.Text, 
//            //                 }
//            //        ).ToList();
//            //}
//            //else
//            //{
//            //    // create
//            //}
//        }
//    }
//}