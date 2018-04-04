using CacheCrow.Cache;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using static Zebra.Application.ZebraContext;

namespace Zebra.APIControllers
{
    public class CacheServiceController : ApiController
    {
        [HttpPost]
        public void Remove()
        {
            var rawform = HttpContext.Current.Request.Form;
            var key = rawform["key"].ToLowerInvariant();
            if (!string.IsNullOrEmpty(key) && CacheCrow<string, PageDesign>.GetCacheCrow != null && CacheCrow<string, PageDesign>.GetCacheCrow.LookUp(key))
            {
                CacheCrow<string, PageDesign>.GetCacheCrow.Remove(key);
            }
        }

        [HttpGet]
        public void Reset()
        {
            CacheCrow<string, PageDesign>.Initialize();
        }
    }
}
