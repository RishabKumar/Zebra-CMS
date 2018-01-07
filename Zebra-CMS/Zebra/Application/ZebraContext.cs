using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.Models;
using Zebra.Globalization;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Application
{
    public class ZebraContext : IDisposable
    {
        public ZebraContext.PageUrl Url;
        public ZebraContext.PageData Page;

        public ZebraContext()
        {
            
            string startnode = "content/";
            string pagepath = HttpContext.Current.Request.Url.AbsolutePath.Replace("zebrapage/", startnode);

            Url = new PageUrl(HttpContext.Current.Request.Url, pagepath);

            var urlparts = HttpContext.Current.Request.Url.AbsolutePath.Split('/');
            foreach(var part in urlparts)
            {
                CurrentLanguage = LanguageManager.GetLanguage(part);
                if(CurrentLanguage != null)
                {
                    pagepath = pagepath.Replace("/" + part, "");
                    break;
                }
            }

            var pagenode = OperationsFactory.PageOperations.GetPageNode(pagepath[pagepath.Length - 1] == '/' ? pagepath : pagepath + "/");
            string layoutid = null;
            List<Guid> actions = new List<Guid>();
            if (pagenode != null)
            {
                if (!pagenode.Id.Equals(Guid.Empty))
                {
                    layoutid = OperationsFactory.NodeOperations.GetValueForField(pagenode.Id.ToString(), "F2BDCBE7-462A-47B2-AE45-E85865626823");
                    var tmpactions = OperationsFactory.NodeOperations.GetValueForField(pagenode.Id.ToString(), "EEECA56F-0D2F-453D-9C37-C1DF80659917");
                    var tmpactionlist = tmpactions.Split(',');
                    foreach(var tmp in tmpactionlist)
                    {
                        Guid id;
                        var t = tmp.Split('=');
                        if(t.Length > 1 && Guid.TryParse(t[1].Trim(), out id))
                        {
                            actions.Add(id);
                        }
                    }
                }
                var layout = string.IsNullOrEmpty(layoutid) ? (Guid?)null : Guid.Parse(layoutid);

                Page = new PageData(pagenode.Id, layout, actions);
            }
        }

        static ZebraContext()
        {
            Current = new ZebraContext();
        }

        public static bool IsEditorMode { get; set; }

        public static ZebraContext Current
        {
            get
            {
                ZebraContext ctx = (ZebraContext)HttpContext.Current.Items[typeof(ZebraContext)];
                if (ctx == null)
                {
                    ctx = new ZebraContext();
                    HttpContext.Current.Items.Add(typeof(ZebraContext), ctx);
                }

                return ctx;
            }
            set { HttpContext.Current.Items[typeof(ZebraContext)] = value; }
        }

        public class PageData
        {
            public PageData(Guid? PageNodeId, Guid? PageLayout, List<Guid>Actions)
            {
                this.PageLayout = PageLayout;
                this.PageNodeId = PageNodeId;
                this.Actions = Actions;
            }
            public readonly Guid? PageNodeId;
            public readonly Guid? PageLayout;
            public readonly List<Guid> Actions;
        }

        public class PageUrl
        {
            public PageUrl(Uri AbsolutePageUrl, string PageNodeUrl)
            {
                this.AbsolutePageUrl = AbsolutePageUrl;
                this.PageNodeUrl = PageNodeUrl;
            }
            public readonly Uri AbsolutePageUrl;
            public readonly string PageNodeUrl;
        }

        public Language CurrentLanguage { get; set; }  

        public void Dispose()
        {
            Current = null;
            Page = null;
            Url = null;
        }
    }
}