using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using Zebra.Constants;
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
        public readonly User CurrentUser;
         
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
            string rawdesign = null;
            PageDesign completedesign = new PageDesign();
            //  List<Guid> actions = new List<Guid>();
            if (pagenode != null)
            {
                if (!pagenode.Id.Equals(Guid.Empty))
                {
                    layoutid = OperationsFactory.NodeOperations.GetValueForField(pagenode.Id.ToString(), FieldId.LayoutFieldId);

                    // *****************[DEPRECATED]**************
                    //var tmpactions = OperationsFactory.NodeOperations.GetValueForField(pagenode.Id.ToString(), "EEECA56F-0D2F-453D-9C37-C1DF80659917");
                    //var tmpactionlist = tmpactions.Split(',');
                    //foreach(var tmp in tmpactionlist)
                    //{
                    //    Guid id;
                    //    var t = tmp.Split('=');
                    //    if(t.Length > 1 && Guid.TryParse(t[1].Trim(), out id))
                    //    {
                    //        actions.Add(id);
                    //    }
                    //}
                    rawdesign = OperationsFactory.NodeOperations.GetValueForField(pagenode.Id.ToString(), FieldId.DesignerDetailFieldId);
                    rawdesign = HttpUtility.HtmlDecode(rawdesign);

                    dynamic rawdata = ((dynamic)JsonConvert.DeserializeObject(rawdesign));
                    
                    completedesign.IsContainer = true;
                    foreach(var tmp in rawdata)
                    {
                        completedesign.Children.Add(DesignGenerator(tmp));
                    }
                }
                var layout = string.IsNullOrEmpty(layoutid) ? (Guid?)null : Guid.Parse(layoutid);

                Page = new PageData(pagenode.Id, layout, completedesign);
            }
 
            var authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket != null && !authTicket.Expired && !string.IsNullOrWhiteSpace(authTicket.UserData))
                {
                    var userid = authTicket.UserData;
                    CurrentUser = OperationsFactory.UserOperations.Getuser(userid);
                }
            }
        }

        private static PageDesign DesignGenerator(dynamic rawdata)
        {
            if (rawdata != null)
            {
                PageDesign obj = new PageDesign();
                obj.IsContainer = rawdata["iscontainer"].Value;
                if (obj.IsContainer)
                {
                    var children = rawdata["children"];
                    if (children != null)
                    {
                        foreach (var tmp in children)
                        {
                            obj.Children.Add(DesignGenerator(tmp));
                        }
                    }
                }
                else
                {
                    obj.ActionId = rawdata["actionid"].Value;
                    obj.ActionName = rawdata["actionname"].Value;
                }
                return obj;
            }
            return null;
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
            public PageData(Guid? PageNodeId, Guid? PageLayout, PageDesign pageDesign)
            {
                this.PageLayout = PageLayout;
                this.PageNodeId = PageNodeId;
                this.PageDesign = pageDesign;
            }
            public readonly Guid? PageNodeId;
            public readonly Guid? PageLayout;
            public readonly PageDesign PageDesign;
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

        public class PageDesign
        {
            public bool IsContainer;
            public string ActionId;
            public string ActionName;
            public List<PageDesign> Children;

            public PageDesign()
            {
                Children = new List<PageDesign>();
            }
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