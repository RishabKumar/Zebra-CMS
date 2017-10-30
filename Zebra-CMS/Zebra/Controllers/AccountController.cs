using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class AccountController : Controller
    {
        IUserOperations _base;

        public AccountController(UserOperations userop)
        {
            _base = userop;
        }

        // GET: Account
        [HttpGet]
        public ActionResult Index(string returnurl)
        {
            if (Url.IsLocalUrl(returnurl))
            {
                TempData["returnurl"] = returnurl;
            }
            else
            {
                TempData["returnurl"] = "/Cpanel";
            }
            return View();
        }

        [HttpPost]
        public ActionResult Validate(User user, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                user = _base.ValidateUser(user);
                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(user.UserName, false);
                    var authTicket = new FormsAuthenticationTicket(1, user.UserName, DateTime.Now, DateTime.Now.AddMinutes(1), false, user.Roles);
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    HttpContext.Response.Cookies.Add(authCookie);
                    return Redirect(string.IsNullOrWhiteSpace(returnUrl)? "/": returnUrl);
                }
            }
            if (!Url.IsLocalUrl(returnUrl))
            {
                returnUrl = "/Cpanel";
            }
            return RedirectToAction("Index", new { returnUrl=returnUrl });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
    }
}