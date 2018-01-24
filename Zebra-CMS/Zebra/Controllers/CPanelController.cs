﻿using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using Zebra.CustomAttributes;
using Zebra.DataRepository.Models;
using Zebra.Globalization;
using Zebra.ViewModel;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class CPanelController : ZebraController
    {
        private IFieldOperations _fieldOperations;

        public void Data(string nodeid)
        {
            OperationsFactory.NodeOperations.GetAllParentNodes(nodeid);
        }

        public CPanelController(NodeOperations nodeOperations, FieldOperations fieldOperations) : base(nodeOperations, true)
        {
            _fieldOperations = fieldOperations;
        }

        // GET: CPanel
        public override ActionResult Index()
        {
            NameValueCollection section = (NameValueCollection)ConfigurationManager.GetSection("ZebraUtility");
            string userName = section["userName"];
            string userPassword = section["userPassword"];
            return RedirectToAction("Editor");
        }

        // GET: CPanel/Editor
        [ZebraAuthorize(Roles ="Editor")]
        public ActionResult Editor()
        {
            Node root = _nodeop.GetRootNode();
           // ((NodeOperations)_nodeop).CreateContentMap();
            var list = new List<Node>();
            list.Add(root);
            ViewBag.Root = list;
            ViewBag.Utilities = new List<string> { "Zebra.Utilities.UtilityProcessor.FieldBuilderUtility, Zebra", "Zebra.Utilities.UtilityProcessor.InheritanceUtility, Zebra" };
            return View();
        }

        //Default nodeid is Template node Id
        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult NodeTree(string nodeid= "8087FA7D-6753-40B9-9F3A-7AE62E882258")
        {
            var list = new List<Node>();
            list.Add(_nodeop.GetNode(nodeid));
            return View(list);
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult NodeSearchResult(string nameorid)
        {
            return View(_nodeop.SearchNode(nameorid));
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult NodeBrowser(string nodeid, string languageid = "B45089D2-CF01-4351-B6A6-40FBFFD64DC3")
        {
            var node = _nodeop.GetNode(nodeid);
            var language = LanguageManager.GetLanguageById(languageid);
            var languages = LanguageManager.GetAllLanguages();
            var list = _fieldOperations.GetInclusiveFieldsOfTemplate(node.Id.ToString());
            List<string> htmllist = new List<string>();
            IEnumerable<NodeFieldMap> nodefieldmap = ((IStructureOperations)_nodeop).GetNodeFieldMapData(node.Id.ToString(), language.Id.ToString());
            //   foreach (var field in list)
            foreach(var nodefield in nodefieldmap)
            {
                //         htmllist.Add(_fieldOperations.GetRenderedField(field.Id.ToString()));
                htmllist.Add(_fieldOperations.GetRenderedField(nodeid, nodefield.FieldId.ToString(), nodefield.Id.ToString()));
            }
            var orderedfields = new Dictionary<string, List<string>>();

            foreach (var nodefield in nodefieldmap)
            {
                if (nodefield.Field != null)
                {
                    var templatename = nodefield.Field.GetTemplate().TemplateName;
                    if (orderedfields.ContainsKey(templatename))
                    {
                        orderedfields[templatename].Add(_fieldOperations.GetRenderedField(nodeid, nodefield.FieldId.ToString(), nodefield.Id.ToString()));
                    }
                    else
                    {
                        var tmplist = new List<string>() { _fieldOperations.GetRenderedField(nodeid, nodefield.FieldId.ToString(), nodefield.Id.ToString()) };
                        orderedfields.Add(templatename, tmplist);
                    }
                }
            }

            var presentlanguages = ((IStructureOperations)_nodeop).GetNodeLanguages(node.Id.ToString());
            return View(model: new NodeBrowserModel() { fields = htmllist, orderedfields = orderedfields,  node = node, template = node.Template, currentlanguage = language, alllanguages = languages, allnodelanguages = presentlanguages });
        }
        
        public ActionResult RenderUtility(string fullyqualifiedname, string method = "RenderView", dynamic data = null)
        {
            var type = Type.GetType(fullyqualifiedname);
            Assembly assembly = null;
            if (type != null && (assembly = Assembly.GetAssembly(type)) != null)
            {
                var instance = Activator.CreateInstance(type, null);
                var mi = type.GetMethod(method);
                object[] args = new[] { data };
                var path = mi.Invoke(instance, args).ToString();
                if (VirtualPathUtility.IsAppRelative(path))
                {
                    return PartialView(viewName:path, model: args[0]);
                }
            }
            return PartialView();
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
