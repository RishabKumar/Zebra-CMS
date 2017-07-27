using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.CustomAttributes;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class CPanelController : ZebraController
    {
        
        public CPanelController(NodeOperations nodeOperations) : base(nodeOperations)
        {
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

        public ActionResult NodeTree(string nodeid)
        {
            var list = new List<Node>();
            list.Add(_nodeop.GetNode(nodeid));
            return View(list);
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
