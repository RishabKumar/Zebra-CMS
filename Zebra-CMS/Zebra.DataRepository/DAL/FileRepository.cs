using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Providers;

namespace Zebra.DataRepository.DAL
{
    public class FileRepository : IFileRepository
    {
        private class FileOperationsProvider
        {
            public string MediaPath { get; set; }

            private static FileOperationsProvider _config = null;

            public static FileOperationsProvider GetInstance(MediaProvider provider)
            {
                if(_config == null)
                {
                    _config = new FileOperationsProvider(provider);
                }
                return _config;
            }

            private FileOperationsProvider(MediaProvider provider)
            {
                MediaPath = provider.MediaPath;
                if (provider.GetType() == typeof(FileProvider))
                {
                    GetMediaBytes = new delGetMediaBytes(((FileProvider)provider).GetMediaBytes);
                    //        SaveMedia = new delSaveMedia(((FileProvider)provider).SaveMedia);
                    SaveMedia = new delSaveMedia(((FileProvider)provider).SaveMedia);
                    DeleteMedia = new delDeleteMedia(((FileProvider)provider).DeleteMedia);
                }
                
            }

            public delegate byte[] delGetMediaBytes();
        //    public delegate void delSaveMedia(string sourcepath, string filename);
            public delegate void delSaveMedia(string filename, byte[] bytes);
            public delegate void delDeleteMedia(string filename);

            public readonly delGetMediaBytes GetMediaBytes;
            public readonly delDeleteMedia DeleteMedia;
            public readonly delSaveMedia SaveMedia;
        }

        private static FileOperationsProvider _provider = null;

        public FileRepository() : base()
        {
            // change this provider
            MediaProvider provider = new FileProvider(HttpContext.Current.Server.MapPath("~/Media/"));
            _provider = FileOperationsProvider.GetInstance(provider);
        }

        public void SaveMedia(string sourcepath, string filename)
        {
    //        _provider.SaveMedia(sourcepath, filename);
        }

        public void SaveMedia(string filename, byte[] bytes)
        {
            _provider.SaveMedia(filename, bytes);
        }

        public void DeleteMedia(string filename)
        {
            _provider.DeleteMedia(filename);
        }
    }


    
}
