using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.CustomAttributes;
using Zebra.DataRepository.Models;
using Zebra.ModelView;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class CPanelController : ZebraController
    {
        private IFieldOperations _fieldOperations;

        public CPanelController(NodeOperations nodeOperations, FieldOperations fieldOperations) : base(nodeOperations)
        {
            _fieldOperations = fieldOperations;
        }

        // GET: CPanel
        public override ActionResult Index()
        {
            return RedirectToAction("Editor");
        }

        // GET: CPanel/Editor
        [ZebraAuthorize(Roles ="Editor")]
        public ActionResult Editor()
        {
            Node root = _nodeop.GetRootNode();
            var list = new List<Node>();
            list.Add(root);
            ViewBag.Root = list;

            return View();
        }

        //Default nodeid is Template node Id
        public ActionResult NodeTree(string nodeid= "8087FA7D-6753-40B9-9F3A-7AE62E882258")
        {
            var list = new List<Node>();
            list.Add(_nodeop.GetNode(nodeid));
            return View(list);
        }
        
        public ActionResult NodeBrowser(string nodeid)
        {
            var node = _nodeop.GetNode(nodeid);
            var list = _fieldOperations.GetAllParentFieldsFromTemplate(node.TemplateId.ToString());
            List<string> htmllist = new List<string>();
            IEnumerable<NodeFieldMap> nodefieldmap = ((IStructureOperations)_nodeop).GetNodeFieldMapData(node.Id.ToString());
            //   foreach (var field in list)
            foreach(var nodefield in nodefieldmap)
            {
                //         htmllist.Add(_fieldOperations.GetRenderedField(field.Id.ToString()));
                htmllist.Add(_fieldOperations.GetRenderedField(nodeid, nodefield.FieldId.ToString(), nodefield.Id.ToString()));
            }
            //.Select(x => x.Id).Cast<string>()
            return View(model: new NodeBrowserModel() { fields = htmllist, nodeid = nodeid });
        } 

        // GET: CPanel/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CPanel/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: CPanel/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: CPanel/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: CPanel/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: CPanel/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
