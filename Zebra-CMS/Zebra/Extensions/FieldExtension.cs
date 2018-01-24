using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Operations
{
    static class FieldExtension
    {
        public static Template GetTemplate(this Field field)
        {
            TemplateFieldMap templatemap = null;
            var enumerator = field.TemplateFieldMaps.GetEnumerator();
            if (enumerator.MoveNext())
            {
                templatemap = enumerator.Current;
                return templatemap.Template;
            }
            return null;
        }
    }
}