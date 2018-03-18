using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.Models;
using Zebra.Services.Operations;

namespace Zebra.Utilities.UtilityProcessor
{
    public class InheritanceUtility : IZebraUtility
    {
        public dynamic Process(ref object obj)
        {
            if (obj != null)
            {
                dynamic data = (dynamic)obj;
                int count = data.Count;
                string nodeid = data[0]["nodeid"];
                
                var list = OperationsFactory.StructureOperations.GetInheritedTemplate(nodeid);
                List<Template> newlist = new List<Template>();
                for(int i = 1; i < count; i++)
                {
                    var id = (string)data[i]["id"];
                    Template template = null;
                    if(!string.IsNullOrWhiteSpace(id) && (template = OperationsFactory.StructureOperations.GetTemplate(id)) != null )
                    {
                        if (list.RemoveAll(x => x.Id == template.Id) == 0)
                        {
                            newlist.Add(template);
                        }
                    }
                }
                list.ForEach((x) => { OperationsFactory.StructureOperations.RemoveInheritance(nodeid, x.Id.ToString()); });
                newlist.ForEach((x) => { OperationsFactory.StructureOperations.AddInheritance(nodeid, x.Id.ToString()); });
                return true;
            }
            return false;
        }

        public string RenderView(ref object obj)
        {
            return "~/Utilities/UtilityViews/Inheritance/InheritanceMenu.cshtml";
        }

        public string RenderInheritance(ref dynamic obj)
        {
            string nodeid = JsonConvert.DeserializeObject<dynamic>(obj[0])[0]["nodeid"];
            var templates = OperationsFactory.StructureOperations.GetInheritedTemplate(nodeid);
            obj = new Dictionary<string, dynamic>();
            obj.Add("nodeid", nodeid);
            obj.Add("templates", templates);
            return "~/Utilities/UtilityViews/Inheritance/AddInheritance.cshtml";
        }

        public bool HasExecutionRights(ref object obj)
        {
            return true;
        }
    }
}