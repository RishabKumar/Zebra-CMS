using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Zebra.DataRepository.DAL;

namespace Zebra.Handlers
{
    /// <summary>
    /// Summary description for VideoHandler
    /// </summary>
    public class VideoHandler : IHttpHandler
    {
        FileRepository repo;
        public VideoHandler()
        {
            repo = new FileRepository();
        }

        private void RangeDownload(string fullpath, HttpContext context)
        {
            long size, start, end, length, fp = 0;
            long buffer = 1024*1024*3;
            //using (StreamReader reader = new StreamReader(fullpath))
            {

                size = repo.GetMediaLength(fullpath);
                start = 0;
                end = size - 1;
                length = size;

                context.Response.AddHeader("Accept-Ranges", "0-" + size);

                if (!String.IsNullOrEmpty(context.Request.ServerVariables["HTTP_RANGE"]))
                {
                    long anotherStart = start;
                    long anotherEnd = end;
                    string[] arr_split = context.Request.ServerVariables["HTTP_RANGE"].Split(new char[] { Convert.ToChar("=") });
                    string range = arr_split[1];

                    if (range.IndexOf(",") > -1)
                    {
                        context.Response.AddHeader("Content-Range", "bytes " + start + "-" + end + "/" + size);
                        throw new HttpException(416, "Requested Range Not Satisfiable");

                    }

                    if (range.StartsWith("-"))
                    {
                        anotherStart = size - Convert.ToInt64(range.Substring(1));
                    }
                    else
                    {
                        arr_split = range.Split(new char[] { Convert.ToChar("-") });
                        anotherStart = Convert.ToInt64(arr_split[0]);
                        long temp = 0;
                        anotherEnd = (arr_split.Length > 1 && Int64.TryParse(arr_split[1].ToString(), out temp)) ? Convert.ToInt64(arr_split[1]) : size;
                    }
                    anotherEnd = (anotherEnd > end) ? end : anotherEnd;
                    if (anotherStart > anotherEnd || anotherStart > size - 1 || anotherEnd >= size)
                    {

                        context.Response.AddHeader("Content-Range", "bytes " + start + "-" + start+buffer + "/" + size);
                        throw new HttpException(416, "Requested Range Not Satisfiable");
                    }
                    start = anotherStart;
                    end = anotherEnd;

                    length = end - start + 1;
                  

                    
                    context.Response.StatusCode = 206;
                }
                
            }
            if(start + buffer > size - 1)
            {
                buffer = size - start - 1;
            }
            context.Response.AddHeader("Content-Range", "bytes " + start + "-" + (start+buffer) + "/" + size);
            context.Response.AddHeader("Content-Length", (buffer).ToString());
            var bytes = repo.GetMediaBytes(fullpath, (int)start, (int)(buffer));
            using (var stream = context.Response.OutputStream)
            {
                stream.Write(bytes, 0, bytes.Length);
            }
            context.Response.End();

        }

        public void ProcessRequest(HttpContext context)
        {
            string filepath = context.Request.QueryString["file"];
            string mimetype = "video/mp4";
           // string filepath = "D:\\Users\\rishabh.ku\\Documents\\Visual Studio 2013\\Projects\\Test\\Test\\Media\\test.mp4";
            string fullpath = filepath;


            context.Response.ContentType = mimetype;
             
                RangeDownload(fullpath, context);
             
          


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