using System;
using System.Collections.Generic;
using Zebra.DataRepository.Models;
using Zebra.Models;
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
        Field CreateField(Field field, Template template, Language language);

        FieldType CreateFieldType(FieldType ft);

        [Obsolete("",true)]
        bool DetermineNodeTypeAndCreate(string name, Guid newid, Node node);

        //bool CreateField(Field f);

        //bool CreateField(List<Field> lst);

        //Template AddField(Field f, Template t);

        

        //Template UpdateTemplate(List<Field> lst, Template t);

        //bool DeleteTemplate(Template t);

        //bool DeleteField(Field f);

        Node CreateNode(string nodename, string parentid, string templateid, List<Field> fields, string zebratype = ZebraType.NODE);
        bool DeleteNode(string nodeid);
        void MoveNode(string nodeid, string newparentid);
        List<NodeFieldMap> GetNodeFieldMapData(string nodeid);
        List<NodeFieldMap> GetNodeFieldMapData(string nodeid, string languageid);
        bool LocalizeNode(string nodeid, string languageid);
        List<Language> GetNodeLanguages(string nodeid);
        bool RegisterFieldsForNode(IEntity node, Field field);
        bool RegisterFieldsForNode(IEntity node, Field field, Language language);
        List<Template> GetInheritedTemplate(string nodeid);
        bool AddInheritance(string nodeid, string templateid);
        bool RemoveInheritance(string nodeid, string templateid);
    }
}
