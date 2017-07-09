using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Zebra.DAL;
using Zebra.Domain.Models;

namespace Zebra.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        [HttpGet]
        public ActionResult Index(string returnurl)
        {
            TempData["returnurl"] = returnurl;
            return View();
        }

        [HttpPost]
        public ActionResult Validate(Users user, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                user = UserRepository.ValidateUser(user);
                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(user.UserName, false);
                    var authTicket = new FormsAuthenticationTicket(1, user.UserName, DateTime.Now, DateTime.Now.AddMinutes(20), false, user.Roles);
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    HttpContext.Response.Cookies.Add(authCookie);
                    return Redirect(string.IsNullOrWhiteSpace(returnUrl)? "/": returnUrl);
                }
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