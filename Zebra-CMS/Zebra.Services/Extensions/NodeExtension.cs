using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.Models;
using Zebra.Globalization;

namespace Zebra.Services.Operations
{
    public static class NodeExtension
    {
        public static Dictionary<string, object> GetFieldValues(this Node node, string culturename)
        {
            var dictionary = new Dictionary<string, object>();
            return node.GetFieldValues(LanguageManager.GetLanguage(culturename));
        }

        public static Dictionary<string, object> GetFieldValues(this Node node, Language language)
        {
            var dictionary = new Dictionary<string, object>();
            if (language != null && language.Id != null)
            {
                var nodefieldmaps = node.NodeFieldMaps.Where(x => x.LanguageId == language.Id).ToList();
                foreach (var nodefieldmap in nodefieldmaps)
                {
                    var key = nodefieldmap.Field.FieldName;
                    var value = OperationsFactory.NodeOperations.GetValueForField(nodefieldmap);
                    dictionary.Add(key, value);
                }
            }
            return dictionary;
        }
    }
}