using System;
using System.Linq;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Mvc;
using System.Web.Security;

namespace Zebra.CustomAttributes
{

    public class ZebraWebAPIAuthorize : System.Web.Http.Filters.AuthorizationFilterAttribute
    {
        public override void OnAuthorization(HttpActionContext actionContext)
        {
            string returnUrl = HttpUtility.UrlEncode(actionContext.RequestContext.Url.Request.RequestUri.AbsoluteUri);
            var authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket != null && !authTicket.Expired && !string.IsNullOrWhiteSpace(authTicket.UserData))
                {
                    var userid = Guid.Parse(authTicket.UserData);
                    if (userid == null)
                    {
                        HttpContext.Current.Response.Redirect("~/CPanel/Error");
                        return;
                    }
                    else
                    {
                        authTicket = FormsAuthentication.RenewTicketIfOld(authTicket);
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        HttpContext.Current.Response.Cookies.Add(authCookie);
                    }
                }
                else
                {
                    RedirectHelper.RedirectToLogin(returnUrl);
                    return;
                }
            }
            else
            {
                RedirectHelper.RedirectToLogin(returnUrl);
                return;
            }
        }
    }

    public class ZebraAuthorize : AuthorizeAttribute
    {
        public ZebraAuthorize() : base()
        {

        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            string returnUrl = HttpUtility.UrlEncode(filterContext.HttpContext.Request.Url.AbsoluteUri);
            var authCookie = filterContext.HttpContext.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket != null && !authTicket.Expired && !string.IsNullOrWhiteSpace(authTicket.UserData))
                {
                    var userid = Guid.Parse(authTicket.UserData);
                    var flag = true;

                    if (!flag)
                    {
                        filterContext.Controller.TempData["ErrorMessage"] = "You don't have sufficient rights";
                        filterContext.Result = new RedirectResult("/Error");
                    }
                    else //renew
                    {
                        authTicket = FormsAuthentication.RenewTicketIfOld(authTicket);
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        HttpContext.Current.Response.Cookies.Add(authCookie);
                    }
                }
                else
                {
                    //filterContext.Result = new RedirectResult("/Account?returnUrl="+ returnUrl);
                    if (!HttpContext.Current.Response.HeadersWritten)
                    {
                        RedirectHelper.RedirectToLogin(returnUrl);
                        return;
                    }
                }
            }
            else
            {
                //filterContext.Result = new RedirectResult("/Account?returnUrl=" + returnUrl);
                RedirectHelper.RedirectToLogin(returnUrl);
                return;
            }
        }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            return true;
        }

        protected override HttpValidationStatus OnCacheAuthorization(HttpContextBase httpContext)
        {
            return HttpValidationStatus.Valid;
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {

        }
    }

    static class RedirectHelper
    {
        public static void RedirectToLogin(string returnurl = "")
        {
            try
            {
                HttpContext.Current.Response.Redirect("~/Account?returnUrl=" + returnurl);
            }
            catch { }
        }
    }
}