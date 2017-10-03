using System;
using System.Collections.Generic;
using Zebra.DataRepository.Models;
using Zebra.Services.Type;

namespace Zebra.Services.Interfaces
{
    public interface IStructureOperations
    {
        //List<Field> GetFieldsByTemplate(Template t);

        Node GetNode(string nodeid);

        Template CreateTemplate(Template t);

        Template GetTemplate(string templateid);

        Field CreateField(Field field, Template template);

        FieldType CreateFieldType(FieldType ft);

        [Obsolete("",true)]
        void DetermineNodeTypeAndCreate(string name, Guid newid, Node node);

        //bool CreateField(Field f);

        //bool CreateField(List<Field> lst);

        //Template AddField(Field f, Template t);

        

        //Template UpdateTemplate(List<Field> lst, Template t);

        //bool DeleteTemplate(Template t);

        //bool DeleteField(Field f);

        Node CreateNode(string nodename, string parentid, string templateid, List<Field> fields, string zebratype = ZebraType.NODE);
        bool DeleteNode(string nodeid);

        List<NodeFieldMap> GetNodeFieldMapData(string nodeid);
    }
}
