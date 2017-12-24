using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Zebra.DataRepository.DAL;

namespace Zebra.Handlers
{
    /// <summary>
    /// Summary description for MediaHandler
    /// </summary>
    /// 

    // Code is buggy, Using VideoHandler.ashx for now !!!
    public class MediaHandler : IHttpHandler
    {
        FileRepository repo;
        public MediaHandler()
        {
            repo = new FileRepository();
        }

        public void ProcessRequest(HttpContext context)
        {
            if (context != null && context.Request != null)
            {
                int i = 0;
                int count = 1024 * 1024;
                if (!String.IsNullOrEmpty(context.Request.ServerVariables["HTTP_RANGE"]))
                {
                    string[] arr_split = context.Request.ServerVariables["HTTP_RANGE"].Split(new char[] { Convert.ToChar("=") });
                    string range = arr_split[1];
                    arr_split = range.Split(new char[] { Convert.ToChar("-") });
                    i = Convert.ToInt32(arr_split[0]);
                    //      context.Response.AddHeader("Content-Range", "bytes " + i + "-" + (size-1) + "/" + size);
                    context.Response.StatusCode = 206;
                }

                var file = context.Request.QueryString["file"];
                var bytes = repo.GetMediaBytes(file, i, count);
               
                int size = bytes.Length;
                context.Response.ContentType = "application/octet-stream";
                context.Response.AddHeader("Accept-Ranges", "0-" + size);
                BufferedStream bf = new BufferedStream(context.Response.OutputStream);

               
                

                context.Response.AddHeader("Content-Range", "bytes " + i + "-" + (i+ count - 1) + "/" + size);
                context.Response.AddHeader("Content-Length", size.ToString());
                bf.Write(bytes, i, count-i);
                context.Response.End();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}