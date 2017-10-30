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
                    var fileprovider = (FileProvider)provider;
                    GetMediaBytes = new delGetMediaBytes(fileprovider.GetMediaBytes);
                    //        SaveMedia = new delSaveMedia(((FileProvider)provider).SaveMedia);
                    SaveMedia = new delSaveMedia(fileprovider.SaveMedia);
                    DeleteMedia = new delDeleteMedia(fileprovider.DeleteMedia);
                    SaveLargeMedia = new delSaveLargeMedia(fileprovider.SaveLargeMedia);
                }
                
            }

            public delegate byte[] delGetMediaBytes();
        //    public delegate void delSaveMedia(string sourcepath, string filename);
            public delegate void delSaveMedia(string filename, byte[] bytes);
            public delegate void delDeleteMedia(string filename);
            public delegate void delSaveLargeMedia(string sourcepath, string filename);

            public readonly delGetMediaBytes GetMediaBytes;
            public readonly delDeleteMedia DeleteMedia;
            public readonly delSaveMedia SaveMedia;
            public readonly delSaveLargeMedia SaveLargeMedia;
        }

        private static FileOperationsProvider _provider = null;
        public readonly string MediaPath = "/Media/";
        public readonly string MediaLocalPath = HttpContext.Current.Server.MapPath("~/Media/");
        public readonly string TempDataPath = HttpContext.Current.Server.MapPath("~/Temp_Data/temp_upload/");

        public FileRepository() : base()
        {
            // change this provider
            MediaProvider provider = new FileProvider(MediaLocalPath);
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

        public void SaveLargeMedia(string sourcepath, string filename)
        {
            _provider.SaveLargeMedia(sourcepath, filename);
        }

        public void DeleteMedia(string filename)
        {
            _provider.DeleteMedia(filename);
        }
    }


    
}
