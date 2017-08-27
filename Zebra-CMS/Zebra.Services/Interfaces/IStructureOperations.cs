using System;
using System.Collections.Generic;
using Zebra.DataRepository.Models;
using Zebra.Services.Type;

namespace Zebra.Services.Interfaces
{
    public interface IStructureOperations
    {
        //List<Field> GetFieldsByTemplate(Template t);

        Template CreateTemplate(Template t);

        Template GetTemplate(string templateid);

        Field CreateField(Field field);

        FieldType CreateFieldType(FieldType ft);

        string DetermineNodeTypeAndCreate(Node node, Guid newid);

        //bool CreateField(Field f);

        //bool CreateField(List<Field> lst);

        //Template AddField(Field f, Template t);

        

        //Template UpdateTemplate(List<Field> lst, Template t);

        //bool DeleteTemplate(Template t);

        //bool DeleteField(Field f);

        Node CreateNode(string nodename, string parentid, string templateid, List<Field> fields);
        bool DeleteNode(string nodeid);

        List<NodeFieldMap> GetNodeFieldMapData(string nodeid);
    }
}
