using Microsoft.Practices.Unity;
using Newtonsoft.Json;
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
        public dynamic Process(ref object obj)
        {
            if (obj != null)
            {
                dynamic data = (dynamic)obj;
                int count = data.Count;
                string nodeid = data[0]["templatenodeid"];
                Template template = OperationsFactory.StructureOperations.GetTemplate(nodeid); // as Node id and template id both are same in respective tables.
                if (template == null)
                {
                    return false;
                }
                var listoffields = OperationsFactory.FieldOperations.GetExclusiveFieldsOfTemplate(nodeid);
                for (int i = 1; i < count; i++)
                {
                    Field tmpfield = null;
                    if (!string.IsNullOrWhiteSpace((string)data[i]["id"]) && (tmpfield = OperationsFactory.FieldOperations.GetField((string)data[i]["id"])) != null)
                    {
                        var existingfield = listoffields.Where(x => x.Id == tmpfield.Id).FirstOrDefault();
                        var updateflag = false;
                        if (existingfield != null)
                        {
                            if(!existingfield.FieldName.Equals((string)data[i]["name"]))
                            {
                                existingfield.FieldName = (string)data[i]["name"];
                                updateflag = true;
                            }
                            if(!existingfield.TypeId.Equals(Guid.Parse((string)data[i]["typeid"])))
                            {
                                existingfield.TypeId = Guid.Parse((string)data[i]["typeid"]);
                                updateflag = true;
                            }
                            if(updateflag)
                            {
                                OperationsFactory.FieldOperations.UpdateField(existingfield);
                            }
                            listoffields.RemoveAll(x => x.Id == existingfield.Id); // remove the field from list, afterwards the left over fields in list are removed from db.        
                        }
                        continue;
                    }
                    var field = new Field() { Id = Guid.NewGuid(), FieldName = data[i]["name"], TypeId = data[i]["typeid"] };
                    //var template = new Template() { Id = Guid.Parse(nodeid) };  // as Node id and template id both are same in respective tables.
                    var newfield = OperationsFactory.StructureOperations.CreateField(field, template);   
                }

                foreach(var fields in listoffields)
                {
                    OperationsFactory.FieldOperations.DeleteField(fields.Id.ToString());
                    //NodefieldMap entry are auto deleted due to cascading.
                }
                //    if(field != null)
                {
                   // GetNodeRepository.
                }
            }
            return true;
        }

        public string RenderView(ref object obj)
        {
            return "~/Utilities/UtilityViews/FieldBuilder/FieldBuilderMenu.cshtml";
        }


        // need to work on parameter obj, need to make it more generic.
        public string RenderFieldBuilder(ref dynamic obj)
        {
            string templateid = JsonConvert.DeserializeObject<dynamic>(obj[0])[0]["templateid"];
            obj = new Dictionary<string, dynamic>();
            obj.Add("Fields" ,OperationsFactory.FieldOperations.GetExclusiveFieldsOfTemplate(templateid));
            obj.Add("FieldTypes", OperationsFactory.FieldOperations.GetAllFieldTypes());
            return "~/Utilities/UtilityViews/FieldBuilder/FieldBuilder.cshtml";
        }
    }
}