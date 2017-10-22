using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using Zebra.CustomAttributes;

namespace Zebra.APIControllers
{
    [ZebraWebAPIAuthorize]
    public class MediaServiceController : ApiController
    {
        [HttpPost]
        public async Task<string> UploadFile()
        {
            HttpRequestMessage request = Request;
            if (!request.Content.IsMimeMultipartContent())
            {
                return null;
            }
            string newname = Guid.NewGuid().ToString();
            string tmppath = System.Web.HttpContext.Current.Server.MapPath("~/Temp_Data/temp_upload");
            byte[] bytes = null;
            try
            {
                bytes = null;
                var files = HttpContext.Current.Request.Files;
                var provider = new MultipartMemoryStreamProvider();
                await Request.Content.ReadAsMultipartAsync(provider);
                bytes = null;
                foreach (var file in provider.Contents)
                {
                    var filename = file.Headers.ContentDisposition.FileName.Trim('\"');
                    bytes = await file.ReadAsByteArrayAsync();
                    string[] tmp = filename.Split('.');
                    newname += "." + tmp[1];
                    File.WriteAllBytes(tmppath + "/" + newname, bytes);                    
                }
            }
            catch(Exception e) { return null; }
            return newname;
        }

    }
}
