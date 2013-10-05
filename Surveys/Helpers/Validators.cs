using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Surveys.Helpers
{
    public class MinDateAttribute : ValidationAttribute, IClientValidatable
    {
        private readonly DateTime _minValue;

        public MinDateAttribute(string minValue)
        {
            _minValue = DateTime.Parse(minValue);
            ErrorMessage = "Podaj wartość większą od " + _minValue;
        }

        public override bool IsValid(object value)
        {
            return (DateTime)value >= _minValue;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var rule = new ModelClientValidationRule();
            rule.ErrorMessage = ErrorMessage;
            rule.ValidationParameters.Add("min", _minValue);
            rule.ValidationParameters.Add("max", DateTime.MaxValue);
            rule.ValidationType = "range";
            yield return rule;
        }

    }
}