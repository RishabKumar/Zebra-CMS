using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Framework.Contexts;
using Zebra.Framework.Executors;

namespace Zebra.Services.Operations
{
    public static class FrameworkOperations
    {
        public static void Execute(string nodeid, short processType)
        {
            var nodeop = OperationsFactory.NodeOperations;
            var fieldop = OperationsFactory.FieldOperations;
            var node = nodeop.GetNode(nodeid);
            var listoffields = fieldop.GetInclusiveFieldsOfTemplate(node.Id.ToString());

            List<FieldData> list = new List<FieldData>();
            foreach (var field in listoffields)
            {
                var fielddata = new FieldData(field.Id, field.FieldName, nodeop.GetValueForField(nodeid, field.Id.ToString()), node.TemplateId, node.Template.TemplateName);
                list.Add(fielddata);
            }

            var nc = new NodeContext(node.Id, node.NodeName, list);
            var fc = new FrameworkContext(GetFrameworkNodeContext(node.Id.ToString(), processType), nc);
            FrameworkExecutor.Execute(fc);
        }

        private static FrameworkNodeContext GetFrameworkNodeContext(string initiatornodeid, short processType)
        {
            var list = new List<FieldData>();
            switch(processType)
            {
                case ProcessType.VALIDATION_TYPE:
                    var frameworknodeid = OperationsFactory.NodeOperations.GetValueForField(initiatornodeid, "B5FD7B60-0E49-4A41-9C4C-B99A33E072D6");
                    var frameworknode = OperationsFactory.NodeOperations.GetNode(frameworknodeid);
                    var fields = OperationsFactory.FieldOperations.GetInclusiveFieldsOfTemplate(frameworknode.TemplateId.ToString());
                    foreach (var field in fields)
                    {
                        list.Add(new FieldData(field.Id, field.FieldName, OperationsFactory.NodeOperations.GetValueForField(frameworknodeid, field.Id.ToString())));
                    }
                    var context = new FrameworkNodeContext(Guid.Parse(frameworknodeid), frameworknode.NodeName, list);
                    return context;
                    break;
            }
            return null;
        }

    }
}
