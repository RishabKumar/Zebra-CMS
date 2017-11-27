using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.ProviderModels;
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
//                if (provider.GetType() == typeof(FileProvider))
                {
                    //var fileprovider = (FileProvider)provider;
                    GetMediaBytes = new delGetMediaBytes(provider.GetMediaBytes);
                    SaveMedia = new delSaveMedia(provider.SaveMedia);
                    DeleteMedia = new delDeleteMedia(provider.DeleteMedia);
                    SaveLargeMedia = new delSaveLargeMedia(provider.SaveLargeMedia);
                    GetMediaFilePath = new delGetMediaFilePath(provider.GetMediaFilePath);
                    GetMediaLength = new delGetMediaLength(provider.GetMediaLength);
                    GetMediaBytesByIndex = new delGetMediaBytesByIndex(provider.GetMediaBytesByIndex);
                }
            }

            public delegate byte[] delGetMediaBytes(string filename);
            public delegate byte[] delGetMediaBytesByIndex(string filename, int startindex, int count);
            public delegate string delGetMediaFilePath(string filename);
            public delegate string delSaveMedia(string filename, byte[] bytes);
            public delegate void delDeleteMedia(string filename);
            public delegate string delSaveLargeMedia(string sourcepath, string filename);
            public delegate long delGetMediaLength(string filename);

            public readonly delGetMediaBytes GetMediaBytes;
            public readonly delGetMediaBytesByIndex GetMediaBytesByIndex;
            public readonly delGetMediaFilePath GetMediaFilePath;
            public readonly delDeleteMedia DeleteMedia;
            public readonly delSaveMedia SaveMedia;
            public readonly delSaveLargeMedia SaveLargeMedia;
            public readonly delGetMediaLength GetMediaLength;

        }

        private static FileOperationsProvider _provider = null;
        public static readonly string MediaPath;// = "/Media/";
        public static readonly string MediaLocalPath;// = HttpContext.Current.Server.MapPath("~/Media/");
        public static readonly string TempDataPath = HttpContext.Current.Server.MapPath("~/Temp_Data/temp_upload/");

        public FileRepository() : base()
        {
            // change this provider
            //string jsonconfig = File.ReadAllText(AppDomain.CurrentDomain.BaseDirectory+"/ZebraConfig/mediaprovider.json");
            //RootObject root = (RootObject)JsonConvert.DeserializeObject<RootObject>(jsonconfig);
            //Mediaprovidersetting settings = root.Mediaprovidersettings.Where(x => x.Active.Equals("true")).FirstOrDefault();
           
        }

        static FileRepository()
        {
            MediaProvider provider = null;
            string jsonconfig = File.ReadAllText(AppDomain.CurrentDomain.BaseDirectory + "/ZebraConfig/mediaprovider.json");
            RootObject root = JsonConvert.DeserializeObject<RootObject>(jsonconfig);
            Mediaprovidersetting settings = root.Mediaprovidersettings.Where(x => x.Active == true).FirstOrDefault();
            if(settings == null)
            {
                MediaPath = "/Media/";
                MediaLocalPath = HttpContext.Current.Server.MapPath("~/Media/");
                provider = new FileProvider(MediaPath, MediaLocalPath, null);
            }
            else
            {
                MediaPath = settings.Mediapath;
                MediaLocalPath = settings.MediaLocalPath;
                provider = (MediaProvider)Activator.CreateInstance(Type.GetType(settings.Type), new[] { MediaPath, MediaLocalPath, settings.Config });
            }
            _provider = FileOperationsProvider.GetInstance(provider);
        }

        public void SaveMedia(string sourcepath, string filename)
        {
    //        _provider.SaveMedia(sourcepath, filename);
        }

        public string SaveMedia(string filename, byte[] bytes)
        {
           return _provider.SaveMedia(filename, bytes);
        }

        public string SaveLargeMedia(string sourcepath, string filename)
        {
           return _provider.SaveLargeMedia(sourcepath, filename);
        }

        public void DeleteMedia(string filename)
        {
            _provider.DeleteMedia(filename);
        }

        public string GetMediaFilePath(string filename)
        {
            return _provider.GetMediaFilePath(filename);
        }

        public byte[] GetMediaBytes(string filename)
        {
            return _provider.GetMediaBytes(filename);
        }

        public byte[] GetMediaBytes(string filename, int startindex, int count)
        {
            return _provider.GetMediaBytesByIndex(filename, startindex, count);
        }

        public long GetMediaLength(string filename)
        {
            return _provider.GetMediaLength(filename);
        }
    }


    
}
