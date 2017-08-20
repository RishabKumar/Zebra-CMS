[33mcommit 3f39afb7d6014c1f10f94a93623ccc5371d9113f[m
Author: Rishabh Kumar <devileatspie@gmail.com>
Date:   Fri Jul 28 02:20:32 2017 +0530

    added test code for 'insert node from template'

[1mdiff --git a/Zebra-CMS/.vs/Zebra/v14/.suo b/Zebra-CMS/.vs/Zebra/v14/.suo[m
[1mindex bb59ff2..0a129dc 100644[m
Binary files a/Zebra-CMS/.vs/Zebra/v14/.suo and b/Zebra-CMS/.vs/Zebra/v14/.suo differ
[1mdiff --git a/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.dll b/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.dll[m
[1mindex b2b0e66..b9d6e12 100644[m
Binary files a/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.dll and b/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.pdb b/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.pdb[m
[1mindex ed11db8..b69c33f 100644[m
Binary files a/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.pdb and b/Zebra-CMS/Zebra.Core/bin/Debug/Zebra.Core.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csproj.FileListAbsolute.txt b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csproj.FileListAbsolute.txt[m
[1mindex 7077a4f..7da2bc2 100644[m
[1m--- a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csproj.FileListAbsolute.txt[m
[1m+++ b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csproj.FileListAbsolute.txt[m
[36m@@ -26,4 +26,3 @@[m [mC:\Users\Rishabh\Documents\Visual Studio 2015\Projects\Zebra\Zebra-CMS\Zebra.Cor[m
 C:\Users\Rishabh\Documents\Visual Studio 2015\Projects\Zebra\Zebra-CMS\Zebra.Core\bin\Debug\Newtonsoft.Json.xml[m
 C:\Users\Rishabh\Documents\Visual Studio 2015\Projects\Zebra\Zebra-CMS\Zebra.Core\bin\Debug\System.Net.Http.Formatting.xml[m
 C:\Users\Rishabh\Documents\Visual Studio 2015\Projects\Zebra\Zebra-CMS\Zebra.Core\bin\Debug\System.Web.Http.xml[m
[31m-C:\Users\Rishabh\Documents\Visual Studio 2015\Projects\Zebra\Zebra-CMS\Zebra.Core\obj\Debug\Zebra.Core.csprojResolveAssemblyReference.cache[m
[1mdiff --git a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csprojResolveAssemblyReference.cache b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csprojResolveAssemblyReference.cache[m
[1mdeleted file mode 100644[m
[1mindex 55bdead..0000000[m
Binary files a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.csprojResolveAssemblyReference.cache and /dev/null differ
[1mdiff --git a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.dll b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.dll[m
[1mindex b2b0e66..b9d6e12 100644[m
Binary files a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.dll and b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.pdb b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.pdb[m
[1mindex ed11db8..b69c33f 100644[m
Binary files a/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.pdb and b/Zebra-CMS/Zebra.Core/obj/Debug/Zebra.Core.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra.DataRepository/DAL/NodeRepository.cs b/Zebra-CMS/Zebra.DataRepository/DAL/NodeRepository.cs[m
[1mindex 58eb405..29133f5 100644[m
[1m--- a/Zebra-CMS/Zebra.DataRepository/DAL/NodeRepository.cs[m
[1m+++ b/Zebra-CMS/Zebra.DataRepository/DAL/NodeRepository.cs[m
[36m@@ -23,6 +23,40 @@[m [mpublic Node CreateNode(Node node)[m
 [m
         }[m
 [m
[32m+[m[32m        public bool DeleteNode(Node node)[m
[32m+[m[32m        {[m
[32m+[m[32m            dynamic rnodes = null;[m
[32m+[m[32m            using (var dbt = _context.Database.BeginTransaction())[m
[32m+[m[32m            {[m
[32m+[m[32m                node = _context.Nodes.Where(x => x.Id == node.Id).FirstOrDefault();[m
[32m+[m[32m                List<Node> nodes = GetAllChildren(node, new List<Node>());[m
[32m+[m[32m                if (nodes == null)[m
[32m+[m[32m                    return false;[m
[32m+[m[32m                nodes.Add(node);[m
[32m+[m[32m                rnodes = _context.Nodes.RemoveRange(nodes.AsEnumerable());[m
[32m+[m[32m                _context.SaveChanges();[m
[32m+[m[32m                dbt.Commit();[m
[32m+[m[32m            }[m
[32m+[m[32m            if(rnodes != null)[m
[32m+[m[32m            {[m
[32m+[m[32m                return true;[m
[32m+[m[32m            }[m
[32m+[m[32m            return false;[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        private List<Node> GetAllChildren(Node node, List<Node> children)[m
[32m+[m[32m        {[m
[32m+[m
[32m+[m[32m            var nodes = GetChildNodes(node);[m
[32m+[m[32m            children.AddRange(nodes);[m
[32m+[m[32m            foreach (var n in nodes)[m
[32m+[m[32m            {[m
[32m+[m[32m                GetAllChildren(n, children);[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            return children;[m
[32m+[m[32m        }[m
[32m+[m
         public override List<Node> GetByCondition(Expression<Func<Node, bool>> selector)[m
         {[m
             return _context.Nodes.Where(selector).ToList();[m
[36m@@ -43,6 +77,11 @@[m [mpublic override List<Node> GetListById(IEntity t)[m
             return _context.Nodes.Where(x => x.Id.Equals(t.Id)).ToList();[m
         }[m
 [m
[32m+[m[32m        public Node GetNode(Node node)[m
[32m+[m[32m        {[m
[32m+[m[32m            return _context.Nodes.Where(x=> x.Id == node.Id).FirstOrDefault();[m
[32m+[m[32m        }[m
[32m+[m
         //public override Template GetById(IEntity t)[m
         //{[m
         //    return _context.Nodes.Where(x => x.Id.Equals(t.Id)).FirstOrDefault();[m
[1mdiff --git a/Zebra-CMS/Zebra.DataRepository/Interfaces/INodeRepository.cs b/Zebra-CMS/Zebra.DataRepository/Interfaces/INodeRepository.cs[m
[1mindex ba3a916..78e5258 100644[m
[1m--- a/Zebra-CMS/Zebra.DataRepository/Interfaces/INodeRepository.cs[m
[1m+++ b/Zebra-CMS/Zebra.DataRepository/Interfaces/INodeRepository.cs[m
[36m@@ -11,5 +11,9 @@[m [mpublic interface INodeRepository[m
     {[m
         List<Node> GetChildNodes(Node parentnode);[m
         Node CreateNode(Node node);[m
[32m+[m
[32m+[m[32m        bool DeleteNode(Node node);[m
[32m+[m
[32m+[m[32m        Node GetNode(Node node);[m
     }[m
 }[m
[1mdiff --git a/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.dll b/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.dll[m
[1mindex 5202fb6..1c3489d 100644[m
Binary files a/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.dll and b/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.pdb b/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.pdb[m
[1mindex 2a4f6ca..96c1723 100644[m
Binary files a/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.pdb and b/Zebra-CMS/Zebra.DataRepository/bin/Debug/Zebra.DataRepository.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.dll b/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.dll[m
[1mindex 5202fb6..1c3489d 100644[m
Binary files a/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.dll and b/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.pdb b/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.pdb[m
[1mindex 2a4f6ca..96c1723 100644[m
Binary files a/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.pdb and b/Zebra-CMS/Zebra.DataRepository/obj/Debug/Zebra.DataRepository.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/Interfaces/INodeOperations.cs b/Zebra-CMS/Zebra.Services/Interfaces/INodeOperations.cs[m
[1mindex 059c361..7781211 100644[m
[1m--- a/Zebra-CMS/Zebra.Services/Interfaces/INodeOperations.cs[m
[1m+++ b/Zebra-CMS/Zebra.Services/Interfaces/INodeOperations.cs[m
[36m@@ -15,5 +15,7 @@[m [mpublic interface INodeOperations[m
 [m
         List<Node> GetChildNodes(Node node);[m
 [m
[32m+[m[32m        Node GetNode(string nodeid);[m
[32m+[m
     }[m
 }[m
[1mdiff --git a/Zebra-CMS/Zebra.Services/Interfaces/IStructureOperations.cs b/Zebra-CMS/Zebra.Services/Interfaces/IStructureOperations.cs[m
[1mindex b51be6c..cc0cb12 100644[m
[1m--- a/Zebra-CMS/Zebra.Services/Interfaces/IStructureOperations.cs[m
[1m+++ b/Zebra-CMS/Zebra.Services/Interfaces/IStructureOperations.cs[m
[36m@@ -22,6 +22,6 @@[m [mpublic interface IStructureOperations[m
         //bool DeleteField(Field f);[m
 [m
         Node CreateNode(string nodename, string parentid, string templateid);[m
[31m-[m
[32m+[m[32m        bool DeleteNode(string nodeid);[m
     }[m
 }[m
[1mdiff --git a/Zebra-CMS/Zebra.Services/Operations/NodeOperations.cs b/Zebra-CMS/Zebra.Services/Operations/NodeOperations.cs[m
[1mindex 9208e34..1ff545d 100644[m
[1m--- a/Zebra-CMS/Zebra.Services/Operations/NodeOperations.cs[m
[1m+++ b/Zebra-CMS/Zebra.Services/Operations/NodeOperations.cs[m
[36m@@ -23,6 +23,16 @@[m [mpublic Node CreateNode(string nodename, string parentid, string templateid)[m
             return ((INodeRepository)_currentrepository).CreateNode(node);[m
         }[m
 [m
[32m+[m[32m        public Node GetNode(string nodeid)[m
[32m+[m[32m        {[m
[32m+[m[32m            return ((INodeRepository)_currentrepository).GetNode(new Node { Id = new Guid(nodeid) });[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        public bool DeleteNode(string nodeid)[m
[32m+[m[32m        {[m
[32m+[m[32m            return ((INodeRepository)_currentrepository).DeleteNode(new Node() { Id = new Guid(nodeid) });[m
[32m+[m[32m        }[m
[32m+[m
         public List<Node> GetAllnodes()[m
         {[m
             throw new NotImplementedException();[m
[1mdiff --git a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.dll b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.dll[m
[1mindex 5202fb6..1c3489d 100644[m
Binary files a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.dll and b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.pdb b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.pdb[m
[1mindex 2a4f6ca..96c1723 100644[m
Binary files a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.pdb and b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.DataRepository.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.dll b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.dll[m
[1mindex 24c0db8..f58760d 100644[m
Binary files a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.dll and b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.pdb b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.pdb[m
[1mindex e5257d0..0092a6a 100644[m
Binary files a/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.pdb and b/Zebra-CMS/Zebra.Services/bin/Debug/Zebra.Services.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.csprojResolveAssemblyReference.cache b/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.csprojResolveAssemblyReference.cache[m
[1mindex e7f236c..22b550b 100644[m
Binary files a/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.csprojResolveAssemblyReference.cache and b/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.csprojResolveAssemblyReference.cache differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.dll b/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.dll[m
[1mindex 24c0db8..f58760d 100644[m
Binary files a/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.dll and b/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.dll differ
[1mdiff --git a/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.pdb b/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.pdb[m
[1mindex e5257d0..0092a6a 100644[m
Binary files a/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.pdb and b/Zebra-CMS/Zebra.Services/obj/Debug/Zebra.Services.pdb differ
[1mdiff --git a/Zebra-CMS/Zebra/APIControllers/NodeServiceController.cs b/Zebra-CMS/Zebra/APIControllers/NodeServiceController.cs[m
[1mindex 138c6ca..e7bb6ba 100644[m
[1m--- a/Zebra-CMS/Zebra/APIControllers/NodeServiceController.cs[m
[1m+++ b/Zebra-CMS/Zebra/APIControllers/NodeServiceController.cs[m
[36m@@ -38,14 +38,26 @@[m [mpublic string CreateNode()[m
             dynamic tmp = JsonConvert.DeserializeObject(json);[m
 [m
             string parentid = tmp.parentid;[m
[31m-            var node = ((IStructureOperations)_ops).CreateNode("temp node", parentid, "6362B5BA-7238-43A0-B3DB-FA24A9A2F925");[m
[32m+[m[32m            string nodename = tmp.nodename;[m
[32m+[m[32m            var node = ((IStructureOperations)_ops).CreateNode(nodename, parentid, "6362B5BA-7238-43A0-B3DB-FA24A9A2F925");[m
             return JsonConvert.SerializeObject(node);[m
         }[m
[31m-        [m
 [m
[31m-       [m
[32m+[m[32m        [HttpPost][m
[32m+[m[32m        public bool DeleteNode()[m
[32m+[m[32m        {[m
[32m+[m[32m            var json = HttpContext.Current.Request.Form[0];[m
[32m+[m[32m            dynamic tmp = JsonConvert.DeserializeObject(json);[m
[32m+[m
[32m+[m[32m            string nodeid = tmp.nodeid;[m
[32m+[m[32m            var result = ((IStructureOperations)_ops).DeleteNode(nodeid);[m
[32m+[m[32m            return result;[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
 [m
[31m-        [m
[31m-       [m
     }[m
 }[m
[1mdiff --git a/Zebra-CMS/Zebra/App_Start/BundleConfig.cs b/Zebra-CMS/Zebra/App_Start/BundleConfig.cs[m
[1mindex 6974b2d..4aaff7d 100644[m
[1m--- a/Zebra-CMS/Zebra/App_Start/BundleConfig.cs[m
[1m+++ b/Zebra-CMS/Zebra/App_Start/BundleConfig.cs[m
[36m@@ -9,7 +9,9 @@[m [mpublic class BundleConfig[m
         public static void RegisterBundles(BundleCollection bundles)[m
         {[m
             bundles.Add(new ScriptBundle("~/bundles/jquery").Include([m
[31m-                        "~/Scripts/jquery-{version}.js"));[m
[32m+[m[32m                        "~/Scripts/jquery-{version}.js").Include("~/Scripts/jquery-ui-{version}.js"));[m
[32m+[m
[32m+[m[32m            bundles.Add(new ScriptBundle("~/bundles/zebra-js").IncludeDirectory("~/Scripts/zebra-js/","*.js"));[m
 [m
             bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include([m
                         "~/Scripts/jquery.validate*"));[m
[36m@@ -26,6 +28,8 @@[m [mpublic static void RegisterBundles(BundleCollection bundles)[m
             bundles.Add(new StyleBundle("~/Content/css").Include([m
                       "~/Content/bootstrap.css",[m
                       "~/Content/site.css"));[m
[32m+[m
[32m+[m[32m            BundleTable.EnableOptimizations = false;[m
         }[m
     }[m
 }[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/accordion.css b/Zebra-CMS/Zebra/Content/themes/base/accordion.css[m
[1mnew file mode 100644[m
[1mindex 0000000..13e5752[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/accordion.css[m
[36m@@ -0,0 +1,36 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Accordion 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/accordion/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-accordion .ui-accordion-header {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mmargin: 2px 0 0 0;[m
[32m+[m	[32mpadding: .5em .5em .5em .7em;[m
[32m+[m	[32mmin-height: 0; /* support: IE7 */[m
[32m+[m	[32mfont-size: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-accordion .ui-accordion-icons {[m
[32m+[m	[32mpadding-left: 2.2em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-accordion .ui-accordion-icons .ui-accordion-icons {[m
[32m+[m	[32mpadding-left: 2.2em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-accordion .ui-accordion-header .ui-accordion-header-icon {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mleft: .5em;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-accordion .ui-accordion-content {[m
[32m+[m	[32mpadding: 1em 2.2em;[m
[32m+[m	[32mborder-top: 0;[m
[32m+[m	[32moverflow: auto;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/all.css b/Zebra-CMS/Zebra/Content/themes/base/all.css[m
[1mnew file mode 100644[m
[1mindex 0000000..0bab991[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/all.css[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI CSS Framework 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/category/theming/[m
[32m+[m[32m */[m
[32m+[m[32m@import "base.css";[m
[32m+[m[32m@import "theme.css";[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/autocomplete.css b/Zebra-CMS/Zebra/Content/themes/base/autocomplete.css[m
[1mnew file mode 100644[m
[1mindex 0000000..c21c54f[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/autocomplete.css[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Autocomplete 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/autocomplete/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-autocomplete {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mcursor: default;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/base.css b/Zebra-CMS/Zebra/Content/themes/base/base.css[m
[1mnew file mode 100644[m
[1mindex 0000000..7f53172[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/base.css[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI CSS Framework 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/category/theming/[m
[32m+[m[32m */[m
[32m+[m[32m@import url("core.css");[m
[32m+[m
[32m+[m[32m@import url("accordion.css");[m
[32m+[m[32m@import url("autocomplete.css");[m
[32m+[m[32m@import url("button.css");[m
[32m+[m[32m@import url("datepicker.css");[m
[32m+[m[32m@import url("dialog.css");[m
[32m+[m[32m@import url("draggable.css");[m
[32m+[m[32m@import url("menu.css");[m
[32m+[m[32m@import url("progressbar.css");[m
[32m+[m[32m@import url("resizable.css");[m
[32m+[m[32m@import url("selectable.css");[m
[32m+[m[32m@import url("selectmenu.css");[m
[32m+[m[32m@import url("sortable.css");[m
[32m+[m[32m@import url("slider.css");[m
[32m+[m[32m@import url("spinner.css");[m
[32m+[m[32m@import url("tabs.css");[m
[32m+[m[32m@import url("tooltip.css");[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/button.css b/Zebra-CMS/Zebra/Content/themes/base/button.css[m
[1mnew file mode 100644[m
[1mindex 0000000..7f11bdd[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/button.css[m
[36m@@ -0,0 +1,114 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Button 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/button/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-button {[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mline-height: normal;[m
[32m+[m	[32mmargin-right: .1em;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m	[32moverflow: visible; /* removes extra width in IE */[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button,[m
[32m+[m[32m.ui-button:link,[m
[32m+[m[32m.ui-button:visited,[m
[32m+[m[32m.ui-button:hover,[m
[32m+[m[32m.ui-button:active {[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m/* to make room for the icon, a width needs to be set here */[m
[32m+[m[32m.ui-button-icon-only {[m
[32m+[m	[32mwidth: 2.2em;[m
[32m+[m[32m}[m
[32m+[m[32m/* button elements seem to need a little more width */[m
[32m+[m[32mbutton.ui-button-icon-only {[m
[32m+[m	[32mwidth: 2.4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-icons-only {[m
[32m+[m	[32mwidth: 3.4em;[m
[32m+[m[32m}[m
[32m+[m[32mbutton.ui-button-icons-only {[m
[32m+[m	[32mwidth: 3.7em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* button text element */[m
[32m+[m[32m.ui-button .ui-button-text {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mline-height: normal;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-text-only .ui-button-text {[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-icon-only .ui-button-text,[m
[32m+[m[32m.ui-button-icons-only .ui-button-text {[m
[32m+[m	[32mpadding: .4em;[m
[32m+[m	[32mtext-indent: -9999999px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-text-icon-primary .ui-button-text,[m
[32m+[m[32m.ui-button-text-icons .ui-button-text {[m
[32m+[m	[32mpadding: .4em 1em .4em 2.1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-text-icon-secondary .ui-button-text,[m
[32m+[m[32m.ui-button-text-icons .ui-button-text {[m
[32m+[m	[32mpadding: .4em 2.1em .4em 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-text-icons .ui-button-text {[m
[32m+[m	[32mpadding-left: 2.1em;[m
[32m+[m	[32mpadding-right: 2.1em;[m
[32m+[m[32m}[m
[32m+[m[32m/* no icon support for input elements, provide padding by default */[m
[32m+[m[32minput.ui-button {[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* button icon element(s) */[m
[32m+[m[32m.ui-button-icon-only .ui-icon,[m
[32m+[m[32m.ui-button-text-icon-primary .ui-icon,[m
[32m+[m[32m.ui-button-text-icon-secondary .ui-icon,[m
[32m+[m[32m.ui-button-text-icons .ui-icon,[m
[32m+[m[32m.ui-button-icons-only .ui-icon {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-icon-only .ui-icon {[m
[32m+[m	[32mleft: 50%;[m
[32m+[m	[32mmargin-left: -8px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-text-icon-primary .ui-button-icon-primary,[m
[32m+[m[32m.ui-button-text-icons .ui-button-icon-primary,[m
[32m+[m[32m.ui-button-icons-only .ui-button-icon-primary {[m
[32m+[m	[32mleft: .5em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button-text-icon-secondary .ui-button-icon-secondary,[m
[32m+[m[32m.ui-button-text-icons .ui-button-icon-secondary,[m
[32m+[m[32m.ui-button-icons-only .ui-button-icon-secondary {[m
[32m+[m	[32mright: .5em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* button sets */[m
[32m+[m[32m.ui-buttonset {[m
[32m+[m	[32mmargin-right: 7px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-buttonset .ui-button {[m
[32m+[m	[32mmargin-left: 0;[m
[32m+[m	[32mmargin-right: -.3em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* workarounds */[m
[32m+[m[32m/* reset extra padding in Firefox, see h5bp.com/l */[m
[32m+[m[32minput.ui-button::-moz-focus-inner,[m
[32m+[m[32mbutton.ui-button::-moz-focus-inner {[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/core.css b/Zebra-CMS/Zebra/Content/themes/base/core.css[m
[1mnew file mode 100644[m
[1mindex 0000000..154f1f8[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/core.css[m
[36m@@ -0,0 +1,93 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI CSS Framework 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/category/theming/[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32m/* Layout helpers[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-helper-hidden {[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-hidden-accessible {[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mclip: rect(0 0 0 0);[m
[32m+[m	[32mheight: 1px;[m
[32m+[m	[32mmargin: -1px;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mwidth: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-reset {[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32moutline: 0;[m
[32m+[m	[32mline-height: 1.3;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m	[32mfont-size: 100%;[m
[32m+[m	[32mlist-style: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-clearfix:before,[m
[32m+[m[32m.ui-helper-clearfix:after {[m
[32m+[m	[32mcontent: "";[m
[32m+[m	[32mdisplay: table;[m
[32m+[m	[32mborder-collapse: collapse;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-clearfix:after {[m
[32m+[m	[32mclear: both;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-clearfix {[m
[32m+[m	[32mmin-height: 0; /* support: IE7 */[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-zfix {[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mopacity: 0;[m
[32m+[m	[32mfilter:Alpha(Opacity=0); /* support: IE8 */[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-front {[m
[32m+[m	[32mz-index: 100;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m[32m/* Interaction Cues[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-state-disabled {[m
[32m+[m	[32mcursor: default !important;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m[32m/* Icons[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* states and images */[m
[32m+[m[32m.ui-icon {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mtext-indent: -99999px;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mbackground-repeat: no-repeat;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m[32m/* Misc visuals[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* Overlays */[m
[32m+[m[32m.ui-widget-overlay {[m
[32m+[m	[32mposition: fixed;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/datepicker.css b/Zebra-CMS/Zebra/Content/themes/base/datepicker.css[m
[1mnew file mode 100644[m
[1mindex 0000000..ea559d8[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/datepicker.css[m
[36m@@ -0,0 +1,175 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Datepicker 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/datepicker/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-datepicker {[m
[32m+[m	[32mwidth: 17em;[m
[32m+[m	[32mpadding: .2em .2em 0;[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-header {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mpadding: .2em 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev,[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 2px;[m
[32m+[m	[32mwidth: 1.8em;[m
[32m+[m	[32mheight: 1.8em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev-hover,[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next-hover {[m
[32m+[m	[32mtop: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev {[m
[32m+[m	[32mleft: 2px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next {[m
[32m+[m	[32mright: 2px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev-hover {[m
[32m+[m	[32mleft: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next-hover {[m
[32m+[m	[32mright: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev span,[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next span {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mleft: 50%;[m
[32m+[m	[32mmargin-left: -8px;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-title {[m
[32m+[m	[32mmargin: 0 2.3em;[m
[32m+[m	[32mline-height: 1.8em;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-title select {[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m	[32mmargin: 1px 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker select.ui-datepicker-month,[m
[32m+[m[32m.ui-datepicker select.ui-datepicker-year {[m
[32m+[m	[32mwidth: 45%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker table {[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mfont-size: .9em;[m
[32m+[m	[32mborder-collapse: collapse;[m
[32m+[m	[32mmargin: 0 0 .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker th {[m
[32m+[m	[32mpadding: .7em .3em;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m	[32mborder: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker td {[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mpadding: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker td span,[m
[32m+[m[32m.ui-datepicker td a {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mpadding: .2em;[m
[32m+[m	[32mtext-align: right;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-buttonpane {[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m	[32mmargin: .7em 0 0 0;[m
[32m+[m	[32mpadding: 0 .2em;[m
[32m+[m	[32mborder-left: 0;[m
[32m+[m	[32mborder-right: 0;[m
[32m+[m	[32mborder-bottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-buttonpane button {[m
[32m+[m	[32mfloat: right;[m
[32m+[m	[32mmargin: .5em .2em .4em;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mpadding: .2em .6em .3em .6em;[m
[32m+[m	[32mwidth: auto;[m
[32m+[m	[32moverflow: visible;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current {[m
[32m+[m	[32mfloat: left;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* with multiple calendars */[m
[32m+[m[32m.ui-datepicker.ui-datepicker-multi {[m
[32m+[m	[32mwidth: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group {[m
[32m+[m	[32mfloat: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group table {[m
[32m+[m	[32mwidth: 95%;[m
[32m+[m	[32mmargin: 0 auto .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi-2 .ui-datepicker-group {[m
[32m+[m	[32mwidth: 50%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi-3 .ui-datepicker-group {[m
[32m+[m	[32mwidth: 33.3%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi-4 .ui-datepicker-group {[m
[32m+[m	[32mwidth: 25%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header,[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header {[m
[32m+[m	[32mborder-left-width: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-buttonpane {[m
[32m+[m	[32mclear: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-row-break {[m
[32m+[m	[32mclear: both;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mfont-size: 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* RTL support */[m
[32m+[m[32m.ui-datepicker-rtl {[m
[32m+[m	[32mdirection: rtl;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-prev {[m
[32m+[m	[32mright: 2px;[m
[32m+[m	[32mleft: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-next {[m
[32m+[m	[32mleft: 2px;[m
[32m+[m	[32mright: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-prev:hover {[m
[32m+[m	[32mright: 1px;[m
[32m+[m	[32mleft: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-next:hover {[m
[32m+[m	[32mleft: 1px;[m
[32m+[m	[32mright: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-buttonpane {[m
[32m+[m	[32mclear: right;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-buttonpane button {[m
[32m+[m	[32mfloat: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current,[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-group {[m
[32m+[m	[32mfloat: right;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header,[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header {[m
[32m+[m	[32mborder-right-width: 0;[m
[32m+[m	[32mborder-left-width: 1px;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/dialog.css b/Zebra-CMS/Zebra/Content/themes/base/dialog.css[m
[1mnew file mode 100644[m
[1mindex 0000000..66b90cc[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/dialog.css[m
[36m@@ -0,0 +1,70 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Dialog 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/dialog/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-dialog {[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mpadding: .2em;[m
[32m+[m	[32moutline: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-titlebar {[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m	[32mposition: relative;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-title {[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mmargin: .1em 0;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m	[32mwidth: 90%;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mtext-overflow: ellipsis;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-titlebar-close {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mright: .3em;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mwidth: 20px;[m
[32m+[m	[32mmargin: -10px 0 0 0;[m
[32m+[m	[32mpadding: 1px;[m
[32m+[m	[32mheight: 20px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-content {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mpadding: .5em 1em;[m
[32m+[m	[32mbackground: none;[m
[32m+[m	[32moverflow: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-buttonpane {[m
[32m+[m	[32mtext-align: left;[m
[32m+[m	[32mborder-width: 1px 0 0 0;[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m	[32mmargin-top: .5em;[m
[32m+[m	[32mpadding: .3em 1em .5em .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset {[m
[32m+[m	[32mfloat: right;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-buttonpane button {[m
[32m+[m	[32mmargin: .5em .4em .5em 0;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-se {[m
[32m+[m	[32mwidth: 12px;[m
[32m+[m	[32mheight: 12px;[m
[32m+[m	[32mright: -5px;[m
[32m+[m	[32mbottom: -5px;[m
[32m+[m	[32mbackground-position: 16px 16px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-draggable .ui-dialog-titlebar {[m
[32m+[m	[32mcursor: move;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/draggable.css b/Zebra-CMS/Zebra/Content/themes/base/draggable.css[m
[1mnew file mode 100644[m
[1mindex 0000000..df01f29[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/draggable.css[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Draggable 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m */[m
[32m+[m[32m.ui-draggable-handle {[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_flat_0_aaaaaa_40x100.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_flat_0_aaaaaa_40x100.png[m
[1mnew file mode 100644[m
[1mindex 0000000..5b5dab2[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_flat_0_aaaaaa_40x100.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_flat_75_ffffff_40x100.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_flat_75_ffffff_40x100.png[m
[1mnew file mode 100644[m
[1mindex 0000000..ac8b229[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_flat_75_ffffff_40x100.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_55_fbf9ee_1x400.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_55_fbf9ee_1x400.png[m
[1mnew file mode 100644[m
[1mindex 0000000..ad3d634[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_55_fbf9ee_1x400.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_65_ffffff_1x400.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_65_ffffff_1x400.png[m
[1mnew file mode 100644[m
[1mindex 0000000..42ccba2[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_65_ffffff_1x400.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_75_dadada_1x400.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_75_dadada_1x400.png[m
[1mnew file mode 100644[m
[1mindex 0000000..5a46b47[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_75_dadada_1x400.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_75_e6e6e6_1x400.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_75_e6e6e6_1x400.png[m
[1mnew file mode 100644[m
[1mindex 0000000..86c2baa[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_75_e6e6e6_1x400.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_95_fef1ec_1x400.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_95_fef1ec_1x400.png[m
[1mnew file mode 100644[m
[1mindex 0000000..4443fdc[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_glass_95_fef1ec_1x400.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_highlight-soft_75_cccccc_1x100.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_highlight-soft_75_cccccc_1x100.png[m
[1mnew file mode 100644[m
[1mindex 0000000..7c9fa6c[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-bg_highlight-soft_75_cccccc_1x100.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_222222_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_222222_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..ee039dc[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_222222_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_2e83ff_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_2e83ff_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..45e8928[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_2e83ff_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_444444_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_444444_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..348243b[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_444444_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_454545_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_454545_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..7ec70d1[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_454545_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_555555_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_555555_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..949749b[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_555555_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_777620_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_777620_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..350c783[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_777620_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_777777_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_777777_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..f8b5cc4[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_777777_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_888888_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_888888_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..5ba708c[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_888888_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_cc0000_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_cc0000_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..a046ee5[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_cc0000_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_cd0a0a_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_cd0a0a_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..7930a55[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_cd0a0a_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_ffffff_256x240.png b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_ffffff_256x240.png[m
[1mnew file mode 100644[m
[1mindex 0000000..ea57ef0[m
Binary files /dev/null and b/Zebra-CMS/Zebra/Content/themes/base/images/ui-icons_ffffff_256x240.png differ
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/jquery-ui.css b/Zebra-CMS/Zebra/Content/themes/base/jquery-ui.css[m
[1mnew file mode 100644[m
[1mindex 0000000..ffdcb23[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/jquery-ui.css[m
[36m@@ -0,0 +1,1312 @@[m
[32m+[m[32m/*! jQuery UI - v1.12.0 - 2016-07-08[m
[32m+[m[32m* http://jqueryui.com[m
[32m+[m[32m* Includes: core.css, accordion.css, autocomplete.css, menu.css, button.css, controlgroup.css, checkboxradio.css, datepicker.css, dialog.css, draggable.css, resizable.css, progressbar.css, selectable.css, selectmenu.css, slider.css, sortable.css, spinner.css, tabs.css, tooltip.css, theme.css[m
[32m+[m[32m* To view and modify this theme, visit http://jqueryui.com/themeroller/?ffDefault=Arial%2CHelvetica%2Csans-serif&fsDefault=1em&fwDefault=normal&cornerRadius=3px&bgColorHeader=e9e9e9&bgTextureHeader=flat&borderColorHeader=dddddd&fcHeader=333333&iconColorHeader=444444&bgColorContent=ffffff&bgTextureContent=flat&borderColorContent=dddddd&fcContent=333333&iconColorContent=444444&bgColorDefault=f6f6f6&bgTextureDefault=flat&borderColorDefault=c5c5c5&fcDefault=454545&iconColorDefault=777777&bgColorHover=ededed&bgTextureHover=flat&borderColorHover=cccccc&fcHover=2b2b2b&iconColorHover=555555&bgColorActive=007fff&bgTextureActive=flat&borderColorActive=003eff&fcActive=ffffff&iconColorActive=ffffff&bgColorHighlight=fffa90&bgTextureHighlight=flat&borderColorHighlight=dad55e&fcHighlight=777620&iconColorHighlight=777620&bgColorError=fddfdf&bgTextureError=flat&borderColorError=f1a899&fcError=5f3f3f&iconColorError=cc0000&bgColorOverlay=aaaaaa&bgTextureOverlay=flat&bgImgOpacityOverlay=0&opacityOverlay=30&bgColorShadow=666666&bgTextureShadow=flat&bgImgOpacityShadow=0&opacityShadow=30&thicknessShadow=5px&offsetTopShadow=0px&offsetLeftShadow=0px&cornerRadiusShadow=8px[m
[32m+[m[32m* Copyright jQuery Foundation and other contributors; Licensed MIT */[m
[32m+[m
[32m+[m[32m/* Layout helpers[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-helper-hidden {[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-hidden-accessible {[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mclip: rect(0 0 0 0);[m
[32m+[m	[32mheight: 1px;[m
[32m+[m	[32mmargin: -1px;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mwidth: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-reset {[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32moutline: 0;[m
[32m+[m	[32mline-height: 1.3;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m	[32mfont-size: 100%;[m
[32m+[m	[32mlist-style: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-clearfix:before,[m
[32m+[m[32m.ui-helper-clearfix:after {[m
[32m+[m	[32mcontent: "";[m
[32m+[m	[32mdisplay: table;[m
[32m+[m	[32mborder-collapse: collapse;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-clearfix:after {[m
[32m+[m	[32mclear: both;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-helper-zfix {[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mopacity: 0;[m
[32m+[m	[32mfilter:Alpha(Opacity=0); /* support: IE8 */[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-front {[m
[32m+[m	[32mz-index: 100;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m[32m/* Interaction Cues[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-state-disabled {[m
[32m+[m	[32mcursor: default !important;[m
[32m+[m	[32mpointer-events: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[32m+[m[32m/* Icons[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-icon {[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m	[32mmargin-top: -.25em;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mtext-indent: -99999px;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mbackground-repeat: no-repeat;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-widget-icon-block {[m
[32m+[m	[32mleft: 50%;[m
[32m+[m	[32mmargin-left: -8px;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Misc visuals[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* Overlays */[m
[32m+[m[32m.ui-widget-overlay {[m
[32m+[m	[32mposition: fixed;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-accordion .ui-accordion-header {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mmargin: 2px 0 0 0;[m
[32m+[m	[32mpadding: .5em .5em .5em .7em;[m
[32m+[m	[32mfont-size: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-accordion .ui-accordion-content {[m
[32m+[m	[32mpadding: 1em 2.2em;[m
[32m+[m	[32mborder-top: 0;[m
[32m+[m	[32moverflow: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-autocomplete {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mcursor: default;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu {[m
[32m+[m	[32mlist-style: none;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32moutline: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu-item {[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32m/* support: IE10, see #8844 */[m
[32m+[m	[32mlist-style-image: url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu-item-wrapper {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mpadding: 3px 1em 3px .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu-divider {[m
[32m+[m	[32mmargin: 5px 0;[m
[32m+[m	[32mheight: 0;[m
[32m+[m	[32mfont-size: 0;[m
[32m+[m	[32mline-height: 0;[m
[32m+[m	[32mborder-width: 1px 0 0 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-state-focus,[m
[32m+[m[32m.ui-menu .ui-state-active {[m
[32m+[m	[32mmargin: -1px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* icon support */[m
[32m+[m[32m.ui-menu-icons {[m
[32m+[m	[32mposition: relative;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu-icons .ui-menu-item-wrapper {[m
[32m+[m	[32mpadding-left: 2em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* left-aligned */[m
[32m+[m[32m.ui-menu .ui-icon {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mbottom: 0;[m
[32m+[m	[32mleft: .2em;[m
[32m+[m	[32mmargin: auto 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* right-aligned */[m
[32m+[m[32m.ui-menu .ui-menu-icon {[m
[32m+[m	[32mleft: auto;[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button {[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mline-height: normal;[m
[32m+[m	[32mmargin-right: .1em;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m	[32m-webkit-user-select: none;[m
[32m+[m	[32m-moz-user-select: none;[m
[32m+[m	[32m-ms-user-select: none;[m
[32m+[m	[32muser-select: none;[m
[32m+[m
[32m+[m	[32m/* Support: IE <= 11 */[m
[32m+[m	[32moverflow: visible;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-button,[m
[32m+[m[32m.ui-button:link,[m
[32m+[m[32m.ui-button:visited,[m
[32m+[m[32m.ui-button:hover,[m
[32m+[m[32m.ui-button:active {[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* to make room for the icon, a width needs to be set here */[m
[32m+[m[32m.ui-button-icon-only {[m
[32m+[m	[32mwidth: 2em;[m
[32m+[m	[32mbox-sizing: border-box;[m
[32m+[m	[32mtext-indent: -9999px;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* no icon support for input elements */[m
[32m+[m[32minput.ui-button.ui-button-icon-only {[m
[32m+[m	[32mtext-indent: 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* button icon element(s) */[m
[32m+[m[32m.ui-button-icon-only .ui-icon {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mleft: 50%;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m	[32mmargin-left: -8px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-button.ui-icon-notext .ui-icon {[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mwidth: 2.1em;[m
[32m+[m	[32mheight: 2.1em;[m
[32m+[m	[32mtext-indent: -9999px;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32minput.ui-button.ui-icon-notext .ui-icon {[m
[32m+[m	[32mwidth: auto;[m
[32m+[m	[32mheight: auto;[m
[32m+[m	[32mtext-indent: 0;[m
[32m+[m	[32mwhite-space: normal;[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* workarounds */[m
[32m+[m[32m/* Support: Firefox 5 - 40 */[m
[32m+[m[32minput.ui-button::-moz-focus-inner,[m
[32m+[m[32mbutton.ui-button::-moz-focus-inner {[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup {[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup > .ui-controlgroup-item {[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mmargin-left: 0;[m
[32m+[m	[32mmargin-right: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup > .ui-controlgroup-item:focus,[m
[32m+[m[32m.ui-controlgroup > .ui-controlgroup-item.ui-visual-focus {[m
[32m+[m	[32mz-index: 9999;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-vertical > .ui-controlgroup-item {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mfloat: none;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mmargin-top: 0;[m
[32m+[m	[32mmargin-bottom: 0;[m
[32m+[m	[32mtext-align: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-vertical .ui-controlgroup-item {[m
[32m+[m	[32mbox-sizing: border-box;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup .ui-controlgroup-label {[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup .ui-controlgroup-label span {[m
[32m+[m	[32mfont-size: 80%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-horizontal .ui-controlgroup-label + .ui-controlgroup-item {[m
[32m+[m	[32mborder-left: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-vertical .ui-controlgroup-label + .ui-controlgroup-item {[m
[32m+[m	[32mborder-top: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-horizontal .ui-controlgroup-label.ui-widget-content {[m
[32m+[m	[32mborder-right: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-vertical .ui-controlgroup-label.ui-widget-content {[m
[32m+[m	[32mborder-bottom: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Spinner specific style fixes */[m
[32m+[m[32m.ui-controlgroup-vertical .ui-spinner-input {[m
[32m+[m
[32m+[m	[32m/* Support: IE8 only, Android < 4.4 only */[m
[32m+[m	[32mwidth: 75%;[m
[32m+[m	[32mwidth: calc( 100% - 2.4em );[m
[32m+[m[32m}[m
[32m+[m[32m.ui-controlgroup-vertical .ui-spinner .ui-spinner-up {[m
[32m+[m	[32mborder-top-style: solid;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-checkboxradio-label .ui-icon-background {[m
[32m+[m	[32mbox-shadow: inset 1px 1px 1px #ccc;[m
[32m+[m	[32mborder-radius: .12em;[m
[32m+[m	[32mborder: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-checkboxradio-radio-label .ui-icon-background {[m
[32m+[m	[32mwidth: 16px;[m
[32m+[m	[32mheight: 16px;[m
[32m+[m	[32mborder-radius: 1em;[m
[32m+[m	[32moverflow: visible;[m
[32m+[m	[32mborder: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-checkboxradio-radio-label.ui-checkboxradio-checked .ui-icon,[m
[32m+[m[32m.ui-checkboxradio-radio-label.ui-checkboxradio-checked:hover .ui-icon {[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m	[32mwidth: 8px;[m
[32m+[m	[32mheight: 8px;[m
[32m+[m	[32mborder-width: 4px;[m
[32m+[m	[32mborder-style: solid;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-checkboxradio-disabled {[m
[32m+[m	[32mpointer-events: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker {[m
[32m+[m	[32mwidth: 17em;[m
[32m+[m	[32mpadding: .2em .2em 0;[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-header {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mpadding: .2em 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev,[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 2px;[m
[32m+[m	[32mwidth: 1.8em;[m
[32m+[m	[32mheight: 1.8em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev-hover,[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next-hover {[m
[32m+[m	[32mtop: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev {[m
[32m+[m	[32mleft: 2px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next {[m
[32m+[m	[32mright: 2px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev-hover {[m
[32m+[m	[32mleft: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next-hover {[m
[32m+[m	[32mright: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-prev span,[m
[32m+[m[32m.ui-datepicker .ui-datepicker-next span {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mleft: 50%;[m
[32m+[m	[32mmargin-left: -8px;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-title {[m
[32m+[m	[32mmargin: 0 2.3em;[m
[32m+[m	[32mline-height: 1.8em;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-title select {[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m	[32mmargin: 1px 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker select.ui-datepicker-month,[m
[32m+[m[32m.ui-datepicker select.ui-datepicker-year {[m
[32m+[m	[32mwidth: 45%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker table {[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mfont-size: .9em;[m
[32m+[m	[32mborder-collapse: collapse;[m
[32m+[m	[32mmargin: 0 0 .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker th {[m
[32m+[m	[32mpadding: .7em .3em;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m	[32mborder: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker td {[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mpadding: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker td span,[m
[32m+[m[32m.ui-datepicker td a {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mpadding: .2em;[m
[32m+[m	[32mtext-align: right;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-buttonpane {[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m	[32mmargin: .7em 0 0 0;[m
[32m+[m	[32mpadding: 0 .2em;[m
[32m+[m	[32mborder-left: 0;[m
[32m+[m	[32mborder-right: 0;[m
[32m+[m	[32mborder-bottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-buttonpane button {[m
[32m+[m	[32mfloat: right;[m
[32m+[m	[32mmargin: .5em .2em .4em;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mpadding: .2em .6em .3em .6em;[m
[32m+[m	[32mwidth: auto;[m
[32m+[m	[32moverflow: visible;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current {[m
[32m+[m	[32mfloat: left;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* with multiple calendars */[m
[32m+[m[32m.ui-datepicker.ui-datepicker-multi {[m
[32m+[m	[32mwidth: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group {[m
[32m+[m	[32mfloat: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group table {[m
[32m+[m	[32mwidth: 95%;[m
[32m+[m	[32mmargin: 0 auto .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi-2 .ui-datepicker-group {[m
[32m+[m	[32mwidth: 50%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi-3 .ui-datepicker-group {[m
[32m+[m	[32mwidth: 33.3%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi-4 .ui-datepicker-group {[m
[32m+[m	[32mwidth: 25%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header,[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header {[m
[32m+[m	[32mborder-left-width: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-multi .ui-datepicker-buttonpane {[m
[32m+[m	[32mclear: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-row-break {[m
[32m+[m	[32mclear: both;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mfont-size: 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* RTL support */[m
[32m+[m[32m.ui-datepicker-rtl {[m
[32m+[m	[32mdirection: rtl;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-prev {[m
[32m+[m	[32mright: 2px;[m
[32m+[m	[32mleft: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-next {[m
[32m+[m	[32mleft: 2px;[m
[32m+[m	[32mright: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-prev:hover {[m
[32m+[m	[32mright: 1px;[m
[32m+[m	[32mleft: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-next:hover {[m
[32m+[m	[32mleft: 1px;[m
[32m+[m	[32mright: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-buttonpane {[m
[32m+[m	[32mclear: right;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-buttonpane button {[m
[32m+[m	[32mfloat: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current,[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-group {[m
[32m+[m	[32mfloat: right;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header,[m
[32m+[m[32m.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header {[m
[32m+[m	[32mborder-right-width: 0;[m
[32m+[m	[32mborder-left-width: 1px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Icons */[m
[32m+[m[32m.ui-datepicker .ui-icon {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mtext-indent: -99999px;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mbackground-repeat: no-repeat;[m
[32m+[m	[32mleft: .5em;[m
[32m+[m	[32mtop: .3em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mpadding: .2em;[m
[32m+[m	[32moutline: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-titlebar {[m
[32m+[m	[32mpadding: .4em 1em;[m
[32m+[m	[32mposition: relative;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-title {[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mmargin: .1em 0;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m	[32mwidth: 90%;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mtext-overflow: ellipsis;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-titlebar-close {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mright: .3em;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mwidth: 20px;[m
[32m+[m	[32mmargin: -10px 0 0 0;[m
[32m+[m	[32mpadding: 1px;[m
[32m+[m	[32mheight: 20px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-content {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mpadding: .5em 1em;[m
[32m+[m	[32mbackground: none;[m
[32m+[m	[32moverflow: auto;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-buttonpane {[m
[32m+[m	[32mtext-align: left;[m
[32m+[m	[32mborder-width: 1px 0 0 0;[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m	[32mmargin-top: .5em;[m
[32m+[m	[32mpadding: .3em 1em .5em .4em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset {[m
[32m+[m	[32mfloat: right;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-dialog-buttonpane button {[m
[32m+[m	[32mmargin: .5em .4em .5em 0;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-n {[m
[32m+[m	[32mheight: 2px;[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-e {[m
[32m+[m	[32mwidth: 2px;[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-s {[m
[32m+[m	[32mheight: 2px;[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-w {[m
[32m+[m	[32mwidth: 2px;[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-se,[m
[32m+[m[32m.ui-dialog .ui-resizable-sw,[m
[32m+[m[32m.ui-dialog .ui-resizable-ne,[m
[32m+[m[32m.ui-dialog .ui-resizable-nw {[m
[32m+[m	[32mwidth: 7px;[m
[32m+[m	[32mheight: 7px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-se {[m
[32m+[m	[32mright: 0;[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-sw {[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-ne {[m
[32m+[m	[32mright: 0;[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-dialog .ui-resizable-nw {[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-draggable .ui-dialog-titlebar {[m
[32m+[m	[32mcursor: move;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-draggable-handle {[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable {[m
[32m+[m	[32mposition: relative;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-handle {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mfont-size: 0.1px;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-disabled .ui-resizable-handle,[m
[32m+[m[32m.ui-resizable-autohide .ui-resizable-handle {[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-n {[m
[32m+[m	[32mcursor: n-resize;[m
[32m+[m	[32mheight: 7px;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mtop: -5px;[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-s {[m
[32m+[m	[32mcursor: s-resize;[m
[32m+[m	[32mheight: 7px;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mbottom: -5px;[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-e {[m
[32m+[m	[32mcursor: e-resize;[m
[32m+[m	[32mwidth: 7px;[m
[32m+[m	[32mright: -5px;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-w {[m
[32m+[m	[32mcursor: w-resize;[m
[32m+[m	[32mwidth: 7px;[m
[32m+[m	[32mleft: -5px;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-se {[m
[32m+[m	[32mcursor: se-resize;[m
[32m+[m	[32mwidth: 12px;[m
[32m+[m	[32mheight: 12px;[m
[32m+[m	[32mright: 1px;[m
[32m+[m	[32mbottom: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-sw {[m
[32m+[m	[32mcursor: sw-resize;[m
[32m+[m	[32mwidth: 9px;[m
[32m+[m	[32mheight: 9px;[m
[32m+[m	[32mleft: -5px;[m
[32m+[m	[32mbottom: -5px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-nw {[m
[32m+[m	[32mcursor: nw-resize;[m
[32m+[m	[32mwidth: 9px;[m
[32m+[m	[32mheight: 9px;[m
[32m+[m	[32mleft: -5px;[m
[32m+[m	[32mtop: -5px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-ne {[m
[32m+[m	[32mcursor: ne-resize;[m
[32m+[m	[32mwidth: 9px;[m
[32m+[m	[32mheight: 9px;[m
[32m+[m	[32mright: -5px;[m
[32m+[m	[32mtop: -5px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar {[m
[32m+[m	[32mheight: 2em;[m
[32m+[m	[32mtext-align: left;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar .ui-progressbar-value {[m
[32m+[m	[32mmargin: -1px;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar .ui-progressbar-overlay {[m
[32m+[m	[32mbackground: url("data:image/gif;base64,R0lGODlhKAAoAIABAAAAAP///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQJAQABACwAAAAAKAAoAAACkYwNqXrdC52DS06a7MFZI+4FHBCKoDeWKXqymPqGqxvJrXZbMx7Ttc+w9XgU2FB3lOyQRWET2IFGiU9m1frDVpxZZc6bfHwv4c1YXP6k1Vdy292Fb6UkuvFtXpvWSzA+HycXJHUXiGYIiMg2R6W459gnWGfHNdjIqDWVqemH2ekpObkpOlppWUqZiqr6edqqWQAAIfkECQEAAQAsAAAAACgAKAAAApSMgZnGfaqcg1E2uuzDmmHUBR8Qil95hiPKqWn3aqtLsS18y7G1SzNeowWBENtQd+T1JktP05nzPTdJZlR6vUxNWWjV+vUWhWNkWFwxl9VpZRedYcflIOLafaa28XdsH/ynlcc1uPVDZxQIR0K25+cICCmoqCe5mGhZOfeYSUh5yJcJyrkZWWpaR8doJ2o4NYq62lAAACH5BAkBAAEALAAAAAAoACgAAAKVDI4Yy22ZnINRNqosw0Bv7i1gyHUkFj7oSaWlu3ovC8GxNso5fluz3qLVhBVeT/Lz7ZTHyxL5dDalQWPVOsQWtRnuwXaFTj9jVVh8pma9JjZ4zYSj5ZOyma7uuolffh+IR5aW97cHuBUXKGKXlKjn+DiHWMcYJah4N0lYCMlJOXipGRr5qdgoSTrqWSq6WFl2ypoaUAAAIfkECQEAAQAsAAAAACgAKAAAApaEb6HLgd/iO7FNWtcFWe+ufODGjRfoiJ2akShbueb0wtI50zm02pbvwfWEMWBQ1zKGlLIhskiEPm9R6vRXxV4ZzWT2yHOGpWMyorblKlNp8HmHEb/lCXjcW7bmtXP8Xt229OVWR1fod2eWqNfHuMjXCPkIGNileOiImVmCOEmoSfn3yXlJWmoHGhqp6ilYuWYpmTqKUgAAIfkECQEAAQAsAAAAACgAKAAAApiEH6kb58biQ3FNWtMFWW3eNVcojuFGfqnZqSebuS06w5V80/X02pKe8zFwP6EFWOT1lDFk8rGERh1TTNOocQ61Hm4Xm2VexUHpzjymViHrFbiELsefVrn6XKfnt2Q9G/+Xdie499XHd2g4h7ioOGhXGJboGAnXSBnoBwKYyfioubZJ2Hn0RuRZaflZOil56Zp6iioKSXpUAAAh+QQJAQABACwAAAAAKAAoAAACkoQRqRvnxuI7kU1a1UU5bd5tnSeOZXhmn5lWK3qNTWvRdQxP8qvaC+/yaYQzXO7BMvaUEmJRd3TsiMAgswmNYrSgZdYrTX6tSHGZO73ezuAw2uxuQ+BbeZfMxsexY35+/Qe4J1inV0g4x3WHuMhIl2jXOKT2Q+VU5fgoSUI52VfZyfkJGkha6jmY+aaYdirq+lQAACH5BAkBAAEALAAAAAAoACgAAAKWBIKpYe0L3YNKToqswUlvznigd4wiR4KhZrKt9Upqip61i9E3vMvxRdHlbEFiEXfk9YARYxOZZD6VQ2pUunBmtRXo1Lf8hMVVcNl8JafV38aM2/Fu5V16Bn63r6xt97j09+MXSFi4BniGFae3hzbH9+hYBzkpuUh5aZmHuanZOZgIuvbGiNeomCnaxxap2upaCZsq+1kAACH5BAkBAAEALAAAAAAoACgAAAKXjI8By5zf4kOxTVrXNVlv1X0d8IGZGKLnNpYtm8Lr9cqVeuOSvfOW79D9aDHizNhDJidFZhNydEahOaDH6nomtJjp1tutKoNWkvA6JqfRVLHU/QUfau9l2x7G54d1fl995xcIGAdXqMfBNadoYrhH+Mg2KBlpVpbluCiXmMnZ2Sh4GBqJ+ckIOqqJ6LmKSllZmsoq6wpQAAAh+QQJAQABACwAAAAAKAAoAAAClYx/oLvoxuJDkU1a1YUZbJ59nSd2ZXhWqbRa2/gF8Gu2DY3iqs7yrq+xBYEkYvFSM8aSSObE+ZgRl1BHFZNr7pRCavZ5BW2142hY3AN/zWtsmf12p9XxxFl2lpLn1rseztfXZjdIWIf2s5dItwjYKBgo9yg5pHgzJXTEeGlZuenpyPmpGQoKOWkYmSpaSnqKileI2FAAACH5BAkBAAEALAAAAAAoACgAAAKVjB+gu+jG4kORTVrVhRlsnn2dJ3ZleFaptFrb+CXmO9OozeL5VfP99HvAWhpiUdcwkpBH3825AwYdU8xTqlLGhtCosArKMpvfa1mMRae9VvWZfeB2XfPkeLmm18lUcBj+p5dnN8jXZ3YIGEhYuOUn45aoCDkp16hl5IjYJvjWKcnoGQpqyPlpOhr3aElaqrq56Bq7VAAAOw==");[m
[32m+[m	[32mheight: 100%;[m
[32m+[m	[32mfilter: alpha(opacity=25); /* support: IE8 */[m
[32m+[m	[32mopacity: 0.25;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar-indeterminate .ui-progressbar-value {[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectable {[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectable-helper {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 100;[m
[32m+[m	[32mborder: 1px dotted black;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-menu {[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-menu .ui-menu {[m
[32m+[m	[32moverflow: auto;[m
[32m+[m	[32moverflow-x: hidden;[m
[32m+[m	[32mpadding-bottom: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-menu .ui-menu .ui-selectmenu-optgroup {[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m	[32mline-height: 1.5;[m
[32m+[m	[32mpadding: 2px 0.4em;[m
[32m+[m	[32mmargin: 0.5em 0 0 0;[m
[32m+[m	[32mheight: auto;[m
[32m+[m	[32mborder: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-open {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-text {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mmargin-right: 20px;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mtext-overflow: ellipsis;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-button.ui-button {[m
[32m+[m	[32mtext-align: left;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m	[32mwidth: 14em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-icon.ui-icon {[m
[32m+[m	[32mfloat: right;[m
[32m+[m	[32mmargin-top: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mtext-align: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider .ui-slider-handle {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 2;[m
[32m+[m	[32mwidth: 1.2em;[m
[32m+[m	[32mheight: 1.2em;[m
[32m+[m	[32mcursor: default;[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider .ui-slider-range {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 1;[m
[32m+[m	[32mfont-size: .7em;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mbackground-position: 0 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* support: IE8 - See #6727 */[m
[32m+[m[32m.ui-slider.ui-state-disabled .ui-slider-handle,[m
[32m+[m[32m.ui-slider.ui-state-disabled .ui-slider-range {[m
[32m+[m	[32mfilter: inherit;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-slider-horizontal {[m
[32m+[m	[32mheight: .8em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-handle {[m
[32m+[m	[32mtop: -.3em;[m
[32m+[m	[32mmargin-left: -.6em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-range {[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-range-min {[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-range-max {[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-slider-vertical {[m
[32m+[m	[32mwidth: .8em;[m
[32m+[m	[32mheight: 100px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-handle {[m
[32m+[m	[32mleft: -.3em;[m
[32m+[m	[32mmargin-left: 0;[m
[32m+[m	[32mmargin-bottom: -.6em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-range {[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-range-min {[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-range-max {[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-sortable-handle {[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-input {[m
[32m+[m	[32mborder: none;[m
[32m+[m	[32mbackground: none;[m
[32m+[m	[32mcolor: inherit;[m
[32m+[m	[32mpadding: .222em 0;[m
[32m+[m	[32mmargin: .2em 0;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m	[32mmargin-left: .4em;[m
[32m+[m	[32mmargin-right: 2em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-button {[m
[32m+[m	[32mwidth: 1.6em;[m
[32m+[m	[32mheight: 50%;[m
[32m+[m	[32mfont-size: .5em;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mcursor: default;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[32m+[m[32m/* more specificity required here to override default borders */[m
[32m+[m[32m.ui-spinner a.ui-spinner-button {[m
[32m+[m	[32mborder-top-style: none;[m
[32m+[m	[32mborder-bottom-style: none;[m
[32m+[m	[32mborder-right-style: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-up {[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-down {[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs {[m
[32m+[m	[32mposition: relative;/* position: relative prevents IE scroll bug (element with position: relative inside container with overflow: auto appear as "fixed") */[m
[32m+[m	[32mpadding: .2em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav {[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mpadding: .2em .2em 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li {[m
[32m+[m	[32mlist-style: none;[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mmargin: 1px .2em 0 0;[m
[32m+[m	[32mborder-bottom-width: 0;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav .ui-tabs-anchor {[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mpadding: .5em 1em;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-tabs-active {[m
[32m+[m	[32mmargin-bottom: -1px;[m
[32m+[m	[32mpadding-bottom: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor,[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-state-disabled .ui-tabs-anchor,[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-tabs-loading .ui-tabs-anchor {[m
[32m+[m	[32mcursor: text;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs-collapsible .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor {[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-panel {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mborder-width: 0;[m
[32m+[m	[32mpadding: 1em 1.4em;[m
[32m+[m	[32mbackground: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tooltip {[m
[32m+[m	[32mpadding: 8px;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 9999;[m
[32m+[m	[32mmax-width: 300px;[m
[32m+[m[32m}[m
[32m+[m[32mbody .ui-tooltip {[m
[32m+[m	[32mborder-width: 2px;[m
[32m+[m[32m}[m
[32m+[m[32m/* Component containers[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-widget {[m
[32m+[m	[32mfont-family: Arial,Helvetica,sans-serif;[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget .ui-widget {[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget input,[m
[32m+[m[32m.ui-widget select,[m
[32m+[m[32m.ui-widget textarea,[m
[32m+[m[32m.ui-widget button {[m
[32m+[m	[32mfont-family: Arial,Helvetica,sans-serif;[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget.ui-widget-content {[m
[32m+[m	[32mborder: 1px solid #c5c5c5;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-content {[m
[32m+[m	[32mborder: 1px solid #dddddd;[m
[32m+[m	[32mbackground: #ffffff;[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-content a {[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-header {[m
[32m+[m	[32mborder: 1px solid #dddddd;[m
[32m+[m	[32mbackground: #e9e9e9;[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-header a {[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Interaction states[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-state-default,[m
[32m+[m[32m.ui-widget-content .ui-state-default,[m
[32m+[m[32m.ui-widget-header .ui-state-default,[m
[32m+[m[32m.ui-button,[m
[32m+[m
[32m+[m[32m/* We use html here because we need a greater specificity to make sure disabled[m
[32m+[m[32mworks properly when clicked or hovered */[m
[32m+[m[32mhtml .ui-button.ui-state-disabled:hover,[m
[32m+[m[32mhtml .ui-button.ui-state-disabled:active {[m
[32m+[m	[32mborder: 1px solid #c5c5c5;[m
[32m+[m	[32mbackground: #f6f6f6;[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m	[32mcolor: #454545;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-default a,[m
[32m+[m[32m.ui-state-default a:link,[m
[32m+[m[32m.ui-state-default a:visited,[m
[32m+[m[32ma.ui-button,[m
[32m+[m[32ma:link.ui-button,[m
[32m+[m[32ma:visited.ui-button,[m
[32m+[m[32m.ui-button {[m
[32m+[m	[32mcolor: #454545;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-hover,[m
[32m+[m[32m.ui-widget-content .ui-state-hover,[m
[32m+[m[32m.ui-widget-header .ui-state-hover,[m
[32m+[m[32m.ui-state-focus,[m
[32m+[m[32m.ui-widget-content .ui-state-focus,[m
[32m+[m[32m.ui-widget-header .ui-state-focus,[m
[32m+[m[32m.ui-button:hover,[m
[32m+[m[32m.ui-button:focus {[m
[32m+[m	[32mborder: 1px solid #cccccc;[m
[32m+[m	[32mbackground: #ededed;[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m	[32mcolor: #2b2b2b;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-hover a,[m
[32m+[m[32m.ui-state-hover a:hover,[m
[32m+[m[32m.ui-state-hover a:link,[m
[32m+[m[32m.ui-state-hover a:visited,[m
[32m+[m[32m.ui-state-focus a,[m
[32m+[m[32m.ui-state-focus a:hover,[m
[32m+[m[32m.ui-state-focus a:link,[m
[32m+[m[32m.ui-state-focus a:visited,[m
[32m+[m[32ma.ui-button:hover,[m
[32m+[m[32ma.ui-button:focus {[m
[32m+[m	[32mcolor: #2b2b2b;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-visual-focus {[m
[32m+[m	[32mbox-shadow: 0 0 3px 1px rgb(94, 158, 214);[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-active,[m
[32m+[m[32m.ui-widget-content .ui-state-active,[m
[32m+[m[32m.ui-widget-header .ui-state-active,[m
[32m+[m[32ma.ui-button:active,[m
[32m+[m[32m.ui-button:active,[m
[32m+[m[32m.ui-button.ui-state-active:hover {[m
[32m+[m	[32mborder: 1px solid #003eff;[m
[32m+[m	[32mbackground: #007fff;[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m	[32mcolor: #ffffff;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-icon-background,[m
[32m+[m[32m.ui-state-active .ui-icon-background {[m
[32m+[m	[32mborder: #003eff;[m
[32m+[m	[32mbackground-color: #ffffff;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-active a,[m
[32m+[m[32m.ui-state-active a:link,[m
[32m+[m[32m.ui-state-active a:visited {[m
[32m+[m	[32mcolor: #ffffff;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Interaction Cues[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-state-highlight,[m
[32m+[m[32m.ui-widget-content .ui-state-highlight,[m
[32m+[m[32m.ui-widget-header .ui-state-highlight {[m
[32m+[m	[32mborder: 1px solid #dad55e;[m
[32m+[m	[32mbackground: #fffa90;[m
[32m+[m	[32mcolor: #777620;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-checked {[m
[32m+[m	[32mborder: 1px solid #dad55e;[m
[32m+[m	[32mbackground: #fffa90;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-highlight a,[m
[32m+[m[32m.ui-widget-content .ui-state-highlight a,[m
[32m+[m[32m.ui-widget-header .ui-state-highlight a {[m
[32m+[m	[32mcolor: #777620;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error,[m
[32m+[m[32m.ui-widget-content .ui-state-error,[m
[32m+[m[32m.ui-widget-header .ui-state-error {[m
[32m+[m	[32mborder: 1px solid #f1a899;[m
[32m+[m	[32mbackground: #fddfdf;[m
[32m+[m	[32mcolor: #5f3f3f;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error a,[m
[32m+[m[32m.ui-widget-content .ui-state-error a,[m
[32m+[m[32m.ui-widget-header .ui-state-error a {[m
[32m+[m	[32mcolor: #5f3f3f;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error-text,[m
[32m+[m[32m.ui-widget-content .ui-state-error-text,[m
[32m+[m[32m.ui-widget-header .ui-state-error-text {[m
[32m+[m	[32mcolor: #5f3f3f;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-priority-primary,[m
[32m+[m[32m.ui-widget-content .ui-priority-primary,[m
[32m+[m[32m.ui-widget-header .ui-priority-primary {[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-priority-secondary,[m
[32m+[m[32m.ui-widget-content .ui-priority-secondary,[m
[32m+[m[32m.ui-widget-header .ui-priority-secondary {[m
[32m+[m	[32mopacity: .7;[m
[32m+[m	[32mfilter:Alpha(Opacity=70); /* support: IE8 */[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-disabled,[m
[32m+[m[32m.ui-widget-content .ui-state-disabled,[m
[32m+[m[32m.ui-widget-header .ui-state-disabled {[m
[32m+[m	[32mopacity: .35;[m
[32m+[m	[32mfilter:Alpha(Opacity=35); /* support: IE8 */[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-disabled .ui-icon {[m
[32m+[m	[32mfilter:Alpha(Opacity=35); /* support: IE8 - See #6059 */[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Icons[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* states and images */[m
[32m+[m[32m.ui-icon {[m
[32m+[m	[32mwidth: 16px;[m
[32m+[m	[32mheight: 16px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-icon,[m
[32m+[m[32m.ui-widget-content .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_444444_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-header .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_444444_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_777777_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-hover .ui-icon,[m
[32m+[m[32m.ui-state-focus .ui-icon,[m
[32m+[m[32m.ui-button:hover .ui-icon,[m
[32m+[m[32m.ui-button:focus .ui-icon,[m
[32m+[m[32m.ui-state-default .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_555555_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-active .ui-icon,[m
[32m+[m[32m.ui-button:active .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_ffffff_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-highlight .ui-icon,[m
[32m+[m[32m.ui-button .ui-state-highlight.ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_777620_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error .ui-icon,[m
[32m+[m[32m.ui-state-error-text .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_cc0000_256x240.png");[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* positioning */[m
[32m+[m[32m.ui-icon-blank { background-position: 16px 16px; }[m
[32m+[m[32m.ui-icon-caret-1-n { background-position: 0 0; }[m
[32m+[m[32m.ui-icon-caret-1-ne { background-position: -16px 0; }[m
[32m+[m[32m.ui-icon-caret-1-e { background-position: -32px 0; }[m
[32m+[m[32m.ui-icon-caret-1-se { background-position: -48px 0; }[m
[32m+[m[32m.ui-icon-caret-1-s { background-position: -65px 0; }[m
[32m+[m[32m.ui-icon-caret-1-sw { background-position: -80px 0; }[m
[32m+[m[32m.ui-icon-caret-1-w { background-position: -96px 0; }[m
[32m+[m[32m.ui-icon-caret-1-nw { background-position: -112px 0; }[m
[32m+[m[32m.ui-icon-caret-2-n-s { background-position: -128px 0; }[m
[32m+[m[32m.ui-icon-caret-2-e-w { background-position: -144px 0; }[m
[32m+[m[32m.ui-icon-triangle-1-n { background-position: 0 -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-ne { background-position: -16px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-e { background-position: -32px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-se { background-position: -48px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-s { background-position: -65px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-sw { background-position: -80px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-w { background-position: -96px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-nw { background-position: -112px -16px; }[m
[32m+[m[32m.ui-icon-triangle-2-n-s { background-position: -128px -16px; }[m
[32m+[m[32m.ui-icon-triangle-2-e-w { background-position: -144px -16px; }[m
[32m+[m[32m.ui-icon-arrow-1-n { background-position: 0 -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-ne { background-position: -16px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-e { background-position: -32px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-se { background-position: -48px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-s { background-position: -65px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-sw { background-position: -80px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-w { background-position: -96px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-nw { background-position: -112px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-n-s { background-position: -128px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-ne-sw { background-position: -144px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-e-w { background-position: -160px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-se-nw { background-position: -176px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-n { background-position: -192px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-e { background-position: -208px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-s { background-position: -224px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-w { background-position: -240px -32px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-n { background-position: 1px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-ne { background-position: -16px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-e { background-position: -32px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-se { background-position: -48px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-s { background-position: -64px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-sw { background-position: -80px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-w { background-position: -96px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-nw { background-position: -112px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-n-s { background-position: -128px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-ne-sw { background-position: -144px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-e-w { background-position: -160px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-se-nw { background-position: -176px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-n { background-position: -192px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-e { background-position: -208px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-s { background-position: -224px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-w { background-position: -240px -48px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-w { background-position: 0 -64px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-n { background-position: -16px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-e { background-position: -32px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-s { background-position: -48px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-w { background-position: -64px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-n { background-position: -80px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-e { background-position: -96px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-s { background-position: -112px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-w { background-position: -128px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-n { background-position: -144px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-e { background-position: -160px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-s { background-position: -176px -64px; }[m
[32m+[m[32m.ui-icon-arrow-4 { background-position: 0 -80px; }[m
[32m+[m[32m.ui-icon-arrow-4-diag { background-position: -16px -80px; }[m
[32m+[m[32m.ui-icon-extlink { background-position: -32px -80px; }[m
[32m+[m[32m.ui-icon-newwin { background-position: -48px -80px; }[m
[32m+[m[32m.ui-icon-refresh { background-position: -64px -80px; }[m
[32m+[m[32m.ui-icon-shuffle { background-position: -80px -80px; }[m
[32m+[m[32m.ui-icon-transfer-e-w { background-position: -96px -80px; }[m
[32m+[m[32m.ui-icon-transferthick-e-w { background-position: -112px -80px; }[m
[32m+[m[32m.ui-icon-folder-collapsed { background-position: 0 -96px; }[m
[32m+[m[32m.ui-icon-folder-open { background-position: -16px -96px; }[m
[32m+[m[32m.ui-icon-document { background-position: -32px -96px; }[m
[32m+[m[32m.ui-icon-document-b { background-position: -48px -96px; }[m
[32m+[m[32m.ui-icon-note { background-position: -64px -96px; }[m
[32m+[m[32m.ui-icon-mail-closed { background-position: -80px -96px; }[m
[32m+[m[32m.ui-icon-mail-open { background-position: -96px -96px; }[m
[32m+[m[32m.ui-icon-suitcase { background-position: -112px -96px; }[m
[32m+[m[32m.ui-icon-comment { background-position: -128px -96px; }[m
[32m+[m[32m.ui-icon-person { background-position: -144px -96px; }[m
[32m+[m[32m.ui-icon-print { background-position: -160px -96px; }[m
[32m+[m[32m.ui-icon-trash { background-position: -176px -96px; }[m
[32m+[m[32m.ui-icon-locked { background-position: -192px -96px; }[m
[32m+[m[32m.ui-icon-unlocked { background-position: -208px -96px; }[m
[32m+[m[32m.ui-icon-bookmark { background-position: -224px -96px; }[m
[32m+[m[32m.ui-icon-tag { background-position: -240px -96px; }[m
[32m+[m[32m.ui-icon-home { background-position: 0 -112px; }[m
[32m+[m[32m.ui-icon-flag { background-position: -16px -112px; }[m
[32m+[m[32m.ui-icon-calendar { background-position: -32px -112px; }[m
[32m+[m[32m.ui-icon-cart { background-position: -48px -112px; }[m
[32m+[m[32m.ui-icon-pencil { background-position: -64px -112px; }[m
[32m+[m[32m.ui-icon-clock { background-position: -80px -112px; }[m
[32m+[m[32m.ui-icon-disk { background-position: -96px -112px; }[m
[32m+[m[32m.ui-icon-calculator { background-position: -112px -112px; }[m
[32m+[m[32m.ui-icon-zoomin { background-position: -128px -112px; }[m
[32m+[m[32m.ui-icon-zoomout { background-position: -144px -112px; }[m
[32m+[m[32m.ui-icon-search { background-position: -160px -112px; }[m
[32m+[m[32m.ui-icon-wrench { background-position: -176px -112px; }[m
[32m+[m[32m.ui-icon-gear { background-position: -192px -112px; }[m
[32m+[m[32m.ui-icon-heart { background-position: -208px -112px; }[m
[32m+[m[32m.ui-icon-star { background-position: -224px -112px; }[m
[32m+[m[32m.ui-icon-link { background-position: -240px -112px; }[m
[32m+[m[32m.ui-icon-cancel { background-position: 0 -128px; }[m
[32m+[m[32m.ui-icon-plus { background-position: -16px -128px; }[m
[32m+[m[32m.ui-icon-plusthick { background-position: -32px -128px; }[m
[32m+[m[32m.ui-icon-minus { background-position: -48px -128px; }[m
[32m+[m[32m.ui-icon-minusthick { background-position: -64px -128px; }[m
[32m+[m[32m.ui-icon-close { background-position: -80px -128px; }[m
[32m+[m[32m.ui-icon-closethick { background-position: -96px -128px; }[m
[32m+[m[32m.ui-icon-key { background-position: -112px -128px; }[m
[32m+[m[32m.ui-icon-lightbulb { background-position: -128px -128px; }[m
[32m+[m[32m.ui-icon-scissors { background-position: -144px -128px; }[m
[32m+[m[32m.ui-icon-clipboard { background-position: -160px -128px; }[m
[32m+[m[32m.ui-icon-copy { background-position: -176px -128px; }[m
[32m+[m[32m.ui-icon-contact { background-position: -192px -128px; }[m
[32m+[m[32m.ui-icon-image { background-position: -208px -128px; }[m
[32m+[m[32m.ui-icon-video { background-position: -224px -128px; }[m
[32m+[m[32m.ui-icon-script { background-position: -240px -128px; }[m
[32m+[m[32m.ui-icon-alert { background-position: 0 -144px; }[m
[32m+[m[32m.ui-icon-info { background-position: -16px -144px; }[m
[32m+[m[32m.ui-icon-notice { background-position: -32px -144px; }[m
[32m+[m[32m.ui-icon-help { background-position: -48px -144px; }[m
[32m+[m[32m.ui-icon-check { background-position: -64px -144px; }[m
[32m+[m[32m.ui-icon-bullet { background-position: -80px -144px; }[m
[32m+[m[32m.ui-icon-radio-on { background-position: -96px -144px; }[m
[32m+[m[32m.ui-icon-radio-off { background-position: -112px -144px; }[m
[32m+[m[32m.ui-icon-pin-w { background-position: -128px -144px; }[m
[32m+[m[32m.ui-icon-pin-s { background-position: -144px -144px; }[m
[32m+[m[32m.ui-icon-play { background-position: 0 -160px; }[m
[32m+[m[32m.ui-icon-pause { background-position: -16px -160px; }[m
[32m+[m[32m.ui-icon-seek-next { background-position: -32px -160px; }[m
[32m+[m[32m.ui-icon-seek-prev { background-position: -48px -160px; }[m
[32m+[m[32m.ui-icon-seek-end { background-position: -64px -160px; }[m
[32m+[m[32m.ui-icon-seek-start { background-position: -80px -160px; }[m
[32m+[m[32m/* ui-icon-seek-first is deprecated, use ui-icon-seek-start instead */[m
[32m+[m[32m.ui-icon-seek-first { background-position: -80px -160px; }[m
[32m+[m[32m.ui-icon-stop { background-position: -96px -160px; }[m
[32m+[m[32m.ui-icon-eject { background-position: -112px -160px; }[m
[32m+[m[32m.ui-icon-volume-off { background-position: -128px -160px; }[m
[32m+[m[32m.ui-icon-volume-on { background-position: -144px -160px; }[m
[32m+[m[32m.ui-icon-power { background-position: 0 -176px; }[m
[32m+[m[32m.ui-icon-signal-diag { background-position: -16px -176px; }[m
[32m+[m[32m.ui-icon-signal { background-position: -32px -176px; }[m
[32m+[m[32m.ui-icon-battery-0 { background-position: -48px -176px; }[m
[32m+[m[32m.ui-icon-battery-1 { background-position: -64px -176px; }[m
[32m+[m[32m.ui-icon-battery-2 { background-position: -80px -176px; }[m
[32m+[m[32m.ui-icon-battery-3 { background-position: -96px -176px; }[m
[32m+[m[32m.ui-icon-circle-plus { background-position: 0 -192px; }[m
[32m+[m[32m.ui-icon-circle-minus { background-position: -16px -192px; }[m
[32m+[m[32m.ui-icon-circle-close { background-position: -32px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-e { background-position: -48px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-s { background-position: -64px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-w { background-position: -80px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-n { background-position: -96px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-e { background-position: -112px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-s { background-position: -128px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-w { background-position: -144px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-n { background-position: -160px -192px; }[m
[32m+[m[32m.ui-icon-circle-zoomin { background-position: -176px -192px; }[m
[32m+[m[32m.ui-icon-circle-zoomout { background-position: -192px -192px; }[m
[32m+[m[32m.ui-icon-circle-check { background-position: -208px -192px; }[m
[32m+[m[32m.ui-icon-circlesmall-plus { background-position: 0 -208px; }[m
[32m+[m[32m.ui-icon-circlesmall-minus { background-position: -16px -208px; }[m
[32m+[m[32m.ui-icon-circlesmall-close { background-position: -32px -208px; }[m
[32m+[m[32m.ui-icon-squaresmall-plus { background-position: -48px -208px; }[m
[32m+[m[32m.ui-icon-squaresmall-minus { background-position: -64px -208px; }[m
[32m+[m[32m.ui-icon-squaresmall-close { background-position: -80px -208px; }[m
[32m+[m[32m.ui-icon-grip-dotted-vertical { background-position: 0 -224px; }[m
[32m+[m[32m.ui-icon-grip-dotted-horizontal { background-position: -16px -224px; }[m
[32m+[m[32m.ui-icon-grip-solid-vertical { background-position: -32px -224px; }[m
[32m+[m[32m.ui-icon-grip-solid-horizontal { background-position: -48px -224px; }[m
[32m+[m[32m.ui-icon-gripsmall-diagonal-se { background-position: -64px -224px; }[m
[32m+[m[32m.ui-icon-grip-diagonal-se { background-position: -80px -224px; }[m
[32m+[m
[32m+[m
[32m+[m[32m/* Misc visuals[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* Corner radius */[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-top,[m
[32m+[m[32m.ui-corner-left,[m
[32m+[m[32m.ui-corner-tl {[m
[32m+[m	[32mborder-top-left-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-top,[m
[32m+[m[32m.ui-corner-right,[m
[32m+[m[32m.ui-corner-tr {[m
[32m+[m	[32mborder-top-right-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-bottom,[m
[32m+[m[32m.ui-corner-left,[m
[32m+[m[32m.ui-corner-bl {[m
[32m+[m	[32mborder-bottom-left-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-bottom,[m
[32m+[m[32m.ui-corner-right,[m
[32m+[m[32m.ui-corner-br {[m
[32m+[m	[32mborder-bottom-right-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Overlays */[m
[32m+[m[32m.ui-widget-overlay {[m
[32m+[m	[32mbackground: #aaaaaa;[m
[32m+[m	[32mopacity: .3;[m
[32m+[m	[32mfilter: Alpha(Opacity=30); /* support: IE8 */[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-shadow {[m
[32m+[m	[32m-webkit-box-shadow: 0px 0px 5px #666666;[m
[32m+[m	[32mbox-shadow: 0px 0px 5px #666666;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/jquery-ui.min.css b/Zebra-CMS/Zebra/Content/themes/base/jquery-ui.min.css[m
[1mnew file mode 100644[m
[1mindex 0000000..1f47347[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/jquery-ui.min.css[m
[36m@@ -0,0 +1,7 @@[m
[32m+[m[32m/*! jQuery UI - v1.12.0 - 2016-07-08[m
[32m+[m[32m* http://jqueryui.com[m
[32m+[m[32m* Includes: core.css, accordion.css, autocomplete.css, menu.css, button.css, controlgroup.css, checkboxradio.css, datepicker.css, dialog.css, draggable.css, resizable.css, progressbar.css, selectable.css, selectmenu.css, slider.css, sortable.css, spinner.css, tabs.css, tooltip.css, theme.css[m
[32m+[m[32m* To view and modify this theme, visit http://jqueryui.com/themeroller/?ffDefault=Arial%2CHelvetica%2Csans-serif&fsDefault=1em&fwDefault=normal&cornerRadius=3px&bgColorHeader=e9e9e9&bgTextureHeader=flat&borderColorHeader=dddddd&fcHeader=333333&iconColorHeader=444444&bgColorContent=ffffff&bgTextureContent=flat&borderColorContent=dddddd&fcContent=333333&iconColorContent=444444&bgColorDefault=f6f6f6&bgTextureDefault=flat&borderColorDefault=c5c5c5&fcDefault=454545&iconColorDefault=777777&bgColorHover=ededed&bgTextureHover=flat&borderColorHover=cccccc&fcHover=2b2b2b&iconColorHover=555555&bgColorActive=007fff&bgTextureActive=flat&borderColorActive=003eff&fcActive=ffffff&iconColorActive=ffffff&bgColorHighlight=fffa90&bgTextureHighlight=flat&borderColorHighlight=dad55e&fcHighlight=777620&iconColorHighlight=777620&bgColorError=fddfdf&bgTextureError=flat&borderColorError=f1a899&fcError=5f3f3f&iconColorError=cc0000&bgColorOverlay=aaaaaa&bgTextureOverlay=flat&bgImgOpacityOverlay=0&opacityOverlay=30&bgColorShadow=666666&bgTextureShadow=flat&bgImgOpacityShadow=0&opacityShadow=30&thicknessShadow=5px&offsetTopShadow=0px&offsetLeftShadow=0px&cornerRadiusShadow=8px[m
[32m+[m[32m* Copyright jQuery Foundation and other contributors; Licensed MIT */[m
[32m+[m
[32m+[m[32m.ui-helper-hidden{display:none}.ui-helper-hidden-accessible{border:0;clip:rect(0 0 0 0);height:1px;margin:-1px;overflow:hidden;padding:0;position:absolute;width:1px}.ui-helper-reset{margin:0;padding:0;border:0;outline:0;line-height:1.3;text-decoration:none;font-size:100%;list-style:none}.ui-helper-clearfix:before,.ui-helper-clearfix:after{content:"";display:table;border-collapse:collapse}.ui-helper-clearfix:after{clear:both}.ui-helper-zfix{width:100%;height:100%;top:0;left:0;position:absolute;opacity:0;filter:Alpha(Opacity=0)}.ui-front{z-index:100}.ui-state-disabled{cursor:default!important;pointer-events:none}.ui-icon{display:inline-block;vertical-align:middle;margin-top:-.25em;position:relative;text-indent:-99999px;overflow:hidden;background-repeat:no-repeat}.ui-widget-icon-block{left:50%;margin-left:-8px;display:block}.ui-widget-overlay{position:fixed;top:0;left:0;width:100%;height:100%}.ui-accordion .ui-accordion-header{display:block;cursor:pointer;position:relative;margin:2px 0 0 0;padding:.5em .5em .5em .7em;font-size:100%}.ui-accordion .ui-accordion-content{padding:1em 2.2em;border-top:0;overflow:auto}.ui-autocomplete{position:absolute;top:0;left:0;cursor:default}.ui-menu{list-style:none;padding:0;margin:0;display:block;outline:0}.ui-menu .ui-menu{position:absolute}.ui-menu .ui-menu-item{margin:0;cursor:pointer;list-style-image:url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7")}.ui-menu .ui-menu-item-wrapper{position:relative;padding:3px 1em 3px .4em}.ui-menu .ui-menu-divider{margin:5px 0;height:0;font-size:0;line-height:0;border-width:1px 0 0 0}.ui-menu .ui-state-focus,.ui-menu .ui-state-active{margin:-1px}.ui-menu-icons{position:relative}.ui-menu-icons .ui-menu-item-wrapper{padding-left:2em}.ui-menu .ui-icon{position:absolute;top:0;bottom:0;left:.2em;margin:auto 0}.ui-menu .ui-menu-icon{left:auto;right:0}.ui-button{padding:.4em 1em;display:inline-block;position:relative;line-height:normal;margin-right:.1em;cursor:pointer;vertical-align:middle;text-align:center;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;overflow:visible}.ui-button,.ui-button:link,.ui-button:visited,.ui-button:hover,.ui-button:active{text-decoration:none}.ui-button-icon-only{width:2em;box-sizing:border-box;text-indent:-9999px;white-space:nowrap}input.ui-button.ui-button-icon-only{text-indent:0}.ui-button-icon-only .ui-icon{position:absolute;top:50%;left:50%;margin-top:-8px;margin-left:-8px}.ui-button.ui-icon-notext .ui-icon{padding:0;width:2.1em;height:2.1em;text-indent:-9999px;white-space:nowrap}input.ui-button.ui-icon-notext .ui-icon{width:auto;height:auto;text-indent:0;white-space:normal;padding:.4em 1em}input.ui-button::-moz-focus-inner,button.ui-button::-moz-focus-inner{border:0;padding:0}.ui-controlgroup{vertical-align:middle;display:inline-block}.ui-controlgroup > .ui-controlgroup-item{float:left;margin-left:0;margin-right:0}.ui-controlgroup > .ui-controlgroup-item:focus,.ui-controlgroup > .ui-controlgroup-item.ui-visual-focus{z-index:9999}.ui-controlgroup-vertical > .ui-controlgroup-item{display:block;float:none;width:100%;margin-top:0;margin-bottom:0;text-align:left}.ui-controlgroup-vertical .ui-controlgroup-item{box-sizing:border-box}.ui-controlgroup .ui-controlgroup-label{padding:.4em 1em}.ui-controlgroup .ui-controlgroup-label span{font-size:80%}.ui-controlgroup-horizontal .ui-controlgroup-label + .ui-controlgroup-item{border-left:none}.ui-controlgroup-vertical .ui-controlgroup-label + .ui-controlgroup-item{border-top:none}.ui-controlgroup-horizontal .ui-controlgroup-label.ui-widget-content{border-right:none}.ui-controlgroup-vertical .ui-controlgroup-label.ui-widget-content{border-bottom:none}.ui-controlgroup-vertical .ui-spinner-input{width:75%;width:calc( 100% - 2.4em )}.ui-controlgroup-vertical .ui-spinner .ui-spinner-up{border-top-style:solid}.ui-checkboxradio-label .ui-icon-background{box-shadow:inset 1px 1px 1px #ccc;border-radius:.12em;border:none}.ui-checkboxradio-radio-label .ui-icon-background{width:16px;height:16px;border-radius:1em;overflow:visible;border:none}.ui-checkboxradio-radio-label.ui-checkboxradio-checked .ui-icon,.ui-checkboxradio-radio-label.ui-checkboxradio-checked:hover .ui-icon{background-image:none;width:8px;height:8px;border-width:4px;border-style:solid}.ui-checkboxradio-disabled{pointer-events:none}.ui-datepicker{width:17em;padding:.2em .2em 0;display:none}.ui-datepicker .ui-datepicker-header{position:relative;padding:.2em 0}.ui-datepicker .ui-datepicker-prev,.ui-datepicker .ui-datepicker-next{position:absolute;top:2px;width:1.8em;height:1.8em}.ui-datepicker .ui-datepicker-prev-hover,.ui-datepicker .ui-datepicker-next-hover{top:1px}.ui-datepicker .ui-datepicker-prev{left:2px}.ui-datepicker .ui-datepicker-next{right:2px}.ui-datepicker .ui-datepicker-prev-hover{left:1px}.ui-datepicker .ui-datepicker-next-hover{right:1px}.ui-datepicker .ui-datepicker-prev span,.ui-datepicker .ui-datepicker-next span{display:block;position:absolute;left:50%;margin-left:-8px;top:50%;margin-top:-8px}.ui-datepicker .ui-datepicker-title{margin:0 2.3em;line-height:1.8em;text-align:center}.ui-datepicker .ui-datepicker-title select{font-size:1em;margin:1px 0}.ui-datepicker select.ui-datepicker-month,.ui-datepicker select.ui-datepicker-year{width:45%}.ui-datepicker table{width:100%;font-size:.9em;border-collapse:collapse;margin:0 0 .4em}.ui-datepicker th{padding:.7em .3em;text-align:center;font-weight:bold;border:0}.ui-datepicker td{border:0;padding:1px}.ui-datepicker td span,.ui-datepicker td a{display:block;padding:.2em;text-align:right;text-decoration:none}.ui-datepicker .ui-datepicker-buttonpane{background-image:none;margin:.7em 0 0 0;padding:0 .2em;border-left:0;border-right:0;border-bottom:0}.ui-datepicker .ui-datepicker-buttonpane button{float:right;margin:.5em .2em .4em;cursor:pointer;padding:.2em .6em .3em .6em;width:auto;overflow:visible}.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current{float:left}.ui-datepicker.ui-datepicker-multi{width:auto}.ui-datepicker-multi .ui-datepicker-group{float:left}.ui-datepicker-multi .ui-datepicker-group table{width:95%;margin:0 auto .4em}.ui-datepicker-multi-2 .ui-datepicker-group{width:50%}.ui-datepicker-multi-3 .ui-datepicker-group{width:33.3%}.ui-datepicker-multi-4 .ui-datepicker-group{width:25%}.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header,.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header{border-left-width:0}.ui-datepicker-multi .ui-datepicker-buttonpane{clear:left}.ui-datepicker-row-break{clear:both;width:100%;font-size:0}.ui-datepicker-rtl{direction:rtl}.ui-datepicker-rtl .ui-datepicker-prev{right:2px;left:auto}.ui-datepicker-rtl .ui-datepicker-next{left:2px;right:auto}.ui-datepicker-rtl .ui-datepicker-prev:hover{right:1px;left:auto}.ui-datepicker-rtl .ui-datepicker-next:hover{left:1px;right:auto}.ui-datepicker-rtl .ui-datepicker-buttonpane{clear:right}.ui-datepicker-rtl .ui-datepicker-buttonpane button{float:left}.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current,.ui-datepicker-rtl .ui-datepicker-group{float:right}.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header,.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header{border-right-width:0;border-left-width:1px}.ui-datepicker .ui-icon{display:block;text-indent:-99999px;overflow:hidden;background-repeat:no-repeat;left:.5em;top:.3em}.ui-dialog{position:absolute;top:0;left:0;padding:.2em;outline:0}.ui-dialog .ui-dialog-titlebar{padding:.4em 1em;position:relative}.ui-dialog .ui-dialog-title{float:left;margin:.1em 0;white-space:nowrap;width:90%;overflow:hidden;text-overflow:ellipsis}.ui-dialog .ui-dialog-titlebar-close{position:absolute;right:.3em;top:50%;width:20px;margin:-10px 0 0 0;padding:1px;height:20px}.ui-dialog .ui-dialog-content{position:relative;border:0;padding:.5em 1em;background:none;overflow:auto}.ui-dialog .ui-dialog-buttonpane{text-align:left;border-width:1px 0 0 0;background-image:none;margin-top:.5em;padding:.3em 1em .5em .4em}.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset{float:right}.ui-dialog .ui-dialog-buttonpane button{margin:.5em .4em .5em 0;cursor:pointer}.ui-dialog .ui-resizable-n{height:2px;top:0}.ui-dialog .ui-resizable-e{width:2px;right:0}.ui-dialog .ui-resizable-s{height:2px;bottom:0}.ui-dialog .ui-resizable-w{width:2px;left:0}.ui-dialog .ui-resizable-se,.ui-dialog .ui-resizable-sw,.ui-dialog .ui-resizable-ne,.ui-dialog .ui-resizable-nw{width:7px;height:7px}.ui-dialog .ui-resizable-se{right:0;bottom:0}.ui-dialog .ui-resizable-sw{left:0;bottom:0}.ui-dialog .ui-resizable-ne{right:0;top:0}.ui-dialog .ui-resizable-nw{left:0;top:0}.ui-draggable .ui-dialog-titlebar{cursor:move}.ui-draggable-handle{-ms-touch-action:none;touch-action:none}.ui-resizable{position:relative}.ui-resizable-handle{position:absolute;font-size:0.1px;display:block;-ms-touch-action:none;touch-action:none}.ui-resizable-disabled .ui-resizable-handle,.ui-resizable-autohide .ui-resizable-handle{display:none}.ui-resizable-n{cursor:n-resize;height:7px;width:100%;top:-5px;left:0}.ui-resizable-s{cursor:s-resize;height:7px;width:100%;bottom:-5px;left:0}.ui-resizable-e{cursor:e-resize;width:7px;right:-5px;top:0;height:100%}.ui-resizable-w{cursor:w-resize;width:7px;left:-5px;top:0;height:100%}.ui-resizable-se{cursor:se-resize;width:12px;height:12px;right:1px;bottom:1px}.ui-resizable-sw{cursor:sw-resize;width:9px;height:9px;left:-5px;bottom:-5px}.ui-resizable-nw{cursor:nw-resize;width:9px;height:9px;left:-5px;top:-5px}.ui-resizable-ne{cursor:ne-resize;width:9px;height:9px;right:-5px;top:-5px}.ui-progressbar{height:2em;text-align:left;overflow:hidden}.ui-progressbar .ui-progressbar-value{margin:-1px;height:100%}.ui-progressbar .ui-progressbar-overlay{background:url("data:image/gif;base64,R0lGODlhKAAoAIABAAAAAP///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQJAQABACwAAAAAKAAoAAACkYwNqXrdC52DS06a7MFZI+4FHBCKoDeWKXqymPqGqxvJrXZbMx7Ttc+w9XgU2FB3lOyQRWET2IFGiU9m1frDVpxZZc6bfHwv4c1YXP6k1Vdy292Fb6UkuvFtXpvWSzA+HycXJHUXiGYIiMg2R6W459gnWGfHNdjIqDWVqemH2ekpObkpOlppWUqZiqr6edqqWQAAIfkECQEAAQAsAAAAACgAKAAAApSMgZnGfaqcg1E2uuzDmmHUBR8Qil95hiPKqWn3aqtLsS18y7G1SzNeowWBENtQd+T1JktP05nzPTdJZlR6vUxNWWjV+vUWhWNkWFwxl9VpZRedYcflIOLafaa28XdsH/ynlcc1uPVDZxQIR0K25+cICCmoqCe5mGhZOfeYSUh5yJcJyrkZWWpaR8doJ2o4NYq62lAAACH5BAkBAAEALAAAAAAoACgAAAKVDI4Yy22ZnINRNqosw0Bv7i1gyHUkFj7oSaWlu3ovC8GxNso5fluz3qLVhBVeT/Lz7ZTHyxL5dDalQWPVOsQWtRnuwXaFTj9jVVh8pma9JjZ4zYSj5ZOyma7uuolffh+IR5aW97cHuBUXKGKXlKjn+DiHWMcYJah4N0lYCMlJOXipGRr5qdgoSTrqWSq6WFl2ypoaUAAAIfkECQEAAQAsAAAAACgAKAAAApaEb6HLgd/iO7FNWtcFWe+ufODGjRfoiJ2akShbueb0wtI50zm02pbvwfWEMWBQ1zKGlLIhskiEPm9R6vRXxV4ZzWT2yHOGpWMyorblKlNp8HmHEb/lCXjcW7bmtXP8Xt229OVWR1fod2eWqNfHuMjXCPkIGNileOiImVmCOEmoSfn3yXlJWmoHGhqp6ilYuWYpmTqKUgAAIfkECQEAAQAsAAAAACgAKAAAApiEH6kb58biQ3FNWtMFWW3eNVcojuFGfqnZqSebuS06w5V80/X02pKe8zFwP6EFWOT1lDFk8rGERh1TTNOocQ61Hm4Xm2VexUHpzjymViHrFbiELsefVrn6XKfnt2Q9G/+Xdie499XHd2g4h7ioOGhXGJboGAnXSBnoBwKYyfioubZJ2Hn0RuRZaflZOil56Zp6iioKSXpUAAAh+QQJAQABACwAAAAAKAAoAAACkoQRqRvnxuI7kU1a1UU5bd5tnSeOZXhmn5lWK3qNTWvRdQxP8qvaC+/yaYQzXO7BMvaUEmJRd3TsiMAgswmNYrSgZdYrTX6tSHGZO73ezuAw2uxuQ+BbeZfMxsexY35+/Qe4J1inV0g4x3WHuMhIl2jXOKT2Q+VU5fgoSUI52VfZyfkJGkha6jmY+aaYdirq+lQAACH5BAkBAAEALAAAAAAoACgAAAKWBIKpYe0L3YNKToqswUlvznigd4wiR4KhZrKt9Upqip61i9E3vMvxRdHlbEFiEXfk9YARYxOZZD6VQ2pUunBmtRXo1Lf8hMVVcNl8JafV38aM2/Fu5V16Bn63r6xt97j09+MXSFi4BniGFae3hzbH9+hYBzkpuUh5aZmHuanZOZgIuvbGiNeomCnaxxap2upaCZsq+1kAACH5BAkBAAEALAAAAAAoACgAAAKXjI8By5zf4kOxTVrXNVlv1X0d8IGZGKLnNpYtm8Lr9cqVeuOSvfOW79D9aDHizNhDJidFZhNydEahOaDH6nomtJjp1tutKoNWkvA6JqfRVLHU/QUfau9l2x7G54d1fl995xcIGAdXqMfBNadoYrhH+Mg2KBlpVpbluCiXmMnZ2Sh4GBqJ+ckIOqqJ6LmKSllZmsoq6wpQAAAh+QQJAQABACwAAAAAKAAoAAAClYx/oLvoxuJDkU1a1YUZbJ59nSd2ZXhWqbRa2/gF8Gu2DY3iqs7yrq+xBYEkYvFSM8aSSObE+ZgRl1BHFZNr7pRCavZ5BW2142hY3AN/zWtsmf12p9XxxFl2lpLn1rseztfXZjdIWIf2s5dItwjYKBgo9yg5pHgzJXTEeGlZuenpyPmpGQoKOWkYmSpaSnqKileI2FAAACH5BAkBAAEALAAAAAAoACgAAAKVjB+gu+jG4kORTVrVhRlsnn2dJ3ZleFaptFrb+CXmO9OozeL5VfP99HvAWhpiUdcwkpBH3825AwYdU8xTqlLGhtCosArKMpvfa1mMRae9VvWZfeB2XfPkeLmm18lUcBj+p5dnN8jXZ3YIGEhYuOUn45aoCDkp16hl5IjYJvjWKcnoGQpqyPlpOhr3aElaqrq56Bq7VAAAOw==");height:100%;filter:alpha(opacity=25);opacity:0.25}.ui-progressbar-indeterminate .ui-progressbar-value{background-image:none}.ui-selectable{-ms-touch-action:none;touch-action:none}.ui-selectable-helper{position:absolute;z-index:100;border:1px dotted black}.ui-selectmenu-menu{padding:0;margin:0;position:absolute;top:0;left:0;display:none}.ui-selectmenu-menu .ui-menu{overflow:auto;overflow-x:hidden;padding-bottom:1px}.ui-selectmenu-menu .ui-menu .ui-selectmenu-optgroup{font-size:1em;font-weight:bold;line-height:1.5;padding:2px 0.4em;margin:0.5em 0 0 0;height:auto;border:0}.ui-selectmenu-open{display:block}.ui-selectmenu-text{display:block;margin-right:20px;overflow:hidden;text-overflow:ellipsis}.ui-selectmenu-button.ui-button{text-align:left;white-space:nowrap;width:14em}.ui-selectmenu-icon.ui-icon{float:right;margin-top:0}.ui-slider{position:relative;text-align:left}.ui-slider .ui-slider-handle{position:absolute;z-index:2;width:1.2em;height:1.2em;cursor:default;-ms-touch-action:none;touch-action:none}.ui-slider .ui-slider-range{position:absolute;z-index:1;font-size:.7em;display:block;border:0;background-position:0 0}.ui-slider.ui-state-disabled .ui-slider-handle,.ui-slider.ui-state-disabled .ui-slider-range{filter:inherit}.ui-slider-horizontal{height:.8em}.ui-slider-horizontal .ui-slider-handle{top:-.3em;margin-left:-.6em}.ui-slider-horizontal .ui-slider-range{top:0;height:100%}.ui-slider-horizontal .ui-slider-range-min{left:0}.ui-slider-horizontal .ui-slider-range-max{right:0}.ui-slider-vertical{width:.8em;height:100px}.ui-slider-vertical .ui-slider-handle{left:-.3em;margin-left:0;margin-bottom:-.6em}.ui-slider-vertical .ui-slider-range{left:0;width:100%}.ui-slider-vertical .ui-slider-range-min{bottom:0}.ui-slider-vertical .ui-slider-range-max{top:0}.ui-sortable-handle{-ms-touch-action:none;touch-action:none}.ui-spinner{position:relative;display:inline-block;overflow:hidden;padding:0;vertical-align:middle}.ui-spinner-input{border:none;background:none;color:inherit;padding:.222em 0;margin:.2em 0;vertical-align:middle;margin-left:.4em;margin-right:2em}.ui-spinner-button{width:1.6em;height:50%;font-size:.5em;padding:0;margin:0;text-align:center;position:absolute;cursor:default;display:block;overflow:hidden;right:0}.ui-spinner a.ui-spinner-button{border-top-style:none;border-bottom-style:none;border-right-style:none}.ui-spinner-up{top:0}.ui-spinner-down{bottom:0}.ui-tabs{position:relative;padding:.2em}.ui-tabs .ui-tabs-nav{margin:0;padding:.2em .2em 0}.ui-tabs .ui-tabs-nav li{list-style:none;float:left;position:relative;top:0;margin:1px .2em 0 0;border-bottom-width:0;padding:0;white-space:nowrap}.ui-tabs .ui-tabs-nav .ui-tabs-anchor{float:left;padding:.5em 1em;text-decoration:none}.ui-tabs .ui-tabs-nav li.ui-tabs-active{margin-bottom:-1px;padding-bottom:1px}.ui-tabs .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor,.ui-tabs .ui-tabs-nav li.ui-state-disabled .ui-tabs-anchor,.ui-tabs .ui-tabs-nav li.ui-tabs-loading .ui-tabs-anchor{cursor:text}.ui-tabs-collapsible .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor{cursor:pointer}.ui-tabs .ui-tabs-panel{display:block;border-width:0;padding:1em 1.4em;background:none}.ui-tooltip{padding:8px;position:absolute;z-index:9999;max-width:300px}body .ui-tooltip{border-width:2px}.ui-widget{font-family:Arial,Helvetica,sans-serif;font-size:1em}.ui-widget .ui-widget{font-size:1em}.ui-widget input,.ui-widget select,.ui-widget textarea,.ui-widget button{font-family:Arial,Helvetica,sans-serif;font-size:1em}.ui-widget.ui-widget-content{border:1px solid #c5c5c5}.ui-widget-content{border:1px solid #ddd;background:#fff;color:#333}.ui-widget-content a{color:#333}.ui-widget-header{border:1px solid #ddd;background:#e9e9e9;color:#333;font-weight:bold}.ui-widget-header a{color:#333}.ui-state-default,.ui-widget-content .ui-state-default,.ui-widget-header .ui-state-default,.ui-button,html .ui-button.ui-state-disabled:hover,html .ui-button.ui-state-disabled:active{border:1px solid #c5c5c5;background:#f6f6f6;font-weight:normal;color:#454545}.ui-state-default a,.ui-state-default a:link,.ui-state-default a:visited,a.ui-button,a:link.ui-button,a:visited.ui-button,.ui-button{color:#454545;text-decoration:none}.ui-state-hover,.ui-widget-content .ui-state-hover,.ui-widget-header .ui-state-hover,.ui-state-focus,.ui-widget-content .ui-state-focus,.ui-widget-header .ui-state-focus,.ui-button:hover,.ui-button:focus{border:1px solid #ccc;background:#ededed;font-weight:normal;color:#2b2b2b}.ui-state-hover a,.ui-state-hover a:hover,.ui-state-hover a:link,.ui-state-hover a:visited,.ui-state-focus a,.ui-state-focus a:hover,.ui-state-focus a:link,.ui-state-focus a:visited,a.ui-button:hover,a.ui-button:focus{color:#2b2b2b;text-decoration:none}.ui-visual-focus{box-shadow:0 0 3px 1px rgb(94,158,214)}.ui-state-active,.ui-widget-content .ui-state-active,.ui-widget-header .ui-state-active,a.ui-button:active,.ui-button:active,.ui-button.ui-state-active:hover{border:1px solid #003eff;background:#007fff;font-weight:normal;color:#fff}.ui-icon-background,.ui-state-active .ui-icon-background{border:#003eff;background-color:#fff}.ui-state-active a,.ui-state-active a:link,.ui-state-active a:visited{color:#fff;text-decoration:none}.ui-state-highlight,.ui-widget-content .ui-state-highlight,.ui-widget-header .ui-state-highlight{border:1px solid #dad55e;background:#fffa90;color:#777620}.ui-state-checked{border:1px solid #dad55e;background:#fffa90}.ui-state-highlight a,.ui-widget-content .ui-state-highlight a,.ui-widget-header .ui-state-highlight a{color:#777620}.ui-state-error,.ui-widget-content .ui-state-error,.ui-widget-header .ui-state-error{border:1px solid #f1a899;background:#fddfdf;color:#5f3f3f}.ui-state-error a,.ui-widget-content .ui-state-error a,.ui-widget-header .ui-state-error a{color:#5f3f3f}.ui-state-error-text,.ui-widget-content .ui-state-error-text,.ui-widget-header .ui-state-error-text{color:#5f3f3f}.ui-priority-primary,.ui-widget-content .ui-priority-primary,.ui-widget-header .ui-priority-primary{font-weight:bold}.ui-priority-secondary,.ui-widget-content .ui-priority-secondary,.ui-widget-header .ui-priority-secondary{opacity:.7;filter:Alpha(Opacity=70);font-weight:normal}.ui-state-disabled,.ui-widget-content .ui-state-disabled,.ui-widget-header .ui-state-disabled{opacity:.35;filter:Alpha(Opacity=35);background-image:none}.ui-state-disabled .ui-icon{filter:Alpha(Opacity=35)}.ui-icon{width:16px;height:16px}.ui-icon,.ui-widget-content .ui-icon{background-image:url("images/ui-icons_444444_256x240.png")}.ui-widget-header .ui-icon{background-image:url("images/ui-icons_444444_256x240.png")}.ui-button .ui-icon{background-image:url("images/ui-icons_777777_256x240.png")}.ui-state-hover .ui-icon,.ui-state-focus .ui-icon,.ui-button:hover .ui-icon,.ui-button:focus .ui-icon,.ui-state-default .ui-icon{background-image:url("images/ui-icons_555555_256x240.png")}.ui-state-active .ui-icon,.ui-button:active .ui-icon{background-image:url("images/ui-icons_ffffff_256x240.png")}.ui-state-highlight .ui-icon,.ui-button .ui-state-highlight.ui-icon{background-image:url("images/ui-icons_777620_256x240.png")}.ui-state-error .ui-icon,.ui-state-error-text .ui-icon{background-image:url("images/ui-icons_cc0000_256x240.png")}.ui-icon-blank{background-position:16px 16px}.ui-icon-caret-1-n{background-position:0 0}.ui-icon-caret-1-ne{background-position:-16px 0}.ui-icon-caret-1-e{background-position:-32px 0}.ui-icon-caret-1-se{background-position:-48px 0}.ui-icon-caret-1-s{background-position:-65px 0}.ui-icon-caret-1-sw{background-position:-80px 0}.ui-icon-caret-1-w{background-position:-96px 0}.ui-icon-caret-1-nw{background-position:-112px 0}.ui-icon-caret-2-n-s{background-position:-128px 0}.ui-icon-caret-2-e-w{background-position:-144px 0}.ui-icon-triangle-1-n{background-position:0 -16px}.ui-icon-triangle-1-ne{background-position:-16px -16px}.ui-icon-triangle-1-e{background-position:-32px -16px}.ui-icon-triangle-1-se{background-position:-48px -16px}.ui-icon-triangle-1-s{background-position:-65px -16px}.ui-icon-triangle-1-sw{background-position:-80px -16px}.ui-icon-triangle-1-w{background-position:-96px -16px}.ui-icon-triangle-1-nw{background-position:-112px -16px}.ui-icon-triangle-2-n-s{background-position:-128px -16px}.ui-icon-triangle-2-e-w{background-position:-144px -16px}.ui-icon-arrow-1-n{background-position:0 -32px}.ui-icon-arrow-1-ne{background-position:-16px -32px}.ui-icon-arrow-1-e{background-position:-32px -32px}.ui-icon-arrow-1-se{background-position:-48px -32px}.ui-icon-arrow-1-s{background-position:-65px -32px}.ui-icon-arrow-1-sw{background-position:-80px -32px}.ui-icon-arrow-1-w{background-position:-96px -32px}.ui-icon-arrow-1-nw{background-position:-112px -32px}.ui-icon-arrow-2-n-s{background-position:-128px -32px}.ui-icon-arrow-2-ne-sw{background-position:-144px -32px}.ui-icon-arrow-2-e-w{background-position:-160px -32px}.ui-icon-arrow-2-se-nw{background-position:-176px -32px}.ui-icon-arrowstop-1-n{background-position:-192px -32px}.ui-icon-arrowstop-1-e{background-position:-208px -32px}.ui-icon-arrowstop-1-s{background-position:-224px -32px}.ui-icon-arrowstop-1-w{background-position:-240px -32px}.ui-icon-arrowthick-1-n{background-position:1px -48px}.ui-icon-arrowthick-1-ne{background-position:-16px -48px}.ui-icon-arrowthick-1-e{background-position:-32px -48px}.ui-icon-arrowthick-1-se{background-position:-48px -48px}.ui-icon-arrowthick-1-s{background-position:-64px -48px}.ui-icon-arrowthick-1-sw{background-position:-80px -48px}.ui-icon-arrowthick-1-w{background-position:-96px -48px}.ui-icon-arrowthick-1-nw{background-position:-112px -48px}.ui-icon-arrowthick-2-n-s{background-position:-128px -48px}.ui-icon-arrowthick-2-ne-sw{background-position:-144px -48px}.ui-icon-arrowthick-2-e-w{background-position:-160px -48px}.ui-icon-arrowthick-2-se-nw{background-position:-176px -48px}.ui-icon-arrowthickstop-1-n{background-position:-192px -48px}.ui-icon-arrowthickstop-1-e{background-position:-208px -48px}.ui-icon-arrowthickstop-1-s{background-position:-224px -48px}.ui-icon-arrowthickstop-1-w{background-position:-240px -48px}.ui-icon-arrowreturnthick-1-w{background-position:0 -64px}.ui-icon-arrowreturnthick-1-n{background-position:-16px -64px}.ui-icon-arrowreturnthick-1-e{background-position:-32px -64px}.ui-icon-arrowreturnthick-1-s{background-position:-48px -64px}.ui-icon-arrowreturn-1-w{background-position:-64px -64px}.ui-icon-arrowreturn-1-n{background-position:-80px -64px}.ui-icon-arrowreturn-1-e{background-position:-96px -64px}.ui-icon-arrowreturn-1-s{background-position:-112px -64px}.ui-icon-arrowrefresh-1-w{background-position:-128px -64px}.ui-icon-arrowrefresh-1-n{background-position:-144px -64px}.ui-icon-arrowrefresh-1-e{background-position:-160px -64px}.ui-icon-arrowrefresh-1-s{background-position:-176px -64px}.ui-icon-arrow-4{background-position:0 -80px}.ui-icon-arrow-4-diag{background-position:-16px -80px}.ui-icon-extlink{background-position:-32px -80px}.ui-icon-newwin{background-position:-48px -80px}.ui-icon-refresh{background-position:-64px -80px}.ui-icon-shuffle{background-position:-80px -80px}.ui-icon-transfer-e-w{background-position:-96px -80px}.ui-icon-transferthick-e-w{background-position:-112px -80px}.ui-icon-folder-collapsed{background-position:0 -96px}.ui-icon-folder-open{background-position:-16px -96px}.ui-icon-document{background-position:-32px -96px}.ui-icon-document-b{background-position:-48px -96px}.ui-icon-note{background-position:-64px -96px}.ui-icon-mail-closed{background-position:-80px -96px}.ui-icon-mail-open{background-position:-96px -96px}.ui-icon-suitcase{background-position:-112px -96px}.ui-icon-comment{background-position:-128px -96px}.ui-icon-person{background-position:-144px -96px}.ui-icon-print{background-position:-160px -96px}.ui-icon-trash{background-position:-176px -96px}.ui-icon-locked{background-position:-192px -96px}.ui-icon-unlocked{background-position:-208px -96px}.ui-icon-bookmark{background-position:-224px -96px}.ui-icon-tag{background-position:-240px -96px}.ui-icon-home{background-position:0 -112px}.ui-icon-flag{background-position:-16px -112px}.ui-icon-calendar{background-position:-32px -112px}.ui-icon-cart{background-position:-48px -112px}.ui-icon-pencil{background-position:-64px -112px}.ui-icon-clock{background-position:-80px -112px}.ui-icon-disk{background-position:-96px -112px}.ui-icon-calculator{background-position:-112px -112px}.ui-icon-zoomin{background-position:-128px -112px}.ui-icon-zoomout{background-position:-144px -112px}.ui-icon-search{background-position:-160px -112px}.ui-icon-wrench{background-position:-176px -112px}.ui-icon-gear{background-position:-192px -112px}.ui-icon-heart{background-position:-208px -112px}.ui-icon-star{background-position:-224px -112px}.ui-icon-link{background-position:-240px -112px}.ui-icon-cancel{background-position:0 -128px}.ui-icon-plus{background-position:-16px -128px}.ui-icon-plusthick{background-position:-32px -128px}.ui-icon-minus{background-position:-48px -128px}.ui-icon-minusthick{background-position:-64px -128px}.ui-icon-close{background-position:-80px -128px}.ui-icon-closethick{background-position:-96px -128px}.ui-icon-key{background-position:-112px -128px}.ui-icon-lightbulb{background-position:-128px -128px}.ui-icon-scissors{background-position:-144px -128px}.ui-icon-clipboard{background-position:-160px -128px}.ui-icon-copy{background-position:-176px -128px}.ui-icon-contact{background-position:-192px -128px}.ui-icon-image{background-position:-208px -128px}.ui-icon-video{background-position:-224px -128px}.ui-icon-script{background-position:-240px -128px}.ui-icon-alert{background-position:0 -144px}.ui-icon-info{background-position:-16px -144px}.ui-icon-notice{background-position:-32px -144px}.ui-icon-help{background-position:-48px -144px}.ui-icon-check{background-position:-64px -144px}.ui-icon-bullet{background-position:-80px -144px}.ui-icon-radio-on{background-position:-96px -144px}.ui-icon-radio-off{background-position:-112px -144px}.ui-icon-pin-w{background-position:-128px -144px}.ui-icon-pin-s{background-position:-144px -144px}.ui-icon-play{background-position:0 -160px}.ui-icon-pause{background-position:-16px -160px}.ui-icon-seek-next{background-position:-32px -160px}.ui-icon-seek-prev{background-position:-48px -160px}.ui-icon-seek-end{background-position:-64px -160px}.ui-icon-seek-start{background-position:-80px -160px}.ui-icon-seek-first{background-position:-80px -160px}.ui-icon-stop{background-position:-96px -160px}.ui-icon-eject{background-position:-112px -160px}.ui-icon-volume-off{background-position:-128px -160px}.ui-icon-volume-on{background-position:-144px -160px}.ui-icon-power{background-position:0 -176px}.ui-icon-signal-diag{background-position:-16px -176px}.ui-icon-signal{background-position:-32px -176px}.ui-icon-battery-0{background-position:-48px -176px}.ui-icon-battery-1{background-position:-64px -176px}.ui-icon-battery-2{background-position:-80px -176px}.ui-icon-battery-3{background-position:-96px -176px}.ui-icon-circle-plus{background-position:0 -192px}.ui-icon-circle-minus{background-position:-16px -192px}.ui-icon-circle-close{background-position:-32px -192px}.ui-icon-circle-triangle-e{background-position:-48px -192px}.ui-icon-circle-triangle-s{background-position:-64px -192px}.ui-icon-circle-triangle-w{background-position:-80px -192px}.ui-icon-circle-triangle-n{background-position:-96px -192px}.ui-icon-circle-arrow-e{background-position:-112px -192px}.ui-icon-circle-arrow-s{background-position:-128px -192px}.ui-icon-circle-arrow-w{background-position:-144px -192px}.ui-icon-circle-arrow-n{background-position:-160px -192px}.ui-icon-circle-zoomin{background-position:-176px -192px}.ui-icon-circle-zoomout{background-position:-192px -192px}.ui-icon-circle-check{background-position:-208px -192px}.ui-icon-circlesmall-plus{background-position:0 -208px}.ui-icon-circlesmall-minus{background-position:-16px -208px}.ui-icon-circlesmall-close{background-position:-32px -208px}.ui-icon-squaresmall-plus{background-position:-48px -208px}.ui-icon-squaresmall-minus{background-position:-64px -208px}.ui-icon-squaresmall-close{background-position:-80px -208px}.ui-icon-grip-dotted-vertical{background-position:0 -224px}.ui-icon-grip-dotted-horizontal{background-position:-16px -224px}.ui-icon-grip-solid-vertical{background-position:-32px -224px}.ui-icon-grip-solid-horizontal{background-position:-48px -224px}.ui-icon-gripsmall-diagonal-se{background-position:-64px -224px}.ui-icon-grip-diagonal-se{background-position:-80px -224px}.ui-corner-all,.ui-corner-top,.ui-corner-left,.ui-corner-tl{border-top-left-radius:3px}.ui-corner-all,.ui-corner-top,.ui-corner-right,.ui-corner-tr{border-top-right-radius:3px}.ui-corner-all,.ui-corner-bottom,.ui-corner-left,.ui-corner-bl{border-bottom-left-radius:3px}.ui-corner-all,.ui-corner-bottom,.ui-corner-right,.ui-corner-br{border-bottom-right-radius:3px}.ui-widget-overlay{background:#aaa;opacity:.3;filter:Alpha(Opacity=30)}.ui-widget-shadow{-webkit-box-shadow:0 0 5px #666;box-shadow:0 0 5px #666}[m
\ No newline at end of file[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/menu.css b/Zebra-CMS/Zebra/Content/themes/base/menu.css[m
[1mnew file mode 100644[m
[1mindex 0000000..221fc51[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/menu.css[m
[36m@@ -0,0 +1,63 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Menu 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/menu/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-menu {[m
[32m+[m	[32mlist-style: none;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32moutline: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu-item {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mpadding: 3px 1em 3px .4em;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m	[32mmin-height: 0; /* support: IE7 */[m
[32m+[m	[32m/* support: IE10, see #8844 */[m
[32m+[m	[32mlist-style-image: url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-menu-divider {[m
[32m+[m	[32mmargin: 5px 0;[m
[32m+[m	[32mheight: 0;[m
[32m+[m	[32mfont-size: 0;[m
[32m+[m	[32mline-height: 0;[m
[32m+[m	[32mborder-width: 1px 0 0 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu .ui-state-focus,[m
[32m+[m[32m.ui-menu .ui-state-active {[m
[32m+[m	[32mmargin: -1px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* icon support */[m
[32m+[m[32m.ui-menu-icons {[m
[32m+[m	[32mposition: relative;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-menu-icons .ui-menu-item {[m
[32m+[m	[32mpadding-left: 2em;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* left-aligned */[m
[32m+[m[32m.ui-menu .ui-icon {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mbottom: 0;[m
[32m+[m	[32mleft: .2em;[m
[32m+[m	[32mmargin: auto 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* right-aligned */[m
[32m+[m[32m.ui-menu .ui-menu-icon {[m
[32m+[m	[32mleft: auto;[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/progressbar.css b/Zebra-CMS/Zebra/Content/themes/base/progressbar.css[m
[1mnew file mode 100644[m
[1mindex 0000000..5e43600[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/progressbar.css[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Progressbar 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/progressbar/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-progressbar {[m
[32m+[m	[32mheight: 2em;[m
[32m+[m	[32mtext-align: left;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar .ui-progressbar-value {[m
[32m+[m	[32mmargin: -1px;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar .ui-progressbar-overlay {[m
[32m+[m	[32mbackground: url("data:image/gif;base64,R0lGODlhKAAoAIABAAAAAP///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQJAQABACwAAAAAKAAoAAACkYwNqXrdC52DS06a7MFZI+4FHBCKoDeWKXqymPqGqxvJrXZbMx7Ttc+w9XgU2FB3lOyQRWET2IFGiU9m1frDVpxZZc6bfHwv4c1YXP6k1Vdy292Fb6UkuvFtXpvWSzA+HycXJHUXiGYIiMg2R6W459gnWGfHNdjIqDWVqemH2ekpObkpOlppWUqZiqr6edqqWQAAIfkECQEAAQAsAAAAACgAKAAAApSMgZnGfaqcg1E2uuzDmmHUBR8Qil95hiPKqWn3aqtLsS18y7G1SzNeowWBENtQd+T1JktP05nzPTdJZlR6vUxNWWjV+vUWhWNkWFwxl9VpZRedYcflIOLafaa28XdsH/ynlcc1uPVDZxQIR0K25+cICCmoqCe5mGhZOfeYSUh5yJcJyrkZWWpaR8doJ2o4NYq62lAAACH5BAkBAAEALAAAAAAoACgAAAKVDI4Yy22ZnINRNqosw0Bv7i1gyHUkFj7oSaWlu3ovC8GxNso5fluz3qLVhBVeT/Lz7ZTHyxL5dDalQWPVOsQWtRnuwXaFTj9jVVh8pma9JjZ4zYSj5ZOyma7uuolffh+IR5aW97cHuBUXKGKXlKjn+DiHWMcYJah4N0lYCMlJOXipGRr5qdgoSTrqWSq6WFl2ypoaUAAAIfkECQEAAQAsAAAAACgAKAAAApaEb6HLgd/iO7FNWtcFWe+ufODGjRfoiJ2akShbueb0wtI50zm02pbvwfWEMWBQ1zKGlLIhskiEPm9R6vRXxV4ZzWT2yHOGpWMyorblKlNp8HmHEb/lCXjcW7bmtXP8Xt229OVWR1fod2eWqNfHuMjXCPkIGNileOiImVmCOEmoSfn3yXlJWmoHGhqp6ilYuWYpmTqKUgAAIfkECQEAAQAsAAAAACgAKAAAApiEH6kb58biQ3FNWtMFWW3eNVcojuFGfqnZqSebuS06w5V80/X02pKe8zFwP6EFWOT1lDFk8rGERh1TTNOocQ61Hm4Xm2VexUHpzjymViHrFbiELsefVrn6XKfnt2Q9G/+Xdie499XHd2g4h7ioOGhXGJboGAnXSBnoBwKYyfioubZJ2Hn0RuRZaflZOil56Zp6iioKSXpUAAAh+QQJAQABACwAAAAAKAAoAAACkoQRqRvnxuI7kU1a1UU5bd5tnSeOZXhmn5lWK3qNTWvRdQxP8qvaC+/yaYQzXO7BMvaUEmJRd3TsiMAgswmNYrSgZdYrTX6tSHGZO73ezuAw2uxuQ+BbeZfMxsexY35+/Qe4J1inV0g4x3WHuMhIl2jXOKT2Q+VU5fgoSUI52VfZyfkJGkha6jmY+aaYdirq+lQAACH5BAkBAAEALAAAAAAoACgAAAKWBIKpYe0L3YNKToqswUlvznigd4wiR4KhZrKt9Upqip61i9E3vMvxRdHlbEFiEXfk9YARYxOZZD6VQ2pUunBmtRXo1Lf8hMVVcNl8JafV38aM2/Fu5V16Bn63r6xt97j09+MXSFi4BniGFae3hzbH9+hYBzkpuUh5aZmHuanZOZgIuvbGiNeomCnaxxap2upaCZsq+1kAACH5BAkBAAEALAAAAAAoACgAAAKXjI8By5zf4kOxTVrXNVlv1X0d8IGZGKLnNpYtm8Lr9cqVeuOSvfOW79D9aDHizNhDJidFZhNydEahOaDH6nomtJjp1tutKoNWkvA6JqfRVLHU/QUfau9l2x7G54d1fl995xcIGAdXqMfBNadoYrhH+Mg2KBlpVpbluCiXmMnZ2Sh4GBqJ+ckIOqqJ6LmKSllZmsoq6wpQAAAh+QQJAQABACwAAAAAKAAoAAAClYx/oLvoxuJDkU1a1YUZbJ59nSd2ZXhWqbRa2/gF8Gu2DY3iqs7yrq+xBYEkYvFSM8aSSObE+ZgRl1BHFZNr7pRCavZ5BW2142hY3AN/zWtsmf12p9XxxFl2lpLn1rseztfXZjdIWIf2s5dItwjYKBgo9yg5pHgzJXTEeGlZuenpyPmpGQoKOWkYmSpaSnqKileI2FAAACH5BAkBAAEALAAAAAAoACgAAAKVjB+gu+jG4kORTVrVhRlsnn2dJ3ZleFaptFrb+CXmO9OozeL5VfP99HvAWhpiUdcwkpBH3825AwYdU8xTqlLGhtCosArKMpvfa1mMRae9VvWZfeB2XfPkeLmm18lUcBj+p5dnN8jXZ3YIGEhYuOUn45aoCDkp16hl5IjYJvjWKcnoGQpqyPlpOhr3aElaqrq56Bq7VAAAOw==");[m
[32m+[m	[32mheight: 100%;[m
[32m+[m	[32mfilter: alpha(opacity=25); /* support: IE8 */[m
[32m+[m	[32mopacity: 0.25;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-progressbar-indeterminate .ui-progressbar-value {[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/resizable.css b/Zebra-CMS/Zebra/Content/themes/base/resizable.css[m
[1mnew file mode 100644[m
[1mindex 0000000..23d9a07[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/resizable.css[m
[36m@@ -0,0 +1,78 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Resizable 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m */[m
[32m+[m[32m.ui-resizable {[m
[32m+[m	[32mposition: relative;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-handle {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mfont-size: 0.1px;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-disabled .ui-resizable-handle,[m
[32m+[m[32m.ui-resizable-autohide .ui-resizable-handle {[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-n {[m
[32m+[m	[32mcursor: n-resize;[m
[32m+[m	[32mheight: 7px;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mtop: -5px;[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-s {[m
[32m+[m	[32mcursor: s-resize;[m
[32m+[m	[32mheight: 7px;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m	[32mbottom: -5px;[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-e {[m
[32m+[m	[32mcursor: e-resize;[m
[32m+[m	[32mwidth: 7px;[m
[32m+[m	[32mright: -5px;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-w {[m
[32m+[m	[32mcursor: w-resize;[m
[32m+[m	[32mwidth: 7px;[m
[32m+[m	[32mleft: -5px;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-se {[m
[32m+[m	[32mcursor: se-resize;[m
[32m+[m	[32mwidth: 12px;[m
[32m+[m	[32mheight: 12px;[m
[32m+[m	[32mright: 1px;[m
[32m+[m	[32mbottom: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-sw {[m
[32m+[m	[32mcursor: sw-resize;[m
[32m+[m	[32mwidth: 9px;[m
[32m+[m	[32mheight: 9px;[m
[32m+[m	[32mleft: -5px;[m
[32m+[m	[32mbottom: -5px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-nw {[m
[32m+[m	[32mcursor: nw-resize;[m
[32m+[m	[32mwidth: 9px;[m
[32m+[m	[32mheight: 9px;[m
[32m+[m	[32mleft: -5px;[m
[32m+[m	[32mtop: -5px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-resizable-ne {[m
[32m+[m	[32mcursor: ne-resize;[m
[32m+[m	[32mwidth: 9px;[m
[32m+[m	[32mheight: 9px;[m
[32m+[m	[32mright: -5px;[m
[32m+[m	[32mtop: -5px;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/selectable.css b/Zebra-CMS/Zebra/Content/themes/base/selectable.css[m
[1mnew file mode 100644[m
[1mindex 0000000..482597c[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/selectable.css[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Selectable 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m */[m
[32m+[m[32m.ui-selectable {[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectable-helper {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 100;[m
[32m+[m	[32mborder: 1px dotted black;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/selectmenu.css b/Zebra-CMS/Zebra/Content/themes/base/selectmenu.css[m
[1mnew file mode 100644[m
[1mindex 0000000..2417b6b[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/selectmenu.css[m
[36m@@ -0,0 +1,59 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Selectmenu 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/selectmenu/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-selectmenu-menu {[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mdisplay: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-menu .ui-menu {[m
[32m+[m	[32moverflow: auto;[m
[32m+[m	[32m/* Support: IE7 */[m
[32m+[m	[32moverflow-x: hidden;[m
[32m+[m	[32mpadding-bottom: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-menu .ui-menu .ui-selectmenu-optgroup {[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m	[32mline-height: 1.5;[m
[32m+[m	[32mpadding: 2px 0.4em;[m
[32m+[m	[32mmargin: 0.5em 0 0 0;[m
[32m+[m	[32mheight: auto;[m
[32m+[m	[32mborder: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-open {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-button {[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-button span.ui-icon {[m
[32m+[m	[32mright: 0.5em;[m
[32m+[m	[32mleft: auto;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-selectmenu-button span.ui-selectmenu-text {[m
[32m+[m	[32mtext-align: left;[m
[32m+[m	[32mpadding: 0.4em 2.1em 0.4em 1em;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mline-height: 1.4;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mtext-overflow: ellipsis;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/slider.css b/Zebra-CMS/Zebra/Content/themes/base/slider.css[m
[1mnew file mode 100644[m
[1mindex 0000000..7c4f01a[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/slider.css[m
[36m@@ -0,0 +1,75 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Slider 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/slider/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-slider {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mtext-align: left;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider .ui-slider-handle {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 2;[m
[32m+[m	[32mwidth: 1.2em;[m
[32m+[m	[32mheight: 1.2em;[m
[32m+[m	[32mcursor: default;[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider .ui-slider-range {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 1;[m
[32m+[m	[32mfont-size: .7em;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mborder: 0;[m
[32m+[m	[32mbackground-position: 0 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* support: IE8 - See #6727 */[m
[32m+[m[32m.ui-slider.ui-state-disabled .ui-slider-handle,[m
[32m+[m[32m.ui-slider.ui-state-disabled .ui-slider-range {[m
[32m+[m	[32mfilter: inherit;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-slider-horizontal {[m
[32m+[m	[32mheight: .8em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-handle {[m
[32m+[m	[32mtop: -.3em;[m
[32m+[m	[32mmargin-left: -.6em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-range {[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mheight: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-range-min {[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-horizontal .ui-slider-range-max {[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-slider-vertical {[m
[32m+[m	[32mwidth: .8em;[m
[32m+[m	[32mheight: 100px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-handle {[m
[32m+[m	[32mleft: -.3em;[m
[32m+[m	[32mmargin-left: 0;[m
[32m+[m	[32mmargin-bottom: -.6em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-range {[m
[32m+[m	[32mleft: 0;[m
[32m+[m	[32mwidth: 100%;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-range-min {[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-slider-vertical .ui-slider-range-max {[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/sortable.css b/Zebra-CMS/Zebra/Content/themes/base/sortable.css[m
[1mnew file mode 100644[m
[1mindex 0000000..1c27bad[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/sortable.css[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Sortable 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m */[m
[32m+[m[32m.ui-sortable-handle {[m
[32m+[m	[32m-ms-touch-action: none;[m
[32m+[m	[32mtouch-action: none;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/spinner.css b/Zebra-CMS/Zebra/Content/themes/base/spinner.css[m
[1mnew file mode 100644[m
[1mindex 0000000..9a9b78b[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/spinner.css[m
[36m@@ -0,0 +1,65 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Spinner 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/spinner/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-spinner {[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mdisplay: inline-block;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-input {[m
[32m+[m	[32mborder: none;[m
[32m+[m	[32mbackground: none;[m
[32m+[m	[32mcolor: inherit;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: .2em 0;[m
[32m+[m	[32mvertical-align: middle;[m
[32m+[m	[32mmargin-left: .4em;[m
[32m+[m	[32mmargin-right: 22px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-button {[m
[32m+[m	[32mwidth: 16px;[m
[32m+[m	[32mheight: 50%;[m
[32m+[m	[32mfont-size: .5em;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mtext-align: center;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mcursor: default;[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32moverflow: hidden;[m
[32m+[m	[32mright: 0;[m
[32m+[m[32m}[m
[32m+[m[32m/* more specificity required here to override default borders */[m
[32m+[m[32m.ui-spinner a.ui-spinner-button {[m
[32m+[m	[32mborder-top: none;[m
[32m+[m	[32mborder-bottom: none;[m
[32m+[m	[32mborder-right: none;[m
[32m+[m[32m}[m
[32m+[m[32m/* vertically center icon */[m
[32m+[m[32m.ui-spinner .ui-icon {[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mmargin-top: -8px;[m
[32m+[m	[32mtop: 50%;[m
[32m+[m	[32mleft: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-up {[m
[32m+[m	[32mtop: 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-spinner-down {[m
[32m+[m	[32mbottom: 0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* TR overrides */[m
[32m+[m[32m.ui-spinner .ui-icon-triangle-1-s {[m
[32m+[m	[32m/* need to fix icons sprite */[m
[32m+[m	[32mbackground-position: -65px -16px;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/tabs.css b/Zebra-CMS/Zebra/Content/themes/base/tabs.css[m
[1mnew file mode 100644[m
[1mindex 0000000..c92a1b8[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/tabs.css[m
[36m@@ -0,0 +1,51 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Tabs 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/tabs/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-tabs {[m
[32m+[m	[32mposition: relative;/* position: relative prevents IE scroll bug (element with position: relative inside container with overflow: auto appear as "fixed") */[m
[32m+[m	[32mpadding: .2em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav {[m
[32m+[m	[32mmargin: 0;[m
[32m+[m	[32mpadding: .2em .2em 0;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li {[m
[32m+[m	[32mlist-style: none;[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mposition: relative;[m
[32m+[m	[32mtop: 0;[m
[32m+[m	[32mmargin: 1px .2em 0 0;[m
[32m+[m	[32mborder-bottom-width: 0;[m
[32m+[m	[32mpadding: 0;[m
[32m+[m	[32mwhite-space: nowrap;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav .ui-tabs-anchor {[m
[32m+[m	[32mfloat: left;[m
[32m+[m	[32mpadding: .5em 1em;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-tabs-active {[m
[32m+[m	[32mmargin-bottom: -1px;[m
[32m+[m	[32mpadding-bottom: 1px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor,[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-state-disabled .ui-tabs-anchor,[m
[32m+[m[32m.ui-tabs .ui-tabs-nav li.ui-tabs-loading .ui-tabs-anchor {[m
[32m+[m	[32mcursor: text;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs-collapsible .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor {[m
[32m+[m	[32mcursor: pointer;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-tabs .ui-tabs-panel {[m
[32m+[m	[32mdisplay: block;[m
[32m+[m	[32mborder-width: 0;[m
[32m+[m	[32mpadding: 1em 1.4em;[m
[32m+[m	[32mbackground: none;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/theme.css b/Zebra-CMS/Zebra/Content/themes/base/theme.css[m
[1mnew file mode 100644[m
[1mindex 0000000..da972f5[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/theme.css[m
[36m@@ -0,0 +1,444 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI CSS Framework 1.12.0[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/category/theming/[m
[32m+[m[32m *[m
[32m+[m[32m * To view and modify this theme, visit http://jqueryui.com/themeroller/?ffDefault=Arial%2CHelvetica%2Csans-serif&fsDefault=1em&fwDefault=normal&cornerRadius=3px&bgColorHeader=e9e9e9&bgTextureHeader=flat&borderColorHeader=dddddd&fcHeader=333333&iconColorHeader=444444&bgColorContent=ffffff&bgTextureContent=flat&borderColorContent=dddddd&fcContent=333333&iconColorContent=444444&bgColorDefault=f6f6f6&bgTextureDefault=flat&borderColorDefault=c5c5c5&fcDefault=454545&iconColorDefault=777777&bgColorHover=ededed&bgTextureHover=flat&borderColorHover=cccccc&fcHover=2b2b2b&iconColorHover=555555&bgColorActive=007fff&bgTextureActive=flat&borderColorActive=003eff&fcActive=ffffff&iconColorActive=ffffff&bgColorHighlight=fffa90&bgTextureHighlight=flat&borderColorHighlight=dad55e&fcHighlight=777620&iconColorHighlight=777620&bgColorError=fddfdf&bgTextureError=flat&borderColorError=f1a899&fcError=5f3f3f&iconColorError=cc0000&bgColorOverlay=aaaaaa&bgTextureOverlay=flat&bgImgOpacityOverlay=0&opacityOverlay=30&bgColorShadow=666666&bgTextureShadow=flat&bgImgOpacityShadow=0&opacityShadow=30&thicknessShadow=5px&offsetTopShadow=0px&offsetLeftShadow=0px&cornerRadiusShadow=8px[m
[32m+[m[32m */[m
[32m+[m
[32m+[m
[32m+[m[32m/* Component containers[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-widget {[m
[32m+[m	[32mfont-family: Arial,Helvetica,sans-serif;[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget .ui-widget {[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget input,[m
[32m+[m[32m.ui-widget select,[m
[32m+[m[32m.ui-widget textarea,[m
[32m+[m[32m.ui-widget button {[m
[32m+[m	[32mfont-family: Arial,Helvetica,sans-serif;[m
[32m+[m	[32mfont-size: 1em;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget.ui-widget-content {[m
[32m+[m	[32mborder: 1px solid #c5c5c5;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-content {[m
[32m+[m	[32mborder: 1px solid #dddddd;[m
[32m+[m	[32mbackground: #ffffff;[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-content a {[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-header {[m
[32m+[m	[32mborder: 1px solid #dddddd;[m
[32m+[m	[32mbackground: #e9e9e9;[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-header a {[m
[32m+[m	[32mcolor: #333333;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Interaction states[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-state-default,[m
[32m+[m[32m.ui-widget-content .ui-state-default,[m
[32m+[m[32m.ui-widget-header .ui-state-default,[m
[32m+[m[32m.ui-button,[m
[32m+[m
[32m+[m[32m/* We use html here because we need a greater specificity to make sure disabled[m
[32m+[m[32mworks properly when clicked or hovered */[m
[32m+[m[32mhtml .ui-button.ui-state-disabled:hover,[m
[32m+[m[32mhtml .ui-button.ui-state-disabled:active {[m
[32m+[m	[32mborder: 1px solid #c5c5c5;[m
[32m+[m	[32mbackground: #f6f6f6;[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m	[32mcolor: #454545;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-default a,[m
[32m+[m[32m.ui-state-default a:link,[m
[32m+[m[32m.ui-state-default a:visited,[m
[32m+[m[32ma.ui-button,[m
[32m+[m[32ma:link.ui-button,[m
[32m+[m[32ma:visited.ui-button,[m
[32m+[m[32m.ui-button {[m
[32m+[m	[32mcolor: #454545;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-hover,[m
[32m+[m[32m.ui-widget-content .ui-state-hover,[m
[32m+[m[32m.ui-widget-header .ui-state-hover,[m
[32m+[m[32m.ui-state-focus,[m
[32m+[m[32m.ui-widget-content .ui-state-focus,[m
[32m+[m[32m.ui-widget-header .ui-state-focus,[m
[32m+[m[32m.ui-button:hover,[m
[32m+[m[32m.ui-button:focus {[m
[32m+[m	[32mborder: 1px solid #cccccc;[m
[32m+[m	[32mbackground: #ededed;[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m	[32mcolor: #2b2b2b;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-hover a,[m
[32m+[m[32m.ui-state-hover a:hover,[m
[32m+[m[32m.ui-state-hover a:link,[m
[32m+[m[32m.ui-state-hover a:visited,[m
[32m+[m[32m.ui-state-focus a,[m
[32m+[m[32m.ui-state-focus a:hover,[m
[32m+[m[32m.ui-state-focus a:link,[m
[32m+[m[32m.ui-state-focus a:visited,[m
[32m+[m[32ma.ui-button:hover,[m
[32m+[m[32ma.ui-button:focus {[m
[32m+[m	[32mcolor: #2b2b2b;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.ui-visual-focus {[m
[32m+[m	[32mbox-shadow: 0 0 3px 1px rgb(94, 158, 214);[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-active,[m
[32m+[m[32m.ui-widget-content .ui-state-active,[m
[32m+[m[32m.ui-widget-header .ui-state-active,[m
[32m+[m[32ma.ui-button:active,[m
[32m+[m[32m.ui-button:active,[m
[32m+[m[32m.ui-button.ui-state-active:hover {[m
[32m+[m	[32mborder: 1px solid #003eff;[m
[32m+[m	[32mbackground: #007fff;[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m	[32mcolor: #ffffff;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-icon-background,[m
[32m+[m[32m.ui-state-active .ui-icon-background {[m
[32m+[m	[32mborder: #003eff;[m
[32m+[m	[32mbackground-color: #ffffff;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-active a,[m
[32m+[m[32m.ui-state-active a:link,[m
[32m+[m[32m.ui-state-active a:visited {[m
[32m+[m	[32mcolor: #ffffff;[m
[32m+[m	[32mtext-decoration: none;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Interaction Cues[m
[32m+[m[32m----------------------------------*/[m
[32m+[m[32m.ui-state-highlight,[m
[32m+[m[32m.ui-widget-content .ui-state-highlight,[m
[32m+[m[32m.ui-widget-header .ui-state-highlight {[m
[32m+[m	[32mborder: 1px solid #dad55e;[m
[32m+[m	[32mbackground: #fffa90;[m
[32m+[m	[32mcolor: #777620;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-checked {[m
[32m+[m	[32mborder: 1px solid #dad55e;[m
[32m+[m	[32mbackground: #fffa90;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-highlight a,[m
[32m+[m[32m.ui-widget-content .ui-state-highlight a,[m
[32m+[m[32m.ui-widget-header .ui-state-highlight a {[m
[32m+[m	[32mcolor: #777620;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error,[m
[32m+[m[32m.ui-widget-content .ui-state-error,[m
[32m+[m[32m.ui-widget-header .ui-state-error {[m
[32m+[m	[32mborder: 1px solid #f1a899;[m
[32m+[m	[32mbackground: #fddfdf;[m
[32m+[m	[32mcolor: #5f3f3f;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error a,[m
[32m+[m[32m.ui-widget-content .ui-state-error a,[m
[32m+[m[32m.ui-widget-header .ui-state-error a {[m
[32m+[m	[32mcolor: #5f3f3f;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error-text,[m
[32m+[m[32m.ui-widget-content .ui-state-error-text,[m
[32m+[m[32m.ui-widget-header .ui-state-error-text {[m
[32m+[m	[32mcolor: #5f3f3f;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-priority-primary,[m
[32m+[m[32m.ui-widget-content .ui-priority-primary,[m
[32m+[m[32m.ui-widget-header .ui-priority-primary {[m
[32m+[m	[32mfont-weight: bold;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-priority-secondary,[m
[32m+[m[32m.ui-widget-content .ui-priority-secondary,[m
[32m+[m[32m.ui-widget-header .ui-priority-secondary {[m
[32m+[m	[32mopacity: .7;[m
[32m+[m	[32mfilter:Alpha(Opacity=70); /* support: IE8 */[m
[32m+[m	[32mfont-weight: normal;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-disabled,[m
[32m+[m[32m.ui-widget-content .ui-state-disabled,[m
[32m+[m[32m.ui-widget-header .ui-state-disabled {[m
[32m+[m	[32mopacity: .35;[m
[32m+[m	[32mfilter:Alpha(Opacity=35); /* support: IE8 */[m
[32m+[m	[32mbackground-image: none;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-disabled .ui-icon {[m
[32m+[m	[32mfilter:Alpha(Opacity=35); /* support: IE8 - See #6059 */[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Icons[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* states and images */[m
[32m+[m[32m.ui-icon {[m
[32m+[m	[32mwidth: 16px;[m
[32m+[m	[32mheight: 16px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-icon,[m
[32m+[m[32m.ui-widget-content .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_444444_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-header .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_444444_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-button .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_777777_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-hover .ui-icon,[m
[32m+[m[32m.ui-state-focus .ui-icon,[m
[32m+[m[32m.ui-button:hover .ui-icon,[m
[32m+[m[32m.ui-button:focus .ui-icon,[m
[32m+[m[32m.ui-state-default .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_555555_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-active .ui-icon,[m
[32m+[m[32m.ui-button:active .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_ffffff_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-highlight .ui-icon,[m
[32m+[m[32m.ui-button .ui-state-highlight.ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_777620_256x240.png");[m
[32m+[m[32m}[m
[32m+[m[32m.ui-state-error .ui-icon,[m
[32m+[m[32m.ui-state-error-text .ui-icon {[m
[32m+[m	[32mbackground-image: url("images/ui-icons_cc0000_256x240.png");[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* positioning */[m
[32m+[m[32m.ui-icon-blank { background-position: 16px 16px; }[m
[32m+[m[32m.ui-icon-caret-1-n { background-position: 0 0; }[m
[32m+[m[32m.ui-icon-caret-1-ne { background-position: -16px 0; }[m
[32m+[m[32m.ui-icon-caret-1-e { background-position: -32px 0; }[m
[32m+[m[32m.ui-icon-caret-1-se { background-position: -48px 0; }[m
[32m+[m[32m.ui-icon-caret-1-s { background-position: -65px 0; }[m
[32m+[m[32m.ui-icon-caret-1-sw { background-position: -80px 0; }[m
[32m+[m[32m.ui-icon-caret-1-w { background-position: -96px 0; }[m
[32m+[m[32m.ui-icon-caret-1-nw { background-position: -112px 0; }[m
[32m+[m[32m.ui-icon-caret-2-n-s { background-position: -128px 0; }[m
[32m+[m[32m.ui-icon-caret-2-e-w { background-position: -144px 0; }[m
[32m+[m[32m.ui-icon-triangle-1-n { background-position: 0 -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-ne { background-position: -16px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-e { background-position: -32px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-se { background-position: -48px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-s { background-position: -65px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-sw { background-position: -80px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-w { background-position: -96px -16px; }[m
[32m+[m[32m.ui-icon-triangle-1-nw { background-position: -112px -16px; }[m
[32m+[m[32m.ui-icon-triangle-2-n-s { background-position: -128px -16px; }[m
[32m+[m[32m.ui-icon-triangle-2-e-w { background-position: -144px -16px; }[m
[32m+[m[32m.ui-icon-arrow-1-n { background-position: 0 -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-ne { background-position: -16px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-e { background-position: -32px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-se { background-position: -48px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-s { background-position: -65px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-sw { background-position: -80px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-w { background-position: -96px -32px; }[m
[32m+[m[32m.ui-icon-arrow-1-nw { background-position: -112px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-n-s { background-position: -128px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-ne-sw { background-position: -144px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-e-w { background-position: -160px -32px; }[m
[32m+[m[32m.ui-icon-arrow-2-se-nw { background-position: -176px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-n { background-position: -192px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-e { background-position: -208px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-s { background-position: -224px -32px; }[m
[32m+[m[32m.ui-icon-arrowstop-1-w { background-position: -240px -32px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-n { background-position: 1px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-ne { background-position: -16px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-e { background-position: -32px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-se { background-position: -48px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-s { background-position: -64px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-sw { background-position: -80px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-w { background-position: -96px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-1-nw { background-position: -112px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-n-s { background-position: -128px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-ne-sw { background-position: -144px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-e-w { background-position: -160px -48px; }[m
[32m+[m[32m.ui-icon-arrowthick-2-se-nw { background-position: -176px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-n { background-position: -192px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-e { background-position: -208px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-s { background-position: -224px -48px; }[m
[32m+[m[32m.ui-icon-arrowthickstop-1-w { background-position: -240px -48px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-w { background-position: 0 -64px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-n { background-position: -16px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-e { background-position: -32px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturnthick-1-s { background-position: -48px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-w { background-position: -64px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-n { background-position: -80px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-e { background-position: -96px -64px; }[m
[32m+[m[32m.ui-icon-arrowreturn-1-s { background-position: -112px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-w { background-position: -128px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-n { background-position: -144px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-e { background-position: -160px -64px; }[m
[32m+[m[32m.ui-icon-arrowrefresh-1-s { background-position: -176px -64px; }[m
[32m+[m[32m.ui-icon-arrow-4 { background-position: 0 -80px; }[m
[32m+[m[32m.ui-icon-arrow-4-diag { background-position: -16px -80px; }[m
[32m+[m[32m.ui-icon-extlink { background-position: -32px -80px; }[m
[32m+[m[32m.ui-icon-newwin { background-position: -48px -80px; }[m
[32m+[m[32m.ui-icon-refresh { background-position: -64px -80px; }[m
[32m+[m[32m.ui-icon-shuffle { background-position: -80px -80px; }[m
[32m+[m[32m.ui-icon-transfer-e-w { background-position: -96px -80px; }[m
[32m+[m[32m.ui-icon-transferthick-e-w { background-position: -112px -80px; }[m
[32m+[m[32m.ui-icon-folder-collapsed { background-position: 0 -96px; }[m
[32m+[m[32m.ui-icon-folder-open { background-position: -16px -96px; }[m
[32m+[m[32m.ui-icon-document { background-position: -32px -96px; }[m
[32m+[m[32m.ui-icon-document-b { background-position: -48px -96px; }[m
[32m+[m[32m.ui-icon-note { background-position: -64px -96px; }[m
[32m+[m[32m.ui-icon-mail-closed { background-position: -80px -96px; }[m
[32m+[m[32m.ui-icon-mail-open { background-position: -96px -96px; }[m
[32m+[m[32m.ui-icon-suitcase { background-position: -112px -96px; }[m
[32m+[m[32m.ui-icon-comment { background-position: -128px -96px; }[m
[32m+[m[32m.ui-icon-person { background-position: -144px -96px; }[m
[32m+[m[32m.ui-icon-print { background-position: -160px -96px; }[m
[32m+[m[32m.ui-icon-trash { background-position: -176px -96px; }[m
[32m+[m[32m.ui-icon-locked { background-position: -192px -96px; }[m
[32m+[m[32m.ui-icon-unlocked { background-position: -208px -96px; }[m
[32m+[m[32m.ui-icon-bookmark { background-position: -224px -96px; }[m
[32m+[m[32m.ui-icon-tag { background-position: -240px -96px; }[m
[32m+[m[32m.ui-icon-home { background-position: 0 -112px; }[m
[32m+[m[32m.ui-icon-flag { background-position: -16px -112px; }[m
[32m+[m[32m.ui-icon-calendar { background-position: -32px -112px; }[m
[32m+[m[32m.ui-icon-cart { background-position: -48px -112px; }[m
[32m+[m[32m.ui-icon-pencil { background-position: -64px -112px; }[m
[32m+[m[32m.ui-icon-clock { background-position: -80px -112px; }[m
[32m+[m[32m.ui-icon-disk { background-position: -96px -112px; }[m
[32m+[m[32m.ui-icon-calculator { background-position: -112px -112px; }[m
[32m+[m[32m.ui-icon-zoomin { background-position: -128px -112px; }[m
[32m+[m[32m.ui-icon-zoomout { background-position: -144px -112px; }[m
[32m+[m[32m.ui-icon-search { background-position: -160px -112px; }[m
[32m+[m[32m.ui-icon-wrench { background-position: -176px -112px; }[m
[32m+[m[32m.ui-icon-gear { background-position: -192px -112px; }[m
[32m+[m[32m.ui-icon-heart { background-position: -208px -112px; }[m
[32m+[m[32m.ui-icon-star { background-position: -224px -112px; }[m
[32m+[m[32m.ui-icon-link { background-position: -240px -112px; }[m
[32m+[m[32m.ui-icon-cancel { background-position: 0 -128px; }[m
[32m+[m[32m.ui-icon-plus { background-position: -16px -128px; }[m
[32m+[m[32m.ui-icon-plusthick { background-position: -32px -128px; }[m
[32m+[m[32m.ui-icon-minus { background-position: -48px -128px; }[m
[32m+[m[32m.ui-icon-minusthick { background-position: -64px -128px; }[m
[32m+[m[32m.ui-icon-close { background-position: -80px -128px; }[m
[32m+[m[32m.ui-icon-closethick { background-position: -96px -128px; }[m
[32m+[m[32m.ui-icon-key { background-position: -112px -128px; }[m
[32m+[m[32m.ui-icon-lightbulb { background-position: -128px -128px; }[m
[32m+[m[32m.ui-icon-scissors { background-position: -144px -128px; }[m
[32m+[m[32m.ui-icon-clipboard { background-position: -160px -128px; }[m
[32m+[m[32m.ui-icon-copy { background-position: -176px -128px; }[m
[32m+[m[32m.ui-icon-contact { background-position: -192px -128px; }[m
[32m+[m[32m.ui-icon-image { background-position: -208px -128px; }[m
[32m+[m[32m.ui-icon-video { background-position: -224px -128px; }[m
[32m+[m[32m.ui-icon-script { background-position: -240px -128px; }[m
[32m+[m[32m.ui-icon-alert { background-position: 0 -144px; }[m
[32m+[m[32m.ui-icon-info { background-position: -16px -144px; }[m
[32m+[m[32m.ui-icon-notice { background-position: -32px -144px; }[m
[32m+[m[32m.ui-icon-help { background-position: -48px -144px; }[m
[32m+[m[32m.ui-icon-check { background-position: -64px -144px; }[m
[32m+[m[32m.ui-icon-bullet { background-position: -80px -144px; }[m
[32m+[m[32m.ui-icon-radio-on { background-position: -96px -144px; }[m
[32m+[m[32m.ui-icon-radio-off { background-position: -112px -144px; }[m
[32m+[m[32m.ui-icon-pin-w { background-position: -128px -144px; }[m
[32m+[m[32m.ui-icon-pin-s { background-position: -144px -144px; }[m
[32m+[m[32m.ui-icon-play { background-position: 0 -160px; }[m
[32m+[m[32m.ui-icon-pause { background-position: -16px -160px; }[m
[32m+[m[32m.ui-icon-seek-next { background-position: -32px -160px; }[m
[32m+[m[32m.ui-icon-seek-prev { background-position: -48px -160px; }[m
[32m+[m[32m.ui-icon-seek-end { background-position: -64px -160px; }[m
[32m+[m[32m.ui-icon-seek-start { background-position: -80px -160px; }[m
[32m+[m[32m/* ui-icon-seek-first is deprecated, use ui-icon-seek-start instead */[m
[32m+[m[32m.ui-icon-seek-first { background-position: -80px -160px; }[m
[32m+[m[32m.ui-icon-stop { background-position: -96px -160px; }[m
[32m+[m[32m.ui-icon-eject { background-position: -112px -160px; }[m
[32m+[m[32m.ui-icon-volume-off { background-position: -128px -160px; }[m
[32m+[m[32m.ui-icon-volume-on { background-position: -144px -160px; }[m
[32m+[m[32m.ui-icon-power { background-position: 0 -176px; }[m
[32m+[m[32m.ui-icon-signal-diag { background-position: -16px -176px; }[m
[32m+[m[32m.ui-icon-signal { background-position: -32px -176px; }[m
[32m+[m[32m.ui-icon-battery-0 { background-position: -48px -176px; }[m
[32m+[m[32m.ui-icon-battery-1 { background-position: -64px -176px; }[m
[32m+[m[32m.ui-icon-battery-2 { background-position: -80px -176px; }[m
[32m+[m[32m.ui-icon-battery-3 { background-position: -96px -176px; }[m
[32m+[m[32m.ui-icon-circle-plus { background-position: 0 -192px; }[m
[32m+[m[32m.ui-icon-circle-minus { background-position: -16px -192px; }[m
[32m+[m[32m.ui-icon-circle-close { background-position: -32px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-e { background-position: -48px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-s { background-position: -64px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-w { background-position: -80px -192px; }[m
[32m+[m[32m.ui-icon-circle-triangle-n { background-position: -96px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-e { background-position: -112px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-s { background-position: -128px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-w { background-position: -144px -192px; }[m
[32m+[m[32m.ui-icon-circle-arrow-n { background-position: -160px -192px; }[m
[32m+[m[32m.ui-icon-circle-zoomin { background-position: -176px -192px; }[m
[32m+[m[32m.ui-icon-circle-zoomout { background-position: -192px -192px; }[m
[32m+[m[32m.ui-icon-circle-check { background-position: -208px -192px; }[m
[32m+[m[32m.ui-icon-circlesmall-plus { background-position: 0 -208px; }[m
[32m+[m[32m.ui-icon-circlesmall-minus { background-position: -16px -208px; }[m
[32m+[m[32m.ui-icon-circlesmall-close { background-position: -32px -208px; }[m
[32m+[m[32m.ui-icon-squaresmall-plus { background-position: -48px -208px; }[m
[32m+[m[32m.ui-icon-squaresmall-minus { background-position: -64px -208px; }[m
[32m+[m[32m.ui-icon-squaresmall-close { background-position: -80px -208px; }[m
[32m+[m[32m.ui-icon-grip-dotted-vertical { background-position: 0 -224px; }[m
[32m+[m[32m.ui-icon-grip-dotted-horizontal { background-position: -16px -224px; }[m
[32m+[m[32m.ui-icon-grip-solid-vertical { background-position: -32px -224px; }[m
[32m+[m[32m.ui-icon-grip-solid-horizontal { background-position: -48px -224px; }[m
[32m+[m[32m.ui-icon-gripsmall-diagonal-se { background-position: -64px -224px; }[m
[32m+[m[32m.ui-icon-grip-diagonal-se { background-position: -80px -224px; }[m
[32m+[m
[32m+[m
[32m+[m[32m/* Misc visuals[m
[32m+[m[32m----------------------------------*/[m
[32m+[m
[32m+[m[32m/* Corner radius */[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-top,[m
[32m+[m[32m.ui-corner-left,[m
[32m+[m[32m.ui-corner-tl {[m
[32m+[m	[32mborder-top-left-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-top,[m
[32m+[m[32m.ui-corner-right,[m
[32m+[m[32m.ui-corner-tr {[m
[32m+[m	[32mborder-top-right-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-bottom,[m
[32m+[m[32m.ui-corner-left,[m
[32m+[m[32m.ui-corner-bl {[m
[32m+[m	[32mborder-bottom-left-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m[32m.ui-corner-all,[m
[32m+[m[32m.ui-corner-bottom,[m
[32m+[m[32m.ui-corner-right,[m
[32m+[m[32m.ui-corner-br {[m
[32m+[m	[32mborder-bottom-right-radius: 3px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Overlays */[m
[32m+[m[32m.ui-widget-overlay {[m
[32m+[m	[32mbackground: #aaaaaa;[m
[32m+[m	[32mopacity: .3;[m
[32m+[m	[32mfilter: Alpha(Opacity=30); /* support: IE8 */[m
[32m+[m[32m}[m
[32m+[m[32m.ui-widget-shadow {[m
[32m+[m	[32m-webkit-box-shadow: 0px 0px 5px #666666;[m
[32m+[m	[32mbox-shadow: 0px 0px 5px #666666;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Content/themes/base/tooltip.css b/Zebra-CMS/Zebra/Content/themes/base/tooltip.css[m
[1mnew file mode 100644[m
[1mindex 0000000..6eb8b91[m
[1m--- /dev/null[m
[1m+++ b/Zebra-CMS/Zebra/Content/themes/base/tooltip.css[m
[36m@@ -0,0 +1,21 @@[m
[32m+[m[32m/*![m
[32m+[m[32m * jQuery UI Tooltip 1.11.4[m
[32m+[m[32m * http://jqueryui.com[m
[32m+[m[32m *[m
[32m+[m[32m * Copyright jQuery Foundation and other contributors[m
[32m+[m[32m * Released under the MIT license.[m
[32m+[m[32m * http://jquery.org/license[m
[32m+[m[32m *[m
[32m+[m[32m * http://api.jqueryui.com/tooltip/#theming[m
[32m+[m[32m */[m
[32m+[m[32m.ui-tooltip {[m
[32m+[m	[32mpadding: 8px;[m
[32m+[m	[32mposition: absolute;[m
[32m+[m	[32mz-index: 9999;[m
[32m+[m	[32mmax-width: 300px;[m
[32m+[m	[32m-webkit-box-shadow: 0 0 5px #aaa;[m
[32m+[m	[32mbox-shadow: 0 0 5px #aaa;[m
[32m+[m[32m}[m
[32m+[m[32mbody .ui-tooltip {[m
[32m+[m	[32mborder-width: 2px;[m
[32m+[m[32m}[m
[1mdiff --git a/Zebra-CMS/Zebra/Controllers/CPanelController.cs b/Zebra-CMS/Zebra/Controllers/CPanelController.cs[m
[1mindex 478606d..3aae6b2 100644[m
[1m--- a/Zebra-CMS/Zebra/Controllers/CPanelController.cs[m
[1m+++ b/Zebra-CMS/Zebra/Controllers/CPanelController.cs[m
[36m@@ -28,11 +28,20 @@[m [mpublic override ActionResult Index()[m
         public ActionResult Editor()[m
         {[m
             Node root = _nodeop.GetRootNode();[m
[31m-            ViewBag.Root = root;[m
[32m+[m[32m            var list = new List<Node>();[m[41m[m
[32m+[m[32m            list.Add(root);[m[41m[m
[32m+[m[32m            ViewBag.Root = list;[m[41m[m
 [m
             return View();[m
         }[m
 [m
[32m+[m[32m        public ActionResult NodeTree(string nodeid)[m[41m[m
[32m+[m[32m        {[m[41m[m
[32m+[m[32m            var list = new List<Node>();[m[41m[m
[32m+[m[32m            list.Add(_nodeop.GetNode(nodeid));[m[41m[m
[32m+[m[32m            return View(list);[m[41m[m
[32m+[m[32m        }[m[41m[m
[32m+[m[41m[m
         // GET: CPanel/Create[m
         public ActionResult Create()[m
         {[m
[1mdiff --git a/Zebra-CMS/Zebra/Scripts/_references.js b/Zebra-CMS/Zebra/Scripts/_references.js[m
[1mindex cbe7a47..a23f1c3 100644[m
Binary files a/Zebra-CMS/Zebra/Scripts/_references.js and b/Zebra-CMS/Zebra/Scripts/_references.js differ
[1mdiff --git a/Zebra-CMS/Zebra/Scripts/jquery-1.10.2.intellisense.js b/Zebra-CMS/Zebra/Scripts/jquery-1.10.2.intellisense.js[m
[1mdeleted file mode 100644[m
[1mindex f1d8325..0000000[m
[1m--- a/Zebra-CMS/Zebra/Scripts/jquery-1.10.2.intellisense.js[m
[1m+++ /dev/null[m
[36m@@ -1,2671 +0,0 @@[m
[31m-﻿/* NUGET: BEGIN LICENSE TEXT[m
[31m- *[m
[31m- * Microsoft grants you the right to use these script files for the sole[m
[31m- * purpose of either: (i) interacting through your browser with the Microsoft[m
[31m- * website or online service, subject to the applicable licensing or use[m
[31m- * terms; or (ii) using the files as included with a Microsoft product subject[m
[31m- * to that product's license terms. Microsoft reserves all other rights to the[m
[31m- * files not expressly granted by Microsoft, whether by implication, estoppel[m
[31m- * or otherwise. Insofar as a script file is dual licensed under GPL,[m
[31m- * Microsoft neither took the code under GPL nor distributes it thereunder but[m
[31m- * under the terms set out in this paragraph. All notices and licenses[m
[31m- * below are for informational purposes only.[m
[31m- *[m
[31m- * NUGET: END LICENSE TEXT */[m
[31m-intellisense.annotate(jQuery, {[m
[31m-  'ajax': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Perform an asynchronous HTTP (Ajax) request.</summary>[m
[31m-    ///   <param name="url" type="String">A string containing the URL to which the request is sent.</param>[m
[31m-    ///   <param name="settings" type="PlainObject">A set of key/value pairs that configure the Ajax request. All settings are optional. A default can be set for any option with $.ajaxSetup(). See jQuery.ajax( settings ) below for a complete list of all settings.</param>[m
[31m-    ///   <returns type="jqXHR" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Perform an asynchronous HTTP (Ajax) request.</summary>[m
[31m-    ///   <param name="settings" type="PlainObject">A set of key/value pairs that configure the Ajax request. All settings are optional. A default can be set for any option with $.ajaxSetup().</param>[m
[31m-    ///   <returns type="jqXHR" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxPrefilter': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Handle custom Ajax options or modify existing options before each request is sent and before they are processed by $.ajax().</summary>[m
[31m-    ///   <param name="dataTypes" type="String">An optional string containing one or more space-separated dataTypes</param>[m
[31m-    ///   <param name="handler(options, originalOptions, jqXHR)" type="Function">A handler to set default values for future Ajax requests.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxSetup': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set default values for future Ajax requests.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A set of key/value pairs that configure the default Ajax request. All options are optional.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxTransport': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Creates an object that handles the actual transmission of Ajax data.</summary>[m
[31m-    ///   <param name="dataType" type="String">A string identifying the data type to use</param>[m
[31m-    ///   <param name="handler(options, originalOptions, jqXHR)" type="Function">A handler to return the new transport object to use with the data type provided in the first argument.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'boxModel': function() {[m
[31m-    /// <summary>Deprecated in jQuery 1.3 (see jQuery.support). States if the current page, in the user's browser, is being rendered using the W3C CSS Box Model.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'browser': function() {[m
[31m-    /// <summary>Contains flags for the useragent, read from navigator.userAgent. We recommend against using this property; please try to use feature detection instead (see jQuery.support). jQuery.browser may be moved to a plugin in a future release of jQuery.</summary>[m
[31m-    /// <returns type="PlainObject" />[m
[31m-  },[m
[31m-  'browser.version': function() {[m
[31m-    /// <summary>The version number of the rendering engine for the user's browser.</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'Callbacks': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>A multi-purpose callbacks list object that provides a powerful way to manage callback lists.</summary>[m
[31m-    ///   <param name="flags" type="String">An optional list of space-separated flags that change how the callback list behaves.</param>[m
[31m-    ///   <returns type="Callbacks" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'contains': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check to see if a DOM element is a descendant of another DOM element.</summary>[m
[31m-    ///   <param name="container" type="Element">The DOM element that may contain the other element.</param>[m
[31m-    ///   <param name="contained" type="Element">The DOM element that may be contained by (a descendant of) the other element.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'cssHooks': function() {[m
[31m-    /// <summary>Hook directly into jQuery to override how particular CSS properties are retrieved or set, normalize CSS property naming, or create custom properties.</summary>[m
[31m-    /// <returns type="Object" />[m
[31m-  },[m
[31m-  'data': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Returns value at named data store for the element, as set by jQuery.data(element, name, value), or the full data store for the element.</summary>[m
[31m-    ///   <param name="element" type="Element">The DOM element to query for the data.</param>[m
[31m-    ///   <param name="key" type="String">Name of the data stored.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Returns value at named data store for the element, as set by jQuery.data(element, name, value), or the full data store for the element.</summary>[m
[31m-    ///   <param name="element" type="Element">The DOM element to query for the data.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'Deferred': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>A constructor function that returns a chainable utility object with methods to register multiple callbacks into callback queues, invoke callback queues, and relay the success or failure state of any synchronous or asynchronous function.</summary>[m
[31m-    ///   <param name="beforeStart" type="Function">A function that is called just before the constructor returns.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'dequeue': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Execute the next function on the queue for the matched element.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element from which to remove and execute a queued function.</param>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'each': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>A generic iterator function, which can be used to seamlessly iterate over both objects and arrays. Arrays and array-like objects with a length property (such as a function's arguments object) are iterated by numeric index, from 0 to length-1. Other objects are iterated via their named properties.</summary>[m
[31m-    ///   <param name="collection" type="Object">The object or array to iterate over.</param>[m
[31m-    ///   <param name="callback(indexInArray, valueOfElement)" type="Function">The function that will be executed on every object.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'error': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Takes a string and throws an exception containing it.</summary>[m
[31m-    ///   <param name="message" type="String">The message to send out.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'extend': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Merge the contents of two or more objects together into the first object.</summary>[m
[31m-    ///   <param name="target" type="Object">An object that will receive the new properties if additional objects are passed in or that will extend the jQuery namespace if it is the sole argument.</param>[m
[31m-    ///   <param name="object1" type="Object">An object containing additional properties to merge in.</param>[m
[31m-    ///   <param name="objectN" type="Object">Additional objects containing properties to merge in.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Merge the contents of two or more objects together into the first object.</summary>[m
[31m-    ///   <param name="deep" type="Boolean">If true, the merge becomes recursive (aka. deep copy).</param>[m
[31m-    ///   <param name="target" type="Object">The object to extend. It will receive the new properties.</param>[m
[31m-    ///   <param name="object1" type="Object">An object containing additional properties to merge in.</param>[m
[31m-    ///   <param name="objectN" type="Object">Additional objects containing properties to merge in.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'get': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Load data from the server using a HTTP GET request.</summary>[m
[31m-    ///   <param name="url" type="String">A string containing the URL to which the request is sent.</param>[m
[31m-    ///   <param name="data" type="String">A plain object or string that is sent to the server with the request.</param>[m
[31m-    ///   <param name="success(data, textStatus, jqXHR)" type="Function">A callback function that is executed if the request succeeds.</param>[m
[31m-    ///   <param name="dataType" type="String">The type of data expected from the server. Default: Intelligent Guess (xml, json, script, or html).</param>[m
[31m-    ///   <returns type="jqXHR" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'getJSON': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Load JSON-encoded data from the server using a GET HTTP request.</summary>[m
[31m-    ///   <param name="url" type="String">A string containing the URL to which the request is sent.</param>[m
[31m-    ///   <param name="data" type="PlainObject">A plain object or string that is sent to the server with the request.</param>[m
[31m-    ///   <param name="success(data, textStatus, jqXHR)" type="Function">A callback function that is executed if the request succeeds.</param>[m
[31m-    ///   <returns type="jqXHR" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'getScript': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Load a JavaScript file from the server using a GET HTTP request, then execute it.</summary>[m
[31m-    ///   <param name="url" type="String">A string containing the URL to which the request is sent.</param>[m
[31m-    ///   <param name="success(script, textStatus, jqXHR)" type="Function">A callback function that is executed if the request succeeds.</param>[m
[31m-    ///   <returns type="jqXHR" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'globalEval': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Execute some JavaScript code globally.</summary>[m
[31m-    ///   <param name="code" type="String">The JavaScript code to execute.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'grep': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Finds the elements of an array which satisfy a filter function. The original array is not affected.</summary>[m
[31m-    ///   <param name="array" type="Array">The array to search through.</param>[m
[31m-    ///   <param name="function(elementOfArray, indexInArray)" type="Function">The function to process each item against.  The first argument to the function is the item, and the second argument is the index.  The function should return a Boolean value.  this will be the global window object.</param>[m
[31m-    ///   <param name="invert" type="Boolean">If "invert" is false, or not provided, then the function returns an array consisting of all elements for which "callback" returns true.  If "invert" is true, then the function returns an array consisting of all elements for which "callback" returns false.</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'hasData': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine whether an element has any jQuery data associated with it.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element to be checked for data.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'holdReady': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Holds or releases the execution of jQuery's ready event.</summary>[m
[31m-    ///   <param name="hold" type="Boolean">Indicates whether the ready hold is being requested or released</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'inArray': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Search for a specified value within an array and return its index (or -1 if not found).</summary>[m
[31m-    ///   <param name="value" type="Anything">The value to search for.</param>[m
[31m-    ///   <param name="array" type="Array">An array through which to search.</param>[m
[31m-    ///   <param name="fromIndex" type="Number">The index of the array at which to begin the search. The default is 0, which will search the whole array.</param>[m
[31m-    ///   <returns type="Number" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isArray': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine whether the argument is an array.</summary>[m
[31m-    ///   <param name="obj" type="Object">Object to test whether or not it is an array.</param>[m
[31m-    ///   <returns type="boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isEmptyObject': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check to see if an object is empty (contains no enumerable properties).</summary>[m
[31m-    ///   <param name="object" type="Object">The object that will be checked to see if it's empty.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isFunction': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine if the argument passed is a Javascript function object.</summary>[m
[31m-    ///   <param name="obj" type="PlainObject">Object to test whether or not it is a function.</param>[m
[31m-    ///   <returns type="boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isNumeric': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determines whether its argument is a number.</summary>[m
[31m-    ///   <param name="value" type="PlainObject">The value to be tested.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isPlainObject': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check to see if an object is a plain object (created using "{}" or "new Object").</summary>[m
[31m-    ///   <param name="object" type="PlainObject">The object that will be checked to see if it's a plain object.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isWindow': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine whether the argument is a window.</summary>[m
[31m-    ///   <param name="obj" type="PlainObject">Object to test whether or not it is a window.</param>[m
[31m-    ///   <returns type="boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isXMLDoc': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check to see if a DOM node is within an XML document (or is an XML document).</summary>[m
[31m-    ///   <param name="node" type="Element">The DOM node that will be checked to see if it's in an XML document.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'makeArray': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Convert an array-like object into a true JavaScript array.</summary>[m
[31m-    ///   <param name="obj" type="PlainObject">Any object to turn into a native Array.</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'map': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Translate all items in an array or object to new array of items.</summary>[m
[31m-    ///   <param name="array" type="Array">The Array to translate.</param>[m
[31m-    ///   <param name="callback(elementOfArray, indexInArray)" type="Function">The function to process each item against.  The first argument to the function is the array item, the second argument is the index in array The function can return any value. Within the function, this refers to the global (window) object.</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Translate all items in an array or object to new array of items.</summary>[m
[31m-    ///   <param name="arrayOrObject" type="Object">The Array or Object to translate.</param>[m
[31m-    ///   <param name="callback( value, indexOrKey )" type="Function">The function to process each item against.  The first argument to the function is the value; the second argument is the index or key of the array or object property. The function can return any value to add to the array. A returned array will be flattened into the resulting array. Within the function, this refers to the global (window) object.</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'merge': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Merge the contents of two arrays together into the first array.</summary>[m
[31m-    ///   <param name="first" type="Array">The first array to merge, the elements of second added.</param>[m
[31m-    ///   <param name="second" type="Array">The second array to merge into the first, unaltered.</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'noConflict': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Relinquish jQuery's control of the $ variable.</summary>[m
[31m-    ///   <param name="removeAll" type="Boolean">A Boolean indicating whether to remove all jQuery variables from the global scope (including jQuery itself).</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'noop': function() {[m
[31m-    /// <summary>An empty function.</summary>[m
[31m-  },[m
[31m-  'now': function() {[m
[31m-    /// <summary>Return a number representing the current time.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-  'param': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Create a serialized representation of an array or object, suitable for use in a URL query string or Ajax request.</summary>[m
[31m-    ///   <param name="obj" type="Object">An array or object to serialize.</param>[m
[31m-    ///   <returns type="String" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Create a serialized representation of an array or object, suitable for use in a URL query string or Ajax request.</summary>[m
[31m-    ///   <param name="obj" type="Object">An array or object to serialize.</param>[m
[31m-    ///   <param name="traditional" type="Boolean">A Boolean indicating whether to perform a traditional "shallow" serialization.</param>[m
[31m-    ///   <returns type="String" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'parseHTML': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Parses a string into an array of DOM nodes.</summary>[m
[31m-    ///   <param name="data" type="String">HTML string to be parsed</param>[m
[31m-    ///   <param name="context" type="Element">DOM element to serve as the context in which the HTML fragment will be created</param>[m
[31m-    ///   <param name="keepScripts" type="Boolean">A Boolean indicating whether to include scripts passed in the HTML string</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'parseJSON': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Takes a well-formed JSON string and returns the resulting JavaScript object.</summary>[m
[31m-    ///   <param name="json" type="String">The JSON string to parse.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'parseXML': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Parses a string into an XML document.</summary>[m
[31m-    ///   <param name="data" type="String">a well-formed XML string to be parsed</param>[m
[31m-    ///   <returns type="XMLDocument" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'post': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Load data from the server using a HTTP POST request.</summary>[m
[31m-    ///   <param name="url" type="String">A string containing the URL to which the request is sent.</param>[m
[31m-    ///   <param name="data" type="String">A plain object or string that is sent to the server with the request.</param>[m
[31m-    ///   <param name="success(data, textStatus, jqXHR)" type="Function">A callback function that is executed if the request succeeds.</param>[m
[31m-    ///   <param name="dataType" type="String">The type of data expected from the server. Default: Intelligent Guess (xml, json, script, text, html).</param>[m
[31m-    ///   <returns type="jqXHR" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'proxy': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Takes a function and returns a new one that will always have a particular context.</summary>[m
[31m-    ///   <param name="function" type="Function">The function whose context will be changed.</param>[m
[31m-    ///   <param name="context" type="PlainObject">The object to which the context (this) of the function should be set.</param>[m
[31m-    ///   <returns type="Function" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Takes a function and returns a new one that will always have a particular context.</summary>[m
[31m-    ///   <param name="context" type="PlainObject">The object to which the context of the function should be set.</param>[m
[31m-    ///   <param name="name" type="String">The name of the function whose context will be changed (should be a property of the context object).</param>[m
[31m-    ///   <returns type="Function" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Takes a function and returns a new one that will always have a particular context.</summary>[m
[31m-    ///   <param name="function" type="Function">The function whose context will be changed.</param>[m
[31m-    ///   <param name="context" type="PlainObject">The object to which the context (this) of the function should be set.</param>[m
[31m-    ///   <param name="additionalArguments" type="Anything">Any number of arguments to be passed to the function referenced in the function argument.</param>[m
[31m-    ///   <returns type="Function" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Takes a function and returns a new one that will always have a particular context.</summary>[m
[31m-    ///   <param name="context" type="PlainObject">The object to which the context of the function should be set.</param>[m
[31m-    ///   <param name="name" type="String">The name of the function whose context will be changed (should be a property of the context object).</param>[m
[31m-    ///   <param name="additionalArguments" type="Anything">Any number of arguments to be passed to the function named in the name argument.</param>[m
[31m-    ///   <returns type="Function" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'queue': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Manipulate the queue of functions to be executed on the matched element.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element where the array of queued functions is attached.</param>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <param name="newQueue" type="Array">An array of functions to replace the current queue contents.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Manipulate the queue of functions to be executed on the matched element.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element on which to add a queued function.</param>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <param name="callback()" type="Function">The new function to add to the queue.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'removeData': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a previously-stored piece of data.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element from which to remove data.</param>[m
[31m-    ///   <param name="name" type="String">A string naming the piece of data to remove.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'sub': function() {[m
[31m-    /// <summary>Creates a new copy of jQuery whose properties and methods can be modified without affecting the original jQuery object.</summary>[m
[31m-    /// <returns type="jQuery" />[m
[31m-  },[m
[31m-  'support': function() {[m
[31m-    /// <summary>A collection of properties that represent the presence of different browser features or bugs. Primarily intended for jQuery's internal use; specific properties may be removed when they are no longer needed internally to improve page startup performance.</summary>[m
[31m-    /// <returns type="Object" />[m
[31m-  },[m
[31m-  'trim': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove the whitespace from the beginning and end of a string.</summary>[m
[31m-    ///   <param name="str" type="String">The string to trim.</param>[m
[31m-    ///   <returns type="String" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'type': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine the internal JavaScript [[Class]] of an object.</summary>[m
[31m-    ///   <param name="obj" type="PlainObject">Object to get the internal JavaScript [[Class]] of.</param>[m
[31m-    ///   <returns type="String" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'unique': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Sorts an array of DOM elements, in place, with the duplicates removed. Note that this only works on arrays of DOM elements, not strings or numbers.</summary>[m
[31m-    ///   <param name="array" type="Array">The Array of DOM elements.</param>[m
[31m-    ///   <returns type="Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'when': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Provides a way to execute callback functions based on one or more objects, usually Deferred objects that represent asynchronous events.</summary>[m
[31m-    ///   <param name="deferreds" type="Deferred">One or more Deferred objects, or plain JavaScript objects.</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-});[m
[31m-[m
[31m-var _1228819969 = jQuery.Callbacks;[m
[31m-jQuery.Callbacks = function(flags) {[m
[31m-var _object = _1228819969(flags);[m
[31m-intellisense.annotate(_object, {[m
[31m-  'add': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add a callback or a collection of callbacks to a callback list.</summary>[m
[31m-    ///   <param name="callbacks" type="Array">A function, or array of functions, that are to be added to the callback list.</param>[m
[31m-    ///   <returns type="Callbacks" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'disable': function() {[m
[31m-    /// <summary>Disable a callback list from doing anything more.</summary>[m
[31m-    /// <returns type="Callbacks" />[m
[31m-  },[m
[31m-  'disabled': function() {[m
[31m-    /// <summary>Determine if the callbacks list has been disabled.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'empty': function() {[m
[31m-    /// <summary>Remove all of the callbacks from a list.</summary>[m
[31m-    /// <returns type="Callbacks" />[m
[31m-  },[m
[31m-  'fire': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Call all of the callbacks with the given arguments</summary>[m
[31m-    ///   <param name="arguments" type="Anything">The argument or list of arguments to pass back to the callback list.</param>[m
[31m-    ///   <returns type="Callbacks" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'fired': function() {[m
[31m-    /// <summary>Determine if the callbacks have already been called at least once.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'fireWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Call all callbacks in a list with the given context and arguments.</summary>[m
[31m-    ///   <param name="context" type="">A reference to the context in which the callbacks in the list should be fired.</param>[m
[31m-    ///   <param name="args" type="">An argument, or array of arguments, to pass to the callbacks in the list.</param>[m
[31m-    ///   <returns type="Callbacks" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'has': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine whether a supplied callback is in a list</summary>[m
[31m-    ///   <param name="callback" type="Function">The callback to search for.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'lock': function() {[m
[31m-    /// <summary>Lock a callback list in its current state.</summary>[m
[31m-    /// <returns type="Callbacks" />[m
[31m-  },[m
[31m-  'locked': function() {[m
[31m-    /// <summary>Determine if the callbacks list has been locked.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'remove': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a callback or a collection of callbacks from a callback list.</summary>[m
[31m-    ///   <param name="callbacks" type="Array">A function, or array of functions, that are to be removed from the callback list.</param>[m
[31m-    ///   <returns type="Callbacks" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-});[m
[31m-[m
[31m-return _object;[m
[31m-};[m
[31m-intellisense.redirectDefinition(jQuery.Callbacks, _1228819969);[m
[31m-[m
[31m-var _731531622 = jQuery.Deferred;[m
[31m-jQuery.Deferred = function(func) {[m
[31m-var _object = _731531622(func);[m
[31m-intellisense.annotate(_object, {[m
[31m-  'always': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object is either resolved or rejected.</summary>[m
[31m-    ///   <param name="alwaysCallbacks" type="Function">A function, or array of functions, that is called when the Deferred is resolved or rejected.</param>[m
[31m-    ///   <param name="alwaysCallbacks" type="Function">Optional additional functions, or arrays of functions, that are called when the Deferred is resolved or rejected.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'done': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object is resolved.</summary>[m
[31m-    ///   <param name="doneCallbacks" type="Function">A function, or array of functions, that are called when the Deferred is resolved.</param>[m
[31m-    ///   <param name="doneCallbacks" type="Function">Optional additional functions, or arrays of functions, that are called when the Deferred is resolved.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'fail': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object is rejected.</summary>[m
[31m-    ///   <param name="failCallbacks" type="Function">A function, or array of functions, that are called when the Deferred is rejected.</param>[m
[31m-    ///   <param name="failCallbacks" type="Function">Optional additional functions, or arrays of functions, that are called when the Deferred is rejected.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'isRejected': function() {[m
[31m-    /// <summary>Determine whether a Deferred object has been rejected.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'isResolved': function() {[m
[31m-    /// <summary>Determine whether a Deferred object has been resolved.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'notify': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Call the progressCallbacks on a Deferred object with the given args.</summary>[m
[31m-    ///   <param name="args" type="Object">Optional arguments that are passed to the progressCallbacks.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'notifyWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Call the progressCallbacks on a Deferred object with the given context and args.</summary>[m
[31m-    ///   <param name="context" type="Object">Context passed to the progressCallbacks as the this object.</param>[m
[31m-    ///   <param name="args" type="Object">Optional arguments that are passed to the progressCallbacks.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'pipe': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Utility method to filter and/or chain Deferreds.</summary>[m
[31m-    ///   <param name="doneFilter" type="Function">An optional function that is called when the Deferred is resolved.</param>[m
[31m-    ///   <param name="failFilter" type="Function">An optional function that is called when the Deferred is rejected.</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Utility method to filter and/or chain Deferreds.</summary>[m
[31m-    ///   <param name="doneFilter" type="Function">An optional function that is called when the Deferred is resolved.</param>[m
[31m-    ///   <param name="failFilter" type="Function">An optional function that is called when the Deferred is rejected.</param>[m
[31m-    ///   <param name="progressFilter" type="Function">An optional function that is called when progress notifications are sent to the Deferred.</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'progress': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object generates progress notifications.</summary>[m
[31m-    ///   <param name="progressCallbacks" type="Function">A function, or array of functions, that is called when the Deferred generates progress notifications.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'promise': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Return a Deferred's Promise object.</summary>[m
[31m-    ///   <param name="target" type="Object">Object onto which the promise methods have to be attached</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'reject': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reject a Deferred object and call any failCallbacks with the given args.</summary>[m
[31m-    ///   <param name="args" type="Object">Optional arguments that are passed to the failCallbacks.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'rejectWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reject a Deferred object and call any failCallbacks with the given context and args.</summary>[m
[31m-    ///   <param name="context" type="Object">Context passed to the failCallbacks as the this object.</param>[m
[31m-    ///   <param name="args" type="Array">An optional array of arguments that are passed to the failCallbacks.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'resolve': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Resolve a Deferred object and call any doneCallbacks with the given args.</summary>[m
[31m-    ///   <param name="args" type="Object">Optional arguments that are passed to the doneCallbacks.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'resolveWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Resolve a Deferred object and call any doneCallbacks with the given context and args.</summary>[m
[31m-    ///   <param name="context" type="Object">Context passed to the doneCallbacks as the this object.</param>[m
[31m-    ///   <param name="args" type="Array">An optional array of arguments that are passed to the doneCallbacks.</param>[m
[31m-    ///   <returns type="Deferred" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'state': function() {[m
[31m-    /// <summary>Determine the current state of a Deferred object.</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'then': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object is resolved, rejected, or still in progress.</summary>[m
[31m-    ///   <param name="doneFilter" type="Function">A function that is called when the Deferred is resolved.</param>[m
[31m-    ///   <param name="failFilter" type="Function">An optional function that is called when the Deferred is rejected.</param>[m
[31m-    ///   <param name="progressFilter" type="Function">An optional function that is called when progress notifications are sent to the Deferred.</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object is resolved, rejected, or still in progress.</summary>[m
[31m-    ///   <param name="doneCallbacks" type="Function">A function, or array of functions, called when the Deferred is resolved.</param>[m
[31m-    ///   <param name="failCallbacks" type="Function">A function, or array of functions, called when the Deferred is rejected.</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add handlers to be called when the Deferred object is resolved, rejected, or still in progress.</summary>[m
[31m-    ///   <param name="doneCallbacks" type="Function">A function, or array of functions, called when the Deferred is resolved.</param>[m
[31m-    ///   <param name="failCallbacks" type="Function">A function, or array of functions, called when the Deferred is rejected.</param>[m
[31m-    ///   <param name="progressCallbacks" type="Function">A function, or array of functions, called when the Deferred notifies progress.</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-});[m
[31m-[m
[31m-return _object;[m
[31m-};[m
[31m-intellisense.redirectDefinition(jQuery.Callbacks, _731531622);[m
[31m-[m
[31m-intellisense.annotate(jQuery.Event.prototype, {[m
[31m-  'currentTarget': function() {[m
[31m-    /// <summary>The current DOM element within the event bubbling phase.</summary>[m
[31m-    /// <returns type="Element" />[m
[31m-  },[m
[31m-  'data': function() {[m
[31m-    /// <summary>An optional object of data passed to an event method when the current executing handler is bound.</summary>[m
[31m-    /// <returns type="Object" />[m
[31m-  },[m
[31m-  'delegateTarget': function() {[m
[31m-    /// <summary>The element where the currently-called jQuery event handler was attached.</summary>[m
[31m-    /// <returns type="Element" />[m
[31m-  },[m
[31m-  'isDefaultPrevented': function() {[m
[31m-    /// <summary>Returns whether event.preventDefault() was ever called on this event object.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'isImmediatePropagationStopped': function() {[m
[31m-    /// <summary>Returns whether event.stopImmediatePropagation() was ever called on this event object.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'isPropagationStopped': function() {[m
[31m-    /// <summary>Returns whether event.stopPropagation() was ever called on this event object.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'metaKey': function() {[m
[31m-    /// <summary>Indicates whether the META key was pressed when the event fired.</summary>[m
[31m-    /// <returns type="Boolean" />[m
[31m-  },[m
[31m-  'namespace': function() {[m
[31m-    /// <summary>The namespace specified when the event was triggered.</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'pageX': function() {[m
[31m-    /// <summary>The mouse position relative to the left edge of the document.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-  'pageY': function() {[m
[31m-    /// <summary>The mouse position relative to the top edge of the document.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-  'preventDefault': function() {[m
[31m-    /// <summary>If this method is called, the default action of the event will not be triggered.</summary>[m
[31m-  },[m
[31m-  'relatedTarget': function() {[m
[31m-    /// <summary>The other DOM element involved in the event, if any.</summary>[m
[31m-    /// <returns type="Element" />[m
[31m-  },[m
[31m-  'result': function() {[m
[31m-    /// <summary>The last value returned by an event handler that was triggered by this event, unless the value was undefined.</summary>[m
[31m-    /// <returns type="Object" />[m
[31m-  },[m
[31m-  'stopImmediatePropagation': function() {[m
[31m-    /// <summary>Keeps the rest of the handlers from being executed and prevents the event from bubbling up the DOM tree.</summary>[m
[31m-  },[m
[31m-  'stopPropagation': function() {[m
[31m-    /// <summary>Prevents the event from bubbling up the DOM tree, preventing any parent handlers from being notified of the event.</summary>[m
[31m-  },[m
[31m-  'target': function() {[m
[31m-    /// <summary>The DOM element that initiated the event.</summary>[m
[31m-    /// <returns type="Element" />[m
[31m-  },[m
[31m-  'timeStamp': function() {[m
[31m-    /// <summary>The difference in milliseconds between the time the browser created the event and January 1, 1970.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-  'type': function() {[m
[31m-    /// <summary>Describes the nature of the event.</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'which': function() {[m
[31m-    /// <summary>For key or mouse events, this property indicates the specific key or button that was pressed.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-});[m
[31m-[m
[31m-intellisense.annotate(jQuery.fn, {[m
[31m-  'add': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add elements to the set of matched elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A string representing a selector expression to find additional elements to add to the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add elements to the set of matched elements.</summary>[m
[31m-    ///   <param name="elements" type="Array">One or more elements to add to the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add elements to the set of matched elements.</summary>[m
[31m-    ///   <param name="html" type="String">An HTML fragment to add to the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add elements to the set of matched elements.</summary>[m
[31m-    ///   <param name="jQuery object" type="jQuery object ">An existing jQuery object to add to the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add elements to the set of matched elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A string representing a selector expression to find additional elements to add to the set of matched elements.</param>[m
[31m-    ///   <param name="context" type="Element">The point in the document at which the selector should begin matching; similar to the context argument of the $(selector, context) method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'addBack': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add the previous set of elements on the stack to the current set, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match the current set of elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'addClass': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Adds the specified class(es) to each of the set of matched elements.</summary>[m
[31m-    ///   <param name="className" type="String">One or more space-separated classes to be added to the class attribute of each matched element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Adds the specified class(es) to each of the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, currentClass)" type="Function">A function returning one or more space-separated class names to be added to the existing class name(s). Receives the index position of the element in the set and the existing class name(s) as arguments. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'after': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, after each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="content" type="jQuery">HTML string, DOM element, or jQuery object to insert after each element in the set of matched elements.</param>[m
[31m-    ///   <param name="content" type="jQuery">One or more additional DOM elements, arrays of elements, HTML strings, or jQuery objects to insert after each element in the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, after each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index)" type="Function">A function that returns an HTML string, DOM element(s), or jQuery object to insert after each element in the set of matched elements. Receives the index position of the element in the set as an argument. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxComplete': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Register a handler to be called when Ajax requests complete. This is an AjaxEvent.</summary>[m
[31m-    ///   <param name="handler(event, XMLHttpRequest, ajaxOptions)" type="Function">The function to be invoked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxError': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Register a handler to be called when Ajax requests complete with an error. This is an Ajax Event.</summary>[m
[31m-    ///   <param name="handler(event, jqXHR, ajaxSettings, thrownError)" type="Function">The function to be invoked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxSend': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a function to be executed before an Ajax request is sent. This is an Ajax Event.</summary>[m
[31m-    ///   <param name="handler(event, jqXHR, ajaxOptions)" type="Function">The function to be invoked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxStart': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Register a handler to be called when the first Ajax request begins. This is an Ajax Event.</summary>[m
[31m-    ///   <param name="handler()" type="Function">The function to be invoked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxStop': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Register a handler to be called when all Ajax requests have completed. This is an Ajax Event.</summary>[m
[31m-    ///   <param name="handler()" type="Function">The function to be invoked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'ajaxSuccess': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a function to be executed whenever an Ajax request completes successfully. This is an Ajax Event.</summary>[m
[31m-    ///   <param name="handler(event, XMLHttpRequest, ajaxOptions)" type="Function">The function to be invoked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'all': function() {[m
[31m-    /// <summary>Selects all elements.</summary>[m
[31m-  },[m
[31m-  'andSelf': function() {[m
[31m-    /// <summary>Add the previous set of elements on the stack to the current set.</summary>[m
[31m-    /// <returns type="jQuery" />[m
[31m-  },[m
[31m-  'animate': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Perform a custom animation of a set of CSS properties.</summary>[m
[31m-    ///   <param name="properties" type="PlainObject">An object of CSS properties and values that the animation will move toward.</param>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Perform a custom animation of a set of CSS properties.</summary>[m
[31m-    ///   <param name="properties" type="PlainObject">An object of CSS properties and values that the animation will move toward.</param>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'animated': function() {[m
[31m-    /// <summary>Select all elements that are in the progress of an animation at the time the selector is run.</summary>[m
[31m-  },[m
[31m-  'append': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, to the end of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="content" type="jQuery">DOM element, HTML string, or jQuery object to insert at the end of each element in the set of matched elements.</param>[m
[31m-    ///   <param name="content" type="jQuery">One or more additional DOM elements, arrays of elements, HTML strings, or jQuery objects to insert at the end of each element in the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, to the end of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, html)" type="Function">A function that returns an HTML string, DOM element(s), or jQuery object to insert at the end of each element in the set of matched elements. Receives the index position of the element in the set and the old HTML value of the element as arguments. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'appendTo': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert every element in the set of matched elements to the end of the target.</summary>[m
[31m-    ///   <param name="target" type="jQuery">A selector, element, HTML string, or jQuery object; the matched set of elements will be inserted at the end of the element(s) specified by this parameter.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attr': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more attributes for the set of matched elements.</summary>[m
[31m-    ///   <param name="attributeName" type="String">The name of the attribute to set.</param>[m
[31m-    ///   <param name="value" type="Number">A value to set for the attribute.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more attributes for the set of matched elements.</summary>[m
[31m-    ///   <param name="attributes" type="PlainObject">An object of attribute-value pairs to set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more attributes for the set of matched elements.</summary>[m
[31m-    ///   <param name="attributeName" type="String">The name of the attribute to set.</param>[m
[31m-    ///   <param name="function(index, attr)" type="Function">A function returning the value to set. this is the current element. Receives the index position of the element in the set and the old attribute value as arguments.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeContains': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute with a value containing the a given substring.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeContainsPrefix': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute with a value either equal to a given string or starting with that string followed by a hyphen (-).</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeContainsWord': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute with a value containing a given word, delimited by spaces.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeEndsWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute with a value ending exactly with a given string. The comparison is case sensitive.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeEquals': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute with a value exactly equal to a certain value.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeHas': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute, with any value.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeMultiple': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Matches elements that match all of the specified attribute filters.</summary>[m
[31m-    ///   <param name="attributeFilter1" type="String">An attribute filter.</param>[m
[31m-    ///   <param name="attributeFilter2" type="String">Another attribute filter, reducing the selection even more</param>[m
[31m-    ///   <param name="attributeFilterN" type="String">As many more attribute filters as necessary</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeNotEqual': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Select elements that either don't have the specified attribute, or do have the specified attribute but not with a certain value.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'attributeStartsWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects elements that have the specified attribute with a value beginning exactly with a given string.</summary>[m
[31m-    ///   <param name="attribute" type="String">An attribute name.</param>[m
[31m-    ///   <param name="value" type="String">An attribute value. Can be either an unquoted single word or a quoted string.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'before': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, before each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="content" type="jQuery">HTML string, DOM element, or jQuery object to insert before each element in the set of matched elements.</param>[m
[31m-    ///   <param name="content" type="jQuery">One or more additional DOM elements, arrays of elements, HTML strings, or jQuery objects to insert before each element in the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, before each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function" type="Function">A function that returns an HTML string, DOM element(s), or jQuery object to insert before each element in the set of matched elements. Receives the index position of the element in the set as an argument. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'bind': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to an event for the elements.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing one or more DOM event types, such as "click" or "submit," or custom event names.</param>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to an event for the elements.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing one or more DOM event types, such as "click" or "submit," or custom event names.</param>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="preventBubble" type="Boolean">Setting the third argument to false will attach a function that prevents the default action from occurring and stops the event from bubbling. The default is true.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to an event for the elements.</summary>[m
[31m-    ///   <param name="events" type="Object">An object containing one or more DOM event types and functions to execute for them.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'blur': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "blur" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "blur" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'button': function() {[m
[31m-    /// <summary>Selects all button elements and elements of type button.</summary>[m
[31m-  },[m
[31m-  'change': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "change" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "change" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'checkbox': function() {[m
[31m-    /// <summary>Selects all elements of type checkbox.</summary>[m
[31m-  },[m
[31m-  'checked': function() {[m
[31m-    /// <summary>Matches all elements that are checked.</summary>[m
[31m-  },[m
[31m-  'child': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all direct child elements specified by "child" of elements specified by "parent".</summary>[m
[31m-    ///   <param name="parent" type="String">Any valid selector.</param>[m
[31m-    ///   <param name="child" type="String">A selector to filter the child elements.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'children': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the children of each element in the set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'class': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements with the given class.</summary>[m
[31m-    ///   <param name="class" type="String">A class to search for. An element can have multiple classes; only one of them must match.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'clearQueue': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove from the queue all items that have not yet been run.</summary>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'click': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "click" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "click" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'clone': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Create a deep copy of the set of matched elements.</summary>[m
[31m-    ///   <param name="withDataAndEvents" type="Boolean">A Boolean indicating whether event handlers should be copied along with the elements. As of jQuery 1.4, element data will be copied as well.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Create a deep copy of the set of matched elements.</summary>[m
[31m-    ///   <param name="withDataAndEvents" type="Boolean">A Boolean indicating whether event handlers and data should be copied along with the elements. The default value is false. *In jQuery 1.5.0 the default value was incorrectly true; it was changed back to false in 1.5.1 and up.</param>[m
[31m-    ///   <param name="deepWithDataAndEvents" type="Boolean">A Boolean indicating whether event handlers and data for all children of the cloned element should be copied. By default its value matches the first argument's value (which defaults to false).</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'closest': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>For each element in the set, get the first element that matches the selector by testing the element itself and traversing up through its ancestors in the DOM tree.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>For each element in the set, get the first element that matches the selector by testing the element itself and traversing up through its ancestors in the DOM tree.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <param name="context" type="Element">A DOM element within which a matching element may be found. If no context is passed in then the context of the jQuery set will be used instead.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>For each element in the set, get the first element that matches the selector by testing the element itself and traversing up through its ancestors in the DOM tree.</summary>[m
[31m-    ///   <param name="jQuery object" type="jQuery">A jQuery object to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>For each element in the set, get the first element that matches the selector by testing the element itself and traversing up through its ancestors in the DOM tree.</summary>[m
[31m-    ///   <param name="element" type="Element">An element to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'contains': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Select all elements that contain the specified text.</summary>[m
[31m-    ///   <param name="text" type="String">A string of text to look for. It's case sensitive.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'contents': function() {[m
[31m-    /// <summary>Get the children of each element in the set of matched elements, including text and comment nodes.</summary>[m
[31m-    /// <returns type="jQuery" />[m
[31m-  },[m
[31m-  'context': function() {[m
[31m-    /// <summary>The DOM node context originally passed to jQuery(); if none was passed then context will likely be the document.</summary>[m
[31m-    /// <returns type="Element" />[m
[31m-  },[m
[31m-  'css': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more CSS properties for the set of matched elements.</summary>[m
[31m-    ///   <param name="propertyName" type="String">A CSS property name.</param>[m
[31m-    ///   <param name="value" type="Number">A value to set for the property.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more CSS properties for the set of matched elements.</summary>[m
[31m-    ///   <param name="propertyName" type="String">A CSS property name.</param>[m
[31m-    ///   <param name="function(index, value)" type="Function">A function returning the value to set. this is the current element. Receives the index position of the element in the set and the old value as arguments.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more CSS properties for the set of matched elements.</summary>[m
[31m-    ///   <param name="properties" type="PlainObject">An object of property-value pairs to set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'data': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Store arbitrary data associated with the matched elements.</summary>[m
[31m-    ///   <param name="key" type="String">A string naming the piece of data to set.</param>[m
[31m-    ///   <param name="value" type="Object">The new data value; it can be any Javascript type including Array or Object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Store arbitrary data associated with the matched elements.</summary>[m
[31m-    ///   <param name="obj" type="Object">An object of key-value pairs of data to update.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'dblclick': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "dblclick" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "dblclick" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'delay': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set a timer to delay execution of subsequent items in the queue.</summary>[m
[31m-    ///   <param name="duration" type="Number">An integer indicating the number of milliseconds to delay execution of the next item in the queue.</param>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'delegate': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to one or more events for all elements that match the selector, now or in the future, based on a specific set of root elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector to filter the elements that trigger the event.</param>[m
[31m-    ///   <param name="eventType" type="String">A string containing one or more space-separated JavaScript event types, such as "click" or "keydown," or custom event names.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute at the time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to one or more events for all elements that match the selector, now or in the future, based on a specific set of root elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector to filter the elements that trigger the event.</param>[m
[31m-    ///   <param name="eventType" type="String">A string containing one or more space-separated JavaScript event types, such as "click" or "keydown," or custom event names.</param>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute at the time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to one or more events for all elements that match the selector, now or in the future, based on a specific set of root elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector to filter the elements that trigger the event.</param>[m
[31m-    ///   <param name="events" type="PlainObject">A plain object of one or more event types and functions to execute for them.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'dequeue': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Execute the next function on the queue for the matched elements.</summary>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'descendant': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements that are descendants of a given ancestor.</summary>[m
[31m-    ///   <param name="ancestor" type="String">Any valid selector.</param>[m
[31m-    ///   <param name="descendant" type="String">A selector to filter the descendant elements.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'detach': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove the set of matched elements from the DOM.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector expression that filters the set of matched elements to be removed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'die': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove event handlers previously attached using .live() from the elements.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as click or keydown.</param>[m
[31m-    ///   <param name="handler" type="String">The function that is no longer to be executed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove event handlers previously attached using .live() from the elements.</summary>[m
[31m-    ///   <param name="events" type="PlainObject">A plain object of one or more event types, such as click or keydown and their corresponding functions that are no longer to be executed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'disabled': function() {[m
[31m-    /// <summary>Selects all elements that are disabled.</summary>[m
[31m-  },[m
[31m-  'each': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Iterate over a jQuery object, executing a function for each matched element.</summary>[m
[31m-    ///   <param name="function(index, Element)" type="Function">A function to execute for each matched element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'element': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements with the given tag name.</summary>[m
[31m-    ///   <param name="element" type="String">An element to search for. Refers to the tagName of DOM nodes.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'empty': function() {[m
[31m-    /// <summary>Select all elements that have no children (including text nodes).</summary>[m
[31m-  },[m
[31m-  'enabled': function() {[m
[31m-    /// <summary>Selects all elements that are enabled.</summary>[m
[31m-  },[m
[31m-  'end': function() {[m
[31m-    /// <summary>End the most recent filtering operation in the current chain and return the set of matched elements to its previous state.</summary>[m
[31m-    /// <returns type="jQuery" />[m
[31m-  },[m
[31m-  'eq': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Select the element at index n within the matched set.</summary>[m
[31m-    ///   <param name="index" type="Number">Zero-based index of the element to match.</param>[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Select the element at index n within the matched set.</summary>[m
[31m-    ///   <param name="-index" type="Number">Zero-based index of the element to match, counting backwards from the last element.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'error': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "error" JavaScript event.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute when the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "error" JavaScript event.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'even': function() {[m
[31m-    /// <summary>Selects even elements, zero-indexed.  See also odd.</summary>[m
[31m-  },[m
[31m-  'fadeIn': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements by fading them to opaque.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements by fading them to opaque.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements by fading them to opaque.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'fadeOut': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements by fading them to transparent.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements by fading them to transparent.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements by fading them to transparent.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'fadeTo': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Adjust the opacity of the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="Number">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="opacity" type="Number">A number between 0 and 1 denoting the target opacity.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Adjust the opacity of the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="Number">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="opacity" type="Number">A number between 0 and 1 denoting the target opacity.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'fadeToggle': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements by animating their opacity.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements by animating their opacity.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'file': function() {[m
[31m-    /// <summary>Selects all elements of type file.</summary>[m
[31m-  },[m
[31m-  'filter': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to those that match the selector or pass the function's test.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match the current set of elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to those that match the selector or pass the function's test.</summary>[m
[31m-    ///   <param name="function(index)" type="Function">A function used as a test for each element in the set. this is the current DOM element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to those that match the selector or pass the function's test.</summary>[m
[31m-    ///   <param name="element" type="Element">An element to match the current set of elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to those that match the selector or pass the function's test.</summary>[m
[31m-    ///   <param name="jQuery object" type="Object">An existing jQuery object to match the current set of elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'find': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the descendants of each element in the current set of matched elements, filtered by a selector, jQuery object, or element.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the descendants of each element in the current set of matched elements, filtered by a selector, jQuery object, or element.</summary>[m
[31m-    ///   <param name="jQuery object" type="Object">A jQuery object to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the descendants of each element in the current set of matched elements, filtered by a selector, jQuery object, or element.</summary>[m
[31m-    ///   <param name="element" type="Element">An element to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'finish': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Stop the currently-running animation, remove all queued animations, and complete all animations for the matched elements.</summary>[m
[31m-    ///   <param name="queue" type="String">The name of the queue in which to stop animations.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'first': function() {[m
[31m-    /// <summary>Selects the first matched element.</summary>[m
[31m-  },[m
[31m-  'first-child': function() {[m
[31m-    /// <summary>Selects all elements that are the first child of their parent.</summary>[m
[31m-  },[m
[31m-  'first-of-type': function() {[m
[31m-    /// <summary>Selects all elements that are the first among siblings of the same element name.</summary>[m
[31m-  },[m
[31m-  'focus': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "focus" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "focus" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'focusin': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "focusin" event.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "focusin" event.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'focusout': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "focusout" JavaScript event.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "focusout" JavaScript event.</summary>[m
[31m-    ///   <param name="eventData" type="Object">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'get': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Retrieve the DOM elements matched by the jQuery object.</summary>[m
[31m-    ///   <param name="index" type="Number">A zero-based integer indicating which element to retrieve.</param>[m
[31m-    ///   <returns type="Element, Array" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'gt': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Select all elements at an index greater than index within the matched set.</summary>[m
[31m-    ///   <param name="index" type="Number">Zero-based index.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'has': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to those that have a descendant that matches the selector or DOM element.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to those that have a descendant that matches the selector or DOM element.</summary>[m
[31m-    ///   <param name="contained" type="Element">A DOM element to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'hasClass': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Determine whether any of the matched elements are assigned the given class.</summary>[m
[31m-    ///   <param name="className" type="String">The class name to search for.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'header': function() {[m
[31m-    /// <summary>Selects all elements that are headers, like h1, h2, h3 and so on.</summary>[m
[31m-  },[m
[31m-  'height': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the CSS height of every matched element.</summary>[m
[31m-    ///   <param name="value" type="Number">An integer representing the number of pixels, or an integer with an optional unit of measure appended (as a string).</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the CSS height of every matched element.</summary>[m
[31m-    ///   <param name="function(index, height)" type="Function">A function returning the height to set. Receives the index position of the element in the set and the old height as arguments. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'hidden': function() {[m
[31m-    /// <summary>Selects all elements that are hidden.</summary>[m
[31m-  },[m
[31m-  'hide': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'hover': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind two handlers to the matched elements, to be executed when the mouse pointer enters and leaves the elements.</summary>[m
[31m-    ///   <param name="handlerIn(eventObject)" type="Function">A function to execute when the mouse pointer enters the element.</param>[m
[31m-    ///   <param name="handlerOut(eventObject)" type="Function">A function to execute when the mouse pointer leaves the element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'html': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the HTML contents of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="htmlString" type="String">A string of HTML to set as the content of each matched element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the HTML contents of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, oldhtml)" type="Function">A function returning the HTML content to set. Receives the           index position of the element in the set and the old HTML value as arguments.           jQuery empties the element before calling the function;           use the oldhtml argument to reference the previous content.           Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'id': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects a single element with the given id attribute.</summary>[m
[31m-    ///   <param name="id" type="String">An ID to search for, specified via the id attribute of an element.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'image': function() {[m
[31m-    /// <summary>Selects all elements of type image.</summary>[m
[31m-  },[m
[31m-  'index': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Search for a given element from among the matched elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector representing a jQuery collection in which to look for an element.</param>[m
[31m-    ///   <returns type="Number" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Search for a given element from among the matched elements.</summary>[m
[31m-    ///   <param name="element" type="jQuery">The DOM element or first element within the jQuery object to look for.</param>[m
[31m-    ///   <returns type="Number" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'init': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression</param>[m
[31m-    ///   <param name="context" type="jQuery">A DOM Element, Document, or jQuery to use as context</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element to wrap in a jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="elementArray" type="Array">An array containing a set of DOM elements to wrap in a jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="object" type="PlainObject">A plain object to wrap in a jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="jQuery object" type="PlainObject">An existing jQuery object to clone.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'innerHeight': function() {[m
[31m-    /// <summary>Get the current computed height for the first element in the set of matched elements, including padding but not border.</summary>[m
[31m-    /// <returns type="Integer" />[m
[31m-  },[m
[31m-  'innerWidth': function() {[m
[31m-    /// <summary>Get the current computed width for the first element in the set of matched elements, including padding but not border.</summary>[m
[31m-    /// <returns type="Integer" />[m
[31m-  },[m
[31m-  'input': function() {[m
[31m-    /// <summary>Selects all input, textarea, select and button elements.</summary>[m
[31m-  },[m
[31m-  'insertAfter': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert every element in the set of matched elements after the target.</summary>[m
[31m-    ///   <param name="target" type="jQuery">A selector, element, HTML string, or jQuery object; the matched set of elements will be inserted after the element(s) specified by this parameter.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'insertBefore': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert every element in the set of matched elements before the target.</summary>[m
[31m-    ///   <param name="target" type="jQuery">A selector, element, HTML string, or jQuery object; the matched set of elements will be inserted before the element(s) specified by this parameter.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'is': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check the current matched set of elements against a selector, element, or jQuery object and return true if at least one of these elements matches the given arguments.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check the current matched set of elements against a selector, element, or jQuery object and return true if at least one of these elements matches the given arguments.</summary>[m
[31m-    ///   <param name="function(index)" type="Function">A function used as a test for the set of elements. It accepts one argument, index, which is the element's index in the jQuery collection.Within the function, this refers to the current DOM element.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check the current matched set of elements against a selector, element, or jQuery object and return true if at least one of these elements matches the given arguments.</summary>[m
[31m-    ///   <param name="jQuery object" type="Object">An existing jQuery object to match the current set of elements against.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Check the current matched set of elements against a selector, element, or jQuery object and return true if at least one of these elements matches the given arguments.</summary>[m
[31m-    ///   <param name="element" type="Element">An element to match the current set of elements against.</param>[m
[31m-    ///   <returns type="Boolean" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'jquery': function() {[m
[31m-    /// <summary>A string containing the jQuery version number.</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'keydown': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "keydown" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "keydown" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'keypress': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "keypress" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "keypress" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'keyup': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "keyup" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "keyup" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'lang': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements of the specified language.</summary>[m
[31m-    ///   <param name="language" type="String">A language code.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'last': function() {[m
[31m-    /// <summary>Selects the last matched element.</summary>[m
[31m-  },[m
[31m-  'last-child': function() {[m
[31m-    /// <summary>Selects all elements that are the last child of their parent.</summary>[m
[31m-  },[m
[31m-  'last-of-type': function() {[m
[31m-    /// <summary>Selects all elements that are the last among siblings of the same element name.</summary>[m
[31m-  },[m
[31m-  'length': function() {[m
[31m-    /// <summary>The number of elements in the jQuery object.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-  'live': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach an event handler for all elements which match the current selector, now and in the future.</summary>[m
[31m-    ///   <param name="events" type="String">A string containing a JavaScript event type, such as "click" or "keydown." As of jQuery 1.4 the string can contain multiple, space-separated event types or custom event names.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute at the time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach an event handler for all elements which match the current selector, now and in the future.</summary>[m
[31m-    ///   <param name="events" type="String">A string containing a JavaScript event type, such as "click" or "keydown." As of jQuery 1.4 the string can contain multiple, space-separated event types or custom event names.</param>[m
[31m-    ///   <param name="data" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute at the time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach an event handler for all elements which match the current selector, now and in the future.</summary>[m
[31m-    ///   <param name="events" type="PlainObject">A plain object of one or more JavaScript event types and functions to execute for them.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'load': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "load" JavaScript event.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute when the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "load" JavaScript event.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'lt': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Select all elements at an index less than index within the matched set.</summary>[m
[31m-    ///   <param name="index" type="Number">Zero-based index.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'map': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Pass each element in the current matched set through a function, producing a new jQuery object containing the return values.</summary>[m
[31m-    ///   <param name="callback(index, domElement)" type="Function">A function object that will be invoked for each element in the current set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mousedown': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mousedown" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mousedown" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mouseenter': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to be fired when the mouse enters an element, or trigger that handler on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to be fired when the mouse enters an element, or trigger that handler on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mouseleave': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to be fired when the mouse leaves an element, or trigger that handler on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to be fired when the mouse leaves an element, or trigger that handler on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mousemove': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mousemove" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mousemove" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mouseout': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mouseout" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mouseout" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mouseover': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mouseover" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mouseover" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'mouseup': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mouseup" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "mouseup" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'multiple': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects the combined results of all the specified selectors.</summary>[m
[31m-    ///   <param name="selector1" type="String">Any valid selector.</param>[m
[31m-    ///   <param name="selector2" type="String">Another valid selector.</param>[m
[31m-    ///   <param name="selectorN" type="String">As many more valid selectors as you like.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'next': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the immediately following sibling of each element in the set of matched elements. If a selector is provided, it retrieves the next sibling only if it matches that selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'next adjacent': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all next elements matching "next" that are immediately preceded by a sibling "prev".</summary>[m
[31m-    ///   <param name="prev" type="String">Any valid selector.</param>[m
[31m-    ///   <param name="next" type="String">A selector to match the element that is next to the first selector.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'next siblings': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all sibling elements that follow after the "prev" element, have the same parent, and match the filtering "siblings" selector.</summary>[m
[31m-    ///   <param name="prev" type="String">Any valid selector.</param>[m
[31m-    ///   <param name="siblings" type="String">A selector to filter elements that are the following siblings of the first selector.</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'nextAll': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get all following siblings of each element in the set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'nextUntil': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get all following siblings of each element up to but not including the element matched by the selector, DOM node, or jQuery object passed.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to indicate where to stop matching following sibling elements.</param>[m
[31m-    ///   <param name="filter" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get all following siblings of each element up to but not including the element matched by the selector, DOM node, or jQuery object passed.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM node or jQuery object indicating where to stop matching following sibling elements.</param>[m
[31m-    ///   <param name="filter" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'not': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove elements from the set of matched elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove elements from the set of matched elements.</summary>[m
[31m-    ///   <param name="elements" type="Array">One or more DOM elements to remove from the matched set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove elements from the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index)" type="Function">A function used as a test for each element in the set. this is the current DOM element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove elements from the set of matched elements.</summary>[m
[31m-    ///   <param name="jQuery object" type="PlainObject">An existing jQuery object to match the current set of elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'nth-child': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements that are the nth-child of their parent.</summary>[m
[31m-    ///   <param name="index" type="String">The index of each child to match, starting with 1, the string even or odd, or an equation ( eg. :nth-child(even), :nth-child(4n) )</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'nth-last-child': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements that are the nth-child of their parent, counting from the last element to the first.</summary>[m
[31m-    ///   <param name="index" type="String">The index of each child to match, starting with the last one (1), the string even or odd, or an equation ( eg. :nth-last-child(even), :nth-last-child(4n) )</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'nth-last-of-type': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements that are the nth-child of their parent, counting from the last element to the first.</summary>[m
[31m-    ///   <param name="index" type="String">The index of each child to match, starting with the last one (1), the string even or odd, or an equation ( eg. :nth-last-of-type(even), :nth-last-of-type(4n) )</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'nth-of-type': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects all elements that are the nth child of their parent in relation to siblings with the same element name.</summary>[m
[31m-    ///   <param name="index" type="String">The index of each child to match, starting with 1, the string even or odd, or an equation ( eg. :nth-of-type(even), :nth-of-type(4n) )</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'odd': function() {[m
[31m-    /// <summary>Selects odd elements, zero-indexed.  See also even.</summary>[m
[31m-  },[m
[31m-  'off': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove an event handler.</summary>[m
[31m-    ///   <param name="events" type="String">One or more space-separated event types and optional namespaces, or just namespaces, such as "click", "keydown.myPlugin", or ".myPlugin".</param>[m
[31m-    ///   <param name="selector" type="String">A selector which should match the one originally passed to .on() when attaching event handlers.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A handler function previously attached for the event(s), or the special value false.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove an event handler.</summary>[m
[31m-    ///   <param name="events" type="PlainObject">An object where the string keys represent one or more space-separated event types and optional namespaces, and the values represent handler functions previously attached for the event(s).</param>[m
[31m-    ///   <param name="selector" type="String">A selector which should match the one originally passed to .on() when attaching event handlers.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'offset': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the current coordinates of every element in the set of matched elements, relative to the document.</summary>[m
[31m-    ///   <param name="coordinates" type="PlainObject">An object containing the properties top and left, which are integers indicating the new top and left coordinates for the elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the current coordinates of every element in the set of matched elements, relative to the document.</summary>[m
[31m-    ///   <param name="function(index, coords)" type="Function">A function to return the coordinates to set. Receives the index of the element in the collection as the first argument and the current coordinates as the second argument. The function should return an object with the new top and left properties.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'offsetParent': function() {[m
[31m-    /// <summary>Get the closest ancestor element that is positioned.</summary>[m
[31m-    /// <returns type="jQuery" />[m
[31m-  },[m
[31m-  'on': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach an event handler function for one or more events to the selected elements.</summary>[m
[31m-    ///   <param name="events" type="String">One or more space-separated event types and optional namespaces, such as "click" or "keydown.myPlugin".</param>[m
[31m-    ///   <param name="selector" type="String">A selector string to filter the descendants of the selected elements that trigger the event. If the selector is null or omitted, the event is always triggered when it reaches the selected element.</param>[m
[31m-    ///   <param name="data" type="Anything">Data to be passed to the handler in event.data when an event is triggered.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute when the event is triggered. The value false is also allowed as a shorthand for a function that simply does return false.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach an event handler function for one or more events to the selected elements.</summary>[m
[31m-    ///   <param name="events" type="PlainObject">An object in which the string keys represent one or more space-separated event types and optional namespaces, and the values represent a handler function to be called for the event(s).</param>[m
[31m-    ///   <param name="selector" type="String">A selector string to filter the descendants of the selected elements that will call the handler. If the selector is null or omitted, the handler is always called when it reaches the selected element.</param>[m
[31m-    ///   <param name="data" type="Anything">Data to be passed to the handler in event.data when an event occurs.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'one': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to an event for the elements. The handler is executed at most once per element.</summary>[m
[31m-    ///   <param name="events" type="String">A string containing one or more JavaScript event types, such as "click" or "submit," or custom event names.</param>[m
[31m-    ///   <param name="data" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute at the time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to an event for the elements. The handler is executed at most once per element.</summary>[m
[31m-    ///   <param name="events" type="String">One or more space-separated event types and optional namespaces, such as "click" or "keydown.myPlugin".</param>[m
[31m-    ///   <param name="selector" type="String">A selector string to filter the descendants of the selected elements that trigger the event. If the selector is null or omitted, the event is always triggered when it reaches the selected element.</param>[m
[31m-    ///   <param name="data" type="Anything">Data to be passed to the handler in event.data when an event is triggered.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute when the event is triggered. The value false is also allowed as a shorthand for a function that simply does return false.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Attach a handler to an event for the elements. The handler is executed at most once per element.</summary>[m
[31m-    ///   <param name="events" type="PlainObject">An object in which the string keys represent one or more space-separated event types and optional namespaces, and the values represent a handler function to be called for the event(s).</param>[m
[31m-    ///   <param name="selector" type="String">A selector string to filter the descendants of the selected elements that will call the handler. If the selector is null or omitted, the handler is always called when it reaches the selected element.</param>[m
[31m-    ///   <param name="data" type="Anything">Data to be passed to the handler in event.data when an event occurs.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'only-child': function() {[m
[31m-    /// <summary>Selects all elements that are the only child of their parent.</summary>[m
[31m-  },[m
[31m-  'only-of-type': function() {[m
[31m-    /// <summary>Selects all elements that have no siblings with the same element name.</summary>[m
[31m-  },[m
[31m-  'outerHeight': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the current computed height for the first element in the set of matched elements, including padding, border, and optionally margin. Returns an integer (without "px") representation of the value or null if called on an empty set of elements.</summary>[m
[31m-    ///   <param name="includeMargin" type="Boolean">A Boolean indicating whether to include the element's margin in the calculation.</param>[m
[31m-    ///   <returns type="Integer" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'outerWidth': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the current computed width for the first element in the set of matched elements, including padding and border.</summary>[m
[31m-    ///   <param name="includeMargin" type="Boolean">A Boolean indicating whether to include the element's margin in the calculation.</param>[m
[31m-    ///   <returns type="Integer" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'parent': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the parent of each element in the current set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'parents': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the ancestors of each element in the current set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'parentsUntil': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the ancestors of each element in the current set of matched elements, up to but not including the element matched by the selector, DOM node, or jQuery object.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to indicate where to stop matching ancestor elements.</param>[m
[31m-    ///   <param name="filter" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the ancestors of each element in the current set of matched elements, up to but not including the element matched by the selector, DOM node, or jQuery object.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM node or jQuery object indicating where to stop matching ancestor elements.</param>[m
[31m-    ///   <param name="filter" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'password': function() {[m
[31m-    /// <summary>Selects all elements of type password.</summary>[m
[31m-  },[m
[31m-  'position': function() {[m
[31m-    /// <summary>Get the current coordinates of the first element in the set of matched elements, relative to the offset parent.</summary>[m
[31m-    /// <returns type="Object" />[m
[31m-  },[m
[31m-  'prepend': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, to the beginning of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="content" type="jQuery">DOM element, array of elements, HTML string, or jQuery object to insert at the beginning of each element in the set of matched elements.</param>[m
[31m-    ///   <param name="content" type="jQuery">One or more additional DOM elements, arrays of elements, HTML strings, or jQuery objects to insert at the beginning of each element in the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert content, specified by the parameter, to the beginning of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, html)" type="Function">A function that returns an HTML string, DOM element(s), or jQuery object to insert at the beginning of each element in the set of matched elements. Receives the index position of the element in the set and the old HTML value of the element as arguments. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'prependTo': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Insert every element in the set of matched elements to the beginning of the target.</summary>[m
[31m-    ///   <param name="target" type="jQuery">A selector, element, HTML string, or jQuery object; the matched set of elements will be inserted at the beginning of the element(s) specified by this parameter.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'prev': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the immediately preceding sibling of each element in the set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'prevAll': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get all preceding siblings of each element in the set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'prevUntil': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get all preceding siblings of each element up to but not including the element matched by the selector, DOM node, or jQuery object.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to indicate where to stop matching preceding sibling elements.</param>[m
[31m-    ///   <param name="filter" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get all preceding siblings of each element up to but not including the element matched by the selector, DOM node, or jQuery object.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM node or jQuery object indicating where to stop matching preceding sibling elements.</param>[m
[31m-    ///   <param name="filter" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'promise': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Return a Promise object to observe when all actions of a certain type bound to the collection, queued or not, have finished.</summary>[m
[31m-    ///   <param name="type" type="String">The type of queue that needs to be observed.</param>[m
[31m-    ///   <param name="target" type="PlainObject">Object onto which the promise methods have to be attached</param>[m
[31m-    ///   <returns type="Promise" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'prop': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more properties for the set of matched elements.</summary>[m
[31m-    ///   <param name="propertyName" type="String">The name of the property to set.</param>[m
[31m-    ///   <param name="value" type="Boolean">A value to set for the property.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more properties for the set of matched elements.</summary>[m
[31m-    ///   <param name="properties" type="PlainObject">An object of property-value pairs to set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set one or more properties for the set of matched elements.</summary>[m
[31m-    ///   <param name="propertyName" type="String">The name of the property to set.</param>[m
[31m-    ///   <param name="function(index, oldPropertyValue)" type="Function">A function returning the value to set. Receives the index position of the element in the set and the old property value as arguments. Within the function, the keyword this refers to the current element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'pushStack': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add a collection of DOM elements onto the jQuery stack.</summary>[m
[31m-    ///   <param name="elements" type="Array">An array of elements to push onto the stack and make into a new jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add a collection of DOM elements onto the jQuery stack.</summary>[m
[31m-    ///   <param name="elements" type="Array">An array of elements to push onto the stack and make into a new jQuery object.</param>[m
[31m-    ///   <param name="name" type="String">The name of a jQuery method that generated the array of elements.</param>[m
[31m-    ///   <param name="arguments" type="Array">The arguments that were passed in to the jQuery method (for serialization).</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'queue': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Manipulate the queue of functions to be executed, once for each matched element.</summary>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <param name="newQueue" type="Array">An array of functions to replace the current queue contents.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Manipulate the queue of functions to be executed, once for each matched element.</summary>[m
[31m-    ///   <param name="queueName" type="String">A string containing the name of the queue. Defaults to fx, the standard effects queue.</param>[m
[31m-    ///   <param name="callback( next )" type="Function">The new function to add to the queue, with a function to call that will dequeue the next item.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'radio': function() {[m
[31m-    /// <summary>Selects all  elements of type radio.</summary>[m
[31m-  },[m
[31m-  'ready': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Specify a function to execute when the DOM is fully loaded.</summary>[m
[31m-    ///   <param name="handler" type="Function">A function to execute after the DOM is ready.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'remove': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove the set of matched elements from the DOM.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector expression that filters the set of matched elements to be removed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'removeAttr': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove an attribute from each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="attributeName" type="String">An attribute to remove; as of version 1.7, it can be a space-separated list of attributes.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'removeClass': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a single class, multiple classes, or all classes from each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="className" type="String">One or more space-separated classes to be removed from the class attribute of each matched element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a single class, multiple classes, or all classes from each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, class)" type="Function">A function returning one or more space-separated class names to be removed. Receives the index position of the element in the set and the old class value as arguments.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'removeData': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a previously-stored piece of data.</summary>[m
[31m-    ///   <param name="name" type="String">A string naming the piece of data to delete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a previously-stored piece of data.</summary>[m
[31m-    ///   <param name="list" type="String">An array or space-separated string naming the pieces of data to delete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'removeProp': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a property for the set of matched elements.</summary>[m
[31m-    ///   <param name="propertyName" type="String">The name of the property to remove.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'replaceAll': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Replace each target element with the set of matched elements.</summary>[m
[31m-    ///   <param name="target" type="String">A selector expression indicating which element(s) to replace.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'replaceWith': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Replace each element in the set of matched elements with the provided new content and return the set of elements that was removed.</summary>[m
[31m-    ///   <param name="newContent" type="jQuery">The content to insert. May be an HTML string, DOM element, or jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Replace each element in the set of matched elements with the provided new content and return the set of elements that was removed.</summary>[m
[31m-    ///   <param name="function" type="Function">A function that returns content with which to replace the set of matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'reset': function() {[m
[31m-    /// <summary>Selects all elements of type reset.</summary>[m
[31m-  },[m
[31m-  'resize': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "resize" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "resize" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'root': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Selects the element that is the root of the document.</summary>[m
[31m-    ///   <param name="index" type="String">The index of each child to match, starting with 1, the string even or odd, or an equation ( eg. :nth-last-child(even), :nth-last-child(4n) )</param>[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'scroll': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "scroll" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "scroll" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'scrollLeft': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the current horizontal position of the scroll bar for each of the set of matched elements.</summary>[m
[31m-    ///   <param name="value" type="Number">An integer indicating the new position to set the scroll bar to.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'scrollTop': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the current vertical position of the scroll bar for each of the set of matched elements.</summary>[m
[31m-    ///   <param name="value" type="Number">An integer indicating the new position to set the scroll bar to.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'select': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "select" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "select" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'selected': function() {[m
[31m-    /// <summary>Selects all elements that are selected.</summary>[m
[31m-  },[m
[31m-  'selector': function() {[m
[31m-    /// <summary>A selector representing selector originally passed to jQuery().</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'serialize': function() {[m
[31m-    /// <summary>Encode a set of form elements as a string for submission.</summary>[m
[31m-    /// <returns type="String" />[m
[31m-  },[m
[31m-  'serializeArray': function() {[m
[31m-    /// <summary>Encode a set of form elements as an array of names and values.</summary>[m
[31m-    /// <returns type="Array" />[m
[31m-  },[m
[31m-  'show': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'siblings': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Get the siblings of each element in the set of matched elements, optionally filtered by a selector.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression to match elements against.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'size': function() {[m
[31m-    /// <summary>Return the number of elements in the jQuery object.</summary>[m
[31m-    /// <returns type="Number" />[m
[31m-  },[m
[31m-  'slice': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Reduce the set of matched elements to a subset specified by a range of indices.</summary>[m
[31m-    ///   <param name="start" type="Number">An integer indicating the 0-based position at which the elements begin to be selected. If negative, it indicates an offset from the end of the set.</param>[m
[31m-    ///   <param name="end" type="Number">An integer indicating the 0-based position at which the elements stop being selected. If negative, it indicates an offset from the end of the set. If omitted, the range continues until the end of the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'slideDown': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'slideToggle': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'slideUp': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Hide the matched elements with a sliding motion.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'stop': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Stop the currently-running animation on the matched elements.</summary>[m
[31m-    ///   <param name="clearQueue" type="Boolean">A Boolean indicating whether to remove queued animation as well. Defaults to false.</param>[m
[31m-    ///   <param name="jumpToEnd" type="Boolean">A Boolean indicating whether to complete the current animation immediately. Defaults to false.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Stop the currently-running animation on the matched elements.</summary>[m
[31m-    ///   <param name="queue" type="String">The name of the queue in which to stop animations.</param>[m
[31m-    ///   <param name="clearQueue" type="Boolean">A Boolean indicating whether to remove queued animation as well. Defaults to false.</param>[m
[31m-    ///   <param name="jumpToEnd" type="Boolean">A Boolean indicating whether to complete the current animation immediately. Defaults to false.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'submit': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "submit" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "submit" JavaScript event, or trigger that event on an element.</summary>[m
[31m-    ///   <param name="eventData" type="PlainObject">An object containing data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'target': function() {[m
[31m-    /// <summary>Selects the target element indicated by the fragment identifier of the document's URI.</summary>[m
[31m-  },[m
[31m-  'text': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the content of each element in the set of matched elements to the specified text.</summary>[m
[31m-    ///   <param name="textString" type="String">A string of text to set as the content of each matched element.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the content of each element in the set of matched elements to the specified text.</summary>[m
[31m-    ///   <param name="function(index, text)" type="Function">A function returning the text content to set. Receives the index position of the element in the set and the old text value as arguments.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'toArray': function() {[m
[31m-    /// <summary>Retrieve all the DOM elements contained in the jQuery set, as an array.</summary>[m
[31m-    /// <returns type="Array" />[m
[31m-  },[m
[31m-  'toggle': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements.</summary>[m
[31m-    ///   <param name="options" type="PlainObject">A map of additional options to pass to the method.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements.</summary>[m
[31m-    ///   <param name="duration" type="">A string or number determining how long the animation will run.</param>[m
[31m-    ///   <param name="easing" type="String">A string indicating which easing function to use for the transition.</param>[m
[31m-    ///   <param name="complete" type="Function">A function to call once the animation is complete.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Display or hide the matched elements.</summary>[m
[31m-    ///   <param name="showOrHide" type="Boolean">A Boolean indicating whether to show or hide the elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'toggleClass': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add or remove one or more classes from each element in the set of matched elements, depending on either the class's presence or the value of the switch argument.</summary>[m
[31m-    ///   <param name="className" type="String">One or more class names (separated by spaces) to be toggled for each element in the matched set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add or remove one or more classes from each element in the set of matched elements, depending on either the class's presence or the value of the switch argument.</summary>[m
[31m-    ///   <param name="className" type="String">One or more class names (separated by spaces) to be toggled for each element in the matched set.</param>[m
[31m-    ///   <param name="switch" type="Boolean">A Boolean (not just truthy/falsy) value to determine whether the class should be added or removed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add or remove one or more classes from each element in the set of matched elements, depending on either the class's presence or the value of the switch argument.</summary>[m
[31m-    ///   <param name="switch" type="Boolean">A boolean value to determine whether the class should be added or removed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Add or remove one or more classes from each element in the set of matched elements, depending on either the class's presence or the value of the switch argument.</summary>[m
[31m-    ///   <param name="function(index, class, switch)" type="Function">A function that returns class names to be toggled in the class attribute of each element in the matched set. Receives the index position of the element in the set, the old class value, and the switch as arguments.</param>[m
[31m-    ///   <param name="switch" type="Boolean">A boolean value to determine whether the class should be added or removed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'trigger': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Execute all handlers and behaviors attached to the matched elements for the given event type.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as click or submit.</param>[m
[31m-    ///   <param name="extraParameters" type="PlainObject">Additional parameters to pass along to the event handler.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Execute all handlers and behaviors attached to the matched elements for the given event type.</summary>[m
[31m-    ///   <param name="event" type="Event">A jQuery.Event object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'triggerHandler': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Execute all handlers attached to an element for an event.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as click or submit.</param>[m
[31m-    ///   <param name="extraParameters" type="Array">An array of additional parameters to pass along to the event handler.</param>[m
[31m-    ///   <returns type="Object" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'unbind': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a previously-attached event handler from the elements.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as click or submit.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">The function that is to be no longer executed.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a previously-attached event handler from the elements.</summary>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as click or submit.</param>[m
[31m-    ///   <param name="false" type="Boolean">Unbinds the corresponding 'return false' function that was bound using .bind( eventType, false ).</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a previously-attached event handler from the elements.</summary>[m
[31m-    ///   <param name="event" type="Object">A JavaScript event object as passed to an event handler.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'undelegate': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a handler from the event for all elements which match the current selector, based upon a specific set of root elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector which will be used to filter the event results.</param>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as "click" or "keydown"</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a handler from the event for all elements which match the current selector, based upon a specific set of root elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector which will be used to filter the event results.</param>[m
[31m-    ///   <param name="eventType" type="String">A string containing a JavaScript event type, such as "click" or "keydown"</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute at the time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a handler from the event for all elements which match the current selector, based upon a specific set of root elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A selector which will be used to filter the event results.</param>[m
[31m-    ///   <param name="events" type="PlainObject">An object of one or more event types and previously bound functions to unbind from them.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Remove a handler from the event for all elements which match the current selector, based upon a specific set of root elements.</summary>[m
[31m-    ///   <param name="namespace" type="String">A string containing a namespace to unbind all events from.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'unload': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "unload" JavaScript event.</summary>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute when the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Bind an event handler to the "unload" JavaScript event.</summary>[m
[31m-    ///   <param name="eventData" type="Object">A plain object of data that will be passed to the event handler.</param>[m
[31m-    ///   <param name="handler(eventObject)" type="Function">A function to execute each time the event is triggered.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'unwrap': function() {[m
[31m-    /// <summary>Remove the parents of the set of matched elements from the DOM, leaving the matched elements in their place.</summary>[m
[31m-    /// <returns type="jQuery" />[m
[31m-  },[m
[31m-  'val': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the value of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="value" type="Array">A string of text or an array of strings corresponding to the value of each matched element to set as selected/checked.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the value of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, value)" type="Function">A function returning the value to set. this is the current element. Receives the index position of the element in the set and the old value as arguments.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'visible': function() {[m
[31m-    /// <summary>Selects all elements that are visible.</summary>[m
[31m-  },[m
[31m-  'width': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the CSS width of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="value" type="Number">An integer representing the number of pixels, or an integer along with an optional unit of measure appended (as a string).</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Set the CSS width of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index, width)" type="Function">A function returning the width to set. Receives the index position of the element in the set and the old width as arguments. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'wrap': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Wrap an HTML structure around each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="wrappingElement" type="jQuery">An HTML snippet, selector expression, jQuery object, or DOM element specifying the structure to wrap around the matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Wrap an HTML structure around each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index)" type="Function">A callback function returning the HTML content or jQuery object to wrap around the matched elements. Receives the index position of the element in the set as an argument. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'wrapAll': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Wrap an HTML structure around all elements in the set of matched elements.</summary>[m
[31m-    ///   <param name="wrappingElement" type="jQuery">An HTML snippet, selector expression, jQuery object, or DOM element specifying the structure to wrap around the matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-  'wrapInner': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Wrap an HTML structure around the content of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="wrappingElement" type="String">An HTML snippet, selector expression, jQuery object, or DOM element specifying the structure to wrap around the content of the matched elements.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Wrap an HTML structure around the content of each element in the set of matched elements.</summary>[m
[31m-    ///   <param name="function(index)" type="Function">A callback function which generates a structure to wrap around the content of the matched elements. Receives the index position of the element in the set as an argument. Within the function, this refers to the current element in the set.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-});[m
[31m-[m
[31m-intellisense.annotate(window, {[m
[31m-  '$': function() {[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="selector" type="String">A string containing a selector expression</param>[m
[31m-    ///   <param name="context" type="jQuery">A DOM Element, Document, or jQuery to use as context</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="element" type="Element">A DOM element to wrap in a jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="elementArray" type="Array">An array containing a set of DOM elements to wrap in a jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="object" type="PlainObject">A plain object to wrap in a jQuery object.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-    /// <signature>[m
[31m-    ///   <summary>Accepts a string containing a CSS selector which is then used to match a set of elements.</summary>[m
[31m-    ///   <param name="jQuery object" type="PlainObject">An existing jQuery object to clone.</param>[m
[31m-    ///   <returns type="jQuery" />[m
[31m-    /// </signature>[m
[31m-  },[m
[31m-});[m
[31m-[m
[1mdiff --git a/Zebra-CMS/Zebra/Scripts/jquery-1.10.2.js b/Zebra-CMS/Zebra/Scripts/jquery-1.10.2.js[m
[1mdeleted file mode 100644[m
[1mindex d3e121b..0000000[m
[1m--- a/Zebra-CMS/Zebra/Scripts/jquery-1.10.2.js[m
[1m+++ /dev/null[m
[36m@@ -1,9803 +0,0 @@[m
[31m-/* NUGET: BEGIN LICENSE TEXT[m
[31m- *[m
[31m- * Microsoft grants you the right to use these script files for the sole[m
[31m- * purpose of either: (i) interacting through your browser with the Microsoft[m
[31m- * website or online service, subject to the applicable licensing or use[m
[31m- * terms; or (ii) using the files as included with a Microsoft product subject[m
[31m- * to that product's license terms. Microsoft reserves all other rights to the[m
[31m- * files not expressly granted by Microsoft, whether by implication, estoppel[m
[31m- * or otherwise. Insofar as a script file is dual licensed under GPL,[m
[31m- * Microsoft neither took the code under GPL nor distributes it thereunder but[m
[31m- * under the terms set out in this paragraph. All notices and licenses[m
[31m- * below are for informational purposes only.[m
[31m- *[m
[31m- * NUGET: END LICENSE TEXT */[m
[31m-/*![m
[31m- * jQuery JavaScript Library v1.10.2[m
[31m- * http://jquery.com/[m
[31m- *[m
[31m- * Includes Sizzle.js[m
[31m- * http://sizzlejs.com/[m
[31m- *[m
[31m- * Copyright 2005, 2013 jQuery Foundation, Inc. and other contributors[m
[31m- * Released under the MIT license[m
[31m- * http://jquery.org/license[m
[31m- *[m
[31m- * Date: 2013-07-03T13:48Z[m
[31m- */[m
[31m-(function( window, undefined ) {[m
[31m-[m
[31m-// Can't do this because several apps including ASP.NET trace[m
[31m-// the stack via arguments.caller.callee and Firefox dies if[m
[31m-// you try to trace through "use strict" call chains. (#13335)[m
[31m-// Support: Firefox 18+[m
[31m-//"use strict";[m
[31m-var[m
[31m-	// The deferred used on DOM ready[m
[31m-	readyList,[m
[31m-[m
[31m-	// A central reference to the root jQuery(document)[m
[31m-	rootjQuery,[m
[31m-[m
[31m-	// Support: IE<10[m
[31m-	// For `typeof xmlNode.method` instead of `xmlNode.method !== undefined`[m
[31m-	core_strundefined = typeof undefined,[m
[31m-[m
[31m-	// Use the correct document accordingly with window argument (sandbox)[m
[31m-	location = window.location,[m
[31m-	document = window.document,[m
[31m-	docElem = document.documentElement,[m
[31m-[m
[31m-	// Map over jQuery in case of overwrite[m
[31m-	_jQuery = window.jQuery,[m
[31m-[m
[31m-	// Map over the $ in case of overwrite[m
[31m-	_$ = window.$,[m
[31m-[m
[31m-	// [[Class]] -> type pairs[m
[31m-	class2type = {},[m
[31m-[m
[31m-	// List of deleted data cache ids, so we can reuse them[m
[31m-	core_deletedIds = [],[m
[31m-[m
[31m-	core_version = "1.10.2",[m
[31m-[m
[31m-	// Save a reference to some core methods[m
[31m-	core_concat = core_deletedIds.concat,[m
[31m-	core_push = core_deletedIds.push,[m
[31m-	core_slice = core_deletedIds.slice,[m
[31m-	core_indexOf = core_deletedIds.indexOf,[m
[31m-	core_toString = class2type.toString,[m
[31m-	core_hasOwn = class2type.hasOwnProperty,[m
[31m-	core_trim = core_version.trim,[m
[31m-[m
[31m-	// Define a local copy of jQuery[m
[31m-	jQuery = function( selector, context ) {[m
[31m-		// The jQuery object is actually just the init constructor 'enhanced'[m
[31m-		return new jQuery.fn.init( selector, context, rootjQuery );[m
[31m-	},[m
[31m-[m
[31m-	// Used for matching numbers[m
[31m-	core_pnum = /[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source,[m
[31m-[m
[31m-	// Used for splitting on whitespace[m
[31m-	core_rnotwhite = /\S+/g,[m
[31m-[m
[31m-	// Make sure we trim BOM and NBSP (here's looking at you, Safari 5.0 and IE)[m
[31m-	rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g,[m
[31m-[m
[31m-	// A simple way to check for HTML strings[m
[31m-	// Prioritize #id over <tag> to avoid XSS via location.hash (#9521)[m
[31m-	// Strict HTML recognition (#11290: must start with <)[m
[31m-	rquickExpr = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/,[m
[31m-[m
[31m-	// Match a standalone tag[m
[31m-	rsingleTag = /^<(\w+)\s*\/?>(?:<\/\1>|)$/,[m
[31m-[m
[31m-	// JSON RegExp[m
[31m-	rvalidchars = /^[\],:{}\s]*$/,[m
[31m-	rvalidbraces = /(?:^|:|,)(?:\s*\[)+/g,[m
[31m-	rvalidescape = /\\(?:["\\\/bfnrt]|u[\da-fA-F]{4})/g,[m
[31m-	rvalidtokens = /"[^"\\\r\n]*"|true|false|null|-?(?:\d+\.|)\d+(?:[eE][+-]?\d+|)/g,[m
[31m-[m
[31m-	// Matches dashed string for camelizing[m
[31m-	rmsPrefix = /^-ms-/,[m
[31m-	rdashAlpha = /-([\da-z])/gi,[m
[31m-[m
[31m-	// Used by jQuery.camelCase as callback to replace()[m
[31m-	fcamelCase = function( all, letter ) {[m
[31m-		return letter.toUpperCase();[m
[31m-	},[m
[31m-[m
[31m-	// The ready event handler[m
[31m-	completed = function( event ) {[m
[31m-[m
[31m-		// readyState === "complete" is good enough for us to call the dom ready in oldIE[m
[31m-		if ( document.addEventListener || event.type === "load" || document.readyState === "complete" ) {[m
[31m-			detach();[m
[31m-			jQuery.ready();[m
[31m-		}[m
[31m-	},[m
[31m-	// Clean-up method for dom ready events[m
[31m-	detach = function() {[m
[31m-		if ( document.addEventListener ) {[m
[31m-			document.removeEventListener( "DOMContentLoaded", completed, false );[m
[31m-			window.removeEventListener( "load", completed, false );[m
[31m-[m
[31m-		} else {[m
[31m-			document.detachEvent( "onreadystatechange", completed );[m
[31m-			window.detachEvent( "onload", completed );[m
[31m-		}[m
[31m-	};[m
[31m-[m
[31m-jQuery.fn = jQuery.prototype = {[m
[31m-	// The current version of jQuery being used[m
[31m-	jquery: core_version,[m
[31m-[m
[31m-	constructor: jQuery,[m
[31m-	init: function( selector, context, rootjQuery ) {[m
[31m-		var match, elem;[m
[31m-[m
[31m-		// HANDLE: $(""), $(null), $(undefined), $(false)[m
[31m-		if ( !selector ) {[m
[31m-			return this;[m
[31m-		}[m
[31m-[m
[31m-		// Handle HTML strings[m
[31m-		if ( typeof selector === "string" ) {[m
[31m-			if ( selector.charAt(0) === "<" && selector.charAt( selector.length - 1 ) === ">" && selector.length >= 3 ) {[m
[31m-				// Assume that strings that start and end with <> are HTML and skip the regex check[m
[31m-				match = [ null, selector, null ];[m
[31m-[m
[31m-			} else {[m
[31m-				match = rquickExpr.exec( selector );[m
[31m-			}[m
[31m-[m
[31m-			// Match html or make sure no context is specified for #id[m
[31m-			if ( match && (match[1] || !context) ) {[m
[31m-[m
[31m-				// HANDLE: $(html) -> $(array)[m
[31m-				if ( match[1] ) {[m
[31m-					context = context instanceof jQuery ? context[0] : context;[m
[31m-[m
[31m-					// scripts is true for back-compat[m
[31m-					jQuery.merge( this, jQuery.parseHTML([m
[31m-						match[1],[m
[31m-						context && context.nodeType ? context.ownerDocument || context : document,[m
[31m-						true[m
[31m-					) );[m
[31m-[m
[31m-					// HANDLE: $(html, props)[m
[31m-					if ( rsingleTag.test( match[1] ) && jQuery.isPlainObject( context ) ) {[m
[31m-						for ( match in context ) {[m
[31m-							// Properties of context are called as methods if possible[m
[31m-							if ( jQuery.isFunction( this[ match ] ) ) {[m
[31m-								this[ match ]( context[ match ] );[m
[31m-[m
[31m-							// ...and otherwise set as attributes[m
[31m-							} else {[m
[31m-								this.attr( match, context[ match ] );[m
[31m-							}[m
[31m-						}[m
[31m-					}[m
[31m-[m
[31m-					return this;[m
[31m-[m
[31m-				// HANDLE: $(#id)[m
[31m-				} else {[m
[31m-					elem = document.getElementById( match[2] );[m
[31m-[m
[31m-					// Check parentNode to catch when Blackberry 4.6 returns[m
[31m-					// nodes that are no longer in the document #6963[m
[31m-					if ( elem && elem.parentNode ) {[m
[31m-						// Handle the case where IE and Opera return items[m
[31m-						// by name instead of ID[m
[31m-						if ( elem.id !== match[2] ) {[m
[31m-							return rootjQuery.find( selector );[m
[31m-						}[m
[31m-[m
[31m-						// Otherwise, we inject the element directly into the jQuery object[m
[31m-						this.length = 1;[m
[31m-						this[0] = elem;[m
[31m-					}[m
[31m-[m
[31m-					this.context = document;[m
[31m-					this.selector = selector;[m
[31m-					return this;[m
[31m-				}[m
[31m-[m
[31m-			// HANDLE: $(expr, $(...))[m
[31m-			} else if ( !context || context.jquery ) {[m
[31m-				return ( context || rootjQuery ).find( selector );[m
[31m-[m
[31m-			// HANDLE: $(expr, context)[m
[31m-			// (which is just equivalent to: $(context).find(expr)[m
[31m-			} else {[m
[31m-				return this.constructor( context ).find( selector );[m
[31m-			}[m
[31m-[m
[31m-		// HANDLE: $(DOMElement)[m
[31m-		} else if ( selector.nodeType ) {[m
[31m-			this.context = this[0] = selector;[m
[31m-			this.length = 1;[m
[31m-			return this;[m
[31m-[m
[31m-		// HANDLE: $(function)[m
[31m-		// Shortcut for document ready[m
[31m-		} else if ( jQuery.isFunction( selector ) ) {[m
[31m-			return rootjQuery.ready( selector );[m
[31m-		}[m
[31m-[m
[31m-		if ( selector.selector !== undefined ) {[m
[31m-			this.selector = selector.selector;[m
[31m-			this.context = selector.context;[m
[31m-		}[m
[31m-[m
[31m-		return jQuery.makeArray( selector, this );[m
[31m-	},[m
[31m-[m
[31m-	// Start with an empty selector[m
[31m-	selector: "",[m
[31m-[m
[31m-	// The default length of a jQuery object is 0[m
[31m-	length: 0,[m
[31m-[m
[31m-	toArray: function() {[m
[31m-		return core_slice.call( this );[m
[31m-	},[m
[31m-[m
[31m-	// Get the Nth element in the matched element set OR[m
[31m-	// Get the whole matched element set as a clean array[m
[31m-	get: function( num ) {[m
[31m-		return num == null ?[m
[31m-[m
[31m-			// Return a 'clean' array[m
[31m-			this.toArray() :[m
[31m-[m
[31m-			// Return just the object[m
[31m-			( num < 0 ? this[ this.length + num ] : this[ num ] );[m
[31m-	},[m
[31m-[m
[31m-	// Take an array of elements and push it onto the stack[m
[31m-	// (returning the new matched element set)[m
[31m-	pushStack: function( elems ) {[m
[31m-[m
[31m-		// Build a new jQuery matched element set[m
[31m-		var ret = jQuery.merge( this.constructor(), elems );[m
[31m-[m
[31m-		// Add the old object onto the stack (as a reference)[m
[31m-		ret.prevObject = this;[m
[31m-		ret.context = this.context;[m
[31m-[m
[31m-		// Return the newly-formed element set[m
[31m-		return ret;[m
[31m-	},[m
[31m-[m
[31m-	// Execute a callback for every element in the matched set.[m
[31m-	// (You can seed the arguments with an array of args, but this is[m
[31m-	// only used internally.)[m
[31m-	each: function( callback, args ) {[m
[31m-		return jQuery.each( this, callback, args );[m
[31m-	},[m
[31m-[m
[31m-	ready: function( fn ) {[m
[31m-		// Add the callback[m
[31m-		jQuery.ready.promise().done( fn );[m
[31m-[m
[31m-		return this;[m
[31m-	},[m
[31m-[m
[31m-	slice: function() {[m
[31m-		return this.pushStack( core_slice.apply( this, arguments ) );[m
[31m-	},[m
[31m-[m
[31m-	first: function() {[m
[31m-		return this.eq( 0 );[m
[31m-	},[m
[31m-[m
[31m-	last: function() {[m
[31m-		return this.eq( -1 );[m
[31m-	},[m
[31m-[m
[31m-	eq: function( i ) {[m
[31m-		var len = this.length,[m
[31m-			j = +i + ( i < 0 ? len : 0 );[m
[31m-		return this.pushStack( j >= 0 && j < len ? [ this[j] ] : [] );[m
[31m-	},[m
[31m-[m
[31m-	map: function( callback ) {[m
[31m-		return this.pushStack( jQuery.map(this, function( elem, i ) {[m
[31m-			return callback.call( elem, i, elem );[m
[31m-		}));[m
[31m-	},[m
[31m-[m
[31m-	end: function() {[m
[31m-		return this.prevObject || this.constructor(null);[m
[31m-	},[m
[31m-[m
[31m-	// For internal use only.[m
[31m-	// Behaves like an Array's method, not like a jQuery method.[m
[31m-	push: core_push,[m
[31m-	sort: [].sort,[m
[31m-	splice: [].splice[m
[31m-};[m
[31m-[m
[31m-// Give the init function the jQuery prototype for later instantiation[m
[31m-jQuery.fn.init.prototype = jQuery.fn;[m
[31m-[m
[31m-jQuery.extend = jQuery.fn.extend = function() {[m
[31m-	var src, copyIsArray, copy, name, options, clone,[m
[31m-		target = arguments[0] || {},[m
[31m-		i = 1,[m
[31m-		length = arguments.length,[m
[31m-		deep = false;[m
[31m-[m
[31m-	// Handle a deep copy situation[m
[31m-	if ( typeof target === "boolean" ) {[m
[31m-		deep = target;[m
[31m-		target = arguments[1] || {};[m
[31m-		// skip the boolean and the target[m
[31m-		i = 2;[m
[31m-	}[m
[31m-[m
[31m-	// Handle case when target is a string or something (possible in deep copy)[m
[31m-	if ( typeof target !== "object" && !jQuery.isFunction(target) ) {[m
[31m-		target = {};[m
[31m-	}[m
[31m-[m
[31m-	// extend jQuery itself if only one argument is passed[m
[31m-	if ( length === i ) {[m
[31m-		target = this;[m
[31m-		--i;[m
[31m-	}[m
[31m-[m
[31m-	for ( ; i < length; i++ ) {[m
[31m-		// Only deal with non-null/undefined values[m
[31m-		if ( (options = arguments[ i ]) != null ) {[m
[31m-			// Extend the base object[m
[31m-			for ( name in options ) {[m
[31m-				src = target[ name ];[m
[31m-				copy = options[ name ];[m
[31m-[m
[31m-				// Prevent never-ending loop[m
[31m-				if ( target === copy ) {[m
[31m-					continue;[m
[31m-				}[m
[31m-[m
[31m-				// Recurse if we're merging plain objects or arrays[m
[31m-				if ( deep && copy && ( jQuery.isPlainObject(copy) || (copyIsArray = jQuery.isArray(copy)) ) ) {[m
[31m-					if ( copyIsArray ) {[m
[31m-						copyIsArray = false;[m
[31m-						clone = src && jQuery.isArray(src) ? src : [];[m
[31m-[m
[31m-					} else {[m
[31m-						clone = src && jQuery.isPlainObject(src) ? src : {};[m
[31m-					}[m
[31m-[m
[31m-					// Never move original objects, clone them[m
[31m-					target[ name ] = jQuery.extend( deep, clone, copy );[m
[31m-[m
[31m-				// Don't bring in undefined values[m
[31m-				} else if ( copy !== undefined ) {[m
[31m-					target[ name ] = copy;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	// Return the modified object[m
[31m-	return target;[m
[31m-};[m
[31m-[m
[31m-jQuery.extend({[m
[31m-	// Unique for each copy of jQuery on the page[m
[31m-	// Non-digits removed to match rinlinejQuery[m
[31m-	expando: "jQuery" + ( core_version + Math.random() ).replace( /\D/g, "" ),[m
[31m-[m
[31m-	noConflict: function( deep ) {[m
[31m-		if ( window.$ === jQuery ) {[m
[31m-			window.$ = _$;[m
[31m-		}[m
[31m-[m
[31m-		if ( deep && window.jQuery === jQuery ) {[m
[31m-			window.jQuery = _jQuery;[m
[31m-		}[m
[31m-[m
[31m-		return jQuery;[m
[31m-	},[m
[31m-[m
[31m-	// Is the DOM ready to be used? Set to true once it occurs.[m
[31m-	isReady: false,[m
[31m-[m
[31m-	// A counter to track how many items to wait for before[m
[31m-	// the ready event fires. See #6781[m
[31m-	readyWait: 1,[m
[31m-[m
[31m-	// Hold (or release) the ready event[m
[31m-	holdReady: function( hold ) {[m
[31m-		if ( hold ) {[m
[31m-			jQuery.readyWait++;[m
[31m-		} else {[m
[31m-			jQuery.ready( true );[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	// Handle when the DOM is ready[m
[31m-	ready: function( wait ) {[m
[31m-[m
[31m-		// Abort if there are pending holds or we're already ready[m
[31m-		if ( wait === true ? --jQuery.readyWait : jQuery.isReady ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// Make sure body exists, at least, in case IE gets a little overzealous (ticket #5443).[m
[31m-		if ( !document.body ) {[m
[31m-			return setTimeout( jQuery.ready );[m
[31m-		}[m
[31m-[m
[31m-		// Remember that the DOM is ready[m
[31m-		jQuery.isReady = true;[m
[31m-[m
[31m-		// If a normal DOM Ready event fired, decrement, and wait if need be[m
[31m-		if ( wait !== true && --jQuery.readyWait > 0 ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// If there are functions bound, to execute[m
[31m-		readyList.resolveWith( document, [ jQuery ] );[m
[31m-[m
[31m-		// Trigger any bound ready events[m
[31m-		if ( jQuery.fn.trigger ) {[m
[31m-			jQuery( document ).trigger("ready").off("ready");[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	// See test/unit/core.js for details concerning isFunction.[m
[31m-	// Since version 1.3, DOM methods and functions like alert[m
[31m-	// aren't supported. They return false on IE (#2968).[m
[31m-	isFunction: function( obj ) {[m
[31m-		return jQuery.type(obj) === "function";[m
[31m-	},[m
[31m-[m
[31m-	isArray: Array.isArray || function( obj ) {[m
[31m-		return jQuery.type(obj) === "array";[m
[31m-	},[m
[31m-[m
[31m-	isWindow: function( obj ) {[m
[31m-		/* jshint eqeqeq: false */[m
[31m-		return obj != null && obj == obj.window;[m
[31m-	},[m
[31m-[m
[31m-	isNumeric: function( obj ) {[m
[31m-		return !isNaN( parseFloat(obj) ) && isFinite( obj );[m
[31m-	},[m
[31m-[m
[31m-	type: function( obj ) {[m
[31m-		if ( obj == null ) {[m
[31m-			return String( obj );[m
[31m-		}[m
[31m-		return typeof obj === "object" || typeof obj === "function" ?[m
[31m-			class2type[ core_toString.call(obj) ] || "object" :[m
[31m-			typeof obj;[m
[31m-	},[m
[31m-[m
[31m-	isPlainObject: function( obj ) {[m
[31m-		var key;[m
[31m-[m
[31m-		// Must be an Object.[m
[31m-		// Because of IE, we also have to check the presence of the constructor property.[m
[31m-		// Make sure that DOM nodes and window objects don't pass through, as well[m
[31m-		if ( !obj || jQuery.type(obj) !== "object" || obj.nodeType || jQuery.isWindow( obj ) ) {[m
[31m-			return false;[m
[31m-		}[m
[31m-[m
[31m-		try {[m
[31m-			// Not own constructor property must be Object[m
[31m-			if ( obj.constructor &&[m
[31m-				!core_hasOwn.call(obj, "constructor") &&[m
[31m-				!core_hasOwn.call(obj.constructor.prototype, "isPrototypeOf") ) {[m
[31m-				return false;[m
[31m-			}[m
[31m-		} catch ( e ) {[m
[31m-			// IE8,9 Will throw exceptions on certain host objects #9897[m
[31m-			return false;[m
[31m-		}[m
[31m-[m
[31m-		// Support: IE<9[m
[31m-		// Handle iteration over inherited properties before own properties.[m
[31m-		if ( jQuery.support.ownLast ) {[m
[31m-			for ( key in obj ) {[m
[31m-				return core_hasOwn.call( obj, key );[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Own properties are enumerated firstly, so to speed up,[m
[31m-		// if last one is own, then all properties are own.[m
[31m-		for ( key in obj ) {}[m
[31m-[m
[31m-		return key === undefined || core_hasOwn.call( obj, key );[m
[31m-	},[m
[31m-[m
[31m-	isEmptyObject: function( obj ) {[m
[31m-		var name;[m
[31m-		for ( name in obj ) {[m
[31m-			return false;[m
[31m-		}[m
[31m-		return true;[m
[31m-	},[m
[31m-[m
[31m-	error: function( msg ) {[m
[31m-		throw new Error( msg );[m
[31m-	},[m
[31m-[m
[31m-	// data: string of html[m
[31m-	// context (optional): If specified, the fragment will be created in this context, defaults to document[m
[31m-	// keepScripts (optional): If true, will include scripts passed in the html string[m
[31m-	parseHTML: function( data, context, keepScripts ) {[m
[31m-		if ( !data || typeof data !== "string" ) {[m
[31m-			return null;[m
[31m-		}[m
[31m-		if ( typeof context === "boolean" ) {[m
[31m-			keepScripts = context;[m
[31m-			context = false;[m
[31m-		}[m
[31m-		context = context || document;[m
[31m-[m
[31m-		var parsed = rsingleTag.exec( data ),[m
[31m-			scripts = !keepScripts && [];[m
[31m-[m
[31m-		// Single tag[m
[31m-		if ( parsed ) {[m
[31m-			return [ context.createElement( parsed[1] ) ];[m
[31m-		}[m
[31m-[m
[31m-		parsed = jQuery.buildFragment( [ data ], context, scripts );[m
[31m-		if ( scripts ) {[m
[31m-			jQuery( scripts ).remove();[m
[31m-		}[m
[31m-		return jQuery.merge( [], parsed.childNodes );[m
[31m-	},[m
[31m-[m
[31m-	parseJSON: function( data ) {[m
[31m-		// Attempt to parse using the native JSON parser first[m
[31m-		if ( window.JSON && window.JSON.parse ) {[m
[31m-			return window.JSON.parse( data );[m
[31m-		}[m
[31m-[m
[31m-		if ( data === null ) {[m
[31m-			return data;[m
[31m-		}[m
[31m-[m
[31m-		if ( typeof data === "string" ) {[m
[31m-[m
[31m-			// Make sure leading/trailing whitespace is removed (IE can't handle it)[m
[31m-			data = jQuery.trim( data );[m
[31m-[m
[31m-			if ( data ) {[m
[31m-				// Make sure the incoming data is actual JSON[m
[31m-				// Logic borrowed from http://json.org/json2.js[m
[31m-				if ( rvalidchars.test( data.replace( rvalidescape, "@" )[m
[31m-					.replace( rvalidtokens, "]" )[m
[31m-					.replace( rvalidbraces, "")) ) {[m
[31m-[m
[31m-					return ( new Function( "return " + data ) )();[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		jQuery.error( "Invalid JSON: " + data );[m
[31m-	},[m
[31m-[m
[31m-	// Cross-browser xml parsing[m
[31m-	parseXML: function( data ) {[m
[31m-		var xml, tmp;[m
[31m-		if ( !data || typeof data !== "string" ) {[m
[31m-			return null;[m
[31m-		}[m
[31m-		try {[m
[31m-			if ( window.DOMParser ) { // Standard[m
[31m-				tmp = new DOMParser();[m
[31m-				xml = tmp.parseFromString( data , "text/xml" );[m
[31m-			} else { // IE[m
[31m-				xml = new ActiveXObject( "Microsoft.XMLDOM" );[m
[31m-				xml.async = "false";[m
[31m-				xml.loadXML( data );[m
[31m-			}[m
[31m-		} catch( e ) {[m
[31m-			xml = undefined;[m
[31m-		}[m
[31m-		if ( !xml || !xml.documentElement || xml.getElementsByTagName( "parsererror" ).length ) {[m
[31m-			jQuery.error( "Invalid XML: " + data );[m
[31m-		}[m
[31m-		return xml;[m
[31m-	},[m
[31m-[m
[31m-	noop: function() {},[m
[31m-[m
[31m-	// Evaluates a script in a global context[m
[31m-	// Workarounds based on findings by Jim Driscoll[m
[31m-	// http://weblogs.java.net/blog/driscoll/archive/2009/09/08/eval-javascript-global-context[m
[31m-	globalEval: function( data ) {[m
[31m-		if ( data && jQuery.trim( data ) ) {[m
[31m-			// We use execScript on Internet Explorer[m
[31m-			// We use an anonymous function so that context is window[m
[31m-			// rather than jQuery in Firefox[m
[31m-			( window.execScript || function( data ) {[m
[31m-				window[ "eval" ].call( window, data );[m
[31m-			} )( data );[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	// Convert dashed to camelCase; used by the css and data modules[m
[31m-	// Microsoft forgot to hump their vendor prefix (#9572)[m
[31m-	camelCase: function( string ) {[m
[31m-		return string.replace( rmsPrefix, "ms-" ).replace( rdashAlpha, fcamelCase );[m
[31m-	},[m
[31m-[m
[31m-	nodeName: function( elem, name ) {[m
[31m-		return elem.nodeName && elem.nodeName.toLowerCase() === name.toLowerCase();[m
[31m-	},[m
[31m-[m
[31m-	// args is for internal usage only[m
[31m-	each: function( obj, callback, args ) {[m
[31m-		var value,[m
[31m-			i = 0,[m
[31m-			length = obj.length,[m
[31m-			isArray = isArraylike( obj );[m
[31m-[m
[31m-		if ( args ) {[m
[31m-			if ( isArray ) {[m
[31m-				for ( ; i < length; i++ ) {[m
[31m-					value = callback.apply( obj[ i ], args );[m
[31m-[m
[31m-					if ( value === false ) {[m
[31m-						break;[m
[31m-					}[m
[31m-				}[m
[31m-			} else {[m
[31m-				for ( i in obj ) {[m
[31m-					value = callback.apply( obj[ i ], args );[m
[31m-[m
[31m-					if ( value === false ) {[m
[31m-						break;[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-		// A special, fast, case for the most common use of each[m
[31m-		} else {[m
[31m-			if ( isArray ) {[m
[31m-				for ( ; i < length; i++ ) {[m
[31m-					value = callback.call( obj[ i ], i, obj[ i ] );[m
[31m-[m
[31m-					if ( value === false ) {[m
[31m-						break;[m
[31m-					}[m
[31m-				}[m
[31m-			} else {[m
[31m-				for ( i in obj ) {[m
[31m-					value = callback.call( obj[ i ], i, obj[ i ] );[m
[31m-[m
[31m-					if ( value === false ) {[m
[31m-						break;[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return obj;[m
[31m-	},[m
[31m-[m
[31m-	// Use native String.trim function wherever possible[m
[31m-	trim: core_trim && !core_trim.call("\uFEFF\xA0") ?[m
[31m-		function( text ) {[m
[31m-			return text == null ?[m
[31m-				"" :[m
[31m-				core_trim.call( text );[m
[31m-		} :[m
[31m-[m
[31m-		// Otherwise use our own trimming functionality[m
[31m-		function( text ) {[m
[31m-			return text == null ?[m
[31m-				"" :[m
[31m-				( text + "" ).replace( rtrim, "" );[m
[31m-		},[m
[31m-[m
[31m-	// results is for internal usage only[m
[31m-	makeArray: function( arr, results ) {[m
[31m-		var ret = results || [];[m
[31m-[m
[31m-		if ( arr != null ) {[m
[31m-			if ( isArraylike( Object(arr) ) ) {[m
[31m-				jQuery.merge( ret,[m
[31m-					typeof arr === "string" ?[m
[31m-					[ arr ] : arr[m
[31m-				);[m
[31m-			} else {[m
[31m-				core_push.call( ret, arr );[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return ret;[m
[31m-	},[m
[31m-[m
[31m-	inArray: function( elem, arr, i ) {[m
[31m-		var len;[m
[31m-[m
[31m-		if ( arr ) {[m
[31m-			if ( core_indexOf ) {[m
[31m-				return core_indexOf.call( arr, elem, i );[m
[31m-			}[m
[31m-[m
[31m-			len = arr.length;[m
[31m-			i = i ? i < 0 ? Math.max( 0, len + i ) : i : 0;[m
[31m-[m
[31m-			for ( ; i < len; i++ ) {[m
[31m-				// Skip accessing in sparse arrays[m
[31m-				if ( i in arr && arr[ i ] === elem ) {[m
[31m-					return i;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return -1;[m
[31m-	},[m
[31m-[m
[31m-	merge: function( first, second ) {[m
[31m-		var l = second.length,[m
[31m-			i = first.length,[m
[31m-			j = 0;[m
[31m-[m
[31m-		if ( typeof l === "number" ) {[m
[31m-			for ( ; j < l; j++ ) {[m
[31m-				first[ i++ ] = second[ j ];[m
[31m-			}[m
[31m-		} else {[m
[31m-			while ( second[j] !== undefined ) {[m
[31m-				first[ i++ ] = second[ j++ ];[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		first.length = i;[m
[31m-[m
[31m-		return first;[m
[31m-	},[m
[31m-[m
[31m-	grep: function( elems, callback, inv ) {[m
[31m-		var retVal,[m
[31m-			ret = [],[m
[31m-			i = 0,[m
[31m-			length = elems.length;[m
[31m-		inv = !!inv;[m
[31m-[m
[31m-		// Go through the array, only saving the items[m
[31m-		// that pass the validator function[m
[31m-		for ( ; i < length; i++ ) {[m
[31m-			retVal = !!callback( elems[ i ], i );[m
[31m-			if ( inv !== retVal ) {[m
[31m-				ret.push( elems[ i ] );[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return ret;[m
[31m-	},[m
[31m-[m
[31m-	// arg is for internal usage only[m
[31m-	map: function( elems, callback, arg ) {[m
[31m-		var value,[m
[31m-			i = 0,[m
[31m-			length = elems.length,[m
[31m-			isArray = isArraylike( elems ),[m
[31m-			ret = [];[m
[31m-[m
[31m-		// Go through the array, translating each of the items to their[m
[31m-		if ( isArray ) {[m
[31m-			for ( ; i < length; i++ ) {[m
[31m-				value = callback( elems[ i ], i, arg );[m
[31m-[m
[31m-				if ( value != null ) {[m
[31m-					ret[ ret.length ] = value;[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-		// Go through every key on the object,[m
[31m-		} else {[m
[31m-			for ( i in elems ) {[m
[31m-				value = callback( elems[ i ], i, arg );[m
[31m-[m
[31m-				if ( value != null ) {[m
[31m-					ret[ ret.length ] = value;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Flatten any nested arrays[m
[31m-		return core_concat.apply( [], ret );[m
[31m-	},[m
[31m-[m
[31m-	// A global GUID counter for objects[m
[31m-	guid: 1,[m
[31m-[m
[31m-	// Bind a function to a context, optionally partially applying any[m
[31m-	// arguments.[m
[31m-	proxy: function( fn, context ) {[m
[31m-		var args, proxy, tmp;[m
[31m-[m
[31m-		if ( typeof context === "string" ) {[m
[31m-			tmp = fn[ context ];[m
[31m-			context = fn;[m
[31m-			fn = tmp;[m
[31m-		}[m
[31m-[m
[31m-		// Quick check to determine if target is callable, in the spec[m
[31m-		// this throws a TypeError, but we will just return undefined.[m
[31m-		if ( !jQuery.isFunction( fn ) ) {[m
[31m-			return undefined;[m
[31m-		}[m
[31m-[m
[31m-		// Simulated bind[m
[31m-		args = core_slice.call( arguments, 2 );[m
[31m-		proxy = function() {[m
[31m-			return fn.apply( context || this, args.concat( core_slice.call( arguments ) ) );[m
[31m-		};[m
[31m-[m
[31m-		// Set the guid of unique handler to the same of original handler, so it can be removed[m
[31m-		proxy.guid = fn.guid = fn.guid || jQuery.guid++;[m
[31m-[m
[31m-		return proxy;[m
[31m-	},[m
[31m-[m
[31m-	// Multifunctional method to get and set values of a collection[m
[31m-	// The value/s can optionally be executed if it's a function[m
[31m-	access: function( elems, fn, key, value, chainable, emptyGet, raw ) {[m
[31m-		var i = 0,[m
[31m-			length = elems.length,[m
[31m-			bulk = key == null;[m
[31m-[m
[31m-		// Sets many values[m
[31m-		if ( jQuery.type( key ) === "object" ) {[m
[31m-			chainable = true;[m
[31m-			for ( i in key ) {[m
[31m-				jQuery.access( elems, fn, i, key[i], true, emptyGet, raw );[m
[31m-			}[m
[31m-[m
[31m-		// Sets one value[m
[31m-		} else if ( value !== undefined ) {[m
[31m-			chainable = true;[m
[31m-[m
[31m-			if ( !jQuery.isFunction( value ) ) {[m
[31m-				raw = true;[m
[31m-			}[m
[31m-[m
[31m-			if ( bulk ) {[m
[31m-				// Bulk operations run against the entire set[m
[31m-				if ( raw ) {[m
[31m-					fn.call( elems, value );[m
[31m-					fn = null;[m
[31m-[m
[31m-				// ...except when executing function values[m
[31m-				} else {[m
[31m-					bulk = fn;[m
[31m-					fn = function( elem, key, value ) {[m
[31m-						return bulk.call( jQuery( elem ), value );[m
[31m-					};[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			if ( fn ) {[m
[31m-				for ( ; i < length; i++ ) {[m
[31m-					fn( elems[i], key, raw ? value : value.call( elems[i], i, fn( elems[i], key ) ) );[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return chainable ?[m
[31m-			elems :[m
[31m-[m
[31m-			// Gets[m
[31m-			bulk ?[m
[31m-				fn.call( elems ) :[m
[31m-				length ? fn( elems[0], key ) : emptyGet;[m
[31m-	},[m
[31m-[m
[31m-	now: function() {[m
[31m-		return ( new Date() ).getTime();[m
[31m-	},[m
[31m-[m
[31m-	// A method for quickly swapping in/out CSS properties to get correct calculations.[m
[31m-	// Note: this method belongs to the css module but it's needed here for the support module.[m
[31m-	// If support gets modularized, this method should be moved back to the css module.[m
[31m-	swap: function( elem, options, callback, args ) {[m
[31m-		var ret, name,[m
[31m-			old = {};[m
[31m-[m
[31m-		// Remember the old values, and insert the new ones[m
[31m-		for ( name in options ) {[m
[31m-			old[ name ] = elem.style[ name ];[m
[31m-			elem.style[ name ] = options[ name ];[m
[31m-		}[m
[31m-[m
[31m-		ret = callback.apply( elem, args || [] );[m
[31m-[m
[31m-		// Revert the old values[m
[31m-		for ( name in options ) {[m
[31m-			elem.style[ name ] = old[ name ];[m
[31m-		}[m
[31m-[m
[31m-		return ret;[m
[31m-	}[m
[31m-});[m
[31m-[m
[31m-jQuery.ready.promise = function( obj ) {[m
[31m-	if ( !readyList ) {[m
[31m-[m
[31m-		readyList = jQuery.Deferred();[m
[31m-[m
[31m-		// Catch cases where $(document).ready() is called after the browser event has already occurred.[m
[31m-		// we once tried to use readyState "interactive" here, but it caused issues like the one[m
[31m-		// discovered by ChrisS here: http://bugs.jquery.com/ticket/12282#comment:15[m
[31m-		if ( document.readyState === "complete" ) {[m
[31m-			// Handle it asynchronously to allow scripts the opportunity to delay ready[m
[31m-			setTimeout( jQuery.ready );[m
[31m-[m
[31m-		// Standards-based browsers support DOMContentLoaded[m
[31m-		} else if ( document.addEventListener ) {[m
[31m-			// Use the handy event callback[m
[31m-			document.addEventListener( "DOMContentLoaded", completed, false );[m
[31m-[m
[31m-			// A fallback to window.onload, that will always work[m
[31m-			window.addEventListener( "load", completed, false );[m
[31m-[m
[31m-		// If IE event model is used[m
[31m-		} else {[m
[31m-			// Ensure firing before onload, maybe late but safe also for iframes[m
[31m-			document.attachEvent( "onreadystatechange", completed );[m
[31m-[m
[31m-			// A fallback to window.onload, that will always work[m
[31m-			window.attachEvent( "onload", completed );[m
[31m-[m
[31m-			// If IE and not a frame[m
[31m-			// continually check to see if the document is ready[m
[31m-			var top = false;[m
[31m-[m
[31m-			try {[m
[31m-				top = window.frameElement == null && document.documentElement;[m
[31m-			} catch(e) {}[m
[31m-[m
[31m-			if ( top && top.doScroll ) {[m
[31m-				(function doScrollCheck() {[m
[31m-					if ( !jQuery.isReady ) {[m
[31m-[m
[31m-						try {[m
[31m-							// Use the trick by Diego Perini[m
[31m-							// http://javascript.nwbox.com/IEContentLoaded/[m
[31m-							top.doScroll("left");[m
[31m-						} catch(e) {[m
[31m-							return setTimeout( doScrollCheck, 50 );[m
[31m-						}[m
[31m-[m
[31m-						// detach all dom ready events[m
[31m-						detach();[m
[31m-[m
[31m-						// and execute any waiting functions[m
[31m-						jQuery.ready();[m
[31m-					}[m
[31m-				})();[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-	return readyList.promise( obj );[m
[31m-};[m
[31m-[m
[31m-// Populate the class2type map[m
[31m-jQuery.each("Boolean Number String Function Array Date RegExp Object Error".split(" "), function(i, name) {[m
[31m-	class2type[ "[object " + name + "]" ] = name.toLowerCase();[m
[31m-});[m
[31m-[m
[31m-function isArraylike( obj ) {[m
[31m-	var length = obj.length,[m
[31m-		type = jQuery.type( obj );[m
[31m-[m
[31m-	if ( jQuery.isWindow( obj ) ) {[m
[31m-		return false;[m
[31m-	}[m
[31m-[m
[31m-	if ( obj.nodeType === 1 && length ) {[m
[31m-		return true;[m
[31m-	}[m
[31m-[m
[31m-	return type === "array" || type !== "function" &&[m
[31m-		( length === 0 ||[m
[31m-		typeof length === "number" && length > 0 && ( length - 1 ) in obj );[m
[31m-}[m
[31m-[m
[31m-// All jQuery objects should point back to these[m
[31m-rootjQuery = jQuery(document);[m
[31m-/*![m
[31m- * Sizzle CSS Selector Engine v1.10.2[m
[31m- * http://sizzlejs.com/[m
[31m- *[m
[31m- * Copyright 2013 jQuery Foundation, Inc. and other contributors[m
[31m- * Released under the MIT license[m
[31m- * http://jquery.org/license[m
[31m- *[m
[31m- * Date: 2013-07-03[m
[31m- */[m
[31m-(function( window, undefined ) {[m
[31m-[m
[31m-var i,[m
[31m-	support,[m
[31m-	cachedruns,[m
[31m-	Expr,[m
[31m-	getText,[m
[31m-	isXML,[m
[31m-	compile,[m
[31m-	outermostContext,[m
[31m-	sortInput,[m
[31m-[m
[31m-	// Local document vars[m
[31m-	setDocument,[m
[31m-	document,[m
[31m-	docElem,[m
[31m-	documentIsHTML,[m
[31m-	rbuggyQSA,[m
[31m-	rbuggyMatches,[m
[31m-	matches,[m
[31m-	contains,[m
[31m-[m
[31m-	// Instance-specific data[m
[31m-	expando = "sizzle" + -(new Date()),[m
[31m-	preferredDoc = window.document,[m
[31m-	dirruns = 0,[m
[31m-	done = 0,[m
[31m-	classCache = createCache(),[m
[31m-	tokenCache = createCache(),[m
[31m-	compilerCache = createCache(),[m
[31m-	hasDuplicate = false,[m
[31m-	sortOrder = function( a, b ) {[m
[31m-		if ( a === b ) {[m
[31m-			hasDuplicate = true;[m
[31m-			return 0;[m
[31m-		}[m
[31m-		return 0;[m
[31m-	},[m
[31m-[m
[31m-	// General-purpose constants[m
[31m-	strundefined = typeof undefined,[m
[31m-	MAX_NEGATIVE = 1 << 31,[m
[31m-[m
[31m-	// Instance methods[m
[31m-	hasOwn = ({}).hasOwnProperty,[m
[31m-	arr = [],[m
[31m-	pop = arr.pop,[m
[31m-	push_native = arr.push,[m
[31m-	push = arr.push,[m
[31m-	slice = arr.slice,[m
[31m-	// Use a stripped-down indexOf if we can't use a native one[m
[31m-	indexOf = arr.indexOf || function( elem ) {[m
[31m-		var i = 0,[m
[31m-			len = this.length;[m
[31m-		for ( ; i < len; i++ ) {[m
[31m-			if ( this[i] === elem ) {[m
[31m-				return i;[m
[31m-			}[m
[31m-		}[m
[31m-		return -1;[m
[31m-	},[m
[31m-[m
[31m-	booleans = "checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped",[m
[31m-[m
[31m-	// Regular expressions[m
[31m-[m
[31m-	// Whitespace characters http://www.w3.org/TR/css3-selectors/#whitespace[m
[31m-	whitespace = "[\\x20\\t\\r\\n\\f]",[m
[31m-	// http://www.w3.org/TR/css3-syntax/#characters[m
[31m-	characterEncoding = "(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+",[m
[31m-[m
[31m-	// Loosely modeled on CSS identifier characters[m
[31m-	// An unquoted value should be a CSS identifier http://www.w3.org/TR/css3-selectors/#attribute-selectors[m
[31m-	// Proper syntax: http://www.w3.org/TR/CSS21/syndata.html#value-def-identifier[m
[31m-	identifier = characterEncoding.replace( "w", "w#" ),[m
[31m-[m
[31m-	// Acceptable operators http://www.w3.org/TR/selectors/#attribute-selectors[m
[31m-	attributes = "\\[" + whitespace + "*(" + characterEncoding + ")" + whitespace +[m
[31m-		"*(?:([*^$|!~]?=)" + whitespace + "*(?:(['\"])((?:\\\\.|[^\\\\])*?)\\3|(" + identifier + ")|)|)" + whitespace + "*\\]",[m
[31m-[m
[31m-	// Prefer arguments quoted,[m
[31m-	//   then not containing pseudos/brackets,[m
[31m-	//   then attribute selectors/non-parenthetical expressions,[m
[31m-	//   then anything else[m
[31m-	// These preferences are here to reduce the number of selectors[m
[31m-	//   needing tokenize in the PSEUDO preFilter[m
[31m-	pseudos = ":(" + characterEncoding + ")(?:\\(((['\"])((?:\\\\.|[^\\\\])*?)\\3|((?:\\\\.|[^\\\\()[\\]]|" + attributes.replace( 3, 8 ) + ")*)|.*)\\)|)",[m
[31m-[m
[31m-	// Leading and non-escaped trailing whitespace, capturing some non-whitespace characters preceding the latter[m
[31m-	rtrim = new RegExp( "^" + whitespace + "+|((?:^|[^\\\\])(?:\\\\.)*)" + whitespace + "+$", "g" ),[m
[31m-[m
[31m-	rcomma = new RegExp( "^" + whitespace + "*," + whitespace + "*" ),[m
[31m-	rcombinators = new RegExp( "^" + whitespace + "*([>+~]|" + whitespace + ")" + whitespace + "*" ),[m
[31m-[m
[31m-	rsibling = new RegExp( whitespace + "*[+~]" ),[m
[31m-	rattributeQuotes = new RegExp( "=" + whitespace + "*([^\\]'\"]*)" + whitespace + "*\\]", "g" ),[m
[31m-[m
[31m-	rpseudo = new RegExp( pseudos ),[m
[31m-	ridentifier = new RegExp( "^" + identifier + "$" ),[m
[31m-[m
[31m-	matchExpr = {[m
[31m-		"ID": new RegExp( "^#(" + characterEncoding + ")" ),[m
[31m-		"CLASS": new RegExp( "^\\.(" + characterEncoding + ")" ),[m
[31m-		"TAG": new RegExp( "^(" + characterEncoding.replace( "w", "w*" ) + ")" ),[m
[31m-		"ATTR": new RegExp( "^" + attributes ),[m
[31m-		"PSEUDO": new RegExp( "^" + pseudos ),[m
[31m-		"CHILD": new RegExp( "^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\(" + whitespace +[m
[31m-			"*(even|odd|(([+-]|)(\\d*)n|)" + whitespace + "*(?:([+-]|)" + whitespace +[m
[31m-			"*(\\d+)|))" + whitespace + "*\\)|)", "i" ),[m
[31m-		"bool": new RegExp( "^(?:" + booleans + ")$", "i" ),[m
[31m-		// For use in libraries implementing .is()[m
[31m-		// We use this for POS matching in `select`[m
[31m-		"needsContext": new RegExp( "^" + whitespace + "*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\(" +[m
[31m-			whitespace + "*((?:-\\d)?\\d*)" + whitespace + "*\\)|)(?=[^-]|$)", "i" )[m
[31m-	},[m
[31m-[m
[31m-	rnative = /^[^{]+\{\s*\[native \w/,[m
[31m-[m
[31m-	// Easily-parseable/retrievable ID or TAG or CLASS selectors[m
[31m-	rquickExpr = /^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/,[m
[31m-[m
[31m-	rinputs = /^(?:input|select|textarea|button)$/i,[m
[31m-	rheader = /^h\d$/i,[m
[31m-[m
[31m-	rescape = /'|\\/g,[m
[31m-[m
[31m-	// CSS escapes http://www.w3.org/TR/CSS21/syndata.html#escaped-characters[m
[31m-	runescape = new RegExp( "\\\\([\\da-f]{1,6}" + whitespace + "?|(" + whitespace + ")|.)", "ig" ),[m
[31m-	funescape = function( _, escaped, escapedWhitespace ) {[m
[31m-		var high = "0x" + escaped - 0x10000;[m
[31m-		// NaN means non-codepoint[m
[31m-		// Support: Firefox[m
[31m-		// Workaround erroneous numeric interpretation of +"0x"[m
[31m-		return high !== high || escapedWhitespace ?[m
[31m-			escaped :[m
[31m-			// BMP codepoint[m
[31m-			high < 0 ?[m
[31m-				String.fromCharCode( high + 0x10000 ) :[m
[31m-				// Supplemental Plane codepoint (surrogate pair)[m
[31m-				String.fromCharCode( high >> 10 | 0xD800, high & 0x3FF | 0xDC00 );[m
[31m-	};[m
[31m-[m
[31m-// Optimize for push.apply( _, NodeList )[m
[31m-try {[m
[31m-	push.apply([m
[31m-		(arr = slice.call( preferredDoc.childNodes )),[m
[31m-		preferredDoc.childNodes[m
[31m-	);[m
[31m-	// Support: Android<4.0[m
[31m-	// Detect silently failing push.apply[m
[31m-	arr[ preferredDoc.childNodes.length ].nodeType;[m
[31m-} catch ( e ) {[m
[31m-	push = { apply: arr.length ?[m
[31m-[m
[31m-		// Leverage slice if possible[m
[31m-		function( target, els ) {[m
[31m-			push_native.apply( target, slice.call(els) );[m
[31m-		} :[m
[31m-[m
[31m-		// Support: IE<9[m
[31m-		// Otherwise append directly[m
[31m-		function( target, els ) {[m
[31m-			var j = target.length,[m
[31m-				i = 0;[m
[31m-			// Can't trust NodeList.length[m
[31m-			while ( (target[j++] = els[i++]) ) {}[m
[31m-			target.length = j - 1;[m
[31m-		}[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-function Sizzle( selector, context, results, seed ) {[m
[31m-	var match, elem, m, nodeType,[m
[31m-		// QSA vars[m
[31m-		i, groups, old, nid, newContext, newSelector;[m
[31m-[m
[31m-	if ( ( context ? context.ownerDocument || context : preferredDoc ) !== document ) {[m
[31m-		setDocument( context );[m
[31m-	}[m
[31m-[m
[31m-	context = context || document;[m
[31m-	results = results || [];[m
[31m-[m
[31m-	if ( !selector || typeof selector !== "string" ) {[m
[31m-		return results;[m
[31m-	}[m
[31m-[m
[31m-	if ( (nodeType = context.nodeType) !== 1 && nodeType !== 9 ) {[m
[31m-		return [];[m
[31m-	}[m
[31m-[m
[31m-	if ( documentIsHTML && !seed ) {[m
[31m-[m
[31m-		// Shortcuts[m
[31m-		if ( (match = rquickExpr.exec( selector )) ) {[m
[31m-			// Speed-up: Sizzle("#ID")[m
[31m-			if ( (m = match[1]) ) {[m
[31m-				if ( nodeType === 9 ) {[m
[31m-					elem = context.getElementById( m );[m
[31m-					// Check parentNode to catch when Blackberry 4.6 returns[m
[31m-					// nodes that are no longer in the document #6963[m
[31m-					if ( elem && elem.parentNode ) {[m
[31m-						// Handle the case where IE, Opera, and Webkit return items[m
[31m-						// by name instead of ID[m
[31m-						if ( elem.id === m ) {[m
[31m-							results.push( elem );[m
[31m-							return results;[m
[31m-						}[m
[31m-					} else {[m
[31m-						return results;[m
[31m-					}[m
[31m-				} else {[m
[31m-					// Context is not a document[m
[31m-					if ( context.ownerDocument && (elem = context.ownerDocument.getElementById( m )) &&[m
[31m-						contains( context, elem ) && elem.id === m ) {[m
[31m-						results.push( elem );[m
[31m-						return results;[m
[31m-					}[m
[31m-				}[m
[31m-[m
[31m-			// Speed-up: Sizzle("TAG")[m
[31m-			} else if ( match[2] ) {[m
[31m-				push.apply( results, context.getElementsByTagName( selector ) );[m
[31m-				return results;[m
[31m-[m
[31m-			// Speed-up: Sizzle(".CLASS")[m
[31m-			} else if ( (m = match[3]) && support.getElementsByClassName && context.getElementsByClassName ) {[m
[31m-				push.apply( results, context.getElementsByClassName( m ) );[m
[31m-				return results;[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// QSA path[m
[31m-		if ( support.qsa && (!rbuggyQSA || !rbuggyQSA.test( selector )) ) {[m
[31m-			nid = old = expando;[m
[31m-			newContext = context;[m
[31m-			newSelector = nodeType === 9 && selector;[m
[31m-[m
[31m-			// qSA works strangely on Element-rooted queries[m
[31m-			// We can work around this by specifying an extra ID on the root[m
[31m-			// and working up from there (Thanks to Andrew Dupont for the technique)[m
[31m-			// IE 8 doesn't work on object elements[m
[31m-			if ( nodeType === 1 && context.nodeName.toLowerCase() !== "object" ) {[m
[31m-				groups = tokenize( selector );[m
[31m-[m
[31m-				if ( (old = context.getAttribute("id")) ) {[m
[31m-					nid = old.replace( rescape, "\\$&" );[m
[31m-				} else {[m
[31m-					context.setAttribute( "id", nid );[m
[31m-				}[m
[31m-				nid = "[id='" + nid + "'] ";[m
[31m-[m
[31m-				i = groups.length;[m
[31m-				while ( i-- ) {[m
[31m-					groups[i] = nid + toSelector( groups[i] );[m
[31m-				}[m
[31m-				newContext = rsibling.test( selector ) && context.parentNode || context;[m
[31m-				newSelector = groups.join(",");[m
[31m-			}[m
[31m-[m
[31m-			if ( newSelector ) {[m
[31m-				try {[m
[31m-					push.apply( results,[m
[31m-						newContext.querySelectorAll( newSelector )[m
[31m-					);[m
[31m-					return results;[m
[31m-				} catch(qsaError) {[m
[31m-				} finally {[m
[31m-					if ( !old ) {[m
[31m-						context.removeAttribute("id");[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	// All others[m
[31m-	return select( selector.replace( rtrim, "$1" ), context, results, seed );[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Create key-value caches of limited size[m
[31m- * @returns {Function(string, Object)} Returns the Object data after storing it on itself with[m
[31m- *	property name the (space-suffixed) string and (if the cache is larger than Expr.cacheLength)[m
[31m- *	deleting the oldest entry[m
[31m- */[m
[31m-function createCache() {[m
[31m-	var keys = [];[m
[31m-[m
[31m-	function cache( key, value ) {[m
[31m-		// Use (key + " ") to avoid collision with native prototype properties (see Issue #157)[m
[31m-		if ( keys.push( key += " " ) > Expr.cacheLength ) {[m
[31m-			// Only keep the most recent entries[m
[31m-			delete cache[ keys.shift() ];[m
[31m-		}[m
[31m-		return (cache[ key ] = value);[m
[31m-	}[m
[31m-	return cache;[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Mark a function for special use by Sizzle[m
[31m- * @param {Function} fn The function to mark[m
[31m- */[m
[31m-function markFunction( fn ) {[m
[31m-	fn[ expando ] = true;[m
[31m-	return fn;[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Support testing using an element[m
[31m- * @param {Function} fn Passed the created div and expects a boolean result[m
[31m- */[m
[31m-function assert( fn ) {[m
[31m-	var div = document.createElement("div");[m
[31m-[m
[31m-	try {[m
[31m-		return !!fn( div );[m
[31m-	} catch (e) {[m
[31m-		return false;[m
[31m-	} finally {[m
[31m-		// Remove from its parent by default[m
[31m-		if ( div.parentNode ) {[m
[31m-			div.parentNode.removeChild( div );[m
[31m-		}[m
[31m-		// release memory in IE[m
[31m-		div = null;[m
[31m-	}[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Adds the same handler for all of the specified attrs[m
[31m- * @param {String} attrs Pipe-separated list of attributes[m
[31m- * @param {Function} handler The method that will be applied[m
[31m- */[m
[31m-function addHandle( attrs, handler ) {[m
[31m-	var arr = attrs.split("|"),[m
[31m-		i = attrs.length;[m
[31m-[m
[31m-	while ( i-- ) {[m
[31m-		Expr.attrHandle[ arr[i] ] = handler;[m
[31m-	}[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Checks document order of two siblings[m
[31m- * @param {Element} a[m
[31m- * @param {Element} b[m
[31m- * @returns {Number} Returns less than 0 if a precedes b, greater than 0 if a follows b[m
[31m- */[m
[31m-function siblingCheck( a, b ) {[m
[31m-	var cur = b && a,[m
[31m-		diff = cur && a.nodeType === 1 && b.nodeType === 1 &&[m
[31m-			( ~b.sourceIndex || MAX_NEGATIVE ) -[m
[31m-			( ~a.sourceIndex || MAX_NEGATIVE );[m
[31m-[m
[31m-	// Use IE sourceIndex if available on both nodes[m
[31m-	if ( diff ) {[m
[31m-		return diff;[m
[31m-	}[m
[31m-[m
[31m-	// Check if b follows a[m
[31m-	if ( cur ) {[m
[31m-		while ( (cur = cur.nextSibling) ) {[m
[31m-			if ( cur === b ) {[m
[31m-				return -1;[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	return a ? 1 : -1;[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Returns a function to use in pseudos for input types[m
[31m- * @param {String} type[m
[31m- */[m
[31m-function createInputPseudo( type ) {[m
[31m-	return function( elem ) {[m
[31m-		var name = elem.nodeName.toLowerCase();[m
[31m-		return name === "input" && elem.type === type;[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Returns a function to use in pseudos for buttons[m
[31m- * @param {String} type[m
[31m- */[m
[31m-function createButtonPseudo( type ) {[m
[31m-	return function( elem ) {[m
[31m-		var name = elem.nodeName.toLowerCase();[m
[31m-		return (name === "input" || name === "button") && elem.type === type;[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Returns a function to use in pseudos for positionals[m
[31m- * @param {Function} fn[m
[31m- */[m
[31m-function createPositionalPseudo( fn ) {[m
[31m-	return markFunction(function( argument ) {[m
[31m-		argument = +argument;[m
[31m-		return markFunction(function( seed, matches ) {[m
[31m-			var j,[m
[31m-				matchIndexes = fn( [], seed.length, argument ),[m
[31m-				i = matchIndexes.length;[m
[31m-[m
[31m-			// Match elements found at the specified indexes[m
[31m-			while ( i-- ) {[m
[31m-				if ( seed[ (j = matchIndexes[i]) ] ) {[m
[31m-					seed[j] = !(matches[j] = seed[j]);[m
[31m-				}[m
[31m-			}[m
[31m-		});[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-/**[m
[31m- * Detect xml[m
[31m- * @param {Element|Object} elem An element or a document[m
[31m- */[m
[31m-isXML = Sizzle.isXML = function( elem ) {[m
[31m-	// documentElement is verified for cases where it doesn't yet exist[m
[31m-	// (such as loading iframes in IE - #4833)[m
[31m-	var documentElement = elem && (elem.ownerDocument || elem).documentElement;[m
[31m-	return documentElement ? documentElement.nodeName !== "HTML" : false;[m
[31m-};[m
[31m-[m
[31m-// Expose support vars for convenience[m
[31m-support = Sizzle.support = {};[m
[31m-[m
[31m-/**[m
[31m- * Sets document-related variables once based on the current document[m
[31m- * @param {Element|Object} [doc] An element or document object to use to set the document[m
[31m- * @returns {Object} Returns the current document[m
[31m- */[m
[31m-setDocument = Sizzle.setDocument = function( node ) {[m
[31m-	var doc = node ? node.ownerDocument || node : preferredDoc,[m
[31m-		parent = doc.defaultView;[m
[31m-[m
[31m-	// If no document and documentElement is available, return[m
[31m-	if ( doc === document || doc.nodeType !== 9 || !doc.documentElement ) {[m
[31m-		return document;[m
[31m-	}[m
[31m-[m
[31m-	// Set our document[m
[31m-	document = doc;[m
[31m-	docElem = doc.documentElement;[m
[31m-[m
[31m-	// Support tests[m
[31m-	documentIsHTML = !isXML( doc );[m
[31m-[m
[31m-	// Support: IE>8[m
[31m-	// If iframe document is assigned to "document" variable and if iframe has been reloaded,[m
[31m-	// IE will throw "permission denied" error when accessing "document" variable, see jQuery #13936[m
[31m-	// IE6-8 do not support the defaultView property so parent will be undefined[m
[31m-	if ( parent && parent.attachEvent && parent !== parent.top ) {[m
[31m-		parent.attachEvent( "onbeforeunload", function() {[m
[31m-			setDocument();[m
[31m-		});[m
[31m-	}[m
[31m-[m
[31m-	/* Attributes[m
[31m-	---------------------------------------------------------------------- */[m
[31m-[m
[31m-	// Support: IE<8[m
[31m-	// Verify that getAttribute really returns attributes and not properties (excepting IE8 booleans)[m
[31m-	support.attributes = assert(function( div ) {[m
[31m-		div.className = "i";[m
[31m-		return !div.getAttribute("className");[m
[31m-	});[m
[31m-[m
[31m-	/* getElement(s)By*[m
[31m-	---------------------------------------------------------------------- */[m
[31m-[m
[31m-	// Check if getElementsByTagName("*") returns only elements[m
[31m-	support.getElementsByTagName = assert(function( div ) {[m
[31m-		div.appendChild( doc.createComment("") );[m
[31m-		return !div.getElementsByTagName("*").length;[m
[31m-	});[m
[31m-[m
[31m-	// Check if getElementsByClassName can be trusted[m
[31m-	support.getElementsByClassName = assert(function( div ) {[m
[31m-		div.innerHTML = "<div class='a'></div><div class='a i'></div>";[m
[31m-[m
[31m-		// Support: Safari<4[m
[31m-		// Catch class over-caching[m
[31m-		div.firstChild.className = "i";[m
[31m-		// Support: Opera<10[m
[31m-		// Catch gEBCN failure to find non-leading classes[m
[31m-		return div.getElementsByClassName("i").length === 2;[m
[31m-	});[m
[31m-[m
[31m-	// Support: IE<10[m
[31m-	// Check if getElementById returns elements by name[m
[31m-	// The broken getElementById methods don't pick up programatically-set names,[m
[31m-	// so use a roundabout getElementsByName test[m
[31m-	support.getById = assert(function( div ) {[m
[31m-		docElem.appendChild( div ).id = expando;[m
[31m-		return !doc.getElementsByName || !doc.getElementsByName( expando ).length;[m
[31m-	});[m
[31m-[m
[31m-	// ID find and filter[m
[31m-	if ( support.getById ) {[m
[31m-		Expr.find["ID"] = function( id, context ) {[m
[31m-			if ( typeof context.getElementById !== strundefined && documentIsHTML ) {[m
[31m-				var m = context.getElementById( id );[m
[31m-				// Check parentNode to catch when Blackberry 4.6 returns[m
[31m-				// nodes that are no longer in the document #6963[m
[31m-				return m && m.parentNode ? [m] : [];[m
[31m-			}[m
[31m-		};[m
[31m-		Expr.filter["ID"] = function( id ) {[m
[31m-			var attrId = id.replace( runescape, funescape );[m
[31m-			return function( elem ) {[m
[31m-				return elem.getAttribute("id") === attrId;[m
[31m-			};[m
[31m-		};[m
[31m-	} else {[m
[31m-		// Support: IE6/7[m
[31m-		// getElementById is not reliable as a find shortcut[m
[31m-		delete Expr.find["ID"];[m
[31m-[m
[31m-		Expr.filter["ID"] =  function( id ) {[m
[31m-			var attrId = id.replace( runescape, funescape );[m
[31m-			return function( elem ) {[m
[31m-				var node = typeof elem.getAttributeNode !== strundefined && elem.getAttributeNode("id");[m
[31m-				return node && node.value === attrId;[m
[31m-			};[m
[31m-		};[m
[31m-	}[m
[31m-[m
[31m-	// Tag[m
[31m-	Expr.find["TAG"] = support.getElementsByTagName ?[m
[31m-		function( tag, context ) {[m
[31m-			if ( typeof context.getElementsByTagName !== strundefined ) {[m
[31m-				return context.getElementsByTagName( tag );[m
[31m-			}[m
[31m-		} :[m
[31m-		function( tag, context ) {[m
[31m-			var elem,[m
[31m-				tmp = [],[m
[31m-				i = 0,[m
[31m-				results = context.getElementsByTagName( tag );[m
[31m-[m
[31m-			// Filter out possible comments[m
[31m-			if ( tag === "*" ) {[m
[31m-				while ( (elem = results[i++]) ) {[m
[31m-					if ( elem.nodeType === 1 ) {[m
[31m-						tmp.push( elem );[m
[31m-					}[m
[31m-				}[m
[31m-[m
[31m-				return tmp;[m
[31m-			}[m
[31m-			return results;[m
[31m-		};[m
[31m-[m
[31m-	// Class[m
[31m-	Expr.find["CLASS"] = support.getElementsByClassName && function( className, context ) {[m
[31m-		if ( typeof context.getElementsByClassName !== strundefined && documentIsHTML ) {[m
[31m-			return context.getElementsByClassName( className );[m
[31m-		}[m
[31m-	};[m
[31m-[m
[31m-	/* QSA/matchesSelector[m
[31m-	---------------------------------------------------------------------- */[m
[31m-[m
[31m-	// QSA and matchesSelector support[m
[31m-[m
[31m-	// matchesSelector(:active) reports false when true (IE9/Opera 11.5)[m
[31m-	rbuggyMatches = [];[m
[31m-[m
[31m-	// qSa(:focus) reports false when true (Chrome 21)[m
[31m-	// We allow this because of a bug in IE8/9 that throws an error[m
[31m-	// whenever `document.activeElement` is accessed on an iframe[m
[31m-	// So, we allow :focus to pass through QSA all the time to avoid the IE error[m
[31m-	// See http://bugs.jquery.com/ticket/13378[m
[31m-	rbuggyQSA = [];[m
[31m-[m
[31m-	if ( (support.qsa = rnative.test( doc.querySelectorAll )) ) {[m
[31m-		// Build QSA regex[m
[31m-		// Regex strategy adopted from Diego Perini[m
[31m-		assert(function( div ) {[m
[31m-			// Select is set to empty string on purpose[m
[31m-			// This is to test IE's treatment of not explicitly[m
[31m-			// setting a boolean content attribute,[m
[31m-			// since its presence should be enough[m
[31m-			// http://bugs.jquery.com/ticket/12359[m
[31m-			div.innerHTML = "<select><option selected=''></option></select>";[m
[31m-[m
[31m-			// Support: IE8[m
[31m-			// Boolean attributes and "value" are not treated correctly[m
[31m-			if ( !div.querySelectorAll("[selected]").length ) {[m
[31m-				rbuggyQSA.push( "\\[" + whitespace + "*(?:value|" + booleans + ")" );[m
[31m-			}[m
[31m-[m
[31m-			// Webkit/Opera - :checked should return selected option elements[m
[31m-			// http://www.w3.org/TR/2011/REC-css3-selectors-20110929/#checked[m
[31m-			// IE8 throws error here and will not see later tests[m
[31m-			if ( !div.querySelectorAll(":checked").length ) {[m
[31m-				rbuggyQSA.push(":checked");[m
[31m-			}[m
[31m-		});[m
[31m-[m
[31m-		assert(function( div ) {[m
[31m-[m
[31m-			// Support: Opera 10-12/IE8[m
[31m-			// ^= $= *= and empty values[m
[31m-			// Should not select anything[m
[31m-			// Support: Windows 8 Native Apps[m
[31m-			// The type attribute is restricted during .innerHTML assignment[m
[31m-			var input = doc.createElement("input");[m
[31m-			input.setAttribute( "type", "hidden" );[m
[31m-			div.appendChild( input ).setAttribute( "t", "" );[m
[31m-[m
[31m-			if ( div.querySelectorAll("[t^='']").length ) {[m
[31m-				rbuggyQSA.push( "[*^$]=" + whitespace + "*(?:''|\"\")" );[m
[31m-			}[m
[31m-[m
[31m-			// FF 3.5 - :enabled/:disabled and hidden elements (hidden elements are still enabled)[m
[31m-			// IE8 throws error here and will not see later tests[m
[31m-			if ( !div.querySelectorAll(":enabled").length ) {[m
[31m-				rbuggyQSA.push( ":enabled", ":disabled" );[m
[31m-			}[m
[31m-[m
[31m-			// Opera 10-11 does not throw on post-comma invalid pseudos[m
[31m-			div.querySelectorAll("*,:x");[m
[31m-			rbuggyQSA.push(",.*:");[m
[31m-		});[m
[31m-	}[m
[31m-[m
[31m-	if ( (support.matchesSelector = rnative.test( (matches = docElem.webkitMatchesSelector ||[m
[31m-		docElem.mozMatchesSelector ||[m
[31m-		docElem.oMatchesSelector ||[m
[31m-		docElem.msMatchesSelector) )) ) {[m
[31m-[m
[31m-		assert(function( div ) {[m
[31m-			// Check to see if it's possible to do matchesSelector[m
[31m-			// on a disconnected node (IE 9)[m
[31m-			support.disconnectedMatch = matches.call( div, "div" );[m
[31m-[m
[31m-			// This should fail with an exception[m
[31m-			// Gecko does not error, returns false instead[m
[31m-			matches.call( div, "[s!='']:x" );[m
[31m-			rbuggyMatches.push( "!=", pseudos );[m
[31m-		});[m
[31m-	}[m
[31m-[m
[31m-	rbuggyQSA = rbuggyQSA.length && new RegExp( rbuggyQSA.join("|") );[m
[31m-	rbuggyMatches = rbuggyMatches.length && new RegExp( rbuggyMatches.join("|") );[m
[31m-[m
[31m-	/* Contains[m
[31m-	---------------------------------------------------------------------- */[m
[31m-[m
[31m-	// Element contains another[m
[31m-	// Purposefully does not implement inclusive descendent[m
[31m-	// As in, an element does not contain itself[m
[31m-	contains = rnative.test( docElem.contains ) || docElem.compareDocumentPosition ?[m
[31m-		function( a, b ) {[m
[31m-			var adown = a.nodeType === 9 ? a.documentElement : a,[m
[31m-				bup = b && b.parentNode;[m
[31m-			return a === bup || !!( bup && bup.nodeType === 1 && ([m
[31m-				adown.contains ?[m
[31m-					adown.contains( bup ) :[m
[31m-					a.compareDocumentPosition && a.compareDocumentPosition( bup ) & 16[m
[31m-			));[m
[31m-		} :[m
[31m-		function( a, b ) {[m
[31m-			if ( b ) {[m
[31m-				while ( (b = b.parentNode) ) {[m
[31m-					if ( b === a ) {[m
[31m-						return true;[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-			return false;[m
[31m-		};[m
[31m-[m
[31m-	/* Sorting[m
[31m-	---------------------------------------------------------------------- */[m
[31m-[m
[31m-	// Document order sorting[m
[31m-	sortOrder = docElem.compareDocumentPosition ?[m
[31m-	function( a, b ) {[m
[31m-[m
[31m-		// Flag for duplicate removal[m
[31m-		if ( a === b ) {[m
[31m-			hasDuplicate = true;[m
[31m-			return 0;[m
[31m-		}[m
[31m-[m
[31m-		var compare = b.compareDocumentPosition && a.compareDocumentPosition && a.compareDocumentPosition( b );[m
[31m-[m
[31m-		if ( compare ) {[m
[31m-			// Disconnected nodes[m
[31m-			if ( compare & 1 ||[m
[31m-				(!support.sortDetached && b.compareDocumentPosition( a ) === compare) ) {[m
[31m-[m
[31m-				// Choose the first element that is related to our preferred document[m
[31m-				if ( a === doc || contains(preferredDoc, a) ) {[m
[31m-					return -1;[m
[31m-				}[m
[31m-				if ( b === doc || contains(preferredDoc, b) ) {[m
[31m-					return 1;[m
[31m-				}[m
[31m-[m
[31m-				// Maintain original order[m
[31m-				return sortInput ?[m
[31m-					( indexOf.call( sortInput, a ) - indexOf.call( sortInput, b ) ) :[m
[31m-					0;[m
[31m-			}[m
[31m-[m
[31m-			return compare & 4 ? -1 : 1;[m
[31m-		}[m
[31m-[m
[31m-		// Not directly comparable, sort on existence of method[m
[31m-		return a.compareDocumentPosition ? -1 : 1;[m
[31m-	} :[m
[31m-	function( a, b ) {[m
[31m-		var cur,[m
[31m-			i = 0,[m
[31m-			aup = a.parentNode,[m
[31m-			bup = b.parentNode,[m
[31m-			ap = [ a ],[m
[31m-			bp = [ b ];[m
[31m-[m
[31m-		// Exit early if the nodes are identical[m
[31m-		if ( a === b ) {[m
[31m-			hasDuplicate = true;[m
[31m-			return 0;[m
[31m-[m
[31m-		// Parentless nodes are either documents or disconnected[m
[31m-		} else if ( !aup || !bup ) {[m
[31m-			return a === doc ? -1 :[m
[31m-				b === doc ? 1 :[m
[31m-				aup ? -1 :[m
[31m-				bup ? 1 :[m
[31m-				sortInput ?[m
[31m-				( indexOf.call( sortInput, a ) - indexOf.call( sortInput, b ) ) :[m
[31m-				0;[m
[31m-[m
[31m-		// If the nodes are siblings, we can do a quick check[m
[31m-		} else if ( aup === bup ) {[m
[31m-			return siblingCheck( a, b );[m
[31m-		}[m
[31m-[m
[31m-		// Otherwise we need full lists of their ancestors for comparison[m
[31m-		cur = a;[m
[31m-		while ( (cur = cur.parentNode) ) {[m
[31m-			ap.unshift( cur );[m
[31m-		}[m
[31m-		cur = b;[m
[31m-		while ( (cur = cur.parentNode) ) {[m
[31m-			bp.unshift( cur );[m
[31m-		}[m
[31m-[m
[31m-		// Walk down the tree looking for a discrepancy[m
[31m-		while ( ap[i] === bp[i] ) {[m
[31m-			i++;[m
[31m-		}[m
[31m-[m
[31m-		return i ?[m
[31m-			// Do a sibling check if the nodes have a common ancestor[m
[31m-			siblingCheck( ap[i], bp[i] ) :[m
[31m-[m
[31m-			// Otherwise nodes in our document sort first[m
[31m-			ap[i] === preferredDoc ? -1 :[m
[31m-			bp[i] === preferredDoc ? 1 :[m
[31m-			0;[m
[31m-	};[m
[31m-[m
[31m-	return doc;[m
[31m-};[m
[31m-[m
[31m-Sizzle.matches = function( expr, elements ) {[m
[31m-	return Sizzle( expr, null, null, elements );[m
[31m-};[m
[31m-[m
[31m-Sizzle.matchesSelector = function( elem, expr ) {[m
[31m-	// Set document vars if needed[m
[31m-	if ( ( elem.ownerDocument || elem ) !== document ) {[m
[31m-		setDocument( elem );[m
[31m-	}[m
[31m-[m
[31m-	// Make sure that attribute selectors are quoted[m
[31m-	expr = expr.replace( rattributeQuotes, "='$1']" );[m
[31m-[m
[31m-	if ( support.matchesSelector && documentIsHTML &&[m
[31m-		( !rbuggyMatches || !rbuggyMatches.test( expr ) ) &&[m
[31m-		( !rbuggyQSA     || !rbuggyQSA.test( expr ) ) ) {[m
[31m-[m
[31m-		try {[m
[31m-			var ret = matches.call( elem, expr );[m
[31m-[m
[31m-			// IE 9's matchesSelector returns false on disconnected nodes[m
[31m-			if ( ret || support.disconnectedMatch ||[m
[31m-					// As well, disconnected nodes are said to be in a document[m
[31m-					// fragment in IE 9[m
[31m-					elem.document && elem.document.nodeType !== 11 ) {[m
[31m-				return ret;[m
[31m-			}[m
[31m-		} catch(e) {}[m
[31m-	}[m
[31m-[m
[31m-	return Sizzle( expr, document, null, [elem] ).length > 0;[m
[31m-};[m
[31m-[m
[31m-Sizzle.contains = function( context, elem ) {[m
[31m-	// Set document vars if needed[m
[31m-	if ( ( context.ownerDocument || context ) !== document ) {[m
[31m-		setDocument( context );[m
[31m-	}[m
[31m-	return contains( context, elem );[m
[31m-};[m
[31m-[m
[31m-Sizzle.attr = function( elem, name ) {[m
[31m-	// Set document vars if needed[m
[31m-	if ( ( elem.ownerDocument || elem ) !== document ) {[m
[31m-		setDocument( elem );[m
[31m-	}[m
[31m-[m
[31m-	var fn = Expr.attrHandle[ name.toLowerCase() ],[m
[31m-		// Don't get fooled by Object.prototype properties (jQuery #13807)[m
[31m-		val = fn && hasOwn.call( Expr.attrHandle, name.toLowerCase() ) ?[m
[31m-			fn( elem, name, !documentIsHTML ) :[m
[31m-			undefined;[m
[31m-[m
[31m-	return val === undefined ?[m
[31m-		support.attributes || !documentIsHTML ?[m
[31m-			elem.getAttribute( name ) :[m
[31m-			(val = elem.getAttributeNode(name)) && val.specified ?[m
[31m-				val.value :[m
[31m-				null :[m
[31m-		val;[m
[31m-};[m
[31m-[m
[31m-Sizzle.error = function( msg ) {[m
[31m-	throw new Error( "Syntax error, unrecognized expression: " + msg );[m
[31m-};[m
[31m-[m
[31m-/**[m
[31m- * Document sorting and removing duplicates[m
[31m- * @param {ArrayLike} results[m
[31m- */[m
[31m-Sizzle.uniqueSort = function( results ) {[m
[31m-	var elem,[m
[31m-		duplicates = [],[m
[31m-		j = 0,[m
[31m-		i = 0;[m
[31m-[m
[31m-	// Unless we *know* we can detect duplicates, assume their presence[m
[31m-	hasDuplicate = !support.detectDuplicates;[m
[31m-	sortInput = !support.sortStable && results.slice( 0 );[m
[31m-	results.sort( sortOrder );[m
[31m-[m
[31m-	if ( hasDuplicate ) {[m
[31m-		while ( (elem = results[i++]) ) {[m
[31m-			if ( elem === results[ i ] ) {[m
[31m-				j = duplicates.push( i );[m
[31m-			}[m
[31m-		}[m
[31m-		while ( j-- ) {[m
[31m-			results.splice( duplicates[ j ], 1 );[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	return results;[m
[31m-};[m
[31m-[m
[31m-/**[m
[31m- * Utility function for retrieving the text value of an array of DOM nodes[m
[31m- * @param {Array|Element} elem[m
[31m- */[m
[31m-getText = Sizzle.getText = function( elem ) {[m
[31m-	var node,[m
[31m-		ret = "",[m
[31m-		i = 0,[m
[31m-		nodeType = elem.nodeType;[m
[31m-[m
[31m-	if ( !nodeType ) {[m
[31m-		// If no nodeType, this is expected to be an array[m
[31m-		for ( ; (node = elem[i]); i++ ) {[m
[31m-			// Do not traverse comment nodes[m
[31m-			ret += getText( node );[m
[31m-		}[m
[31m-	} else if ( nodeType === 1 || nodeType === 9 || nodeType === 11 ) {[m
[31m-		// Use textContent for elements[m
[31m-		// innerText usage removed for consistency of new lines (see #11153)[m
[31m-		if ( typeof elem.textContent === "string" ) {[m
[31m-			return elem.textContent;[m
[31m-		} else {[m
[31m-			// Traverse its children[m
[31m-			for ( elem = elem.firstChild; elem; elem = elem.nextSibling ) {[m
[31m-				ret += getText( elem );[m
[31m-			}[m
[31m-		}[m
[31m-	} else if ( nodeType === 3 || nodeType === 4 ) {[m
[31m-		return elem.nodeValue;[m
[31m-	}[m
[31m-	// Do not include comment or processing instruction nodes[m
[31m-[m
[31m-	return ret;[m
[31m-};[m
[31m-[m
[31m-Expr = Sizzle.selectors = {[m
[31m-[m
[31m-	// Can be adjusted by the user[m
[31m-	cacheLength: 50,[m
[31m-[m
[31m-	createPseudo: markFunction,[m
[31m-[m
[31m-	match: matchExpr,[m
[31m-[m
[31m-	attrHandle: {},[m
[31m-[m
[31m-	find: {},[m
[31m-[m
[31m-	relative: {[m
[31m-		">": { dir: "parentNode", first: true },[m
[31m-		" ": { dir: "parentNode" },[m
[31m-		"+": { dir: "previousSibling", first: true },[m
[31m-		"~": { dir: "previousSibling" }[m
[31m-	},[m
[31m-[m
[31m-	preFilter: {[m
[31m-		"ATTR": function( match ) {[m
[31m-			match[1] = match[1].replace( runescape, funescape );[m
[31m-[m
[31m-			// Move the given value to match[3] whether quoted or unquoted[m
[31m-			match[3] = ( match[4] || match[5] || "" ).replace( runescape, funescape );[m
[31m-[m
[31m-			if ( match[2] === "~=" ) {[m
[31m-				match[3] = " " + match[3] + " ";[m
[31m-			}[m
[31m-[m
[31m-			return match.slice( 0, 4 );[m
[31m-		},[m
[31m-[m
[31m-		"CHILD": function( match ) {[m
[31m-			/* matches from matchExpr["CHILD"][m
[31m-				1 type (only|nth|...)[m
[31m-				2 what (child|of-type)[m
[31m-				3 argument (even|odd|\d*|\d*n([+-]\d+)?|...)[m
[31m-				4 xn-component of xn+y argument ([+-]?\d*n|)[m
[31m-				5 sign of xn-component[m
[31m-				6 x of xn-component[m
[31m-				7 sign of y-component[m
[31m-				8 y of y-component[m
[31m-			*/[m
[31m-			match[1] = match[1].toLowerCase();[m
[31m-[m
[31m-			if ( match[1].slice( 0, 3 ) === "nth" ) {[m
[31m-				// nth-* requires argument[m
[31m-				if ( !match[3] ) {[m
[31m-					Sizzle.error( match[0] );[m
[31m-				}[m
[31m-[m
[31m-				// numeric x and y parameters for Expr.filter.CHILD[m
[31m-				// remember that false/true cast respectively to 0/1[m
[31m-				match[4] = +( match[4] ? match[5] + (match[6] || 1) : 2 * ( match[3] === "even" || match[3] === "odd" ) );[m
[31m-				match[5] = +( ( match[7] + match[8] ) || match[3] === "odd" );[m
[31m-[m
[31m-			// other types prohibit arguments[m
[31m-			} else if ( match[3] ) {[m
[31m-				Sizzle.error( match[0] );[m
[31m-			}[m
[31m-[m
[31m-			return match;[m
[31m-		},[m
[31m-[m
[31m-		"PSEUDO": function( match ) {[m
[31m-			var excess,[m
[31m-				unquoted = !match[5] && match[2];[m
[31m-[m
[31m-			if ( matchExpr["CHILD"].test( match[0] ) ) {[m
[31m-				return null;[m
[31m-			}[m
[31m-[m
[31m-			// Accept quoted arguments as-is[m
[31m-			if ( match[3] && match[4] !== undefined ) {[m
[31m-				match[2] = match[4];[m
[31m-[m
[31m-			// Strip excess characters from unquoted arguments[m
[31m-			} else if ( unquoted && rpseudo.test( unquoted ) &&[m
[31m-				// Get excess from tokenize (recursively)[m
[31m-				(excess = tokenize( unquoted, true )) &&[m
[31m-				// advance to the next closing parenthesis[m
[31m-				(excess = unquoted.indexOf( ")", unquoted.length - excess ) - unquoted.length) ) {[m
[31m-[m
[31m-				// excess is a negative index[m
[31m-				match[0] = match[0].slice( 0, excess );[m
[31m-				match[2] = unquoted.slice( 0, excess );[m
[31m-			}[m
[31m-[m
[31m-			// Return only captures needed by the pseudo filter method (type and argument)[m
[31m-			return match.slice( 0, 3 );[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	filter: {[m
[31m-[m
[31m-		"TAG": function( nodeNameSelector ) {[m
[31m-			var nodeName = nodeNameSelector.replace( runescape, funescape ).toLowerCase();[m
[31m-			return nodeNameSelector === "*" ?[m
[31m-				function() { return true; } :[m
[31m-				function( elem ) {[m
[31m-					return elem.nodeName && elem.nodeName.toLowerCase() === nodeName;[m
[31m-				};[m
[31m-		},[m
[31m-[m
[31m-		"CLASS": function( className ) {[m
[31m-			var pattern = classCache[ className + " " ];[m
[31m-[m
[31m-			return pattern ||[m
[31m-				(pattern = new RegExp( "(^|" + whitespace + ")" + className + "(" + whitespace + "|$)" )) &&[m
[31m-				classCache( className, function( elem ) {[m
[31m-					return pattern.test( typeof elem.className === "string" && elem.className || typeof elem.getAttribute !== strundefined && elem.getAttribute("class") || "" );[m
[31m-				});[m
[31m-		},[m
[31m-[m
[31m-		"ATTR": function( name, operator, check ) {[m
[31m-			return function( elem ) {[m
[31m-				var result = Sizzle.attr( elem, name );[m
[31m-[m
[31m-				if ( result == null ) {[m
[31m-					return operator === "!=";[m
[31m-				}[m
[31m-				if ( !operator ) {[m
[31m-					return true;[m
[31m-				}[m
[31m-[m
[31m-				result += "";[m
[31m-[m
[31m-				return operator === "=" ? result === check :[m
[31m-					operator === "!=" ? result !== check :[m
[31m-					operator === "^=" ? check && result.indexOf( check ) === 0 :[m
[31m-					operator === "*=" ? check && result.indexOf( check ) > -1 :[m
[31m-					operator === "$=" ? check && result.slice( -check.length ) === check :[m
[31m-					operator === "~=" ? ( " " + result + " " ).indexOf( check ) > -1 :[m
[31m-					operator === "|=" ? result === check || result.slice( 0, check.length + 1 ) === check + "-" :[m
[31m-					false;[m
[31m-			};[m
[31m-		},[m
[31m-[m
[31m-		"CHILD": function( type, what, argument, first, last ) {[m
[31m-			var simple = type.slice( 0, 3 ) !== "nth",[m
[31m-				forward = type.slice( -4 ) !== "last",[m
[31m-				ofType = what === "of-type";[m
[31m-[m
[31m-			return first === 1 && last === 0 ?[m
[31m-[m
[31m-				// Shortcut for :nth-*(n)[m
[31m-				function( elem ) {[m
[31m-					return !!elem.parentNode;[m
[31m-				} :[m
[31m-[m
[31m-				function( elem, context, xml ) {[m
[31m-					var cache, outerCache, node, diff, nodeIndex, start,[m
[31m-						dir = simple !== forward ? "nextSibling" : "previousSibling",[m
[31m-						parent = elem.parentNode,[m
[31m-						name = ofType && elem.nodeName.toLowerCase(),[m
[31m-						useCache = !xml && !ofType;[m
[31m-[m
[31m-					if ( parent ) {[m
[31m-[m
[31m-						// :(first|last|only)-(child|of-type)[m
[31m-						if ( simple ) {[m
[31m-							while ( dir ) {[m
[31m-								node = elem;[m
[31m-								while ( (node = node[ dir ]) ) {[m
[31m-									if ( ofType ? node.nodeName.toLowerCase() === name : node.nodeType === 1 ) {[m
[31m-										return false;[m
[31m-									}[m
[31m-								}[m
[31m-								// Reverse direction for :only-* (if we haven't yet done so)[m
[31m-								start = dir = type === "only" && !start && "nextSibling";[m
[31m-							}[m
[31m-							return true;[m
[31m-						}[m
[31m-[m
[31m-						start = [ forward ? parent.firstChild : parent.lastChild ];[m
[31m-[m
[31m-						// non-xml :nth-child(...) stores cache data on `parent`[m
[31m-						if ( forward && useCache ) {[m
[31m-							// Seek `elem` from a previously-cached index[m
[31m-							outerCache = parent[ expando ] || (parent[ expando ] = {});[m
[31m-							cache = outerCache[ type ] || [];[m
[31m-							nodeIndex = cache[0] === dirruns && cache[1];[m
[31m-							diff = cache[0] === dirruns && cache[2];[m
[31m-							node = nodeIndex && parent.childNodes[ nodeIndex ];[m
[31m-[m
[31m-							while ( (node = ++nodeIndex && node && node[ dir ] ||[m
[31m-[m
[31m-								// Fallback to seeking `elem` from the start[m
[31m-								(diff = nodeIndex = 0) || start.pop()) ) {[m
[31m-[m
[31m-								// When found, cache indexes on `parent` and break[m
[31m-								if ( node.nodeType === 1 && ++diff && node === elem ) {[m
[31m-									outerCache[ type ] = [ dirruns, nodeIndex, diff ];[m
[31m-									break;[m
[31m-								}[m
[31m-							}[m
[31m-[m
[31m-						// Use previously-cached element index if available[m
[31m-						} else if ( useCache && (cache = (elem[ expando ] || (elem[ expando ] = {}))[ type ]) && cache[0] === dirruns ) {[m
[31m-							diff = cache[1];[m
[31m-[m
[31m-						// xml :nth-child(...) or :nth-last-child(...) or :nth(-last)?-of-type(...)[m
[31m-						} else {[m
[31m-							// Use the same loop as above to seek `elem` from the start[m
[31m-							while ( (node = ++nodeIndex && node && node[ dir ] ||[m
[31m-								(diff = nodeIndex = 0) || start.pop()) ) {[m
[31m-[m
[31m-								if ( ( ofType ? node.nodeName.toLowerCase() === name : node.nodeType === 1 ) && ++diff ) {[m
[31m-									// Cache the index of each encountered element[m
[31m-									if ( useCache ) {[m
[31m-										(node[ expando ] || (node[ expando ] = {}))[ type ] = [ dirruns, diff ];[m
[31m-									}[m
[31m-[m
[31m-									if ( node === elem ) {[m
[31m-										break;[m
[31m-									}[m
[31m-								}[m
[31m-							}[m
[31m-						}[m
[31m-[m
[31m-						// Incorporate the offset, then check against cycle size[m
[31m-						diff -= last;[m
[31m-						return diff === first || ( diff % first === 0 && diff / first >= 0 );[m
[31m-					}[m
[31m-				};[m
[31m-		},[m
[31m-[m
[31m-		"PSEUDO": function( pseudo, argument ) {[m
[31m-			// pseudo-class names are case-insensitive[m
[31m-			// http://www.w3.org/TR/selectors/#pseudo-classes[m
[31m-			// Prioritize by case sensitivity in case custom pseudos are added with uppercase letters[m
[31m-			// Remember that setFilters inherits from pseudos[m
[31m-			var args,[m
[31m-				fn = Expr.pseudos[ pseudo ] || Expr.setFilters[ pseudo.toLowerCase() ] ||[m
[31m-					Sizzle.error( "unsupported pseudo: " + pseudo );[m
[31m-[m
[31m-			// The user may use createPseudo to indicate that[m
[31m-			// arguments are needed to create the filter function[m
[31m-			// just as Sizzle does[m
[31m-			if ( fn[ expando ] ) {[m
[31m-				return fn( argument );[m
[31m-			}[m
[31m-[m
[31m-			// But maintain support for old signatures[m
[31m-			if ( fn.length > 1 ) {[m
[31m-				args = [ pseudo, pseudo, "", argument ];[m
[31m-				return Expr.setFilters.hasOwnProperty( pseudo.toLowerCase() ) ?[m
[31m-					markFunction(function( seed, matches ) {[m
[31m-						var idx,[m
[31m-							matched = fn( seed, argument ),[m
[31m-							i = matched.length;[m
[31m-						while ( i-- ) {[m
[31m-							idx = indexOf.call( seed, matched[i] );[m
[31m-							seed[ idx ] = !( matches[ idx ] = matched[i] );[m
[31m-						}[m
[31m-					}) :[m
[31m-					function( elem ) {[m
[31m-						return fn( elem, 0, args );[m
[31m-					};[m
[31m-			}[m
[31m-[m
[31m-			return fn;[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	pseudos: {[m
[31m-		// Potentially complex pseudos[m
[31m-		"not": markFunction(function( selector ) {[m
[31m-			// Trim the selector passed to compile[m
[31m-			// to avoid treating leading and trailing[m
[31m-			// spaces as combinators[m
[31m-			var input = [],[m
[31m-				results = [],[m
[31m-				matcher = compile( selector.replace( rtrim, "$1" ) );[m
[31m-[m
[31m-			return matcher[ expando ] ?[m
[31m-				markFunction(function( seed, matches, context, xml ) {[m
[31m-					var elem,[m
[31m-						unmatched = matcher( seed, null, xml, [] ),[m
[31m-						i = seed.length;[m
[31m-[m
[31m-					// Match elements unmatched by `matcher`[m
[31m-					while ( i-- ) {[m
[31m-						if ( (elem = unmatched[i]) ) {[m
[31m-							seed[i] = !(matches[i] = elem);[m
[31m-						}[m
[31m-					}[m
[31m-				}) :[m
[31m-				function( elem, context, xml ) {[m
[31m-					input[0] = elem;[m
[31m-					matcher( input, null, xml, results );[m
[31m-					return !results.pop();[m
[31m-				};[m
[31m-		}),[m
[31m-[m
[31m-		"has": markFunction(function( selector ) {[m
[31m-			return function( elem ) {[m
[31m-				return Sizzle( selector, elem ).length > 0;[m
[31m-			};[m
[31m-		}),[m
[31m-[m
[31m-		"contains": markFunction(function( text ) {[m
[31m-			return function( elem ) {[m
[31m-				return ( elem.textContent || elem.innerText || getText( elem ) ).indexOf( text ) > -1;[m
[31m-			};[m
[31m-		}),[m
[31m-[m
[31m-		// "Whether an element is represented by a :lang() selector[m
[31m-		// is based solely on the element's language value[m
[31m-		// being equal to the identifier C,[m
[31m-		// or beginning with the identifier C immediately followed by "-".[m
[31m-		// The matching of C against the element's language value is performed case-insensitively.[m
[31m-		// The identifier C does not have to be a valid language name."[m
[31m-		// http://www.w3.org/TR/selectors/#lang-pseudo[m
[31m-		"lang": markFunction( function( lang ) {[m
[31m-			// lang value must be a valid identifier[m
[31m-			if ( !ridentifier.test(lang || "") ) {[m
[31m-				Sizzle.error( "unsupported lang: " + lang );[m
[31m-			}[m
[31m-			lang = lang.replace( runescape, funescape ).toLowerCase();[m
[31m-			return function( elem ) {[m
[31m-				var elemLang;[m
[31m-				do {[m
[31m-					if ( (elemLang = documentIsHTML ?[m
[31m-						elem.lang :[m
[31m-						elem.getAttribute("xml:lang") || elem.getAttribute("lang")) ) {[m
[31m-[m
[31m-						elemLang = elemLang.toLowerCase();[m
[31m-						return elemLang === lang || elemLang.indexOf( lang + "-" ) === 0;[m
[31m-					}[m
[31m-				} while ( (elem = elem.parentNode) && elem.nodeType === 1 );[m
[31m-				return false;[m
[31m-			};[m
[31m-		}),[m
[31m-[m
[31m-		// Miscellaneous[m
[31m-		"target": function( elem ) {[m
[31m-			var hash = window.location && window.location.hash;[m
[31m-			return hash && hash.slice( 1 ) === elem.id;[m
[31m-		},[m
[31m-[m
[31m-		"root": function( elem ) {[m
[31m-			return elem === docElem;[m
[31m-		},[m
[31m-[m
[31m-		"focus": function( elem ) {[m
[31m-			return elem === document.activeElement && (!document.hasFocus || document.hasFocus()) && !!(elem.type || elem.href || ~elem.tabIndex);[m
[31m-		},[m
[31m-[m
[31m-		// Boolean properties[m
[31m-		"enabled": function( elem ) {[m
[31m-			return elem.disabled === false;[m
[31m-		},[m
[31m-[m
[31m-		"disabled": function( elem ) {[m
[31m-			return elem.disabled === true;[m
[31m-		},[m
[31m-[m
[31m-		"checked": function( elem ) {[m
[31m-			// In CSS3, :checked should return both checked and selected elements[m
[31m-			// http://www.w3.org/TR/2011/REC-css3-selectors-20110929/#checked[m
[31m-			var nodeName = elem.nodeName.toLowerCase();[m
[31m-			return (nodeName === "input" && !!elem.checked) || (nodeName === "option" && !!elem.selected);[m
[31m-		},[m
[31m-[m
[31m-		"selected": function( elem ) {[m
[31m-			// Accessing this property makes selected-by-default[m
[31m-			// options in Safari work properly[m
[31m-			if ( elem.parentNode ) {[m
[31m-				elem.parentNode.selectedIndex;[m
[31m-			}[m
[31m-[m
[31m-			return elem.selected === true;[m
[31m-		},[m
[31m-[m
[31m-		// Contents[m
[31m-		"empty": function( elem ) {[m
[31m-			// http://www.w3.org/TR/selectors/#empty-pseudo[m
[31m-			// :empty is only affected by element nodes and content nodes(including text(3), cdata(4)),[m
[31m-			//   not comment, processing instructions, or others[m
[31m-			// Thanks to Diego Perini for the nodeName shortcut[m
[31m-			//   Greater than "@" means alpha characters (specifically not starting with "#" or "?")[m
[31m-			for ( elem = elem.firstChild; elem; elem = elem.nextSibling ) {[m
[31m-				if ( elem.nodeName > "@" || elem.nodeType === 3 || elem.nodeType === 4 ) {[m
[31m-					return false;[m
[31m-				}[m
[31m-			}[m
[31m-			return true;[m
[31m-		},[m
[31m-[m
[31m-		"parent": function( elem ) {[m
[31m-			return !Expr.pseudos["empty"]( elem );[m
[31m-		},[m
[31m-[m
[31m-		// Element/input types[m
[31m-		"header": function( elem ) {[m
[31m-			return rheader.test( elem.nodeName );[m
[31m-		},[m
[31m-[m
[31m-		"input": function( elem ) {[m
[31m-			return rinputs.test( elem.nodeName );[m
[31m-		},[m
[31m-[m
[31m-		"button": function( elem ) {[m
[31m-			var name = elem.nodeName.toLowerCase();[m
[31m-			return name === "input" && elem.type === "button" || name === "button";[m
[31m-		},[m
[31m-[m
[31m-		"text": function( elem ) {[m
[31m-			var attr;[m
[31m-			// IE6 and 7 will map elem.type to 'text' for new HTML5 types (search, etc)[m
[31m-			// use getAttribute instead to test this case[m
[31m-			return elem.nodeName.toLowerCase() === "input" &&[m
[31m-				elem.type === "text" &&[m
[31m-				( (attr = elem.getAttribute("type")) == null || attr.toLowerCase() === elem.type );[m
[31m-		},[m
[31m-[m
[31m-		// Position-in-collection[m
[31m-		"first": createPositionalPseudo(function() {[m
[31m-			return [ 0 ];[m
[31m-		}),[m
[31m-[m
[31m-		"last": createPositionalPseudo(function( matchIndexes, length ) {[m
[31m-			return [ length - 1 ];[m
[31m-		}),[m
[31m-[m
[31m-		"eq": createPositionalPseudo(function( matchIndexes, length, argument ) {[m
[31m-			return [ argument < 0 ? argument + length : argument ];[m
[31m-		}),[m
[31m-[m
[31m-		"even": createPositionalPseudo(function( matchIndexes, length ) {[m
[31m-			var i = 0;[m
[31m-			for ( ; i < length; i += 2 ) {[m
[31m-				matchIndexes.push( i );[m
[31m-			}[m
[31m-			return matchIndexes;[m
[31m-		}),[m
[31m-[m
[31m-		"odd": createPositionalPseudo(function( matchIndexes, length ) {[m
[31m-			var i = 1;[m
[31m-			for ( ; i < length; i += 2 ) {[m
[31m-				matchIndexes.push( i );[m
[31m-			}[m
[31m-			return matchIndexes;[m
[31m-		}),[m
[31m-[m
[31m-		"lt": createPositionalPseudo(function( matchIndexes, length, argument ) {[m
[31m-			var i = argument < 0 ? argument + length : argument;[m
[31m-			for ( ; --i >= 0; ) {[m
[31m-				matchIndexes.push( i );[m
[31m-			}[m
[31m-			return matchIndexes;[m
[31m-		}),[m
[31m-[m
[31m-		"gt": createPositionalPseudo(function( matchIndexes, length, argument ) {[m
[31m-			var i = argument < 0 ? argument + length : argument;[m
[31m-			for ( ; ++i < length; ) {[m
[31m-				matchIndexes.push( i );[m
[31m-			}[m
[31m-			return matchIndexes;[m
[31m-		})[m
[31m-	}[m
[31m-};[m
[31m-[m
[31m-Expr.pseudos["nth"] = Expr.pseudos["eq"];[m
[31m-[m
[31m-// Add button/input type pseudos[m
[31m-for ( i in { radio: true, checkbox: true, file: true, password: true, image: true } ) {[m
[31m-	Expr.pseudos[ i ] = createInputPseudo( i );[m
[31m-}[m
[31m-for ( i in { submit: true, reset: true } ) {[m
[31m-	Expr.pseudos[ i ] = createButtonPseudo( i );[m
[31m-}[m
[31m-[m
[31m-// Easy API for creating new setFilters[m
[31m-function setFilters() {}[m
[31m-setFilters.prototype = Expr.filters = Expr.pseudos;[m
[31m-Expr.setFilters = new setFilters();[m
[31m-[m
[31m-function tokenize( selector, parseOnly ) {[m
[31m-	var matched, match, tokens, type,[m
[31m-		soFar, groups, preFilters,[m
[31m-		cached = tokenCache[ selector + " " ];[m
[31m-[m
[31m-	if ( cached ) {[m
[31m-		return parseOnly ? 0 : cached.slice( 0 );[m
[31m-	}[m
[31m-[m
[31m-	soFar = selector;[m
[31m-	groups = [];[m
[31m-	preFilters = Expr.preFilter;[m
[31m-[m
[31m-	while ( soFar ) {[m
[31m-[m
[31m-		// Comma and first run[m
[31m-		if ( !matched || (match = rcomma.exec( soFar )) ) {[m
[31m-			if ( match ) {[m
[31m-				// Don't consume trailing commas as valid[m
[31m-				soFar = soFar.slice( match[0].length ) || soFar;[m
[31m-			}[m
[31m-			groups.push( tokens = [] );[m
[31m-		}[m
[31m-[m
[31m-		matched = false;[m
[31m-[m
[31m-		// Combinators[m
[31m-		if ( (match = rcombinators.exec( soFar )) ) {[m
[31m-			matched = match.shift();[m
[31m-			tokens.push({[m
[31m-				value: matched,[m
[31m-				// Cast descendant combinators to space[m
[31m-				type: match[0].replace( rtrim, " " )[m
[31m-			});[m
[31m-			soFar = soFar.slice( matched.length );[m
[31m-		}[m
[31m-[m
[31m-		// Filters[m
[31m-		for ( type in Expr.filter ) {[m
[31m-			if ( (match = matchExpr[ type ].exec( soFar )) && (!preFilters[ type ] ||[m
[31m-				(match = preFilters[ type ]( match ))) ) {[m
[31m-				matched = match.shift();[m
[31m-				tokens.push({[m
[31m-					value: matched,[m
[31m-					type: type,[m
[31m-					matches: match[m
[31m-				});[m
[31m-				soFar = soFar.slice( matched.length );[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		if ( !matched ) {[m
[31m-			break;[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	// Return the length of the invalid excess[m
[31m-	// if we're just parsing[m
[31m-	// Otherwise, throw an error or return tokens[m
[31m-	return parseOnly ?[m
[31m-		soFar.length :[m
[31m-		soFar ?[m
[31m-			Sizzle.error( selector ) :[m
[31m-			// Cache the tokens[m
[31m-			tokenCache( selector, groups ).slice( 0 );[m
[31m-}[m
[31m-[m
[31m-function toSelector( tokens ) {[m
[31m-	var i = 0,[m
[31m-		len = tokens.length,[m
[31m-		selector = "";[m
[31m-	for ( ; i < len; i++ ) {[m
[31m-		selector += tokens[i].value;[m
[31m-	}[m
[31m-	return selector;[m
[31m-}[m
[31m-[m
[31m-function addCombinator( matcher, combinator, base ) {[m
[31m-	var dir = combinator.dir,[m
[31m-		checkNonElements = base && dir === "parentNode",[m
[31m-		doneName = done++;[m
[31m-[m
[31m-	return combinator.first ?[m
[31m-		// Check against closest ancestor/preceding element[m
[31m-		function( elem, context, xml ) {[m
[31m-			while ( (elem = elem[ dir ]) ) {[m
[31m-				if ( elem.nodeType === 1 || checkNonElements ) {[m
[31m-					return matcher( elem, context, xml );[m
[31m-				}[m
[31m-			}[m
[31m-		} :[m
[31m-[m
[31m-		// Check against all ancestor/preceding elements[m
[31m-		function( elem, context, xml ) {[m
[31m-			var data, cache, outerCache,[m
[31m-				dirkey = dirruns + " " + doneName;[m
[31m-[m
[31m-			// We can't set arbitrary data on XML nodes, so they don't benefit from dir caching[m
[31m-			if ( xml ) {[m
[31m-				while ( (elem = elem[ dir ]) ) {[m
[31m-					if ( elem.nodeType === 1 || checkNonElements ) {[m
[31m-						if ( matcher( elem, context, xml ) ) {[m
[31m-							return true;[m
[31m-						}[m
[31m-					}[m
[31m-				}[m
[31m-			} else {[m
[31m-				while ( (elem = elem[ dir ]) ) {[m
[31m-					if ( elem.nodeType === 1 || checkNonElements ) {[m
[31m-						outerCache = elem[ expando ] || (elem[ expando ] = {});[m
[31m-						if ( (cache = outerCache[ dir ]) && cache[0] === dirkey ) {[m
[31m-							if ( (data = cache[1]) === true || data === cachedruns ) {[m
[31m-								return data === true;[m
[31m-							}[m
[31m-						} else {[m
[31m-							cache = outerCache[ dir ] = [ dirkey ];[m
[31m-							cache[1] = matcher( elem, context, xml ) || cachedruns;[m
[31m-							if ( cache[1] === true ) {[m
[31m-								return true;[m
[31m-							}[m
[31m-						}[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		};[m
[31m-}[m
[31m-[m
[31m-function elementMatcher( matchers ) {[m
[31m-	return matchers.length > 1 ?[m
[31m-		function( elem, context, xml ) {[m
[31m-			var i = matchers.length;[m
[31m-			while ( i-- ) {[m
[31m-				if ( !matchers[i]( elem, context, xml ) ) {[m
[31m-					return false;[m
[31m-				}[m
[31m-			}[m
[31m-			return true;[m
[31m-		} :[m
[31m-		matchers[0];[m
[31m-}[m
[31m-[m
[31m-function condense( unmatched, map, filter, context, xml ) {[m
[31m-	var elem,[m
[31m-		newUnmatched = [],[m
[31m-		i = 0,[m
[31m-		len = unmatched.length,[m
[31m-		mapped = map != null;[m
[31m-[m
[31m-	for ( ; i < len; i++ ) {[m
[31m-		if ( (elem = unmatched[i]) ) {[m
[31m-			if ( !filter || filter( elem, context, xml ) ) {[m
[31m-				newUnmatched.push( elem );[m
[31m-				if ( mapped ) {[m
[31m-					map.push( i );[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	return newUnmatched;[m
[31m-}[m
[31m-[m
[31m-function setMatcher( preFilter, selector, matcher, postFilter, postFinder, postSelector ) {[m
[31m-	if ( postFilter && !postFilter[ expando ] ) {[m
[31m-		postFilter = setMatcher( postFilter );[m
[31m-	}[m
[31m-	if ( postFinder && !postFinder[ expando ] ) {[m
[31m-		postFinder = setMatcher( postFinder, postSelector );[m
[31m-	}[m
[31m-	return markFunction(function( seed, results, context, xml ) {[m
[31m-		var temp, i, elem,[m
[31m-			preMap = [],[m
[31m-			postMap = [],[m
[31m-			preexisting = results.length,[m
[31m-[m
[31m-			// Get initial elements from seed or context[m
[31m-			elems = seed || multipleContexts( selector || "*", context.nodeType ? [ context ] : context, [] ),[m
[31m-[m
[31m-			// Prefilter to get matcher input, preserving a map for seed-results synchronization[m
[31m-			matcherIn = preFilter && ( seed || !selector ) ?[m
[31m-				condense( elems, preMap, preFilter, context, xml ) :[m
[31m-				elems,[m
[31m-[m
[31m-			matcherOut = matcher ?[m
[31m-				// If we have a postFinder, or filtered seed, or non-seed postFilter or preexisting results,[m
[31m-				postFinder || ( seed ? preFilter : preexisting || postFilter ) ?[m
[31m-[m
[31m-					// ...intermediate processing is necessary[m
[31m-					[] :[m
[31m-[m
[31m-					// ...otherwise use results directly[m
[31m-					results :[m
[31m-				matcherIn;[m
[31m-[m
[31m-		// Find primary matches[m
[31m-		if ( matcher ) {[m
[31m-			matcher( matcherIn, matcherOut, context, xml );[m
[31m-		}[m
[31m-[m
[31m-		// Apply postFilter[m
[31m-		if ( postFilter ) {[m
[31m-			temp = condense( matcherOut, postMap );[m
[31m-			postFilter( temp, [], context, xml );[m
[31m-[m
[31m-			// Un-match failing elements by moving them back to matcherIn[m
[31m-			i = temp.length;[m
[31m-			while ( i-- ) {[m
[31m-				if ( (elem = temp[i]) ) {[m
[31m-					matcherOut[ postMap[i] ] = !(matcherIn[ postMap[i] ] = elem);[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		if ( seed ) {[m
[31m-			if ( postFinder || preFilter ) {[m
[31m-				if ( postFinder ) {[m
[31m-					// Get the final matcherOut by condensing this intermediate into postFinder contexts[m
[31m-					temp = [];[m
[31m-					i = matcherOut.length;[m
[31m-					while ( i-- ) {[m
[31m-						if ( (elem = matcherOut[i]) ) {[m
[31m-							// Restore matcherIn since elem is not yet a final match[m
[31m-							temp.push( (matcherIn[i] = elem) );[m
[31m-						}[m
[31m-					}[m
[31m-					postFinder( null, (matcherOut = []), temp, xml );[m
[31m-				}[m
[31m-[m
[31m-				// Move matched elements from seed to results to keep them synchronized[m
[31m-				i = matcherOut.length;[m
[31m-				while ( i-- ) {[m
[31m-					if ( (elem = matcherOut[i]) &&[m
[31m-						(temp = postFinder ? indexOf.call( seed, elem ) : preMap[i]) > -1 ) {[m
[31m-[m
[31m-						seed[temp] = !(results[temp] = elem);[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-		// Add elements to results, through postFinder if defined[m
[31m-		} else {[m
[31m-			matcherOut = condense([m
[31m-				matcherOut === results ?[m
[31m-					matcherOut.splice( preexisting, matcherOut.length ) :[m
[31m-					matcherOut[m
[31m-			);[m
[31m-			if ( postFinder ) {[m
[31m-				postFinder( null, results, matcherOut, xml );[m
[31m-			} else {[m
[31m-				push.apply( results, matcherOut );[m
[31m-			}[m
[31m-		}[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-function matcherFromTokens( tokens ) {[m
[31m-	var checkContext, matcher, j,[m
[31m-		len = tokens.length,[m
[31m-		leadingRelative = Expr.relative[ tokens[0].type ],[m
[31m-		implicitRelative = leadingRelative || Expr.relative[" "],[m
[31m-		i = leadingRelative ? 1 : 0,[m
[31m-[m
[31m-		// The foundational matcher ensures that elements are reachable from top-level context(s)[m
[31m-		matchContext = addCombinator( function( elem ) {[m
[31m-			return elem === checkContext;[m
[31m-		}, implicitRelative, true ),[m
[31m-		matchAnyContext = addCombinator( function( elem ) {[m
[31m-			return indexOf.call( checkContext, elem ) > -1;[m
[31m-		}, implicitRelative, true ),[m
[31m-		matchers = [ function( elem, context, xml ) {[m
[31m-			return ( !leadingRelative && ( xml || context !== outermostContext ) ) || ([m
[31m-				(checkContext = context).nodeType ?[m
[31m-					matchContext( elem, context, xml ) :[m
[31m-					matchAnyContext( elem, context, xml ) );[m
[31m-		} ];[m
[31m-[m
[31m-	for ( ; i < len; i++ ) {[m
[31m-		if ( (matcher = Expr.relative[ tokens[i].type ]) ) {[m
[31m-			matchers = [ addCombinator(elementMatcher( matchers ), matcher) ];[m
[31m-		} else {[m
[31m-			matcher = Expr.filter[ tokens[i].type ].apply( null, tokens[i].matches );[m
[31m-[m
[31m-			// Return special upon seeing a positional matcher[m
[31m-			if ( matcher[ expando ] ) {[m
[31m-				// Find the next relative operator (if any) for proper handling[m
[31m-				j = ++i;[m
[31m-				for ( ; j < len; j++ ) {[m
[31m-					if ( Expr.relative[ tokens[j].type ] ) {[m
[31m-						break;[m
[31m-					}[m
[31m-				}[m
[31m-				return setMatcher([m
[31m-					i > 1 && elementMatcher( matchers ),[m
[31m-					i > 1 && toSelector([m
[31m-						// If the preceding token was a descendant combinator, insert an implicit any-element `*`[m
[31m-						tokens.slice( 0, i - 1 ).concat({ value: tokens[ i - 2 ].type === " " ? "*" : "" })[m
[31m-					).replace( rtrim, "$1" ),[m
[31m-					matcher,[m
[31m-					i < j && matcherFromTokens( tokens.slice( i, j ) ),[m
[31m-					j < len && matcherFromTokens( (tokens = tokens.slice( j )) ),[m
[31m-					j < len && toSelector( tokens )[m
[31m-				);[m
[31m-			}[m
[31m-			matchers.push( matcher );[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	return elementMatcher( matchers );[m
[31m-}[m
[31m-[m
[31m-function matcherFromGroupMatchers( elementMatchers, setMatchers ) {[m
[31m-	// A counter to specify which element is currently being matched[m
[31m-	var matcherCachedRuns = 0,[m
[31m-		bySet = setMatchers.length > 0,[m
[31m-		byElement = elementMatchers.length > 0,[m
[31m-		superMatcher = function( seed, context, xml, results, expandContext ) {[m
[31m-			var elem, j, matcher,[m
[31m-				setMatched = [],[m
[31m-				matchedCount = 0,[m
[31m-				i = "0",[m
[31m-				unmatched = seed && [],[m
[31m-				outermost = expandContext != null,[m
[31m-				contextBackup = outermostContext,[m
[31m-				// We must always have either seed elements or context[m
[31m-				elems = seed || byElement && Expr.find["TAG"]( "*", expandContext && context.parentNode || context ),[m
[31m-				// Use integer dirruns iff this is the outermost matcher[m
[31m-				dirrunsUnique = (dirruns += contextBackup == null ? 1 : Math.random() || 0.1);[m
[31m-[m
[31m-			if ( outermost ) {[m
[31m-				outermostContext = context !== document && context;[m
[31m-				cachedruns = matcherCachedRuns;[m
[31m-			}[m
[31m-[m
[31m-			// Add elements passing elementMatchers directly to results[m
[31m-			// Keep `i` a string if there are no elements so `matchedCount` will be "00" below[m
[31m-			for ( ; (elem = elems[i]) != null; i++ ) {[m
[31m-				if ( byElement && elem ) {[m
[31m-					j = 0;[m
[31m-					while ( (matcher = elementMatchers[j++]) ) {[m
[31m-						if ( matcher( elem, context, xml ) ) {[m
[31m-							results.push( elem );[m
[31m-							break;[m
[31m-						}[m
[31m-					}[m
[31m-					if ( outermost ) {[m
[31m-						dirruns = dirrunsUnique;[m
[31m-						cachedruns = ++matcherCachedRuns;[m
[31m-					}[m
[31m-				}[m
[31m-[m
[31m-				// Track unmatched elements for set filters[m
[31m-				if ( bySet ) {[m
[31m-					// They will have gone through all possible matchers[m
[31m-					if ( (elem = !matcher && elem) ) {[m
[31m-						matchedCount--;[m
[31m-					}[m
[31m-[m
[31m-					// Lengthen the array for every element, matched or not[m
[31m-					if ( seed ) {[m
[31m-						unmatched.push( elem );[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			// Apply set filters to unmatched elements[m
[31m-			matchedCount += i;[m
[31m-			if ( bySet && i !== matchedCount ) {[m
[31m-				j = 0;[m
[31m-				while ( (matcher = setMatchers[j++]) ) {[m
[31m-					matcher( unmatched, setMatched, context, xml );[m
[31m-				}[m
[31m-[m
[31m-				if ( seed ) {[m
[31m-					// Reintegrate element matches to eliminate the need for sorting[m
[31m-					if ( matchedCount > 0 ) {[m
[31m-						while ( i-- ) {[m
[31m-							if ( !(unmatched[i] || setMatched[i]) ) {[m
[31m-								setMatched[i] = pop.call( results );[m
[31m-							}[m
[31m-						}[m
[31m-					}[m
[31m-[m
[31m-					// Discard index placeholder values to get only actual matches[m
[31m-					setMatched = condense( setMatched );[m
[31m-				}[m
[31m-[m
[31m-				// Add matches to results[m
[31m-				push.apply( results, setMatched );[m
[31m-[m
[31m-				// Seedless set matches succeeding multiple successful matchers stipulate sorting[m
[31m-				if ( outermost && !seed && setMatched.length > 0 &&[m
[31m-					( matchedCount + setMatchers.length ) > 1 ) {[m
[31m-[m
[31m-					Sizzle.uniqueSort( results );[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			// Override manipulation of globals by nested matchers[m
[31m-			if ( outermost ) {[m
[31m-				dirruns = dirrunsUnique;[m
[31m-				outermostContext = contextBackup;[m
[31m-			}[m
[31m-[m
[31m-			return unmatched;[m
[31m-		};[m
[31m-[m
[31m-	return bySet ?[m
[31m-		markFunction( superMatcher ) :[m
[31m-		superMatcher;[m
[31m-}[m
[31m-[m
[31m-compile = Sizzle.compile = function( selector, group /* Internal Use Only */ ) {[m
[31m-	var i,[m
[31m-		setMatchers = [],[m
[31m-		elementMatchers = [],[m
[31m-		cached = compilerCache[ selector + " " ];[m
[31m-[m
[31m-	if ( !cached ) {[m
[31m-		// Generate a function of recursive functions that can be used to check each element[m
[31m-		if ( !group ) {[m
[31m-			group = tokenize( selector );[m
[31m-		}[m
[31m-		i = group.length;[m
[31m-		while ( i-- ) {[m
[31m-			cached = matcherFromTokens( group[i] );[m
[31m-			if ( cached[ expando ] ) {[m
[31m-				setMatchers.push( cached );[m
[31m-			} else {[m
[31m-				elementMatchers.push( cached );[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Cache the compiled function[m
[31m-		cached = compilerCache( selector, matcherFromGroupMatchers( elementMatchers, setMatchers ) );[m
[31m-	}[m
[31m-	return cached;[m
[31m-};[m
[31m-[m
[31m-function multipleContexts( selector, contexts, results ) {[m
[31m-	var i = 0,[m
[31m-		len = contexts.length;[m
[31m-	for ( ; i < len; i++ ) {[m
[31m-		Sizzle( selector, contexts[i], results );[m
[31m-	}[m
[31m-	return results;[m
[31m-}[m
[31m-[m
[31m-function select( selector, context, results, seed ) {[m
[31m-	var i, tokens, token, type, find,[m
[31m-		match = tokenize( selector );[m
[31m-[m
[31m-	if ( !seed ) {[m
[31m-		// Try to minimize operations if there is only one group[m
[31m-		if ( match.length === 1 ) {[m
[31m-[m
[31m-			// Take a shortcut and set the context if the root selector is an ID[m
[31m-			tokens = match[0] = match[0].slice( 0 );[m
[31m-			if ( tokens.length > 2 && (token = tokens[0]).type === "ID" &&[m
[31m-					support.getById && context.nodeType === 9 && documentIsHTML &&[m
[31m-					Expr.relative[ tokens[1].type ] ) {[m
[31m-[m
[31m-				context = ( Expr.find["ID"]( token.matches[0].replace(runescape, funescape), context ) || [] )[0];[m
[31m-				if ( !context ) {[m
[31m-					return results;[m
[31m-				}[m
[31m-				selector = selector.slice( tokens.shift().value.length );[m
[31m-			}[m
[31m-[m
[31m-			// Fetch a seed set for right-to-left matching[m
[31m-			i = matchExpr["needsContext"].test( selector ) ? 0 : tokens.length;[m
[31m-			while ( i-- ) {[m
[31m-				token = tokens[i];[m
[31m-[m
[31m-				// Abort if we hit a combinator[m
[31m-				if ( Expr.relative[ (type = token.type) ] ) {[m
[31m-					break;[m
[31m-				}[m
[31m-				if ( (find = Expr.find[ type ]) ) {[m
[31m-					// Search, expanding context for leading sibling combinators[m
[31m-					if ( (seed = find([m
[31m-						token.matches[0].replace( runescape, funescape ),[m
[31m-						rsibling.test( tokens[0].type ) && context.parentNode || context[m
[31m-					)) ) {[m
[31m-[m
[31m-						// If seed is empty or no tokens remain, we can return early[m
[31m-						tokens.splice( i, 1 );[m
[31m-						selector = seed.length && toSelector( tokens );[m
[31m-						if ( !selector ) {[m
[31m-							push.apply( results, seed );[m
[31m-							return results;[m
[31m-						}[m
[31m-[m
[31m-						break;[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	// Compile and execute a filtering function[m
[31m-	// Provide `match` to avoid retokenization if we modified the selector above[m
[31m-	compile( selector, match )([m
[31m-		seed,[m
[31m-		context,[m
[31m-		!documentIsHTML,[m
[31m-		results,[m
[31m-		rsibling.test( selector )[m
[31m-	);[m
[31m-	return results;[m
[31m-}[m
[31m-[m
[31m-// One-time assignments[m
[31m-[m
[31m-// Sort stability[m
[31m-support.sortStable = expando.split("").sort( sortOrder ).join("") === expando;[m
[31m-[m
[31m-// Support: Chrome<14[m
[31m-// Always assume duplicates if they aren't passed to the comparison function[m
[31m-support.detectDuplicates = hasDuplicate;[m
[31m-[m
[31m-// Initialize against the default document[m
[31m-setDocument();[m
[31m-[m
[31m-// Support: Webkit<537.32 - Safari 6.0.3/Chrome 25 (fixed in Chrome 27)[m
[31m-// Detached nodes confoundingly follow *each other*[m
[31m-support.sortDetached = assert(function( div1 ) {[m
[31m-	// Should return 1, but returns 4 (following)[m
[31m-	return div1.compareDocumentPosition( document.createElement("div") ) & 1;[m
[31m-});[m
[31m-[m
[31m-// Support: IE<8[m
[31m-// Prevent attribute/property "interpolation"[m
[31m-// http://msdn.microsoft.com/en-us/library/ms536429%28VS.85%29.aspx[m
[31m-if ( !assert(function( div ) {[m
[31m-	div.innerHTML = "<a href='#'></a>";[m
[31m-	return div.firstChild.getAttribute("href") === "#" ;[m
[31m-}) ) {[m
[31m-	addHandle( "type|href|height|width", function( elem, name, isXML ) {[m
[31m-		if ( !isXML ) {[m
[31m-			return elem.getAttribute( name, name.toLowerCase() === "type" ? 1 : 2 );[m
[31m-		}[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-// Support: IE<9[m
[31m-// Use defaultValue in place of getAttribute("value")[m
[31m-if ( !support.attributes || !assert(function( div ) {[m
[31m-	div.innerHTML = "<input/>";[m
[31m-	div.firstChild.setAttribute( "value", "" );[m
[31m-	return div.firstChild.getAttribute( "value" ) === "";[m
[31m-}) ) {[m
[31m-	addHandle( "value", function( elem, name, isXML ) {[m
[31m-		if ( !isXML && elem.nodeName.toLowerCase() === "input" ) {[m
[31m-			return elem.defaultValue;[m
[31m-		}[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-// Support: IE<9[m
[31m-// Use getAttributeNode to fetch booleans when getAttribute lies[m
[31m-if ( !assert(function( div ) {[m
[31m-	return div.getAttribute("disabled") == null;[m
[31m-}) ) {[m
[31m-	addHandle( booleans, function( elem, name, isXML ) {[m
[31m-		var val;[m
[31m-		if ( !isXML ) {[m
[31m-			return (val = elem.getAttributeNode( name )) && val.specified ?[m
[31m-				val.value :[m
[31m-				elem[ name ] === true ? name.toLowerCase() : null;[m
[31m-		}[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-jQuery.find = Sizzle;[m
[31m-jQuery.expr = Sizzle.selectors;[m
[31m-jQuery.expr[":"] = jQuery.expr.pseudos;[m
[31m-jQuery.unique = Sizzle.uniqueSort;[m
[31m-jQuery.text = Sizzle.getText;[m
[31m-jQuery.isXMLDoc = Sizzle.isXML;[m
[31m-jQuery.contains = Sizzle.contains;[m
[31m-[m
[31m-[m
[31m-})( window );[m
[31m-// String to Object options format cache[m
[31m-var optionsCache = {};[m
[31m-[m
[31m-// Convert String-formatted options into Object-formatted ones and store in cache[m
[31m-function createOptions( options ) {[m
[31m-	var object = optionsCache[ options ] = {};[m
[31m-	jQuery.each( options.match( core_rnotwhite ) || [], function( _, flag ) {[m
[31m-		object[ flag ] = true;[m
[31m-	});[m
[31m-	return object;[m
[31m-}[m
[31m-[m
[31m-/*[m
[31m- * Create a callback list using the following parameters:[m
[31m- *[m
[31m- *	options: an optional list of space-separated options that will change how[m
[31m- *			the callback list behaves or a more traditional option object[m
[31m- *[m
[31m- * By default a callback list will act like an event callback list and can be[m
[31m- * "fired" multiple times.[m
[31m- *[m
[31m- * Possible options:[m
[31m- *[m
[31m- *	once:			will ensure the callback list can only be fired once (like a Deferred)[m
[31m- *[m
[31m- *	memory:			will keep track of previous values and will call any callback added[m
[31m- *					after the list has been fired right away with the latest "memorized"[m
[31m- *					values (like a Deferred)[m
[31m- *[m
[31m- *	unique:			will ensure a callback can only be added once (no duplicate in the list)[m
[31m- *[m
[31m- *	stopOnFalse:	interrupt callings when a callback returns false[m
[31m- *[m
[31m- */[m
[31m-jQuery.Callbacks = function( options ) {[m
[31m-[m
[31m-	// Convert options from String-formatted to Object-formatted if needed[m
[31m-	// (we check in cache first)[m
[31m-	options = typeof options === "string" ?[m
[31m-		( optionsCache[ options ] || createOptions( options ) ) :[m
[31m-		jQuery.extend( {}, options );[m
[31m-[m
[31m-	var // Flag to know if list is currently firing[m
[31m-		firing,[m
[31m-		// Last fire value (for non-forgettable lists)[m
[31m-		memory,[m
[31m-		// Flag to know if list was already fired[m
[31m-		fired,[m
[31m-		// End of the loop when firing[m
[31m-		firingLength,[m
[31m-		// Index of currently firing callback (modified by remove if needed)[m
[31m-		firingIndex,[m
[31m-		// First callback to fire (used internally by add and fireWith)[m
[31m-		firingStart,[m
[31m-		// Actual callback list[m
[31m-		list = [],[m
[31m-		// Stack of fire calls for repeatable lists[m
[31m-		stack = !options.once && [],[m
[31m-		// Fire callbacks[m
[31m-		fire = function( data ) {[m
[31m-			memory = options.memory && data;[m
[31m-			fired = true;[m
[31m-			firingIndex = firingStart || 0;[m
[31m-			firingStart = 0;[m
[31m-			firingLength = list.length;[m
[31m-			firing = true;[m
[31m-			for ( ; list && firingIndex < firingLength; firingIndex++ ) {[m
[31m-				if ( list[ firingIndex ].apply( data[ 0 ], data[ 1 ] ) === false && options.stopOnFalse ) {[m
[31m-					memory = false; // To prevent further calls using add[m
[31m-					break;[m
[31m-				}[m
[31m-			}[m
[31m-			firing = false;[m
[31m-			if ( list ) {[m
[31m-				if ( stack ) {[m
[31m-					if ( stack.length ) {[m
[31m-						fire( stack.shift() );[m
[31m-					}[m
[31m-				} else if ( memory ) {[m
[31m-					list = [];[m
[31m-				} else {[m
[31m-					self.disable();[m
[31m-				}[m
[31m-			}[m
[31m-		},[m
[31m-		// Actual Callbacks object[m
[31m-		self = {[m
[31m-			// Add a callback or a collection of callbacks to the list[m
[31m-			add: function() {[m
[31m-				if ( list ) {[m
[31m-					// First, we save the current length[m
[31m-					var start = list.length;[m
[31m-					(function add( args ) {[m
[31m-						jQuery.each( args, function( _, arg ) {[m
[31m-							var type = jQuery.type( arg );[m
[31m-							if ( type === "function" ) {[m
[31m-								if ( !options.unique || !self.has( arg ) ) {[m
[31m-									list.push( arg );[m
[31m-								}[m
[31m-							} else if ( arg && arg.length && type !== "string" ) {[m
[31m-								// Inspect recursively[m
[31m-								add( arg );[m
[31m-							}[m
[31m-						});[m
[31m-					})( arguments );[m
[31m-					// Do we need to add the callbacks to the[m
[31m-					// current firing batch?[m
[31m-					if ( firing ) {[m
[31m-						firingLength = list.length;[m
[31m-					// With memory, if we're not firing then[m
[31m-					// we should call right away[m
[31m-					} else if ( memory ) {[m
[31m-						firingStart = start;[m
[31m-						fire( memory );[m
[31m-					}[m
[31m-				}[m
[31m-				return this;[m
[31m-			},[m
[31m-			// Remove a callback from the list[m
[31m-			remove: function() {[m
[31m-				if ( list ) {[m
[31m-					jQuery.each( arguments, function( _, arg ) {[m
[31m-						var index;[m
[31m-						while( ( index = jQuery.inArray( arg, list, index ) ) > -1 ) {[m
[31m-							list.splice( index, 1 );[m
[31m-							// Handle firing indexes[m
[31m-							if ( firing ) {[m
[31m-								if ( index <= firingLength ) {[m
[31m-									firingLength--;[m
[31m-								}[m
[31m-								if ( index <= firingIndex ) {[m
[31m-									firingIndex--;[m
[31m-								}[m
[31m-							}[m
[31m-						}[m
[31m-					});[m
[31m-				}[m
[31m-				return this;[m
[31m-			},[m
[31m-			// Check if a given callback is in the list.[m
[31m-			// If no argument is given, return whether or not list has callbacks attached.[m
[31m-			has: function( fn ) {[m
[31m-				return fn ? jQuery.inArray( fn, list ) > -1 : !!( list && list.length );[m
[31m-			},[m
[31m-			// Remove all callbacks from the list[m
[31m-			empty: function() {[m
[31m-				list = [];[m
[31m-				firingLength = 0;[m
[31m-				return this;[m
[31m-			},[m
[31m-			// Have the list do nothing anymore[m
[31m-			disable: function() {[m
[31m-				list = stack = memory = undefined;[m
[31m-				return this;[m
[31m-			},[m
[31m-			// Is it disabled?[m
[31m-			disabled: function() {[m
[31m-				return !list;[m
[31m-			},[m
[31m-			// Lock the list in its current state[m
[31m-			lock: function() {[m
[31m-				stack = undefined;[m
[31m-				if ( !memory ) {[m
[31m-					self.disable();[m
[31m-				}[m
[31m-				return this;[m
[31m-			},[m
[31m-			// Is it locked?[m
[31m-			locked: function() {[m
[31m-				return !stack;[m
[31m-			},[m
[31m-			// Call all callbacks with the given context and arguments[m
[31m-			fireWith: function( context, args ) {[m
[31m-				if ( list && ( !fired || stack ) ) {[m
[31m-					args = args || [];[m
[31m-					args = [ context, args.slice ? args.slice() : args ];[m
[31m-					if ( firing ) {[m
[31m-						stack.push( args );[m
[31m-					} else {[m
[31m-						fire( args );[m
[31m-					}[m
[31m-				}[m
[31m-				return this;[m
[31m-			},[m
[31m-			// Call all the callbacks with the given arguments[m
[31m-			fire: function() {[m
[31m-				self.fireWith( this, arguments );[m
[31m-				return this;[m
[31m-			},[m
[31m-			// To know if the callbacks have already been called at least once[m
[31m-			fired: function() {[m
[31m-				return !!fired;[m
[31m-			}[m
[31m-		};[m
[31m-[m
[31m-	return self;[m
[31m-};[m
[31m-jQuery.extend({[m
[31m-[m
[31m-	Deferred: function( func ) {[m
[31m-		var tuples = [[m
[31m-				// action, add listener, listener list, final state[m
[31m-				[ "resolve", "done", jQuery.Callbacks("once memory"), "resolved" ],[m
[31m-				[ "reject", "fail", jQuery.Callbacks("once memory"), "rejected" ],[m
[31m-				[ "notify", "progress", jQuery.Callbacks("memory") ][m
[31m-			],[m
[31m-			state = "pending",[m
[31m-			promise = {[m
[31m-				state: function() {[m
[31m-					return state;[m
[31m-				},[m
[31m-				always: function() {[m
[31m-					deferred.done( arguments ).fail( arguments );[m
[31m-					return this;[m
[31m-				},[m
[31m-				then: function( /* fnDone, fnFail, fnProgress */ ) {[m
[31m-					var fns = arguments;[m
[31m-					return jQuery.Deferred(function( newDefer ) {[m
[31m-						jQuery.each( tuples, function( i, tuple ) {[m
[31m-							var action = tuple[ 0 ],[m
[31m-								fn = jQuery.isFunction( fns[ i ] ) && fns[ i ];[m
[31m-							// deferred[ done | fail | progress ] for forwarding actions to newDefer[m
[31m-							deferred[ tuple[1] ](function() {[m
[31m-								var returned = fn && fn.apply( this, arguments );[m
[31m-								if ( returned && jQuery.isFunction( returned.promise ) ) {[m
[31m-									returned.promise()[m
[31m-										.done( newDefer.resolve )[m
[31m-										.fail( newDefer.reject )[m
[31m-										.progress( newDefer.notify );[m
[31m-								} else {[m
[31m-									newDefer[ action + "With" ]( this === promise ? newDefer.promise() : this, fn ? [ returned ] : arguments );[m
[31m-								}[m
[31m-							});[m
[31m-						});[m
[31m-						fns = null;[m
[31m-					}).promise();[m
[31m-				},[m
[31m-				// Get a promise for this deferred[m
[31m-				// If obj is provided, the promise aspect is added to the object[m
[31m-				promise: function( obj ) {[m
[31m-					return obj != null ? jQuery.extend( obj, promise ) : promise;[m
[31m-				}[m
[31m-			},[m
[31m-			deferred = {};[m
[31m-[m
[31m-		// Keep pipe for back-compat[m
[31m-		promise.pipe = promise.then;[m
[31m-[m
[31m-		// Add list-specific methods[m
[31m-		jQuery.each( tuples, function( i, tuple ) {[m
[31m-			var list = tuple[ 2 ],[m
[31m-				stateString = tuple[ 3 ];[m
[31m-[m
[31m-			// promise[ done | fail | progress ] = list.add[m
[31m-			promise[ tuple[1] ] = list.add;[m
[31m-[m
[31m-			// Handle state[m
[31m-			if ( stateString ) {[m
[31m-				list.add(function() {[m
[31m-					// state = [ resolved | rejected ][m
[31m-					state = stateString;[m
[31m-[m
[31m-				// [ reject_list | resolve_list ].disable; progress_list.lock[m
[31m-				}, tuples[ i ^ 1 ][ 2 ].disable, tuples[ 2 ][ 2 ].lock );[m
[31m-			}[m
[31m-[m
[31m-			// deferred[ resolve | reject | notify ][m
[31m-			deferred[ tuple[0] ] = function() {[m
[31m-				deferred[ tuple[0] + "With" ]( this === deferred ? promise : this, arguments );[m
[31m-				return this;[m
[31m-			};[m
[31m-			deferred[ tuple[0] + "With" ] = list.fireWith;[m
[31m-		});[m
[31m-[m
[31m-		// Make the deferred a promise[m
[31m-		promise.promise( deferred );[m
[31m-[m
[31m-		// Call given func if any[m
[31m-		if ( func ) {[m
[31m-			func.call( deferred, deferred );[m
[31m-		}[m
[31m-[m
[31m-		// All done![m
[31m-		return deferred;[m
[31m-	},[m
[31m-[m
[31m-	// Deferred helper[m
[31m-	when: function( subordinate /* , ..., subordinateN */ ) {[m
[31m-		var i = 0,[m
[31m-			resolveValues = core_slice.call( arguments ),[m
[31m-			length = resolveValues.length,[m
[31m-[m
[31m-			// the count of uncompleted subordinates[m
[31m-			remaining = length !== 1 || ( subordinate && jQuery.isFunction( subordinate.promise ) ) ? length : 0,[m
[31m-[m
[31m-			// the master Deferred. If resolveValues consist of only a single Deferred, just use that.[m
[31m-			deferred = remaining === 1 ? subordinate : jQuery.Deferred(),[m
[31m-[m
[31m-			// Update function for both resolve and progress values[m
[31m-			updateFunc = function( i, contexts, values ) {[m
[31m-				return function( value ) {[m
[31m-					contexts[ i ] = this;[m
[31m-					values[ i ] = arguments.length > 1 ? core_slice.call( arguments ) : value;[m
[31m-					if( values === progressValues ) {[m
[31m-						deferred.notifyWith( contexts, values );[m
[31m-					} else if ( !( --remaining ) ) {[m
[31m-						deferred.resolveWith( contexts, values );[m
[31m-					}[m
[31m-				};[m
[31m-			},[m
[31m-[m
[31m-			progressValues, progressContexts, resolveContexts;[m
[31m-[m
[31m-		// add listeners to Deferred subordinates; treat others as resolved[m
[31m-		if ( length > 1 ) {[m
[31m-			progressValues = new Array( length );[m
[31m-			progressContexts = new Array( length );[m
[31m-			resolveContexts = new Array( length );[m
[31m-			for ( ; i < length; i++ ) {[m
[31m-				if ( resolveValues[ i ] && jQuery.isFunction( resolveValues[ i ].promise ) ) {[m
[31m-					resolveValues[ i ].promise()[m
[31m-						.done( updateFunc( i, resolveContexts, resolveValues ) )[m
[31m-						.fail( deferred.reject )[m
[31m-						.progress( updateFunc( i, progressContexts, progressValues ) );[m
[31m-				} else {[m
[31m-					--remaining;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// if we're not waiting on anything, resolve the master[m
[31m-		if ( !remaining ) {[m
[31m-			deferred.resolveWith( resolveContexts, resolveValues );[m
[31m-		}[m
[31m-[m
[31m-		return deferred.promise();[m
[31m-	}[m
[31m-});[m
[31m-jQuery.support = (function( support ) {[m
[31m-[m
[31m-	var all, a, input, select, fragment, opt, eventName, isSupported, i,[m
[31m-		div = document.createElement("div");[m
[31m-[m
[31m-	// Setup[m
[31m-	div.setAttribute( "className", "t" );[m
[31m-	div.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>";[m
[31m-[m
[31m-	// Finish early in limited (non-browser) environments[m
[31m-	all = div.getElementsByTagName("*") || [];[m
[31m-	a = div.getElementsByTagName("a")[ 0 ];[m
[31m-	if ( !a || !a.style || !all.length ) {[m
[31m-		return support;[m
[31m-	}[m
[31m-[m
[31m-	// First batch of tests[m
[31m-	select = document.createElement("select");[m
[31m-	opt = select.appendChild( document.createElement("option") );[m
[31m-	input = div.getElementsByTagName("input")[ 0 ];[m
[31m-[m
[31m-	a.style.cssText = "top:1px;float:left;opacity:.5";[m
[31m-[m
[31m-	// Test setAttribute on camelCase class. If it works, we need attrFixes when doing get/setAttribute (ie6/7)[m
[31m-	support.getSetAttribute = div.className !== "t";[m
[31m-[m
[31m-	// IE strips leading whitespace when .innerHTML is used[m
[31m-	support.leadingWhitespace = div.firstChild.nodeType === 3;[m
[31m-[m
[31m-	// Make sure that tbody elements aren't automatically inserted[m
[31m-	// IE will insert them into empty tables[m
[31m-	support.tbody = !div.getElementsByTagName("tbody").length;[m
[31m-[m
[31m-	// Make sure that link elements get serialized correctly by innerHTML[m
[31m-	// This requires a wrapper element in IE[m
[31m-	support.htmlSerialize = !!div.getElementsByTagName("link").length;[m
[31m-[m
[31m-	// Get the style information from getAttribute[m
[31m-	// (IE uses .cssText instead)[m
[31m-	support.style = /top/.test( a.getAttribute("style") );[m
[31m-[m
[31m-	// Make sure that URLs aren't manipulated[m
[31m-	// (IE normalizes it by default)[m
[31m-	support.hrefNormalized = a.getAttribute("href") === "/a";[m
[31m-[m
[31m-	// Make sure that element opacity exists[m
[31m-	// (IE uses filter instead)[m
[31m-	// Use a regex to work around a WebKit issue. See #5145[m
[31m-	support.opacity = /^0.5/.test( a.style.opacity );[m
[31m-[m
[31m-	// Verify style float existence[m
[31m-	// (IE uses styleFloat instead of cssFloat)[m
[31m-	support.cssFloat = !!a.style.cssFloat;[m
[31m-[m
[31m-	// Check the default checkbox/radio value ("" on WebKit; "on" elsewhere)[m
[31m-	support.checkOn = !!input.value;[m
[31m-[m
[31m-	// Make sure that a selected-by-default option has a working selected property.[m
[31m-	// (WebKit defaults to false instead of true, IE too, if it's in an optgroup)[m
[31m-	support.optSelected = opt.selected;[m
[31m-[m
[31m-	// Tests for enctype support on a form (#6743)[m
[31m-	support.enctype = !!document.createElement("form").enctype;[m
[31m-[m
[31m-	// Makes sure cloning an html5 element does not cause problems[m
[31m-	// Where outerHTML is undefined, this still works[m
[31m-	support.html5Clone = document.createElement("nav").cloneNode( true ).outerHTML !== "<:nav></:nav>";[m
[31m-[m
[31m-	// Will be defined later[m
[31m-	support.inlineBlockNeedsLayout = false;[m
[31m-	support.shrinkWrapBlocks = false;[m
[31m-	support.pixelPosition = false;[m
[31m-	support.deleteExpando = true;[m
[31m-	support.noCloneEvent = true;[m
[31m-	support.reliableMarginRight = true;[m
[31m-	support.boxSizingReliable = true;[m
[31m-[m
[31m-	// Make sure checked status is properly cloned[m
[31m-	input.checked = true;[m
[31m-	support.noCloneChecked = input.cloneNode( true ).checked;[m
[31m-[m
[31m-	// Make sure that the options inside disabled selects aren't marked as disabled[m
[31m-	// (WebKit marks them as disabled)[m
[31m-	select.disabled = true;[m
[31m-	support.optDisabled = !opt.disabled;[m
[31m-[m
[31m-	// Support: IE<9[m
[31m-	try {[m
[31m-		delete div.test;[m
[31m-	} catch( e ) {[m
[31m-		support.deleteExpando = false;[m
[31m-	}[m
[31m-[m
[31m-	// Check if we can trust getAttribute("value")[m
[31m-	input = document.createElement("input");[m
[31m-	input.setAttribute( "value", "" );[m
[31m-	support.input = input.getAttribute( "value" ) === "";[m
[31m-[m
[31m-	// Check if an input maintains its value after becoming a radio[m
[31m-	input.value = "t";[m
[31m-	input.setAttribute( "type", "radio" );[m
[31m-	support.radioValue = input.value === "t";[m
[31m-[m
[31m-	// #11217 - WebKit loses check when the name is after the checked attribute[m
[31m-	input.setAttribute( "checked", "t" );[m
[31m-	input.setAttribute( "name", "t" );[m
[31m-[m
[31m-	fragment = document.createDocumentFragment();[m
[31m-	fragment.appendChild( input );[m
[31m-[m
[31m-	// Check if a disconnected checkbox will retain its checked[m
[31m-	// value of true after appended to the DOM (IE6/7)[m
[31m-	support.appendChecked = input.checked;[m
[31m-[m
[31m-	// WebKit doesn't clone checked state correctly in fragments[m
[31m-	support.checkClone = fragment.cloneNode( true ).cloneNode( true ).lastChild.checked;[m
[31m-[m
[31m-	// Support: IE<9[m
[31m-	// Opera does not clone events (and typeof div.attachEvent === undefined).[m
[31m-	// IE9-10 clones events bound via attachEvent, but they don't trigger with .click()[m
[31m-	if ( div.attachEvent ) {[m
[31m-		div.attachEvent( "onclick", function() {[m
[31m-			support.noCloneEvent = false;[m
[31m-		});[m
[31m-[m
[31m-		div.cloneNode( true ).click();[m
[31m-	}[m
[31m-[m
[31m-	// Support: IE<9 (lack submit/change bubble), Firefox 17+ (lack focusin event)[m
[31m-	// Beware of CSP restrictions (https://developer.mozilla.org/en/Security/CSP)[m
[31m-	for ( i in { submit: true, change: true, focusin: true }) {[m
[31m-		div.setAttribute( eventName = "on" + i, "t" );[m
[31m-[m
[31m-		support[ i + "Bubbles" ] = eventName in window || div.attributes[ eventName ].expando === false;[m
[31m-	}[m
[31m-[m
[31m-	div.style.backgroundClip = "content-box";[m
[31m-	div.cloneNode( true ).style.backgroundClip = "";[m
[31m-	support.clearCloneStyle = div.style.backgroundClip === "content-box";[m
[31m-[m
[31m-	// Support: IE<9[m
[31m-	// Iteration over object's inherited properties before its own.[m
[31m-	for ( i in jQuery( support ) ) {[m
[31m-		break;[m
[31m-	}[m
[31m-	support.ownLast = i !== "0";[m
[31m-[m
[31m-	// Run tests that need a body at doc ready[m
[31m-	jQuery(function() {[m
[31m-		var container, marginDiv, tds,[m
[31m-			divReset = "padding:0;margin:0;border:0;display:block;box-sizing:content-box;-moz-box-sizing:content-box;-webkit-box-sizing:content-box;",[m
[31m-			body = document.getElementsByTagName("body")[0];[m
[31m-[m
[31m-		if ( !body ) {[m
[31m-			// Return for frameset docs that don't have a body[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		container = document.createElement("div");[m
[31m-		container.style.cssText = "border:0;width:0;height:0;position:absolute;top:0;left:-9999px;margin-top:1px";[m
[31m-[m
[31m-		body.appendChild( container ).appendChild( div );[m
[31m-[m
[31m-		// Support: IE8[m
[31m-		// Check if table cells still have offsetWidth/Height when they are set[m
[31m-		// to display:none and there are still other visible table cells in a[m
[31m-		// table row; if so, offsetWidth/Height are not reliable for use when[m
[31m-		// determining if an element has been hidden directly using[m
[31m-		// display:none (it is still safe to use offsets if a parent element is[m
[31m-		// hidden; don safety goggles and see bug #4512 for more information).[m
[31m-		div.innerHTML = "<table><tr><td></td><td>t</td></tr></table>";[m
[31m-		tds = div.getElementsByTagName("td");[m
[31m-		tds[ 0 ].style.cssText = "padding:0;margin:0;border:0;display:none";[m
[31m-		isSupported = ( tds[ 0 ].offsetHeight === 0 );[m
[31m-[m
[31m-		tds[ 0 ].style.display = "";[m
[31m-		tds[ 1 ].style.display = "none";[m
[31m-[m
[31m-		// Support: IE8[m
[31m-		// Check if empty table cells still have offsetWidth/Height[m
[31m-		support.reliableHiddenOffsets = isSupported && ( tds[ 0 ].offsetHeight === 0 );[m
[31m-[m
[31m-		// Check box-sizing and margin behavior.[m
[31m-		div.innerHTML = "";[m
[31m-		div.style.cssText = "box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;padding:1px;border:1px;display:block;width:4px;margin-top:1%;position:absolute;top:1%;";[m
[31m-[m
[31m-		// Workaround failing boxSizing test due to offsetWidth returning wrong value[m
[31m-		// with some non-1 values of body zoom, ticket #13543[m
[31m-		jQuery.swap( body, body.style.zoom != null ? { zoom: 1 } : {}, function() {[m
[31m-			support.boxSizing = div.offsetWidth === 4;[m
[31m-		});[m
[31m-[m
[31m-		// Use window.getComputedStyle because jsdom on node.js will break without it.[m
[31m-		if ( window.getComputedStyle ) {[m
[31m-			support.pixelPosition = ( window.getComputedStyle( div, null ) || {} ).top !== "1%";[m
[31m-			support.boxSizingReliable = ( window.getComputedStyle( div, null ) || { width: "4px" } ).width === "4px";[m
[31m-[m
[31m-			// Check if div with explicit width and no margin-right incorrectly[m
[31m-			// gets computed margin-right based on width of container. (#3333)[m
[31m-			// Fails in WebKit before Feb 2011 nightlies[m
[31m-			// WebKit Bug 13343 - getComputedStyle returns wrong value for margin-right[m
[31m-			marginDiv = div.appendChild( document.createElement("div") );[m
[31m-			marginDiv.style.cssText = div.style.cssText = divReset;[m
[31m-			marginDiv.style.marginRight = marginDiv.style.width = "0";[m
[31m-			div.style.width = "1px";[m
[31m-[m
[31m-			support.reliableMarginRight =[m
[31m-				!parseFloat( ( window.getComputedStyle( marginDiv, null ) || {} ).marginRight );[m
[31m-		}[m
[31m-[m
[31m-		if ( typeof div.style.zoom !== core_strundefined ) {[m
[31m-			// Support: IE<8[m
[31m-			// Check if natively block-level elements act like inline-block[m
[31m-			// elements when setting their display to 'inline' and giving[m
[31m-			// them layout[m
[31m-			div.innerHTML = "";[m
[31m-			div.style.cssText = divReset + "width:1px;padding:1px;display:inline;zoom:1";[m
[31m-			support.inlineBlockNeedsLayout = ( div.offsetWidth === 3 );[m
[31m-[m
[31m-			// Support: IE6[m
[31m-			// Check if elements with layout shrink-wrap their children[m
[31m-			div.style.display = "block";[m
[31m-			div.innerHTML = "<div></div>";[m
[31m-			div.firstChild.style.width = "5px";[m
[31m-			support.shrinkWrapBlocks = ( div.offsetWidth !== 3 );[m
[31m-[m
[31m-			if ( support.inlineBlockNeedsLayout ) {[m
[31m-				// Prevent IE 6 from affecting layout for positioned elements #11048[m
[31m-				// Prevent IE from shrinking the body in IE 7 mode #12869[m
[31m-				// Support: IE<8[m
[31m-				body.style.zoom = 1;[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		body.removeChild( container );[m
[31m-[m
[31m-		// Null elements to avoid leaks in IE[m
[31m-		container = div = tds = marginDiv = null;[m
[31m-	});[m
[31m-[m
[31m-	// Null elements to avoid leaks in IE[m
[31m-	all = select = fragment = opt = a = input = null;[m
[31m-[m
[31m-	return support;[m
[31m-})({});[m
[31m-[m
[31m-var rbrace = /(?:\{[\s\S]*\}|\[[\s\S]*\])$/,[m
[31m-	rmultiDash = /([A-Z])/g;[m
[31m-[m
[31m-function internalData( elem, name, data, pvt /* Internal Use Only */ ){[m
[31m-	if ( !jQuery.acceptData( elem ) ) {[m
[31m-		return;[m
[31m-	}[m
[31m-[m
[31m-	var ret, thisCache,[m
[31m-		internalKey = jQuery.expando,[m
[31m-[m
[31m-		// We have to handle DOM nodes and JS objects differently because IE6-7[m
[31m-		// can't GC object references properly across the DOM-JS boundary[m
[31m-		isNode = elem.nodeType,[m
[31m-[m
[31m-		// Only DOM nodes need the global jQuery cache; JS object data is[m
[31m-		// attached directly to the object so GC can occur automatically[m
[31m-		cache = isNode ? jQuery.cache : elem,[m
[31m-[m
[31m-		// Only defining an ID for JS objects if its cache already exists allows[m
[31m-		// the code to shortcut on the same path as a DOM node with no cache[m
[31m-		id = isNode ? elem[ internalKey ] : elem[ internalKey ] && internalKey;[m
[31m-[m
[31m-	// Avoid doing any more work than we need to when trying to get data on an[m
[31m-	// object that has no data at all[m
[31m-	if ( (!id || !cache[id] || (!pvt && !cache[id].data)) && data === undefined && typeof name === "string" ) {[m
[31m-		return;[m
[31m-	}[m
[31m-[m
[31m-	if ( !id ) {[m
[31m-		// Only DOM nodes need a new unique ID for each element since their data[m
[31m-		// ends up in the global cache[m
[31m-		if ( isNode ) {[m
[31m-			id = elem[ internalKey ] = core_deletedIds.pop() || jQuery.guid++;[m
[31m-		} else {[m
[31m-			id = internalKey;[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	if ( !cache[ id ] ) {[m
[31m-		// Avoid exposing jQuery metadata on plain JS objects when the object[m
[31m-		// is serialized using JSON.stringify[m
[31m-		cache[ id ] = isNode ? {} : { toJSON: jQuery.noop };[m
[31m-	}[m
[31m-[m
[31m-	// An object can be passed to jQuery.data instead of a key/value pair; this gets[m
[31m-	// shallow copied over onto the existing cache[m
[31m-	if ( typeof name === "object" || typeof name === "function" ) {[m
[31m-		if ( pvt ) {[m
[31m-			cache[ id ] = jQuery.extend( cache[ id ], name );[m
[31m-		} else {[m
[31m-			cache[ id ].data = jQuery.extend( cache[ id ].data, name );[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	thisCache = cache[ id ];[m
[31m-[m
[31m-	// jQuery data() is stored in a separate object inside the object's internal data[m
[31m-	// cache in order to avoid key collisions between internal data and user-defined[m
[31m-	// data.[m
[31m-	if ( !pvt ) {[m
[31m-		if ( !thisCache.data ) {[m
[31m-			thisCache.data = {};[m
[31m-		}[m
[31m-[m
[31m-		thisCache = thisCache.data;[m
[31m-	}[m
[31m-[m
[31m-	if ( data !== undefined ) {[m
[31m-		thisCache[ jQuery.camelCase( name ) ] = data;[m
[31m-	}[m
[31m-[m
[31m-	// Check for both converted-to-camel and non-converted data property names[m
[31m-	// If a data property was specified[m
[31m-	if ( typeof name === "string" ) {[m
[31m-[m
[31m-		// First Try to find as-is property data[m
[31m-		ret = thisCache[ name ];[m
[31m-[m
[31m-		// Test for null|undefined property data[m
[31m-		if ( ret == null ) {[m
[31m-[m
[31m-			// Try to find the camelCased property[m
[31m-			ret = thisCache[ jQuery.camelCase( name ) ];[m
[31m-		}[m
[31m-	} else {[m
[31m-		ret = thisCache;[m
[31m-	}[m
[31m-[m
[31m-	return ret;[m
[31m-}[m
[31m-[m
[31m-function internalRemoveData( elem, name, pvt ) {[m
[31m-	if ( !jQuery.acceptData( elem ) ) {[m
[31m-		return;[m
[31m-	}[m
[31m-[m
[31m-	var thisCache, i,[m
[31m-		isNode = elem.nodeType,[m
[31m-[m
[31m-		// See jQuery.data for more information[m
[31m-		cache = isNode ? jQuery.cache : elem,[m
[31m-		id = isNode ? elem[ jQuery.expando ] : jQuery.expando;[m
[31m-[m
[31m-	// If there is already no cache entry for this object, there is no[m
[31m-	// purpose in continuing[m
[31m-	if ( !cache[ id ] ) {[m
[31m-		return;[m
[31m-	}[m
[31m-[m
[31m-	if ( name ) {[m
[31m-[m
[31m-		thisCache = pvt ? cache[ id ] : cache[ id ].data;[m
[31m-[m
[31m-		if ( thisCache ) {[m
[31m-[m
[31m-			// Support array or space separated string names for data keys[m
[31m-			if ( !jQuery.isArray( name ) ) {[m
[31m-[m
[31m-				// try the string as a key before any manipulation[m
[31m-				if ( name in thisCache ) {[m
[31m-					name = [ name ];[m
[31m-				} else {[m
[31m-[m
[31m-					// split the camel cased version by spaces unless a key with the spaces exists[m
[31m-					name = jQuery.camelCase( name );[m
[31m-					if ( name in thisCache ) {[m
[31m-						name = [ name ];[m
[31m-					} else {[m
[31m-						name = name.split(" ");[m
[31m-					}[m
[31m-				}[m
[31m-			} else {[m
[31m-				// If "name" is an array of keys...[m
[31m-				// When data is initially created, via ("key", "val") signature,[m
[31m-				// keys will be converted to camelCase.[m
[31m-				// Since there is no way to tell _how_ a key was added, remove[m
[31m-				// both plain key and camelCase key. #12786[m
[31m-				// This will only penalize the array argument path.[m
[31m-				name = name.concat( jQuery.map( name, jQuery.camelCase ) );[m
[31m-			}[m
[31m-[m
[31m-			i = name.length;[m
[31m-			while ( i-- ) {[m
[31m-				delete thisCache[ name[i] ];[m
[31m-			}[m
[31m-[m
[31m-			// If there is no data left in the cache, we want to continue[m
[31m-			// and let the cache object itself get destroyed[m
[31m-			if ( pvt ? !isEmptyDataObject(thisCache) : !jQuery.isEmptyObject(thisCache) ) {[m
[31m-				return;[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	// See jQuery.data for more information[m
[31m-	if ( !pvt ) {[m
[31m-		delete cache[ id ].data;[m
[31m-[m
[31m-		// Don't destroy the parent cache unless the internal data object[m
[31m-		// had been the only thing left in it[m
[31m-		if ( !isEmptyDataObject( cache[ id ] ) ) {[m
[31m-			return;[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	// Destroy the cache[m
[31m-	if ( isNode ) {[m
[31m-		jQuery.cleanData( [ elem ], true );[m
[31m-[m
[31m-	// Use delete when supported for expandos or `cache` is not a window per isWindow (#10080)[m
[31m-	/* jshint eqeqeq: false */[m
[31m-	} else if ( jQuery.support.deleteExpando || cache != cache.window ) {[m
[31m-		/* jshint eqeqeq: true */[m
[31m-		delete cache[ id ];[m
[31m-[m
[31m-	// When all else fails, null[m
[31m-	} else {[m
[31m-		cache[ id ] = null;[m
[31m-	}[m
[31m-}[m
[31m-[m
[31m-jQuery.extend({[m
[31m-	cache: {},[m
[31m-[m
[31m-	// The following elements throw uncatchable exceptions if you[m
[31m-	// attempt to add expando properties to them.[m
[31m-	noData: {[m
[31m-		"applet": true,[m
[31m-		"embed": true,[m
[31m-		// Ban all objects except for Flash (which handle expandos)[m
[31m-		"object": "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"[m
[31m-	},[m
[31m-[m
[31m-	hasData: function( elem ) {[m
[31m-		elem = elem.nodeType ? jQuery.cache[ elem[jQuery.expando] ] : elem[ jQuery.expando ];[m
[31m-		return !!elem && !isEmptyDataObject( elem );[m
[31m-	},[m
[31m-[m
[31m-	data: function( elem, name, data ) {[m
[31m-		return internalData( elem, name, data );[m
[31m-	},[m
[31m-[m
[31m-	removeData: function( elem, name ) {[m
[31m-		return internalRemoveData( elem, name );[m
[31m-	},[m
[31m-[m
[31m-	// For internal use only.[m
[31m-	_data: function( elem, name, data ) {[m
[31m-		return internalData( elem, name, data, true );[m
[31m-	},[m
[31m-[m
[31m-	_removeData: function( elem, name ) {[m
[31m-		return internalRemoveData( elem, name, true );[m
[31m-	},[m
[31m-[m
[31m-	// A method for determining if a DOM node can handle the data expando[m
[31m-	acceptData: function( elem ) {[m
[31m-		// Do not set data on non-element because it will not be cleared (#8335).[m
[31m-		if ( elem.nodeType && elem.nodeType !== 1 && elem.nodeType !== 9 ) {[m
[31m-			return false;[m
[31m-		}[m
[31m-[m
[31m-		var noData = elem.nodeName && jQuery.noData[ elem.nodeName.toLowerCase() ];[m
[31m-[m
[31m-		// nodes accept data unless otherwise specified; rejection can be conditional[m
[31m-		return !noData || noData !== true && elem.getAttribute("classid") === noData;[m
[31m-	}[m
[31m-});[m
[31m-[m
[31m-jQuery.fn.extend({[m
[31m-	data: function( key, value ) {[m
[31m-		var attrs, name,[m
[31m-			data = null,[m
[31m-			i = 0,[m
[31m-			elem = this[0];[m
[31m-[m
[31m-		// Special expections of .data basically thwart jQuery.access,[m
[31m-		// so implement the relevant behavior ourselves[m
[31m-[m
[31m-		// Gets all values[m
[31m-		if ( key === undefined ) {[m
[31m-			if ( this.length ) {[m
[31m-				data = jQuery.data( elem );[m
[31m-[m
[31m-				if ( elem.nodeType === 1 && !jQuery._data( elem, "parsedAttrs" ) ) {[m
[31m-					attrs = elem.attributes;[m
[31m-					for ( ; i < attrs.length; i++ ) {[m
[31m-						name = attrs[i].name;[m
[31m-[m
[31m-						if ( name.indexOf("data-") === 0 ) {[m
[31m-							name = jQuery.camelCase( name.slice(5) );[m
[31m-[m
[31m-							dataAttr( elem, name, data[ name ] );[m
[31m-						}[m
[31m-					}[m
[31m-					jQuery._data( elem, "parsedAttrs", true );[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			return data;[m
[31m-		}[m
[31m-[m
[31m-		// Sets multiple values[m
[31m-		if ( typeof key === "object" ) {[m
[31m-			return this.each(function() {[m
[31m-				jQuery.data( this, key );[m
[31m-			});[m
[31m-		}[m
[31m-[m
[31m-		return arguments.length > 1 ?[m
[31m-[m
[31m-			// Sets one value[m
[31m-			this.each(function() {[m
[31m-				jQuery.data( this, key, value );[m
[31m-			}) :[m
[31m-[m
[31m-			// Gets one value[m
[31m-			// Try to fetch any internally stored data first[m
[31m-			elem ? dataAttr( elem, key, jQuery.data( elem, key ) ) : null;[m
[31m-	},[m
[31m-[m
[31m-	removeData: function( key ) {[m
[31m-		return this.each(function() {[m
[31m-			jQuery.removeData( this, key );[m
[31m-		});[m
[31m-	}[m
[31m-});[m
[31m-[m
[31m-function dataAttr( elem, key, data ) {[m
[31m-	// If nothing was found internally, try to fetch any[m
[31m-	// data from the HTML5 data-* attribute[m
[31m-	if ( data === undefined && elem.nodeType === 1 ) {[m
[31m-[m
[31m-		var name = "data-" + key.replace( rmultiDash, "-$1" ).toLowerCase();[m
[31m-[m
[31m-		data = elem.getAttribute( name );[m
[31m-[m
[31m-		if ( typeof data === "string" ) {[m
[31m-			try {[m
[31m-				data = data === "true" ? true :[m
[31m-					data === "false" ? false :[m
[31m-					data === "null" ? null :[m
[31m-					// Only convert to a number if it doesn't change the string[m
[31m-					+data + "" === data ? +data :[m
[31m-					rbrace.test( data ) ? jQuery.parseJSON( data ) :[m
[31m-						data;[m
[31m-			} catch( e ) {}[m
[31m-[m
[31m-			// Make sure we set the data so it isn't changed later[m
[31m-			jQuery.data( elem, key, data );[m
[31m-[m
[31m-		} else {[m
[31m-			data = undefined;[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	return data;[m
[31m-}[m
[31m-[m
[31m-// checks a cache object for emptiness[m
[31m-function isEmptyDataObject( obj ) {[m
[31m-	var name;[m
[31m-	for ( name in obj ) {[m
[31m-[m
[31m-		// if the public data object is empty, the private is still empty[m
[31m-		if ( name === "data" && jQuery.isEmptyObject( obj[name] ) ) {[m
[31m-			continue;[m
[31m-		}[m
[31m-		if ( name !== "toJSON" ) {[m
[31m-			return false;[m
[31m-		}[m
[31m-	}[m
[31m-[m
[31m-	return true;[m
[31m-}[m
[31m-jQuery.extend({[m
[31m-	queue: function( elem, type, data ) {[m
[31m-		var queue;[m
[31m-[m
[31m-		if ( elem ) {[m
[31m-			type = ( type || "fx" ) + "queue";[m
[31m-			queue = jQuery._data( elem, type );[m
[31m-[m
[31m-			// Speed up dequeue by getting out quickly if this is just a lookup[m
[31m-			if ( data ) {[m
[31m-				if ( !queue || jQuery.isArray(data) ) {[m
[31m-					queue = jQuery._data( elem, type, jQuery.makeArray(data) );[m
[31m-				} else {[m
[31m-					queue.push( data );[m
[31m-				}[m
[31m-			}[m
[31m-			return queue || [];[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	dequeue: function( elem, type ) {[m
[31m-		type = type || "fx";[m
[31m-[m
[31m-		var queue = jQuery.queue( elem, type ),[m
[31m-			startLength = queue.length,[m
[31m-			fn = queue.shift(),[m
[31m-			hooks = jQuery._queueHooks( elem, type ),[m
[31m-			next = function() {[m
[31m-				jQuery.dequeue( elem, type );[m
[31m-			};[m
[31m-[m
[31m-		// If the fx queue is dequeued, always remove the progress sentinel[m
[31m-		if ( fn === "inprogress" ) {[m
[31m-			fn = queue.shift();[m
[31m-			startLength--;[m
[31m-		}[m
[31m-[m
[31m-		if ( fn ) {[m
[31m-[m
[31m-			// Add a progress sentinel to prevent the fx queue from being[m
[31m-			// automatically dequeued[m
[31m-			if ( type === "fx" ) {[m
[31m-				queue.unshift( "inprogress" );[m
[31m-			}[m
[31m-[m
[31m-			// clear up the last queue stop function[m
[31m-			delete hooks.stop;[m
[31m-			fn.call( elem, next, hooks );[m
[31m-		}[m
[31m-[m
[31m-		if ( !startLength && hooks ) {[m
[31m-			hooks.empty.fire();[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	// not intended for public consumption - generates a queueHooks object, or returns the current one[m
[31m-	_queueHooks: function( elem, type ) {[m
[31m-		var key = type + "queueHooks";[m
[31m-		return jQuery._data( elem, key ) || jQuery._data( elem, key, {[m
[31m-			empty: jQuery.Callbacks("once memory").add(function() {[m
[31m-				jQuery._removeData( elem, type + "queue" );[m
[31m-				jQuery._removeData( elem, key );[m
[31m-			})[m
[31m-		});[m
[31m-	}[m
[31m-});[m
[31m-[m
[31m-jQuery.fn.extend({[m
[31m-	queue: function( type, data ) {[m
[31m-		var setter = 2;[m
[31m-[m
[31m-		if ( typeof type !== "string" ) {[m
[31m-			data = type;[m
[31m-			type = "fx";[m
[31m-			setter--;[m
[31m-		}[m
[31m-[m
[31m-		if ( arguments.length < setter ) {[m
[31m-			return jQuery.queue( this[0], type );[m
[31m-		}[m
[31m-[m
[31m-		return data === undefined ?[m
[31m-			this :[m
[31m-			this.each(function() {[m
[31m-				var queue = jQuery.queue( this, type, data );[m
[31m-[m
[31m-				// ensure a hooks for this queue[m
[31m-				jQuery._queueHooks( this, type );[m
[31m-[m
[31m-				if ( type === "fx" && queue[0] !== "inprogress" ) {[m
[31m-					jQuery.dequeue( this, type );[m
[31m-				}[m
[31m-			});[m
[31m-	},[m
[31m-	dequeue: function( type ) {[m
[31m-		return this.each(function() {[m
[31m-			jQuery.dequeue( this, type );[m
[31m-		});[m
[31m-	},[m
[31m-	// Based off of the plugin by Clint Helfers, with permission.[m
[31m-	// http://blindsignals.com/index.php/2009/07/jquery-delay/[m
[31m-	delay: function( time, type ) {[m
[31m-		time = jQuery.fx ? jQuery.fx.speeds[ time ] || time : time;[m
[31m-		type = type || "fx";[m
[31m-[m
[31m-		return this.queue( type, function( next, hooks ) {[m
[31m-			var timeout = setTimeout( next, time );[m
[31m-			hooks.stop = function() {[m
[31m-				clearTimeout( timeout );[m
[31m-			};[m
[31m-		});[m
[31m-	},[m
[31m-	clearQueue: function( type ) {[m
[31m-		return this.queue( type || "fx", [] );[m
[31m-	},[m
[31m-	// Get a promise resolved when queues of a certain type[m
[31m-	// are emptied (fx is the type by default)[m
[31m-	promise: function( type, obj ) {[m
[31m-		var tmp,[m
[31m-			count = 1,[m
[31m-			defer = jQuery.Deferred(),[m
[31m-			elements = this,[m
[31m-			i = this.length,[m
[31m-			resolve = function() {[m
[31m-				if ( !( --count ) ) {[m
[31m-					defer.resolveWith( elements, [ elements ] );[m
[31m-				}[m
[31m-			};[m
[31m-[m
[31m-		if ( typeof type !== "string" ) {[m
[31m-			obj = type;[m
[31m-			type = undefined;[m
[31m-		}[m
[31m-		type = type || "fx";[m
[31m-[m
[31m-		while( i-- ) {[m
[31m-			tmp = jQuery._data( elements[ i ], type + "queueHooks" );[m
[31m-			if ( tmp && tmp.empty ) {[m
[31m-				count++;[m
[31m-				tmp.empty.add( resolve );[m
[31m-			}[m
[31m-		}[m
[31m-		resolve();[m
[31m-		return defer.promise( obj );[m
[31m-	}[m
[31m-});[m
[31m-var nodeHook, boolHook,[m
[31m-	rclass = /[\t\r\n\f]/g,[m
[31m-	rreturn = /\r/g,[m
[31m-	rfocusable = /^(?:input|select|textarea|button|object)$/i,[m
[31m-	rclickable = /^(?:a|area)$/i,[m
[31m-	ruseDefault = /^(?:checked|selected)$/i,[m
[31m-	getSetAttribute = jQuery.support.getSetAttribute,[m
[31m-	getSetInput = jQuery.support.input;[m
[31m-[m
[31m-jQuery.fn.extend({[m
[31m-	attr: function( name, value ) {[m
[31m-		return jQuery.access( this, jQuery.attr, name, value, arguments.length > 1 );[m
[31m-	},[m
[31m-[m
[31m-	removeAttr: function( name ) {[m
[31m-		return this.each(function() {[m
[31m-			jQuery.removeAttr( this, name );[m
[31m-		});[m
[31m-	},[m
[31m-[m
[31m-	prop: function( name, value ) {[m
[31m-		return jQuery.access( this, jQuery.prop, name, value, arguments.length > 1 );[m
[31m-	},[m
[31m-[m
[31m-	removeProp: function( name ) {[m
[31m-		name = jQuery.propFix[ name ] || name;[m
[31m-		return this.each(function() {[m
[31m-			// try/catch handles cases where IE balks (such as removing a property on window)[m
[31m-			try {[m
[31m-				this[ name ] = undefined;[m
[31m-				delete this[ name ];[m
[31m-			} catch( e ) {}[m
[31m-		});[m
[31m-	},[m
[31m-[m
[31m-	addClass: function( value ) {[m
[31m-		var classes, elem, cur, clazz, j,[m
[31m-			i = 0,[m
[31m-			len = this.length,[m
[31m-			proceed = typeof value === "string" && value;[m
[31m-[m
[31m-		if ( jQuery.isFunction( value ) ) {[m
[31m-			return this.each(function( j ) {[m
[31m-				jQuery( this ).addClass( value.call( this, j, this.className ) );[m
[31m-			});[m
[31m-		}[m
[31m-[m
[31m-		if ( proceed ) {[m
[31m-			// The disjunction here is for better compressibility (see removeClass)[m
[31m-			classes = ( value || "" ).match( core_rnotwhite ) || [];[m
[31m-[m
[31m-			for ( ; i < len; i++ ) {[m
[31m-				elem = this[ i ];[m
[31m-				cur = elem.nodeType === 1 && ( elem.className ?[m
[31m-					( " " + elem.className + " " ).replace( rclass, " " ) :[m
[31m-					" "[m
[31m-				);[m
[31m-[m
[31m-				if ( cur ) {[m
[31m-					j = 0;[m
[31m-					while ( (clazz = classes[j++]) ) {[m
[31m-						if ( cur.indexOf( " " + clazz + " " ) < 0 ) {[m
[31m-							cur += clazz + " ";[m
[31m-						}[m
[31m-					}[m
[31m-					elem.className = jQuery.trim( cur );[m
[31m-[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return this;[m
[31m-	},[m
[31m-[m
[31m-	removeClass: function( value ) {[m
[31m-		var classes, elem, cur, clazz, j,[m
[31m-			i = 0,[m
[31m-			len = this.length,[m
[31m-			proceed = arguments.length === 0 || typeof value === "string" && value;[m
[31m-[m
[31m-		if ( jQuery.isFunction( value ) ) {[m
[31m-			return this.each(function( j ) {[m
[31m-				jQuery( this ).removeClass( value.call( this, j, this.className ) );[m
[31m-			});[m
[31m-		}[m
[31m-		if ( proceed ) {[m
[31m-			classes = ( value || "" ).match( core_rnotwhite ) || [];[m
[31m-[m
[31m-			for ( ; i < len; i++ ) {[m
[31m-				elem = this[ i ];[m
[31m-				// This expression is here for better compressibility (see addClass)[m
[31m-				cur = elem.nodeType === 1 && ( elem.className ?[m
[31m-					( " " + elem.className + " " ).replace( rclass, " " ) :[m
[31m-					""[m
[31m-				);[m
[31m-[m
[31m-				if ( cur ) {[m
[31m-					j = 0;[m
[31m-					while ( (clazz = classes[j++]) ) {[m
[31m-						// Remove *all* instances[m
[31m-						while ( cur.indexOf( " " + clazz + " " ) >= 0 ) {[m
[31m-							cur = cur.replace( " " + clazz + " ", " " );[m
[31m-						}[m
[31m-					}[m
[31m-					elem.className = value ? jQuery.trim( cur ) : "";[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return this;[m
[31m-	},[m
[31m-[m
[31m-	toggleClass: function( value, stateVal ) {[m
[31m-		var type = typeof value;[m
[31m-[m
[31m-		if ( typeof stateVal === "boolean" && type === "string" ) {[m
[31m-			return stateVal ? this.addClass( value ) : this.removeClass( value );[m
[31m-		}[m
[31m-[m
[31m-		if ( jQuery.isFunction( value ) ) {[m
[31m-			return this.each(function( i ) {[m
[31m-				jQuery( this ).toggleClass( value.call(this, i, this.className, stateVal), stateVal );[m
[31m-			});[m
[31m-		}[m
[31m-[m
[31m-		return this.each(function() {[m
[31m-			if ( type === "string" ) {[m
[31m-				// toggle individual class names[m
[31m-				var className,[m
[31m-					i = 0,[m
[31m-					self = jQuery( this ),[m
[31m-					classNames = value.match( core_rnotwhite ) || [];[m
[31m-[m
[31m-				while ( (className = classNames[ i++ ]) ) {[m
[31m-					// check each className given, space separated list[m
[31m-					if ( self.hasClass( className ) ) {[m
[31m-						self.removeClass( className );[m
[31m-					} else {[m
[31m-						self.addClass( className );[m
[31m-					}[m
[31m-				}[m
[31m-[m
[31m-			// Toggle whole class name[m
[31m-			} else if ( type === core_strundefined || type === "boolean" ) {[m
[31m-				if ( this.className ) {[m
[31m-					// store className if set[m
[31m-					jQuery._data( this, "__className__", this.className );[m
[31m-				}[m
[31m-[m
[31m-				// If the element has a class name or if we're passed "false",[m
[31m-				// then remove the whole classname (if there was one, the above saved it).[m
[31m-				// Otherwise bring back whatever was previously saved (if anything),[m
[31m-				// falling back to the empty string if nothing was stored.[m
[31m-				this.className = this.className || value === false ? "" : jQuery._data( this, "__className__" ) || "";[m
[31m-			}[m
[31m-		});[m
[31m-	},[m
[31m-[m
[31m-	hasClass: function( selector ) {[m
[31m-		var className = " " + selector + " ",[m
[31m-			i = 0,[m
[31m-			l = this.length;[m
[31m-		for ( ; i < l; i++ ) {[m
[31m-			if ( this[i].nodeType === 1 && (" " + this[i].className + " ").replace(rclass, " ").indexOf( className ) >= 0 ) {[m
[31m-				return true;[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return false;[m
[31m-	},[m
[31m-[m
[31m-	val: function( value ) {[m
[31m-		var ret, hooks, isFunction,[m
[31m-			elem = this[0];[m
[31m-[m
[31m-		if ( !arguments.length ) {[m
[31m-			if ( elem ) {[m
[31m-				hooks = jQuery.valHooks[ elem.type ] || jQuery.valHooks[ elem.nodeName.toLowerCase() ];[m
[31m-[m
[31m-				if ( hooks && "get" in hooks && (ret = hooks.get( elem, "value" )) !== undefined ) {[m
[31m-					return ret;[m
[31m-				}[m
[31m-[m
[31m-				ret = elem.value;[m
[31m-[m
[31m-				return typeof ret === "string" ?[m
[31m-					// handle most common string cases[m
[31m-					ret.replace(rreturn, "") :[m
[31m-					// handle cases where value is null/undef or number[m
[31m-					ret == null ? "" : ret;[m
[31m-			}[m
[31m-[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		isFunction = jQuery.isFunction( value );[m
[31m-[m
[31m-		return this.each(function( i ) {[m
[31m-			var val;[m
[31m-[m
[31m-			if ( this.nodeType !== 1 ) {[m
[31m-				return;[m
[31m-			}[m
[31m-[m
[31m-			if ( isFunction ) {[m
[31m-				val = value.call( this, i, jQuery( this ).val() );[m
[31m-			} else {[m
[31m-				val = value;[m
[31m-			}[m
[31m-[m
[31m-			// Treat null/undefined as ""; convert numbers to string[m
[31m-			if ( val == null ) {[m
[31m-				val = "";[m
[31m-			} else if ( typeof val === "number" ) {[m
[31m-				val += "";[m
[31m-			} else if ( jQuery.isArray( val ) ) {[m
[31m-				val = jQuery.map(val, function ( value ) {[m
[31m-					return value == null ? "" : value + "";[m
[31m-				});[m
[31m-			}[m
[31m-[m
[31m-			hooks = jQuery.valHooks[ this.type ] || jQuery.valHooks[ this.nodeName.toLowerCase() ];[m
[31m-[m
[31m-			// If set returns undefined, fall back to normal setting[m
[31m-			if ( !hooks || !("set" in hooks) || hooks.set( this, val, "value" ) === undefined ) {[m
[31m-				this.value = val;[m
[31m-			}[m
[31m-		});[m
[31m-	}[m
[31m-});[m
[31m-[m
[31m-jQuery.extend({[m
[31m-	valHooks: {[m
[31m-		option: {[m
[31m-			get: function( elem ) {[m
[31m-				// Use proper attribute retrieval(#6932, #12072)[m
[31m-				var val = jQuery.find.attr( elem, "value" );[m
[31m-				return val != null ?[m
[31m-					val :[m
[31m-					elem.text;[m
[31m-			}[m
[31m-		},[m
[31m-		select: {[m
[31m-			get: function( elem ) {[m
[31m-				var value, option,[m
[31m-					options = elem.options,[m
[31m-					index = elem.selectedIndex,[m
[31m-					one = elem.type === "select-one" || index < 0,[m
[31m-					values = one ? null : [],[m
[31m-					max = one ? index + 1 : options.length,[m
[31m-					i = index < 0 ?[m
[31m-						max :[m
[31m-						one ? index : 0;[m
[31m-[m
[31m-				// Loop through all the selected options[m
[31m-				for ( ; i < max; i++ ) {[m
[31m-					option = options[ i ];[m
[31m-[m
[31m-					// oldIE doesn't update selected after form reset (#2551)[m
[31m-					if ( ( option.selected || i === index ) &&[m
[31m-							// Don't return options that are disabled or in a disabled optgroup[m
[31m-							( jQuery.support.optDisabled ? !option.disabled : option.getAttribute("disabled") === null ) &&[m
[31m-							( !option.parentNode.disabled || !jQuery.nodeName( option.parentNode, "optgroup" ) ) ) {[m
[31m-[m
[31m-						// Get the specific value for the option[m
[31m-						value = jQuery( option ).val();[m
[31m-[m
[31m-						// We don't need an array for one selects[m
[31m-						if ( one ) {[m
[31m-							return value;[m
[31m-						}[m
[31m-[m
[31m-						// Multi-Selects return an array[m
[31m-						values.push( value );[m
[31m-					}[m
[31m-				}[m
[31m-[m
[31m-				return values;[m
[31m-			},[m
[31m-[m
[31m-			set: function( elem, value ) {[m
[31m-				var optionSet, option,[m
[31m-					options = elem.options,[m
[31m-					values = jQuery.makeArray( value ),[m
[31m-					i = options.length;[m
[31m-[m
[31m-				while ( i-- ) {[m
[31m-					option = options[ i ];[m
[31m-					if ( (option.selected = jQuery.inArray( jQuery(option).val(), values ) >= 0) ) {[m
[31m-						optionSet = true;[m
[31m-					}[m
[31m-				}[m
[31m-[m
[31m-				// force browsers to behave consistently when non-matching value is set[m
[31m-				if ( !optionSet ) {[m
[31m-					elem.selectedIndex = -1;[m
[31m-				}[m
[31m-				return values;[m
[31m-			}[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	attr: function( elem, name, value ) {[m
[31m-		var hooks, ret,[m
[31m-			nType = elem.nodeType;[m
[31m-[m
[31m-		// don't get/set attributes on text, comment and attribute nodes[m
[31m-		if ( !elem || nType === 3 || nType === 8 || nType === 2 ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// Fallback to prop when attributes are not supported[m
[31m-		if ( typeof elem.getAttribute === core_strundefined ) {[m
[31m-			return jQuery.prop( elem, name, value );[m
[31m-		}[m
[31m-[m
[31m-		// All attributes are lowercase[m
[31m-		// Grab necessary hook if one is defined[m
[31m-		if ( nType !== 1 || !jQuery.isXMLDoc( elem ) ) {[m
[31m-			name = name.toLowerCase();[m
[31m-			hooks = jQuery.attrHooks[ name ] ||[m
[31m-				( jQuery.expr.match.bool.test( name ) ? boolHook : nodeHook );[m
[31m-		}[m
[31m-[m
[31m-		if ( value !== undefined ) {[m
[31m-[m
[31m-			if ( value === null ) {[m
[31m-				jQuery.removeAttr( elem, name );[m
[31m-[m
[31m-			} else if ( hooks && "set" in hooks && (ret = hooks.set( elem, value, name )) !== undefined ) {[m
[31m-				return ret;[m
[31m-[m
[31m-			} else {[m
[31m-				elem.setAttribute( name, value + "" );[m
[31m-				return value;[m
[31m-			}[m
[31m-[m
[31m-		} else if ( hooks && "get" in hooks && (ret = hooks.get( elem, name )) !== null ) {[m
[31m-			return ret;[m
[31m-[m
[31m-		} else {[m
[31m-			ret = jQuery.find.attr( elem, name );[m
[31m-[m
[31m-			// Non-existent attributes return null, we normalize to undefined[m
[31m-			return ret == null ?[m
[31m-				undefined :[m
[31m-				ret;[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	removeAttr: function( elem, value ) {[m
[31m-		var name, propName,[m
[31m-			i = 0,[m
[31m-			attrNames = value && value.match( core_rnotwhite );[m
[31m-[m
[31m-		if ( attrNames && elem.nodeType === 1 ) {[m
[31m-			while ( (name = attrNames[i++]) ) {[m
[31m-				propName = jQuery.propFix[ name ] || name;[m
[31m-[m
[31m-				// Boolean attributes get special treatment (#10870)[m
[31m-				if ( jQuery.expr.match.bool.test( name ) ) {[m
[31m-					// Set corresponding property to false[m
[31m-					if ( getSetInput && getSetAttribute || !ruseDefault.test( name ) ) {[m
[31m-						elem[ propName ] = false;[m
[31m-					// Support: IE<9[m
[31m-					// Also clear defaultChecked/defaultSelected (if appropriate)[m
[31m-					} else {[m
[31m-						elem[ jQuery.camelCase( "default-" + name ) ] =[m
[31m-							elem[ propName ] = false;[m
[31m-					}[m
[31m-[m
[31m-				// See #9699 for explanation of this approach (setting first, then removal)[m
[31m-				} else {[m
[31m-					jQuery.attr( elem, name, "" );[m
[31m-				}[m
[31m-[m
[31m-				elem.removeAttribute( getSetAttribute ? name : propName );[m
[31m-			}[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	attrHooks: {[m
[31m-		type: {[m
[31m-			set: function( elem, value ) {[m
[31m-				if ( !jQuery.support.radioValue && value === "radio" && jQuery.nodeName(elem, "input") ) {[m
[31m-					// Setting the type on a radio button after the value resets the value in IE6-9[m
[31m-					// Reset value to default in case type is set after value during creation[m
[31m-					var val = elem.value;[m
[31m-					elem.setAttribute( "type", value );[m
[31m-					if ( val ) {[m
[31m-						elem.value = val;[m
[31m-					}[m
[31m-					return value;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	propFix: {[m
[31m-		"for": "htmlFor",[m
[31m-		"class": "className"[m
[31m-	},[m
[31m-[m
[31m-	prop: function( elem, name, value ) {[m
[31m-		var ret, hooks, notxml,[m
[31m-			nType = elem.nodeType;[m
[31m-[m
[31m-		// don't get/set properties on text, comment and attribute nodes[m
[31m-		if ( !elem || nType === 3 || nType === 8 || nType === 2 ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		notxml = nType !== 1 || !jQuery.isXMLDoc( elem );[m
[31m-[m
[31m-		if ( notxml ) {[m
[31m-			// Fix name and attach hooks[m
[31m-			name = jQuery.propFix[ name ] || name;[m
[31m-			hooks = jQuery.propHooks[ name ];[m
[31m-		}[m
[31m-[m
[31m-		if ( value !== undefined ) {[m
[31m-			return hooks && "set" in hooks && (ret = hooks.set( elem, value, name )) !== undefined ?[m
[31m-				ret :[m
[31m-				( elem[ name ] = value );[m
[31m-[m
[31m-		} else {[m
[31m-			return hooks && "get" in hooks && (ret = hooks.get( elem, name )) !== null ?[m
[31m-				ret :[m
[31m-				elem[ name ];[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	propHooks: {[m
[31m-		tabIndex: {[m
[31m-			get: function( elem ) {[m
[31m-				// elem.tabIndex doesn't always return the correct value when it hasn't been explicitly set[m
[31m-				// http://fluidproject.org/blog/2008/01/09/getting-setting-and-removing-tabindex-values-with-javascript/[m
[31m-				// Use proper attribute retrieval(#12072)[m
[31m-				var tabindex = jQuery.find.attr( elem, "tabindex" );[m
[31m-[m
[31m-				return tabindex ?[m
[31m-					parseInt( tabindex, 10 ) :[m
[31m-					rfocusable.test( elem.nodeName ) || rclickable.test( elem.nodeName ) && elem.href ?[m
[31m-						0 :[m
[31m-						-1;[m
[31m-			}[m
[31m-		}[m
[31m-	}[m
[31m-});[m
[31m-[m
[31m-// Hooks for boolean attributes[m
[31m-boolHook = {[m
[31m-	set: function( elem, value, name ) {[m
[31m-		if ( value === false ) {[m
[31m-			// Remove boolean attributes when set to false[m
[31m-			jQuery.removeAttr( elem, name );[m
[31m-		} else if ( getSetInput && getSetAttribute || !ruseDefault.test( name ) ) {[m
[31m-			// IE<8 needs the *property* name[m
[31m-			elem.setAttribute( !getSetAttribute && jQuery.propFix[ name ] || name, name );[m
[31m-[m
[31m-		// Use defaultChecked and defaultSelected for oldIE[m
[31m-		} else {[m
[31m-			elem[ jQuery.camelCase( "default-" + name ) ] = elem[ name ] = true;[m
[31m-		}[m
[31m-[m
[31m-		return name;[m
[31m-	}[m
[31m-};[m
[31m-jQuery.each( jQuery.expr.match.bool.source.match( /\w+/g ), function( i, name ) {[m
[31m-	var getter = jQuery.expr.attrHandle[ name ] || jQuery.find.attr;[m
[31m-[m
[31m-	jQuery.expr.attrHandle[ name ] = getSetInput && getSetAttribute || !ruseDefault.test( name ) ?[m
[31m-		function( elem, name, isXML ) {[m
[31m-			var fn = jQuery.expr.attrHandle[ name ],[m
[31m-				ret = isXML ?[m
[31m-					undefined :[m
[31m-					/* jshint eqeqeq: false */[m
[31m-					(jQuery.expr.attrHandle[ name ] = undefined) !=[m
[31m-						getter( elem, name, isXML ) ?[m
[31m-[m
[31m-						name.toLowerCase() :[m
[31m-						null;[m
[31m-			jQuery.expr.attrHandle[ name ] = fn;[m
[31m-			return ret;[m
[31m-		} :[m
[31m-		function( elem, name, isXML ) {[m
[31m-			return isXML ?[m
[31m-				undefined :[m
[31m-				elem[ jQuery.camelCase( "default-" + name ) ] ?[m
[31m-					name.toLowerCase() :[m
[31m-					null;[m
[31m-		};[m
[31m-});[m
[31m-[m
[31m-// fix oldIE attroperties[m
[31m-if ( !getSetInput || !getSetAttribute ) {[m
[31m-	jQuery.attrHooks.value = {[m
[31m-		set: function( elem, value, name ) {[m
[31m-			if ( jQuery.nodeName( elem, "input" ) ) {[m
[31m-				// Does not return so that setAttribute is also used[m
[31m-				elem.defaultValue = value;[m
[31m-			} else {[m
[31m-				// Use nodeHook if defined (#1954); otherwise setAttribute is fine[m
[31m-				return nodeHook && nodeHook.set( elem, value, name );[m
[31m-			}[m
[31m-		}[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-// IE6/7 do not support getting/setting some attributes with get/setAttribute[m
[31m-if ( !getSetAttribute ) {[m
[31m-[m
[31m-	// Use this for any attribute in IE6/7[m
[31m-	// This fixes almost every IE6/7 issue[m
[31m-	nodeHook = {[m
[31m-		set: function( elem, value, name ) {[m
[31m-			// Set the existing or create a new attribute node[m
[31m-			var ret = elem.getAttributeNode( name );[m
[31m-			if ( !ret ) {[m
[31m-				elem.setAttributeNode([m
[31m-					(ret = elem.ownerDocument.createAttribute( name ))[m
[31m-				);[m
[31m-			}[m
[31m-[m
[31m-			ret.value = value += "";[m
[31m-[m
[31m-			// Break association with cloned elements by also using setAttribute (#9646)[m
[31m-			return name === "value" || value === elem.getAttribute( name ) ?[m
[31m-				value :[m
[31m-				undefined;[m
[31m-		}[m
[31m-	};[m
[31m-	jQuery.expr.attrHandle.id = jQuery.expr.attrHandle.name = jQuery.expr.attrHandle.coords =[m
[31m-		// Some attributes are constructed with empty-string values when not defined[m
[31m-		function( elem, name, isXML ) {[m
[31m-			var ret;[m
[31m-			return isXML ?[m
[31m-				undefined :[m
[31m-				(ret = elem.getAttributeNode( name )) && ret.value !== "" ?[m
[31m-					ret.value :[m
[31m-					null;[m
[31m-		};[m
[31m-	jQuery.valHooks.button = {[m
[31m-		get: function( elem, name ) {[m
[31m-			var ret = elem.getAttributeNode( name );[m
[31m-			return ret && ret.specified ?[m
[31m-				ret.value :[m
[31m-				undefined;[m
[31m-		},[m
[31m-		set: nodeHook.set[m
[31m-	};[m
[31m-[m
[31m-	// Set contenteditable to false on removals(#10429)[m
[31m-	// Setting to empty string throws an error as an invalid value[m
[31m-	jQuery.attrHooks.contenteditable = {[m
[31m-		set: function( elem, value, name ) {[m
[31m-			nodeHook.set( elem, value === "" ? false : value, name );[m
[31m-		}[m
[31m-	};[m
[31m-[m
[31m-	// Set width and height to auto instead of 0 on empty string( Bug #8150 )[m
[31m-	// This is for removals[m
[31m-	jQuery.each([ "width", "height" ], function( i, name ) {[m
[31m-		jQuery.attrHooks[ name ] = {[m
[31m-			set: function( elem, value ) {[m
[31m-				if ( value === "" ) {[m
[31m-					elem.setAttribute( name, "auto" );[m
[31m-					return value;[m
[31m-				}[m
[31m-			}[m
[31m-		};[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-[m
[31m-// Some attributes require a special call on IE[m
[31m-// http://msdn.microsoft.com/en-us/library/ms536429%28VS.85%29.aspx[m
[31m-if ( !jQuery.support.hrefNormalized ) {[m
[31m-	// href/src property should get the full normalized URL (#10299/#12915)[m
[31m-	jQuery.each([ "href", "src" ], function( i, name ) {[m
[31m-		jQuery.propHooks[ name ] = {[m
[31m-			get: function( elem ) {[m
[31m-				return elem.getAttribute( name, 4 );[m
[31m-			}[m
[31m-		};[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-if ( !jQuery.support.style ) {[m
[31m-	jQuery.attrHooks.style = {[m
[31m-		get: function( elem ) {[m
[31m-			// Return undefined in the case of empty string[m
[31m-			// Note: IE uppercases css property names, but if we were to .toLowerCase()[m
[31m-			// .cssText, that would destroy case senstitivity in URL's, like in "background"[m
[31m-			return elem.style.cssText || undefined;[m
[31m-		},[m
[31m-		set: function( elem, value ) {[m
[31m-			return ( elem.style.cssText = value + "" );[m
[31m-		}[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-// Safari mis-reports the default selected property of an option[m
[31m-// Accessing the parent's selectedIndex property fixes it[m
[31m-if ( !jQuery.support.optSelected ) {[m
[31m-	jQuery.propHooks.selected = {[m
[31m-		get: function( elem ) {[m
[31m-			var parent = elem.parentNode;[m
[31m-[m
[31m-			if ( parent ) {[m
[31m-				parent.selectedIndex;[m
[31m-[m
[31m-				// Make sure that it also works with optgroups, see #5701[m
[31m-				if ( parent.parentNode ) {[m
[31m-					parent.parentNode.selectedIndex;[m
[31m-				}[m
[31m-			}[m
[31m-			return null;[m
[31m-		}[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-jQuery.each([[m
[31m-	"tabIndex",[m
[31m-	"readOnly",[m
[31m-	"maxLength",[m
[31m-	"cellSpacing",[m
[31m-	"cellPadding",[m
[31m-	"rowSpan",[m
[31m-	"colSpan",[m
[31m-	"useMap",[m
[31m-	"frameBorder",[m
[31m-	"contentEditable"[m
[31m-], function() {[m
[31m-	jQuery.propFix[ this.toLowerCase() ] = this;[m
[31m-});[m
[31m-[m
[31m-// IE6/7 call enctype encoding[m
[31m-if ( !jQuery.support.enctype ) {[m
[31m-	jQuery.propFix.enctype = "encoding";[m
[31m-}[m
[31m-[m
[31m-// Radios and checkboxes getter/setter[m
[31m-jQuery.each([ "radio", "checkbox" ], function() {[m
[31m-	jQuery.valHooks[ this ] = {[m
[31m-		set: function( elem, value ) {[m
[31m-			if ( jQuery.isArray( value ) ) {[m
[31m-				return ( elem.checked = jQuery.inArray( jQuery(elem).val(), value ) >= 0 );[m
[31m-			}[m
[31m-		}[m
[31m-	};[m
[31m-	if ( !jQuery.support.checkOn ) {[m
[31m-		jQuery.valHooks[ this ].get = function( elem ) {[m
[31m-			// Support: Webkit[m
[31m-			// "" is returned instead of "on" if a value isn't specified[m
[31m-			return elem.getAttribute("value") === null ? "on" : elem.value;[m
[31m-		};[m
[31m-	}[m
[31m-});[m
[31m-var rformElems = /^(?:input|select|textarea)$/i,[m
[31m-	rkeyEvent = /^key/,[m
[31m-	rmouseEvent = /^(?:mouse|contextmenu)|click/,[m
[31m-	rfocusMorph = /^(?:focusinfocus|focusoutblur)$/,[m
[31m-	rtypenamespace = /^([^.]*)(?:\.(.+)|)$/;[m
[31m-[m
[31m-function returnTrue() {[m
[31m-	return true;[m
[31m-}[m
[31m-[m
[31m-function returnFalse() {[m
[31m-	return false;[m
[31m-}[m
[31m-[m
[31m-function safeActiveElement() {[m
[31m-	try {[m
[31m-		return document.activeElement;[m
[31m-	} catch ( err ) { }[m
[31m-}[m
[31m-[m
[31m-/*[m
[31m- * Helper functions for managing events -- not part of the public interface.[m
[31m- * Props to Dean Edwards' addEvent library for many of the ideas.[m
[31m- */[m
[31m-jQuery.event = {[m
[31m-[m
[31m-	global: {},[m
[31m-[m
[31m-	add: function( elem, types, handler, data, selector ) {[m
[31m-		var tmp, events, t, handleObjIn,[m
[31m-			special, eventHandle, handleObj,[m
[31m-			handlers, type, namespaces, origType,[m
[31m-			elemData = jQuery._data( elem );[m
[31m-[m
[31m-		// Don't attach events to noData or text/comment nodes (but allow plain objects)[m
[31m-		if ( !elemData ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// Caller can pass in an object of custom data in lieu of the handler[m
[31m-		if ( handler.handler ) {[m
[31m-			handleObjIn = handler;[m
[31m-			handler = handleObjIn.handler;[m
[31m-			selector = handleObjIn.selector;[m
[31m-		}[m
[31m-[m
[31m-		// Make sure that the handler has a unique ID, used to find/remove it later[m
[31m-		if ( !handler.guid ) {[m
[31m-			handler.guid = jQuery.guid++;[m
[31m-		}[m
[31m-[m
[31m-		// Init the element's event structure and main handler, if this is the first[m
[31m-		if ( !(events = elemData.events) ) {[m
[31m-			events = elemData.events = {};[m
[31m-		}[m
[31m-		if ( !(eventHandle = elemData.handle) ) {[m
[31m-			eventHandle = elemData.handle = function( e ) {[m
[31m-				// Discard the second event of a jQuery.event.trigger() and[m
[31m-				// when an event is called after a page has unloaded[m
[31m-				return typeof jQuery !== core_strundefined && (!e || jQuery.event.triggered !== e.type) ?[m
[31m-					jQuery.event.dispatch.apply( eventHandle.elem, arguments ) :[m
[31m-					undefined;[m
[31m-			};[m
[31m-			// Add elem as a property of the handle fn to prevent a memory leak with IE non-native events[m
[31m-			eventHandle.elem = elem;[m
[31m-		}[m
[31m-[m
[31m-		// Handle multiple events separated by a space[m
[31m-		types = ( types || "" ).match( core_rnotwhite ) || [""];[m
[31m-		t = types.length;[m
[31m-		while ( t-- ) {[m
[31m-			tmp = rtypenamespace.exec( types[t] ) || [];[m
[31m-			type = origType = tmp[1];[m
[31m-			namespaces = ( tmp[2] || "" ).split( "." ).sort();[m
[31m-[m
[31m-			// There *must* be a type, no attaching namespace-only handlers[m
[31m-			if ( !type ) {[m
[31m-				continue;[m
[31m-			}[m
[31m-[m
[31m-			// If event changes its type, use the special event handlers for the changed type[m
[31m-			special = jQuery.event.special[ type ] || {};[m
[31m-[m
[31m-			// If selector defined, determine special event api type, otherwise given type[m
[31m-			type = ( selector ? special.delegateType : special.bindType ) || type;[m
[31m-[m
[31m-			// Update special based on newly reset type[m
[31m-			special = jQuery.event.special[ type ] || {};[m
[31m-[m
[31m-			// handleObj is passed to all event handlers[m
[31m-			handleObj = jQuery.extend({[m
[31m-				type: type,[m
[31m-				origType: origType,[m
[31m-				data: data,[m
[31m-				handler: handler,[m
[31m-				guid: handler.guid,[m
[31m-				selector: selector,[m
[31m-				needsContext: selector && jQuery.expr.match.needsContext.test( selector ),[m
[31m-				namespace: namespaces.join(".")[m
[31m-			}, handleObjIn );[m
[31m-[m
[31m-			// Init the event handler queue if we're the first[m
[31m-			if ( !(handlers = events[ type ]) ) {[m
[31m-				handlers = events[ type ] = [];[m
[31m-				handlers.delegateCount = 0;[m
[31m-[m
[31m-				// Only use addEventListener/attachEvent if the special events handler returns false[m
[31m-				if ( !special.setup || special.setup.call( elem, data, namespaces, eventHandle ) === false ) {[m
[31m-					// Bind the global event handler to the element[m
[31m-					if ( elem.addEventListener ) {[m
[31m-						elem.addEventListener( type, eventHandle, false );[m
[31m-[m
[31m-					} else if ( elem.attachEvent ) {[m
[31m-						elem.attachEvent( "on" + type, eventHandle );[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			if ( special.add ) {[m
[31m-				special.add.call( elem, handleObj );[m
[31m-[m
[31m-				if ( !handleObj.handler.guid ) {[m
[31m-					handleObj.handler.guid = handler.guid;[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			// Add to the element's handler list, delegates in front[m
[31m-			if ( selector ) {[m
[31m-				handlers.splice( handlers.delegateCount++, 0, handleObj );[m
[31m-			} else {[m
[31m-				handlers.push( handleObj );[m
[31m-			}[m
[31m-[m
[31m-			// Keep track of which events have ever been used, for event optimization[m
[31m-			jQuery.event.global[ type ] = true;[m
[31m-		}[m
[31m-[m
[31m-		// Nullify elem to prevent memory leaks in IE[m
[31m-		elem = null;[m
[31m-	},[m
[31m-[m
[31m-	// Detach an event or set of events from an element[m
[31m-	remove: function( elem, types, handler, selector, mappedTypes ) {[m
[31m-		var j, handleObj, tmp,[m
[31m-			origCount, t, events,[m
[31m-			special, handlers, type,[m
[31m-			namespaces, origType,[m
[31m-			elemData = jQuery.hasData( elem ) && jQuery._data( elem );[m
[31m-[m
[31m-		if ( !elemData || !(events = elemData.events) ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// Once for each type.namespace in types; type may be omitted[m
[31m-		types = ( types || "" ).match( core_rnotwhite ) || [""];[m
[31m-		t = types.length;[m
[31m-		while ( t-- ) {[m
[31m-			tmp = rtypenamespace.exec( types[t] ) || [];[m
[31m-			type = origType = tmp[1];[m
[31m-			namespaces = ( tmp[2] || "" ).split( "." ).sort();[m
[31m-[m
[31m-			// Unbind all events (on this namespace, if provided) for the element[m
[31m-			if ( !type ) {[m
[31m-				for ( type in events ) {[m
[31m-					jQuery.event.remove( elem, type + types[ t ], handler, selector, true );[m
[31m-				}[m
[31m-				continue;[m
[31m-			}[m
[31m-[m
[31m-			special = jQuery.event.special[ type ] || {};[m
[31m-			type = ( selector ? special.delegateType : special.bindType ) || type;[m
[31m-			handlers = events[ type ] || [];[m
[31m-			tmp = tmp[2] && new RegExp( "(^|\\.)" + namespaces.join("\\.(?:.*\\.|)") + "(\\.|$)" );[m
[31m-[m
[31m-			// Remove matching events[m
[31m-			origCount = j = handlers.length;[m
[31m-			while ( j-- ) {[m
[31m-				handleObj = handlers[ j ];[m
[31m-[m
[31m-				if ( ( mappedTypes || origType === handleObj.origType ) &&[m
[31m-					( !handler || handler.guid === handleObj.guid ) &&[m
[31m-					( !tmp || tmp.test( handleObj.namespace ) ) &&[m
[31m-					( !selector || selector === handleObj.selector || selector === "**" && handleObj.selector ) ) {[m
[31m-					handlers.splice( j, 1 );[m
[31m-[m
[31m-					if ( handleObj.selector ) {[m
[31m-						handlers.delegateCount--;[m
[31m-					}[m
[31m-					if ( special.remove ) {[m
[31m-						special.remove.call( elem, handleObj );[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-[m
[31m-			// Remove generic event handler if we removed something and no more handlers exist[m
[31m-			// (avoids potential for endless recursion during removal of special event handlers)[m
[31m-			if ( origCount && !handlers.length ) {[m
[31m-				if ( !special.teardown || special.teardown.call( elem, namespaces, elemData.handle ) === false ) {[m
[31m-					jQuery.removeEvent( elem, type, elemData.handle );[m
[31m-				}[m
[31m-[m
[31m-				delete events[ type ];[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Remove the expando if it's no longer used[m
[31m-		if ( jQuery.isEmptyObject( events ) ) {[m
[31m-			delete elemData.handle;[m
[31m-[m
[31m-			// removeData also checks for emptiness and clears the expando if empty[m
[31m-			// so use it instead of delete[m
[31m-			jQuery._removeData( elem, "events" );[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	trigger: function( event, data, elem, onlyHandlers ) {[m
[31m-		var handle, ontype, cur,[m
[31m-			bubbleType, special, tmp, i,[m
[31m-			eventPath = [ elem || document ],[m
[31m-			type = core_hasOwn.call( event, "type" ) ? event.type : event,[m
[31m-			namespaces = core_hasOwn.call( event, "namespace" ) ? event.namespace.split(".") : [];[m
[31m-[m
[31m-		cur = tmp = elem = elem || document;[m
[31m-[m
[31m-		// Don't do events on text and comment nodes[m
[31m-		if ( elem.nodeType === 3 || elem.nodeType === 8 ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// focus/blur morphs to focusin/out; ensure we're not firing them right now[m
[31m-		if ( rfocusMorph.test( type + jQuery.event.triggered ) ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		if ( type.indexOf(".") >= 0 ) {[m
[31m-			// Namespaced trigger; create a regexp to match event type in handle()[m
[31m-			namespaces = type.split(".");[m
[31m-			type = namespaces.shift();[m
[31m-			namespaces.sort();[m
[31m-		}[m
[31m-		ontype = type.indexOf(":") < 0 && "on" + type;[m
[31m-[m
[31m-		// Caller can pass in a jQuery.Event object, Object, or just an event type string[m
[31m-		event = event[ jQuery.expando ] ?[m
[31m-			event :[m
[31m-			new jQuery.Event( type, typeof event === "object" && event );[m
[31m-[m
[31m-		// Trigger bitmask: & 1 for native handlers; & 2 for jQuery (always true)[m
[31m-		event.isTrigger = onlyHandlers ? 2 : 3;[m
[31m-		event.namespace = namespaces.join(".");[m
[31m-		event.namespace_re = event.namespace ?[m
[31m-			new RegExp( "(^|\\.)" + namespaces.join("\\.(?:.*\\.|)") + "(\\.|$)" ) :[m
[31m-			null;[m
[31m-[m
[31m-		// Clean up the event in case it is being reused[m
[31m-		event.result = undefined;[m
[31m-		if ( !event.target ) {[m
[31m-			event.target = elem;[m
[31m-		}[m
[31m-[m
[31m-		// Clone any incoming data and prepend the event, creating the handler arg list[m
[31m-		data = data == null ?[m
[31m-			[ event ] :[m
[31m-			jQuery.makeArray( data, [ event ] );[m
[31m-[m
[31m-		// Allow special events to draw outside the lines[m
[31m-		special = jQuery.event.special[ type ] || {};[m
[31m-		if ( !onlyHandlers && special.trigger && special.trigger.apply( elem, data ) === false ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// Determine event propagation path in advance, per W3C events spec (#9951)[m
[31m-		// Bubble up to document, then to window; watch for a global ownerDocument var (#9724)[m
[31m-		if ( !onlyHandlers && !special.noBubble && !jQuery.isWindow( elem ) ) {[m
[31m-[m
[31m-			bubbleType = special.delegateType || type;[m
[31m-			if ( !rfocusMorph.test( bubbleType + type ) ) {[m
[31m-				cur = cur.parentNode;[m
[31m-			}[m
[31m-			for ( ; cur; cur = cur.parentNode ) {[m
[31m-				eventPath.push( cur );[m
[31m-				tmp = cur;[m
[31m-			}[m
[31m-[m
[31m-			// Only add window if we got to document (e.g., not plain obj or detached DOM)[m
[31m-			if ( tmp === (elem.ownerDocument || document) ) {[m
[31m-				eventPath.push( tmp.defaultView || tmp.parentWindow || window );[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Fire handlers on the event path[m
[31m-		i = 0;[m
[31m-		while ( (cur = eventPath[i++]) && !event.isPropagationStopped() ) {[m
[31m-[m
[31m-			event.type = i > 1 ?[m
[31m-				bubbleType :[m
[31m-				special.bindType || type;[m
[31m-[m
[31m-			// jQuery handler[m
[31m-			handle = ( jQuery._data( cur, "events" ) || {} )[ event.type ] && jQuery._data( cur, "handle" );[m
[31m-			if ( handle ) {[m
[31m-				handle.apply( cur, data );[m
[31m-			}[m
[31m-[m
[31m-			// Native handler[m
[31m-			handle = ontype && cur[ ontype ];[m
[31m-			if ( handle && jQuery.acceptData( cur ) && handle.apply && handle.apply( cur, data ) === false ) {[m
[31m-				event.preventDefault();[m
[31m-			}[m
[31m-		}[m
[31m-		event.type = type;[m
[31m-[m
[31m-		// If nobody prevented the default action, do it now[m
[31m-		if ( !onlyHandlers && !event.isDefaultPrevented() ) {[m
[31m-[m
[31m-			if ( (!special._default || special._default.apply( eventPath.pop(), data ) === false) &&[m
[31m-				jQuery.acceptData( elem ) ) {[m
[31m-[m
[31m-				// Call a native DOM method on the target with the same name name as the event.[m
[31m-				// Can't use an .isFunction() check here because IE6/7 fails that test.[m
[31m-				// Don't do default actions on window, that's where global variables be (#6170)[m
[31m-				if ( ontype && elem[ type ] && !jQuery.isWindow( elem ) ) {[m
[31m-[m
[31m-					// Don't re-trigger an onFOO event when we call its FOO() method[m
[31m-					tmp = elem[ ontype ];[m
[31m-[m
[31m-					if ( tmp ) {[m
[31m-						elem[ ontype ] = null;[m
[31m-					}[m
[31m-[m
[31m-					// Prevent re-triggering of the same event, since we already bubbled it above[m
[31m-					jQuery.event.triggered = type;[m
[31m-					try {[m
[31m-						elem[ type ]();[m
[31m-					} catch ( e ) {[m
[31m-						// IE<9 dies on focus/blur to hidden element (#1486,#12518)[m
[31m-						// only reproducible on winXP IE8 native, not IE9 in IE8 mode[m
[31m-					}[m
[31m-					jQuery.event.triggered = undefined;[m
[31m-[m
[31m-					if ( tmp ) {[m
[31m-						elem[ ontype ] = tmp;[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return event.result;[m
[31m-	},[m
[31m-[m
[31m-	dispatch: function( event ) {[m
[31m-[m
[31m-		// Make a writable jQuery.Event from the native event object[m
[31m-		event = jQuery.event.fix( event );[m
[31m-[m
[31m-		var i, ret, handleObj, matched, j,[m
[31m-			handlerQueue = [],[m
[31m-			args = core_slice.call( arguments ),[m
[31m-			handlers = ( jQuery._data( this, "events" ) || {} )[ event.type ] || [],[m
[31m-			special = jQuery.event.special[ event.type ] || {};[m
[31m-[m
[31m-		// Use the fix-ed jQuery.Event rather than the (read-only) native event[m
[31m-		args[0] = event;[m
[31m-		event.delegateTarget = this;[m
[31m-[m
[31m-		// Call the preDispatch hook for the mapped type, and let it bail if desired[m
[31m-		if ( special.preDispatch && special.preDispatch.call( this, event ) === false ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// Determine handlers[m
[31m-		handlerQueue = jQuery.event.handlers.call( this, event, handlers );[m
[31m-[m
[31m-		// Run delegates first; they may want to stop propagation beneath us[m
[31m-		i = 0;[m
[31m-		while ( (matched = handlerQueue[ i++ ]) && !event.isPropagationStopped() ) {[m
[31m-			event.currentTarget = matched.elem;[m
[31m-[m
[31m-			j = 0;[m
[31m-			while ( (handleObj = matched.handlers[ j++ ]) && !event.isImmediatePropagationStopped() ) {[m
[31m-[m
[31m-				// Triggered event must either 1) have no namespace, or[m
[31m-				// 2) have namespace(s) a subset or equal to those in the bound event (both can have no namespace).[m
[31m-				if ( !event.namespace_re || event.namespace_re.test( handleObj.namespace ) ) {[m
[31m-[m
[31m-					event.handleObj = handleObj;[m
[31m-					event.data = handleObj.data;[m
[31m-[m
[31m-					ret = ( (jQuery.event.special[ handleObj.origType ] || {}).handle || handleObj.handler )[m
[31m-							.apply( matched.elem, args );[m
[31m-[m
[31m-					if ( ret !== undefined ) {[m
[31m-						if ( (event.result = ret) === false ) {[m
[31m-							event.preventDefault();[m
[31m-							event.stopPropagation();[m
[31m-						}[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Call the postDispatch hook for the mapped type[m
[31m-		if ( special.postDispatch ) {[m
[31m-			special.postDispatch.call( this, event );[m
[31m-		}[m
[31m-[m
[31m-		return event.result;[m
[31m-	},[m
[31m-[m
[31m-	handlers: function( event, handlers ) {[m
[31m-		var sel, handleObj, matches, i,[m
[31m-			handlerQueue = [],[m
[31m-			delegateCount = handlers.delegateCount,[m
[31m-			cur = event.target;[m
[31m-[m
[31m-		// Find delegate handlers[m
[31m-		// Black-hole SVG <use> instance trees (#13180)[m
[31m-		// Avoid non-left-click bubbling in Firefox (#3861)[m
[31m-		if ( delegateCount && cur.nodeType && (!event.button || event.type !== "click") ) {[m
[31m-[m
[31m-			/* jshint eqeqeq: false */[m
[31m-			for ( ; cur != this; cur = cur.parentNode || this ) {[m
[31m-				/* jshint eqeqeq: true */[m
[31m-[m
[31m-				// Don't check non-elements (#13208)[m
[31m-				// Don't process clicks on disabled elements (#6911, #8165, #11382, #11764)[m
[31m-				if ( cur.nodeType === 1 && (cur.disabled !== true || event.type !== "click") ) {[m
[31m-					matches = [];[m
[31m-					for ( i = 0; i < delegateCount; i++ ) {[m
[31m-						handleObj = handlers[ i ];[m
[31m-[m
[31m-						// Don't conflict with Object.prototype properties (#13203)[m
[31m-						sel = handleObj.selector + " ";[m
[31m-[m
[31m-						if ( matches[ sel ] === undefined ) {[m
[31m-							matches[ sel ] = handleObj.needsContext ?[m
[31m-								jQuery( sel, this ).index( cur ) >= 0 :[m
[31m-								jQuery.find( sel, this, null, [ cur ] ).length;[m
[31m-						}[m
[31m-						if ( matches[ sel ] ) {[m
[31m-							matches.push( handleObj );[m
[31m-						}[m
[31m-					}[m
[31m-					if ( matches.length ) {[m
[31m-						handlerQueue.push({ elem: cur, handlers: matches });[m
[31m-					}[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		// Add the remaining (directly-bound) handlers[m
[31m-		if ( delegateCount < handlers.length ) {[m
[31m-			handlerQueue.push({ elem: this, handlers: handlers.slice( delegateCount ) });[m
[31m-		}[m
[31m-[m
[31m-		return handlerQueue;[m
[31m-	},[m
[31m-[m
[31m-	fix: function( event ) {[m
[31m-		if ( event[ jQuery.expando ] ) {[m
[31m-			return event;[m
[31m-		}[m
[31m-[m
[31m-		// Create a writable copy of the event object and normalize some properties[m
[31m-		var i, prop, copy,[m
[31m-			type = event.type,[m
[31m-			originalEvent = event,[m
[31m-			fixHook = this.fixHooks[ type ];[m
[31m-[m
[31m-		if ( !fixHook ) {[m
[31m-			this.fixHooks[ type ] = fixHook =[m
[31m-				rmouseEvent.test( type ) ? this.mouseHooks :[m
[31m-				rkeyEvent.test( type ) ? this.keyHooks :[m
[31m-				{};[m
[31m-		}[m
[31m-		copy = fixHook.props ? this.props.concat( fixHook.props ) : this.props;[m
[31m-[m
[31m-		event = new jQuery.Event( originalEvent );[m
[31m-[m
[31m-		i = copy.length;[m
[31m-		while ( i-- ) {[m
[31m-			prop = copy[ i ];[m
[31m-			event[ prop ] = originalEvent[ prop ];[m
[31m-		}[m
[31m-[m
[31m-		// Support: IE<9[m
[31m-		// Fix target property (#1925)[m
[31m-		if ( !event.target ) {[m
[31m-			event.target = originalEvent.srcElement || document;[m
[31m-		}[m
[31m-[m
[31m-		// Support: Chrome 23+, Safari?[m
[31m-		// Target should not be a text node (#504, #13143)[m
[31m-		if ( event.target.nodeType === 3 ) {[m
[31m-			event.target = event.target.parentNode;[m
[31m-		}[m
[31m-[m
[31m-		// Support: IE<9[m
[31m-		// For mouse/key events, metaKey==false if it's undefined (#3368, #11328)[m
[31m-		event.metaKey = !!event.metaKey;[m
[31m-[m
[31m-		return fixHook.filter ? fixHook.filter( event, originalEvent ) : event;[m
[31m-	},[m
[31m-[m
[31m-	// Includes some event props shared by KeyEvent and MouseEvent[m
[31m-	props: "altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),[m
[31m-[m
[31m-	fixHooks: {},[m
[31m-[m
[31m-	keyHooks: {[m
[31m-		props: "char charCode key keyCode".split(" "),[m
[31m-		filter: function( event, original ) {[m
[31m-[m
[31m-			// Add which for key events[m
[31m-			if ( event.which == null ) {[m
[31m-				event.which = original.charCode != null ? original.charCode : original.keyCode;[m
[31m-			}[m
[31m-[m
[31m-			return event;[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	mouseHooks: {[m
[31m-		props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),[m
[31m-		filter: function( event, original ) {[m
[31m-			var body, eventDoc, doc,[m
[31m-				button = original.button,[m
[31m-				fromElement = original.fromElement;[m
[31m-[m
[31m-			// Calculate pageX/Y if missing and clientX/Y available[m
[31m-			if ( event.pageX == null && original.clientX != null ) {[m
[31m-				eventDoc = event.target.ownerDocument || document;[m
[31m-				doc = eventDoc.documentElement;[m
[31m-				body = eventDoc.body;[m
[31m-[m
[31m-				event.pageX = original.clientX + ( doc && doc.scrollLeft || body && body.scrollLeft || 0 ) - ( doc && doc.clientLeft || body && body.clientLeft || 0 );[m
[31m-				event.pageY = original.clientY + ( doc && doc.scrollTop  || body && body.scrollTop  || 0 ) - ( doc && doc.clientTop  || body && body.clientTop  || 0 );[m
[31m-			}[m
[31m-[m
[31m-			// Add relatedTarget, if necessary[m
[31m-			if ( !event.relatedTarget && fromElement ) {[m
[31m-				event.relatedTarget = fromElement === event.target ? original.toElement : fromElement;[m
[31m-			}[m
[31m-[m
[31m-			// Add which for click: 1 === left; 2 === middle; 3 === right[m
[31m-			// Note: button is not normalized, so don't use it[m
[31m-			if ( !event.which && button !== undefined ) {[m
[31m-				event.which = ( button & 1 ? 1 : ( button & 2 ? 3 : ( button & 4 ? 2 : 0 ) ) );[m
[31m-			}[m
[31m-[m
[31m-			return event;[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	special: {[m
[31m-		load: {[m
[31m-			// Prevent triggered image.load events from bubbling to window.load[m
[31m-			noBubble: true[m
[31m-		},[m
[31m-		focus: {[m
[31m-			// Fire native event if possible so blur/focus sequence is correct[m
[31m-			trigger: function() {[m
[31m-				if ( this !== safeActiveElement() && this.focus ) {[m
[31m-					try {[m
[31m-						this.focus();[m
[31m-						return false;[m
[31m-					} catch ( e ) {[m
[31m-						// Support: IE<9[m
[31m-						// If we error on focus to hidden element (#1486, #12518),[m
[31m-						// let .trigger() run the handlers[m
[31m-					}[m
[31m-				}[m
[31m-			},[m
[31m-			delegateType: "focusin"[m
[31m-		},[m
[31m-		blur: {[m
[31m-			trigger: function() {[m
[31m-				if ( this === safeActiveElement() && this.blur ) {[m
[31m-					this.blur();[m
[31m-					return false;[m
[31m-				}[m
[31m-			},[m
[31m-			delegateType: "focusout"[m
[31m-		},[m
[31m-		click: {[m
[31m-			// For checkbox, fire native event so checked state will be right[m
[31m-			trigger: function() {[m
[31m-				if ( jQuery.nodeName( this, "input" ) && this.type === "checkbox" && this.click ) {[m
[31m-					this.click();[m
[31m-					return false;[m
[31m-				}[m
[31m-			},[m
[31m-[m
[31m-			// For cross-browser consistency, don't fire native .click() on links[m
[31m-			_default: function( event ) {[m
[31m-				return jQuery.nodeName( event.target, "a" );[m
[31m-			}[m
[31m-		},[m
[31m-[m
[31m-		beforeunload: {[m
[31m-			postDispatch: function( event ) {[m
[31m-[m
[31m-				// Even when returnValue equals to undefined Firefox will still show alert[m
[31m-				if ( event.result !== undefined ) {[m
[31m-					event.originalEvent.returnValue = event.result;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-	},[m
[31m-[m
[31m-	simulate: function( type, elem, event, bubble ) {[m
[31m-		// Piggyback on a donor event to simulate a different one.[m
[31m-		// Fake originalEvent to avoid donor's stopPropagation, but if the[m
[31m-		// simulated event prevents default then we do the same on the donor.[m
[31m-		var e = jQuery.extend([m
[31m-			new jQuery.Event(),[m
[31m-			event,[m
[31m-			{[m
[31m-				type: type,[m
[31m-				isSimulated: true,[m
[31m-				originalEvent: {}[m
[31m-			}[m
[31m-		);[m
[31m-		if ( bubble ) {[m
[31m-			jQuery.event.trigger( e, null, elem );[m
[31m-		} else {[m
[31m-			jQuery.event.dispatch.call( elem, e );[m
[31m-		}[m
[31m-		if ( e.isDefaultPrevented() ) {[m
[31m-			event.preventDefault();[m
[31m-		}[m
[31m-	}[m
[31m-};[m
[31m-[m
[31m-jQuery.removeEvent = document.removeEventListener ?[m
[31m-	function( elem, type, handle ) {[m
[31m-		if ( elem.removeEventListener ) {[m
[31m-			elem.removeEventListener( type, handle, false );[m
[31m-		}[m
[31m-	} :[m
[31m-	function( elem, type, handle ) {[m
[31m-		var name = "on" + type;[m
[31m-[m
[31m-		if ( elem.detachEvent ) {[m
[31m-[m
[31m-			// #8545, #7054, preventing memory leaks for custom events in IE6-8[m
[31m-			// detachEvent needed property on element, by name of that event, to properly expose it to GC[m
[31m-			if ( typeof elem[ name ] === core_strundefined ) {[m
[31m-				elem[ name ] = null;[m
[31m-			}[m
[31m-[m
[31m-			elem.detachEvent( name, handle );[m
[31m-		}[m
[31m-	};[m
[31m-[m
[31m-jQuery.Event = function( src, props ) {[m
[31m-	// Allow instantiation without the 'new' keyword[m
[31m-	if ( !(this instanceof jQuery.Event) ) {[m
[31m-		return new jQuery.Event( src, props );[m
[31m-	}[m
[31m-[m
[31m-	// Event object[m
[31m-	if ( src && src.type ) {[m
[31m-		this.originalEvent = src;[m
[31m-		this.type = src.type;[m
[31m-[m
[31m-		// Events bubbling up the document may have been marked as prevented[m
[31m-		// by a handler lower down the tree; reflect the correct value.[m
[31m-		this.isDefaultPrevented = ( src.defaultPrevented || src.returnValue === false ||[m
[31m-			src.getPreventDefault && src.getPreventDefault() ) ? returnTrue : returnFalse;[m
[31m-[m
[31m-	// Event type[m
[31m-	} else {[m
[31m-		this.type = src;[m
[31m-	}[m
[31m-[m
[31m-	// Put explicitly provided properties onto the event object[m
[31m-	if ( props ) {[m
[31m-		jQuery.extend( this, props );[m
[31m-	}[m
[31m-[m
[31m-	// Create a timestamp if incoming event doesn't have one[m
[31m-	this.timeStamp = src && src.timeStamp || jQuery.now();[m
[31m-[m
[31m-	// Mark it as fixed[m
[31m-	this[ jQuery.expando ] = true;[m
[31m-};[m
[31m-[m
[31m-// jQuery.Event is based on DOM3 Events as specified by the ECMAScript Language Binding[m
[31m-// http://www.w3.org/TR/2003/WD-DOM-Level-3-Events-20030331/ecma-script-binding.html[m
[31m-jQuery.Event.prototype = {[m
[31m-	isDefaultPrevented: returnFalse,[m
[31m-	isPropagationStopped: returnFalse,[m
[31m-	isImmediatePropagationStopped: returnFalse,[m
[31m-[m
[31m-	preventDefault: function() {[m
[31m-		var e = this.originalEvent;[m
[31m-[m
[31m-		this.isDefaultPrevented = returnTrue;[m
[31m-		if ( !e ) {[m
[31m-			return;[m
[31m-		}[m
[31m-[m
[31m-		// If preventDefault exists, run it on the original event[m
[31m-		if ( e.preventDefault ) {[m
[31m-			e.preventDefault();[m
[31m-[m
[31m-		// Support: IE[m
[31m-		// Otherwise set the returnValue property of the original event to false[m
[31m-		} else {[m
[31m-			e.returnValue = false;[m
[31m-		}[m
[31m-	},[m
[31m-	stopPropagation: function() {[m
[31m-		var e = this.originalEvent;[m
[31m-[m
[31m-		this.isPropagationStopped = returnTrue;[m
[31m-		if ( !e ) {[m
[31m-			return;[m
[31m-		}[m
[31m-		// If stopPropagation exists, run it on the original event[m
[31m-		if ( e.stopPropagation ) {[m
[31m-			e.stopPropagation();[m
[31m-		}[m
[31m-[m
[31m-		// Support: IE[m
[31m-		// Set the cancelBubble property of the original event to true[m
[31m-		e.cancelBubble = true;[m
[31m-	},[m
[31m-	stopImmediatePropagation: function() {[m
[31m-		this.isImmediatePropagationStopped = returnTrue;[m
[31m-		this.stopPropagation();[m
[31m-	}[m
[31m-};[m
[31m-[m
[31m-// Create mouseenter/leave events using mouseover/out and event-time checks[m
[31m-jQuery.each({[m
[31m-	mouseenter: "mouseover",[m
[31m-	mouseleave: "mouseout"[m
[31m-}, function( orig, fix ) {[m
[31m-	jQuery.event.special[ orig ] = {[m
[31m-		delegateType: fix,[m
[31m-		bindType: fix,[m
[31m-[m
[31m-		handle: function( event ) {[m
[31m-			var ret,[m
[31m-				target = this,[m
[31m-				related = event.relatedTarget,[m
[31m-				handleObj = event.handleObj;[m
[31m-[m
[31m-			// For mousenter/leave call the handler if related is outside the target.[m
[31m-			// NB: No relatedTarget if the mouse left/entered the browser window[m
[31m-			if ( !related || (related !== target && !jQuery.contains( target, related )) ) {[m
[31m-				event.type = handleObj.origType;[m
[31m-				ret = handleObj.handler.apply( this, arguments );[m
[31m-				event.type = fix;[m
[31m-			}[m
[31m-			return ret;[m
[31m-		}[m
[31m-	};[m
[31m-});[m
[31m-[m
[31m-// IE submit delegation[m
[31m-if ( !jQuery.support.submitBubbles ) {[m
[31m-[m
[31m-	jQuery.event.special.submit = {[m
[31m-		setup: function() {[m
[31m-			// Only need this for delegated form submit events[m
[31m-			if ( jQuery.nodeName( this, "form" ) ) {[m
[31m-				return false;[m
[31m-			}[m
[31m-[m
[31m-			// Lazy-add a submit handler when a descendant form may potentially be submitted[m
[31m-			jQuery.event.add( this, "click._submit keypress._submit", function( e ) {[m
[31m-				// Node name check avoids a VML-related crash in IE (#9807)[m
[31m-				var elem = e.target,[m
[31m-					form = jQuery.nodeName( elem, "input" ) || jQuery.nodeName( elem, "button" ) ? elem.form : undefined;[m
[31m-				if ( form && !jQuery._data( form, "submitBubbles" ) ) {[m
[31m-					jQuery.event.add( form, "submit._submit", function( event ) {[m
[31m-						event._submit_bubble = true;[m
[31m-					});[m
[31m-					jQuery._data( form, "submitBubbles", true );[m
[31m-				}[m
[31m-			});[m
[31m-			// return undefined since we don't need an event listener[m
[31m-		},[m
[31m-[m
[31m-		postDispatch: function( event ) {[m
[31m-			// If form was submitted by the user, bubble the event up the tree[m
[31m-			if ( event._submit_bubble ) {[m
[31m-				delete event._submit_bubble;[m
[31m-				if ( this.parentNode && !event.isTrigger ) {[m
[31m-					jQuery.event.simulate( "submit", this.parentNode, event, true );[m
[31m-				}[m
[31m-			}[m
[31m-		},[m
[31m-[m
[31m-		teardown: function() {[m
[31m-			// Only need this for delegated form submit events[m
[31m-			if ( jQuery.nodeName( this, "form" ) ) {[m
[31m-				return false;[m
[31m-			}[m
[31m-[m
[31m-			// Remove delegated handlers; cleanData eventually reaps submit handlers attached above[m
[31m-			jQuery.event.remove( this, "._submit" );[m
[31m-		}[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-// IE change delegation and checkbox/radio fix[m
[31m-if ( !jQuery.support.changeBubbles ) {[m
[31m-[m
[31m-	jQuery.event.special.change = {[m
[31m-[m
[31m-		setup: function() {[m
[31m-[m
[31m-			if ( rformElems.test( this.nodeName ) ) {[m
[31m-				// IE doesn't fire change on a check/radio until blur; trigger it on click[m
[31m-				// after a propertychange. Eat the blur-change in special.change.handle.[m
[31m-				// This still fires onchange a second time for check/radio after blur.[m
[31m-				if ( this.type === "checkbox" || this.type === "radio" ) {[m
[31m-					jQuery.event.add( this, "propertychange._change", function( event ) {[m
[31m-						if ( event.originalEvent.propertyName === "checked" ) {[m
[31m-							this._just_changed = true;[m
[31m-						}[m
[31m-					});[m
[31m-					jQuery.event.add( this, "click._change", function( event ) {[m
[31m-						if ( this._just_changed && !event.isTrigger ) {[m
[31m-							this._just_changed = false;[m
[31m-						}[m
[31m-						// Allow triggered, simulated change events (#11500)[m
[31m-						jQuery.event.simulate( "change", this, event, true );[m
[31m-					});[m
[31m-				}[m
[31m-				return false;[m
[31m-			}[m
[31m-			// Delegated event; lazy-add a change handler on descendant inputs[m
[31m-			jQuery.event.add( this, "beforeactivate._change", function( e ) {[m
[31m-				var elem = e.target;[m
[31m-[m
[31m-				if ( rformElems.test( elem.nodeName ) && !jQuery._data( elem, "changeBubbles" ) ) {[m
[31m-					jQuery.event.add( elem, "change._change", function( event ) {[m
[31m-						if ( this.parentNode && !event.isSimulated && !event.isTrigger ) {[m
[31m-							jQuery.event.simulate( "change", this.parentNode, event, true );[m
[31m-						}[m
[31m-					});[m
[31m-					jQuery._data( elem, "changeBubbles", true );[m
[31m-				}[m
[31m-			});[m
[31m-		},[m
[31m-[m
[31m-		handle: function( event ) {[m
[31m-			var elem = event.target;[m
[31m-[m
[31m-			// Swallow native change events from checkbox/radio, we already triggered them above[m
[31m-			if ( this !== elem || event.isSimulated || event.isTrigger || (elem.type !== "radio" && elem.type !== "checkbox") ) {[m
[31m-				return event.handleObj.handler.apply( this, arguments );[m
[31m-			}[m
[31m-		},[m
[31m-[m
[31m-		teardown: function() {[m
[31m-			jQuery.event.remove( this, "._change" );[m
[31m-[m
[31m-			return !rformElems.test( this.nodeName );[m
[31m-		}[m
[31m-	};[m
[31m-}[m
[31m-[m
[31m-// Create "bubbling" focus and blur events[m
[31m-if ( !jQuery.support.focusinBubbles ) {[m
[31m-	jQuery.each({ focus: "focusin", blur: "focusout" }, function( orig, fix ) {[m
[31m-[m
[31m-		// Attach a single capturing handler while someone wants focusin/focusout[m
[31m-		var attaches = 0,[m
[31m-			handler = function( event ) {[m
[31m-				jQuery.event.simulate( fix, event.target, jQuery.event.fix( event ), true );[m
[31m-			};[m
[31m-[m
[31m-		jQuery.event.special[ fix ] = {[m
[31m-			setup: function() {[m
[31m-				if ( attaches++ === 0 ) {[m
[31m-					document.addEventListener( orig, handler, true );[m
[31m-				}[m
[31m-			},[m
[31m-			teardown: function() {[m
[31m-				if ( --attaches === 0 ) {[m
[31m-					document.removeEventListener( orig, handler, true );[m
[31m-				}[m
[31m-			}[m
[31m-		};[m
[31m-	});[m
[31m-}[m
[31m-[m
[31m-jQuery.fn.extend({[m
[31m-[m
[31m-	on: function( types, selector, data, fn, /*INTERNAL*/ one ) {[m
[31m-		var type, origFn;[m
[31m-[m
[31m-		// Types can be a map of types/handlers[m
[31m-		if ( typeof types === "object" ) {[m
[31m-			// ( types-Object, selector, data )[m
[31m-			if ( typeof selector !== "string" ) {[m
[31m-				// ( types-Object, data )[m
[31m-				data = data || selector;[m
[31m-				selector = undefined;[m
[31m-			}[m
[31m-			for ( type in types ) {[m
[31m-				this.on( type, selector, data, types[ type ], one );[m
[31m-			}[m
[31m-			return this;[m
[31m-		}[m
[31m-[m
[31m-		if ( data == null && fn == null ) {[m
[31m-			// ( types, fn )[m
[31m-			fn = selector;[m
[31m-			data = selector = undefined;[m
[31m-		} else if ( fn == null ) {[m
[31m-			if ( typeof selector === "string" ) {[m
[31m-				// ( types, selector, fn )[m
[31m-				fn = data;[m
[31m-				data = undefined;[m
[31m-			} else {[m
[31m-				// ( types, data, fn )[m
[31m-				fn = data;[m
[31m-				data = selector;[m
[31m-				selector = undefined;[m
[31m-			}[m
[31m-		}[m
[31m-		if ( fn === false ) {[m
[31m-			fn = returnFalse;[m
[31m-		} else if ( !fn ) {[m
[31m-			return this;[m
[31m-		}[m
[31m-[m
[31m-		if ( one === 1 ) {[m
[31m-			origFn = fn;[m
[31m-			fn = function( event ) {[m
[31m-				// Can use an empty set, since event contains the info[m
[31m-				jQuery().off( event );[m
[31m-				return origFn.apply( this, arguments );[m
[31m-			};[m
[31m-			// Use same guid so caller can remove using origFn[m
[31m-			fn.guid = origFn.guid || ( origFn.guid = jQuery.guid++ );[m
[31m-		}[m
[31m-		return this.each( function() {[m
[31m-			jQuery.event.add( this, types, fn, data, selector );[m
[31m-		});[m
[31m-	},[m
[31m-	one: function( types, selector, data, fn ) {[m
[31m-		return this.on( types, selector, data, fn, 1 );[m
[31m-	},[m
[31m-	off: function( types, selector, fn ) {[m
[31m-		var handleObj, type;[m
[31m-		if ( types && types.preventDefault && types.handleObj ) {[m
[31m-			// ( event )  dispatched jQuery.Event[m
[31m-			handleObj = types.handleObj;[m
[31m-			jQuery( types.delegateTarget ).off([m
[31m-				handleObj.namespace ? handleObj.origType + "." + handleObj.namespace : handleObj.origType,[m
[31m-				handleObj.selector,[m
[31m-				handleObj.handler[m
[31m-			);[m
[31m-			return this;[m
[31m-		}[m
[31m-		if ( typeof types === "object" ) {[m
[31m-			// ( types-object [, selector] )[m
[31m-			for ( type in types ) {[m
[31m-				this.off( type, selector, types[ type ] );[m
[31m-			}[m
[31m-			return this;[m
[31m-		}[m
[31m-		if ( selector === false || typeof selector === "function" ) {[m
[31m-			// ( types [, fn] )[m
[31m-			fn = selector;[m
[31m-			selector = undefined;[m
[31m-		}[m
[31m-		if ( fn === false ) {[m
[31m-			fn = returnFalse;[m
[31m-		}[m
[31m-		return this.each(function() {[m
[31m-			jQuery.event.remove( this, types, fn, selector );[m
[31m-		});[m
[31m-	},[m
[31m-[m
[31m-	trigger: function( type, data ) {[m
[31m-		return this.each(function() {[m
[31m-			jQuery.event.trigger( type, data, this );[m
[31m-		});[m
[31m-	},[m
[31m-	triggerHandler: function( type, data ) {[m
[31m-		var elem = this[0];[m
[31m-		if ( elem ) {[m
[31m-			return jQuery.event.trigger( type, data, elem, true );[m
[31m-		}[m
[31m-	}[m
[31m-});[m
[31m-var isSimple = /^.[^:#\[\.,]*$/,[m
[31m-	rparentsprev = /^(?:parents|prev(?:Until|All))/,[m
[31m-	rneedsContext = jQuery.expr.match.needsContext,[m
[31m-	// methods guaranteed to produce a unique set when starting from a unique set[m
[31m-	guaranteedUnique = {[m
[31m-		children: true,[m
[31m-		contents: true,[m
[31m-		next: true,[m
[31m-		prev: true[m
[31m-	};[m
[31m-[m
[31m-jQuery.fn.extend({[m
[31m-	find: function( selector ) {[m
[31m-		var i,[m
[31m-			ret = [],[m
[31m-			self = this,[m
[31m-			len = self.length;[m
[31m-[m
[31m-		if ( typeof selector !== "string" ) {[m
[31m-			return this.pushStack( jQuery( selector ).filter(function() {[m
[31m-				for ( i = 0; i < len; i++ ) {[m
[31m-					if ( jQuery.contains( self[ i ], this ) ) {[m
[31m-						return true;[m
[31m-					}[m
[31m-				}[m
[31m-			}) );[m
[31m-		}[m
[31m-[m
[31m-		for ( i = 0; i < len; i++ ) {[m
[31m-			jQuery.find( selector, self[ i ], ret );[m
[31m-		}[m
[31m-[m
[31m-		// Needed because $( selector, context ) becomes $( context ).find( selector )[m
[31m-		ret = this.pushStack( len > 1 ? jQuery.unique( ret ) : ret );[m
[31m-		ret.selector = this.selector ? this.selector + " " + selector : selector;[m
[31m-		return ret;[m
[31m-	},[m
[31m-[m
[31m-	has: function( target ) {[m
[31m-		var i,[m
[31m-			targets = jQuery( target, this ),[m
[31m-			len = targets.length;[m
[31m-[m
[31m-		return this.filter(function() {[m
[31m-			for ( i = 0; i < len; i++ ) {[m
[31m-				if ( jQuery.contains( this, targets[i] ) ) {[m
[31m-					return true;[m
[31m-				}[m
[31m-			}[m
[31m-		});[m
[31m-	},[m
[31m-[m
[31m-	not: function( selector ) {[m
[31m-		return this.pushStack( winnow(this, selector || [], true) );[m
[31m-	},[m
[31m-[m
[31m-	filter: function( selector ) {[m
[31m-		return this.pushStack( winnow(this, selector || [], false) );[m
[31m-	},[m
[31m-[m
[31m-	is: function( selector ) {[m
[31m-		return !!winnow([m
[31m-			this,[m
[31m-[m
[31m-			// If this is a positional/relative selector, check membership in the returned set[m
[31m-			// so $("p:first").is("p:last") won't return true for a doc with two "p".[m
[31m-			typeof selector === "string" && rneedsContext.test( selector ) ?[m
[31m-				jQuery( selector ) :[m
[31m-				selector || [],[m
[31m-			false[m
[31m-		).length;[m
[31m-	},[m
[31m-[m
[31m-	closest: function( selectors, context ) {[m
[31m-		var cur,[m
[31m-			i = 0,[m
[31m-			l = this.length,[m
[31m-			ret = [],[m
[31m-			pos = rneedsContext.test( selectors ) || typeof selectors !== "string" ?[m
[31m-				jQuery( selectors, context || this.context ) :[m
[31m-				0;[m
[31m-[m
[31m-		for ( ; i < l; i++ ) {[m
[31m-			for ( cur = this[i]; cur && cur !== context; cur = cur.parentNode ) {[m
[31m-				// Always skip document fragments[m
[31m-				if ( cur.nodeType < 11 && (pos ?[m
[31m-					pos.index(cur) > -1 :[m
[31m-[m
[31m-					// Don't pass non-elements to Sizzle[m
[31m-					cur.nodeType === 1 &&[m
[31m-						jQuery.find.matchesSelector(cur, selectors)) ) {[m
[31m-[m
[31m-					cur = ret.push( cur );[m
[31m-					break;[m
[31m-				}[m
[31m-			}[m
[31m-		}[m
[31m-[m
[31m-		return this.pushStack( ret.length > 1 ? jQuery.unique( ret ) : ret );[m
[31m-	},[m
[31m-[m
[31m-	// Determine the position of an element within[m
[31m-	// the matched set of elements[m
[31m-	index: function( elem ) {[m
[31m-[m
[31m-		// No argument, return index in parent[m
[31m-		if ( !elem ) {[m
[31m-			return ( this[0] && this[0].parentNode ) ? this.first().prevAll().length : -1;[m
[31