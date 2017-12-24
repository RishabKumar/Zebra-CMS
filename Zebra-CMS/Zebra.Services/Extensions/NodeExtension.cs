using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Operations
{
    public static class NodeExtension
    {
        public static Dictionary<string, object> GetFieldValues(this Node node)
        {
            var dictionary = new Dictionary<string, object>();
            foreach (var nodefieldmap in node.NodeFieldMaps)
            {
                var key = nodefieldmap.Field.FieldName;
                var value = OperationsFactory.NodeOperations.GetValueForField(nodefieldmap);
                dictionary.Add(key, value);
            }
            return dictionary;
        }
    }
}