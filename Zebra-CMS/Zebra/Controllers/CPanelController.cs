using System;
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
        public CPanelController(NodeOperations nodeOperations, FieldOperations fieldOperations, UserOperations userOperations) : base(nodeOperations, fieldOperations, userOperations, true)
        {
             
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
            root = _userOperations.FilterByUser(CurrentUser, root);
           // ((NodeOperations)_nodeop).CreateContentMap();
            var list = new List<Node>();
            list.Add(root);
            ViewBag.Root = list;
            ViewBag.Utilities = new List<string>
            {   "Zebra.Utilities.UtilityProcessor.FieldBuilderUtility, Zebra",
                "Zebra.Utilities.UtilityProcessor.InheritanceUtility, Zebra",
                "Zebra.Utilities.UtilityProcessor.RoadmapUtility, Zebra",
                "Zebra.Utilities.UtilityProcessor.ValidationUtility, Zebra"
            };
            return View();
        }

        //Default nodeid is Template node Id
        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult NodeTree(string nodeid= "8087FA7D-6753-40B9-9F3A-7AE62E882258")
        {
            var list = new List<Node>();
            var node = _nodeop.GetNode(nodeid);
            node = _userOperations.FilterByUser(CurrentUser, node);
            list.Add(node);
            if(list.Count == 0)
            {
                return null;
            }
            return View(list);
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult NodeSearchResult(string nameorid)
        {
            return View(_userOperations.FilterByUser(CurrentUser, _nodeop.SearchNode(nameorid)));
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult NodeBrowser(string nodeid, string languageid = "B45089D2-CF01-4351-B6A6-40FBFFD64DC3")
        {
            var node = _nodeop.GetNode(nodeid);
            node = _userOperations.FilterByUser(CurrentUser, node);
            if(node == null)
            {
                return null;
            }
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

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult RenderUtility(string fullyqualifiedname, string method = "RenderView", dynamic data = null)
        {
            var type = Type.GetType(fullyqualifiedname);
            Assembly assembly = null;
            if (type != null && (assembly = Assembly.GetAssembly(type)) != null)
            {
                var instance = Activator.CreateInstance(type, null);
                object[] args = new[] { data };
                var mi = type.GetMethod("HasExecutionRights");
                data = mi.Invoke(instance, args);
                if (data.Equals(true))
                {
                    mi = type.GetMethod(method);
                    var path = mi.Invoke(instance, args).ToString();
                    if (VirtualPathUtility.IsAppRelative(path))
                    {
                        return PartialView(viewName: path, model: args[0]);
                    }
                }
            }
            return PartialView();
        }
        
        [HttpGet]
        public ActionResult PageDesigner(string nodeid)
        {
            if(!string.IsNullOrWhiteSpace(nodeid))
            {
                var node = _nodeop.GetNode(nodeid);
                if(node != null)
                {
                    var designdetailfieldid = "06C00328-A252-4BA9-A8C2-95A354A90E2F";
                    var data = _nodeop.GetValueForField(node.Id.ToString(), designdetailfieldid);
                    // string json = ("[{\"iscontainer\":true,\"children\":[{\"iscontainer\":true,\"children\":[{\"iscontainer\":true,\"children\":[]},{\"iscontainer\":true,\"children\":[{\"iscontainer\":true,\"children\":[{\"iscontainer\":true,\"children\":[]}]},{\"actionid\":\"cd51d86f - c990 - 48f2 - 9655 - 160ec15c1cd8\",\"children\":[]}]}]},{\"iscontainer\":true,\"children\":[]}]},{\"iscontainer\":true,\"children\":[]},{\"iscontainer\":true,\"children\":[]}]");
                    ViewBag.NodeId = nodeid;
                    ViewBag.DesignerDetailFieldId = designdetailfieldid;
                    ViewBag.DefaultLanguageId = LanguageManager.GetDefaultLanguage().Id.ToString();
                    return View(model: HttpUtility.HtmlDecode(data));
                }
            }
            return null;
        }
    }
}