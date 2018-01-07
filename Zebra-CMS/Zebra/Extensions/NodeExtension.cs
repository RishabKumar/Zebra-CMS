using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.Application;
using Zebra.DataRepository.Models;
using Zebra.Globalization;

namespace Zebra.Services.Operations
{
    static class NodeExtension
    {
        public static Dictionary<string, object> GetFieldValues(this Node node)
        {
            var dictionary = new Dictionary<string, object>();
            Language lang = ZebraContext.Current.CurrentLanguage;
            if (lang == null)
            {
                lang = LanguageManager.GetDefaultLanguage();
            }
            return node.GetFieldValues(lang);
        }
    }
}