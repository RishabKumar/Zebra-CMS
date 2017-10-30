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
                if (authTicket != null && !authTicket.Expired)
                {
                    var userroles = authTicket.UserData.ToLower().Trim().Split(',').OfType<string>().ToList<string>();
                    if (userroles == null && userroles.Count < 1)
                    {
                        HttpContext.Current.Response.Redirect("~/CPanel/Error");
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
                    HttpContext.Current.Response.Redirect("~/Account?returnurl=" + returnUrl);
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("~/Account?returnurl=" + returnUrl);
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
                if (authTicket != null && !authTicket.Expired)
                {
                    var userroles = authTicket.UserData.ToLower().Trim().Split(',').OfType<string>().ToList<string>();
                    if(string.IsNullOrWhiteSpace(Roles))
                    {
                        return;
                    }

                    var roles = Roles.Split(',').OfType<string>().ToList<string>();

                    bool flag = true;
                    
                    roles.ForEach(x=>
                    {
                        flag &= userroles.Contains(x.ToLower());
                    });

                    if(!flag)
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
                    filterContext.Result = new RedirectResult("/Account?returnurl="+ returnUrl);
                }
            }
            else
            {
                filterContext.Result = new RedirectResult("/Account?returnurl=" + returnUrl);
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
}