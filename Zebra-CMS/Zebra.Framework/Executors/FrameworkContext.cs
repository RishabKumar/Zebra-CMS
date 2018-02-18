using System;
using System.Collections.Generic;

namespace Zebra.Framework.Contexts
{
    public class FrameworkContext
    {
        public FrameworkNodeContext frameworknodecontext;
        public NodeContext initiatornodecontext;
        public ProcessType processtype;

        public FrameworkContext(FrameworkNodeContext frameworknodecontext, NodeContext initiator)
        {
            this.frameworknodecontext = frameworknodecontext;
            initiatornodecontext = initiator;
        }
    }

    public sealed class ProcessType
    {
        public const short ROADMAP_TYPE = 0;
        public const short VALIDATION_TYPE = 1;
        public const short LIFESPAN_TYPE = 2;
        public const short SECURITY_TYPE = 3;
       // public const short ROADMAP_TYPE = "Roadmap";
    }

    public class FieldData
    {
        public FieldData(Guid fieldId, string fieldName, string fieldValue, Guid? templateId = null, string templateName = null)
        {
            FieldId = fieldId;
            FieldName = fieldName;
            FieldValue = fieldValue;
            if (templateId.HasValue)
            {
                TemplateId = templateId.Value;
            }
            TemplateName = templateName;
        }

        public Guid FieldId { get; set; }
        public string FieldName { get; set; }
        public string FieldValue { get; set; }
        public Guid TemplateId { get; set; }
        public string TemplateName { get; set; }
        

    }

    public class NodeContext
    {
        public Guid NodeId { get; set; }

        public string Name { get; set; }

        public List<FieldData> FieldsData { get; set; }

        public NodeContext(Guid nodeid, string Name, List<FieldData> fieldsData)
        {
            this.NodeId = nodeid;
            this.Name = Name;
            this.FieldsData = fieldsData;
        }
    }

    public class FrameworkNodeContext : NodeContext
    {
        public FrameworkNodeContext(Guid nodeid, string Name, List<FieldData> fieldsData) : base(nodeid, Name, fieldsData)
        {
        }
    }
}