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
using Zebra.DataRepository.DAL;

namespace Zebra.APIControllers
{
    [ZebraWebAPIAuthorize]
    public class MediaServiceController : ApiController
    {
        [HttpGet]
        public string GetUniqueMediaId(string filename)
        {
            string ext = filename.Substring(filename.LastIndexOf('.'));
            var newname = Guid.NewGuid().ToString() + ext;
            return newname;
        }

        [HttpPost]
        public async Task<string> UploadFile(string filename, int part)
        {
            if (string.IsNullOrWhiteSpace(filename))
            {
                return string.Empty;
            }
            HttpRequestMessage request = Request;
            if (!request.Content.IsMimeMultipartContent())
            {
                return null;
            }
             
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
                    bytes = await file.ReadAsByteArrayAsync();
                    var newname = filename.Split('.')[0] + "_" + part;
                    var extension = filename.Split('.')[1];
                    File.WriteAllBytes(tmppath + "/" + newname+"."+extension, bytes);                    
                }
            }
            catch(Exception e) { return null; }
            return string.Empty;
        }

        [HttpPost]
        public void MergeTempMedia(string filename)
        {
            if(string.IsNullOrWhiteSpace(filename))
            {
                return;
            }
            var pattern = filename.Substring(0, filename.LastIndexOf('.'));
            var files = Directory.GetFiles(FileRepository.TempDataPath, pattern + "*", SearchOption.TopDirectoryOnly).OrderBy(f => f);
            var fs = File.Create(FileRepository.TempDataPath + "\\" + filename);
            fs.Flush();
            fs.Close();
            var stream = File.Open(FileRepository.TempDataPath + "\\" + filename, FileMode.Append);
            foreach (var file in files)
            {
                try
                {
                    var tmpbytes = File.ReadAllBytes(file);
                    stream.Write(tmpbytes, 0, tmpbytes.Length);
                    File.Delete(file);
                }
                catch (Exception e) { throw e; }
            }
            stream.Flush();
            stream.Close();
        }


        private void DeleteTempMedia()
        {

        }
    }
}
