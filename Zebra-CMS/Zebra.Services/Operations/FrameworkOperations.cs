using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Framework.Contexts;
using Zebra.Framework.Executors;

namespace Zebra.Services.Operations
{
    public static class FrameworkOperations
    { 
        public static void Execute(string nodeid, short processType, dynamic parameters = null)
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
            var fc = new FrameworkContext(GetFrameworkNodeContext(node.Id.ToString(), processType, parameters), nc, processType);
            if (fc != null)
            {
                FrameworkExecutor.Execute(fc);
            }
        }

        private static FrameworkNodeContext GetFrameworkNodeContext(string initiatornodeid, short processType, dynamic parameters)
        {
            switch (processType)
            {
                case ProcessType.VALIDATION_TYPE:
                    {
                        return ValidationProcess(initiatornodeid);
                    }
                case ProcessType.ROADMAP_TYPE:
                    {
                        return RoadmapProcess(initiatornodeid, parameters);
                    }
            }
            return null;
        }

        private static FrameworkNodeContext ValidationProcess(string initiatornodeid)
        {
            var list = new List<FieldData>();
            var frameworknodeid = OperationsFactory.NodeOperations.GetValueForField(initiatornodeid, "B5FD7B60-0E49-4A41-9C4C-B99A33E072D6");
            var frameworknode = OperationsFactory.NodeOperations.GetNode(frameworknodeid);
            var fields = OperationsFactory.FieldOperations.GetInclusiveFieldsOfTemplate(frameworknode.TemplateId.ToString());
            foreach (var field in fields)
            {
                list.Add(new FieldData(field.Id, field.FieldName, OperationsFactory.NodeOperations.GetValueForField(frameworknodeid, field.Id.ToString())));
            }
            var context = new FrameworkNodeContext(Guid.Parse(frameworknodeid), frameworknode.NodeName, list);
            return context;
        }

        private static FrameworkNodeContext RoadmapProcess(string initiatornodeid, dynamic parameters)
        {
            var nodeop = OperationsFactory.NodeOperations;
            var fieldop = OperationsFactory.FieldOperations;
            var node = nodeop.GetNode(initiatornodeid);
            List<FieldData> list = new List<FieldData>();
            var roadmapid = nodeop.GetValueForField(initiatornodeid, "EC9F06A6-4194-4332-B58F-957FC4FD25B4");
            var roadmapnode = nodeop.GetNode(roadmapid);
            var fields = OperationsFactory.FieldOperations.GetInclusiveFieldsOfTemplate(roadmapnode.TemplateId.ToString());
            var initialphasefield = fields.Where(x => x.FieldName == "Initial Phase Executor").FirstOrDefault();
            var frameworkdata = FrameworkExecutor.GetFrameworkData(node.Id, roadmapnode.Id);
            var frameworknodeid = "";
            var currentphaseid = frameworkdata != null ? (string)((dynamic)JsonConvert.DeserializeObject(frameworkdata.ProcessData))["currentphaseid"] : null;
            var initialphaseid = nodeop.GetValueForField(roadmapid, initialphasefield.Id.ToString());

            if(string.IsNullOrWhiteSpace(currentphaseid) || currentphaseid == initialphaseid)
            {
                currentphaseid = initialphaseid;
            }
            if (parameters != null)
            {   
                var param = parameters;
                var phasenodes = nodeop.GetChildNodes(nodeop.GetNode(roadmapid.ToString()));
                var phasetemplateid = phasenodes.FirstOrDefault().TemplateId;
                var phasefields = fieldop.GetInclusiveFieldsOfTemplate(phasetemplateid.ToString());
                var phaseclasstype = phasefields.Where(x => x.FieldName == "Type").FirstOrDefault();

                if (param["result"] == "SUBMIT")
                {
                    var nxtphasefield = phasefields.Where(x => x.FieldName == "Next Phase Executor").FirstOrDefault();
                    currentphaseid = nodeop.GetValueForField(currentphaseid, nxtphasefield.Id.ToString());
                    frameworknodeid = currentphaseid;
                }
                else if (param["result"] == "BOUNCE")
                {
                    var bouncephasefield = phasefields.Where(x => x.FieldName == "Bounce Phase Executor").FirstOrDefault();
                    currentphaseid = nodeop.GetValueForField(currentphaseid, bouncephasefield.Id.ToString());
                    frameworknodeid = currentphaseid;
                }
                //list of all fields is fetched as the phase can be a derived one and could have more fields.
                if (!string.IsNullOrWhiteSpace(frameworknodeid))
                {
                    var tmpphasefields = fieldop.GetInclusiveFieldsOfTemplate(nodeop.GetNode(frameworknodeid).TemplateId.ToString());
                    foreach (var t in tmpphasefields)
                    {
                        list.Add(new FieldData(t.Id, t.FieldName, nodeop.GetValueForField(frameworknodeid, t.Id.ToString())));
                    }
                    FrameworkData tt = FrameworkExecutor.GetFrameworkData(node.Id, roadmapnode.Id);
                    if(tt != null)
                    {
                       FrameworkExecutor.UpdateFrameworkData(tt.Id, Guid.Parse(initiatornodeid), Guid.Parse(roadmapid), "Roadmap", "{\"currentphaseid\":\"" + currentphaseid + "\"}", "intermediate");
                    }
                    else
                    {
                        FrameworkExecutor.SaveFrameworkData(Guid.Parse(initiatornodeid), Guid.Parse(roadmapid), "Roadmap", "{\"currentphaseid\":\"" + currentphaseid + "\"}", "intermediate");
                    }
                }
            }
            if (!string.IsNullOrWhiteSpace(frameworknodeid))
            {
                var context = new FrameworkNodeContext(Guid.Parse(frameworknodeid), nodeop.GetNode(frameworknodeid).NodeName, list);
                return context;
            }
            return null;
        }

        //public static void SaveFrameworkData(Guid nodeId, Guid relatedId, string processName, string processData, string value)
        //{
        //    var data = new FrameworkData() { Id = Guid.NewGuid(), NodeId = nodeId, RelatedId = relatedId, ProcessName = processName, ProcessData = processData, Value = value};
        //    IFrameworkRepository repo = new FrameworkRepository();
        //    repo.SaveFrameworkData(data);
        //}

        //public static FrameworkData GetFrameworkData(Guid nodeId ,Guid relatedId)
        //{
        //    BaseRepository<FrameworkData> repo = new FrameworkRepository();
        //    return repo.GetByCondition(x=>x.NodeId == nodeId && relatedId == x.RelatedId).FirstOrDefault();
        //}

        //public static void UpdateFrameworkData(Guid id, Guid nodeId, Guid relatedId, string processName, string processData, string value)
        //{
        //    var data = new FrameworkData() { Id = id, NodeId = nodeId, RelatedId = relatedId, ProcessName = processName, ProcessData = processData, Value = value };
        //    IFrameworkRepository repo = new FrameworkRepository();
        //    repo.UpdateFrameworkData(data);
        //}

        //public static List<FrameworkData> GetFrameworkDataList(Guid nodeId)
        //{
        //    BaseRepository<FrameworkData> repo = new FrameworkRepository();
        //    return repo.GetByCondition(x => x.NodeId == nodeId).ToList();
        //}

    }
}
