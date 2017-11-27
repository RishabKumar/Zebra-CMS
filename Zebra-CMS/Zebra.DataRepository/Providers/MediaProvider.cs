using System;

namespace Zebra.DataRepository.Providers
{
    public abstract class MediaProvider
    {
        public MediaProvider(string mediapath, string medialocalpath, dynamic config)
        {
            MediaPath = mediapath;
            MediaLocalPath = medialocalpath;
        }
        public string MediaPath { get; set; }

        public string MediaLocalPath { get; set; }

        public abstract long GetMediaLength(string filename);
        public abstract byte[] GetMediaBytes(string filename);
        public abstract byte[] GetMediaBytesByIndex(string filename, int startindex, int count);
        public abstract string SaveLargeMedia(string sourcepath, string filename);

        public abstract string SaveMedia(string filename, byte[] bytes);
        public abstract void DeleteMedia(string filepath);

        public virtual string GetMediaFilePath(string filename)
        {
            return MediaPath + filename;
        }

        public virtual string GetMediaLocalFilePath(string filename)
        {
            return MediaLocalPath + filename;
        }

    }
}