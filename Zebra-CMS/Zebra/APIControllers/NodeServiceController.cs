using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.APIControllers
{
    public class NodeServiceController : ApiController
    {
        public INodeOperations _ops;
        public IFieldOperations _fieldops;
        
        public NodeServiceController(INodeOperations nodeops, IFieldOperations fieldops) : base()
        {
            _ops = nodeops;
            _fieldops = fieldops;
        }

        [HttpGet]
        public string GetChildNodes(string parentid)
        {
            Node node = new Node() { Id = new Guid(parentid) };
            var list = _ops.GetChildNodes(node);
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
            var fields = _fieldops.GetAllParentFieldsFromTemplate(templateid);
            var node = ((IStructureOperations)_ops).CreateNode(nodename, parentid, templateid, fields);
            return JsonConvert.SerializeObject(node);
        }

        [HttpPost]
        public bool DeleteNode()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = JsonConvert.DeserializeObject(json);

            string nodeid = tmp.nodeid;
            var result = ((IStructureOperations)_ops).DeleteNode(nodeid);
            return result;
        }

        [HttpPost]
        public bool SaveNode()
        {
            bool result = false;
            var form = HttpContext.Current.Request.Form;
            var nodeid = form["nodeid"];
            var node = _ops.GetNode(nodeid);
            //var fields = _fieldops.GetAllParentFieldsFromTemplate(node.TemplateId.ToString());
            _ops.SaveNode(node, form);

            return result;
        }




    }
}
