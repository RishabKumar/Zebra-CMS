using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Zebra.CustomAttributes
{
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