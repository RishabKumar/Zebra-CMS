using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Utilities.UtilityProcessor
{
    public class FieldBuilderUtility : IZebraUtility
    {
        public dynamic Process(object obj = null)
        {
            if (obj != null)
            {
                dynamic data = (dynamic)obj;
                int count = data.Count;
                string nodeid = data[0]["templatenodeid"];
                for(int i = 1; i < count; i++)
                {
                    var field = new Field() { Id = Guid.NewGuid(), FieldName = data[i]["name"], TypeId = data[i]["typeid"] };
                    var template = new Template() { Id = Guid.Parse(nodeid) };  // as Node id and template id both are same in respective tables.
                    var newfield = OperationsFactory.StructureOperations.CreateField(field, template);   
                }
                //    if(field != null)
                {
                   // GetNodeRepository.
                }
            }
            return true;
        }

        public string RenderView(object obj = null)
        {
            return "~/Utilities/UtilityViews/FieldBuilder/FieldBuilderMenu.cshtml";
        }

        public string RenderFieldBuilder(object obj = null)
        {
            return "~/Utilities/UtilityViews/FieldBuilder/FieldBuilder.cshtml";
        }
    }
}