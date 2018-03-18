using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Framework.Contexts;

namespace Zebra.Framework.Executors
{
    public static class FrameworkExecutor
    {
        public static bool Execute(FrameworkContext fwcontext)
        {
            if (fwcontext != null && fwcontext.frameworknodecontext != null && fwcontext.initiatornodecontext != null)
            {
                var classType = fwcontext.frameworknodecontext.FieldsData.Where(x => x.FieldName == "Type").Select(y => y.FieldValue).FirstOrDefault();
                if (!string.IsNullOrWhiteSpace(classType))
                {
                    var type = Type.GetType(classType);
                    var obj = Activator.CreateInstance(type);
                    var mi = type.GetMethod("Execute");
                    var data = (bool)mi.Invoke(obj, new[] { fwcontext });
                    string processdata = string.Empty;
                    string processname = string.Empty;
                    switch(fwcontext.processtype)
                    {
                        case ProcessType.VALIDATION_TYPE:
                            if (data)
                            {
                                processdata = "{\"validation\":\"pass\"}";
                            }
                            else
                                processdata = "{\"validation\":\"fail\"}";
                            processname = "Validation";
                            break;
                        case ProcessType.ROADMAP_TYPE:
                            //empty as the steps remains for all the roadmap-phases, however new class type can be added to phases that isn't the part of regular roadmap cycle(no save/update/delete).
                            break;
                    }
                    var frameworkdata = GetFrameworkData(fwcontext.initiatornodecontext.NodeId, fwcontext.frameworknodecontext.NodeId);
                    if (frameworkdata != null && !string.IsNullOrWhiteSpace(processdata))
                    {
                        UpdateFrameworkData(frameworkdata.Id, frameworkdata.NodeId, frameworkdata.RelatedId, processname, processdata, frameworkdata.Value);
                    }
                    else if(!string.IsNullOrWhiteSpace(processdata))
                    {
                        SaveFrameworkData(fwcontext.initiatornodecontext.NodeId, fwcontext.frameworknodecontext.NodeId, processname, processdata, string.Empty);
                    }
                    return data;
                }
            }
            return false;
        }

        public static void SaveFrameworkData(Guid nodeId, Guid relatedId, string processName, string processData, string value)
        {
            var data = new FrameworkData() { Id = Guid.NewGuid(), NodeId = nodeId, RelatedId = relatedId, ProcessName = processName, ProcessData = processData, Value = value };
            IFrameworkRepository repo = new FrameworkRepository();
            repo.SaveFrameworkData(data);
        }

        public static FrameworkData GetFrameworkData(Guid nodeId, Guid relatedId)
        {
            BaseRepository<FrameworkData> repo = new FrameworkRepository();
            return repo.GetByCondition(x => x.NodeId == nodeId && relatedId == x.RelatedId).FirstOrDefault();
        }

        public static void UpdateFrameworkData(Guid id, Guid nodeId, Guid relatedId, string processName, string processData, string value)
        {
            var data = new FrameworkData() { Id = id, NodeId = nodeId, RelatedId = relatedId, ProcessName = processName, ProcessData = processData, Value = value };
            IFrameworkRepository repo = new FrameworkRepository();
            repo.UpdateFrameworkData(data);
        }

        public static List<FrameworkData> GetFrameworkDataList(Guid nodeId)
        {
            BaseRepository<FrameworkData> repo = new FrameworkRepository();
            return repo.GetByCondition(x => x.NodeId == nodeId).ToList();
        }
    }
}
