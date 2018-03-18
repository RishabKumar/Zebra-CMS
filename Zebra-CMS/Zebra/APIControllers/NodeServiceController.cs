using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Zebra.Application;
using Zebra.CustomAttributes;
using Zebra.DataRepository.Models;
using Zebra.Globalization;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.APIControllers
{
    [ZebraWebAPIAuthorize]
    public class NodeServiceController : ApiController
    {
        private IStructureOperations _structops;
        private INodeOperations _nodeops;
        private IFieldOperations _fieldops;
        private IUserOperations _userops;
        
        public NodeServiceController() : base()
        {
            _structops = OperationsFactory.StructureOperations;
            _nodeops = OperationsFactory.NodeOperations;
            _fieldops = OperationsFactory.FieldOperations;
            _userops = OperationsFactory.UserOperations;
            ZebraContext.IsEditorMode = false;
        }

        [HttpGet]
        public string GetChildNodes(string parentid)
        {
            Node node = new Node() { Id = new Guid(parentid) };
            var list = _nodeops.GetChildNodes(node);
            list = _userops.FilterByUser(ZebraContext.Current.CurrentUser, list).ToList();
            var newlist = list.Select(x => new { x.Id, x.NodeName });
            return JsonConvert.SerializeObject(newlist);
        }

        [HttpPost]
        public string CreateNode()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = JsonConvert.DeserializeObject(json);
            string parentid = tmp.parentid;
            string nodename = tmp.nodename;
            string templateid = tmp.templateid;
            var fields = _fieldops.GetInclusiveFieldsOfTemplate(templateid);  //templateid should be passed instead of nodeid
            var node = _structops.CreateNode(nodename, parentid, templateid, fields);
            return JsonConvert.SerializeObject(node, Formatting.Indented,
                                                new JsonSerializerSettings
                                                {
                                                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                                                });
        }

        [HttpPost]
        [Obsolete("remove list and add new table", true)]
        public void RegisterLocaleForNode()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic node = JsonConvert.DeserializeObject(json);
            string nodeid = node.nodeid;
            string languageid = node.languageid;
            _structops.LocalizeNode(nodeid, languageid);
         //   var list = _structops.GetNodeFieldMapData(nodeid, languageid);
            // list needs to be removed....add new table for nodelanguagemap.
             
            var tmplist = _structops.GetNodeFieldMapData(nodeid, LanguageManager.GetDefaultLanguage().Id.ToString());
            foreach(var nodefield in tmplist)
            {
                _structops.RegisterFieldsForNode(new Node() { Id = nodefield.NodeId.Value }, new Field() { Id = nodefield.FieldId.Value }, LanguageManager.GetLanguageById(languageid));
            }
            
        }

        [HttpPost]
        public void MoveNode()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = JsonConvert.DeserializeObject(json);
            string newparentid = tmp.newparentid;
            string nodeid = tmp.nodeid;
            _structops.MoveNode(nodeid, newparentid);
        }

        [HttpPost]
        public bool DeleteNode()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = JsonConvert.DeserializeObject(json);
            string nodeid = tmp.nodeid;
            var result = _structops.DeleteNode(nodeid);
            return result;
        }

        [HttpPost]
        public bool SaveNode()
        {
            bool result = false;
            var rawform = HttpContext.Current.Request.Form;
            var nodeid = rawform["nodeid"];
            var node = _nodeops.GetNode(nodeid);
            //var fields = _fieldops.GetAllParentFieldsFromTemplate(node.TemplateId.ToString());
            _nodeops.SaveNode(node, rawform);
            return result;
        }
    }
}
