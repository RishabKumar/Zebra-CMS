using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zebra.DataRepository.Providers
{
    class FileProvider : MediaProvider
    {
        public FileProvider(string mediapath, string medialocalpath, dynamic config) : base(mediapath, medialocalpath, (object)config)
        {
        }

        public override byte[] GetMediaBytes(string filename)
        {
            byte[] bytes = null;
            try
            {
                bytes = File.ReadAllBytes(GetMediaLocalFilePath(filename));
            }
            catch(Exception e) { }
            return bytes;
        }

        public override string SaveLargeMedia(string sourcepath, string filename)
        {
            if (!string.IsNullOrWhiteSpace(sourcepath))
            {
                using (var readstream = File.Open(sourcepath, FileMode.Open))
                {
                    using (var writestream = new FileStream(GetMediaLocalFilePath(filename), FileMode.CreateNew))
                    {
                        readstream.CopyTo(writestream);
                    }
                    readstream.Close();
                }
            }
            return filename;
        }

        public override string SaveMedia(string filename, byte[] bytes)
        {
            if (!string.IsNullOrWhiteSpace(filename))
            {
                File.WriteAllBytes(GetMediaLocalFilePath(filename), bytes);
            }
            return filename;
        }

        public override void DeleteMedia(string filepath)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(filepath))
                    File.Delete(filepath);
            }
            catch { }
        }

        public override byte[] GetMediaBytesByIndex(string filename, int startindex, int count)
        {
            throw new NotImplementedException();
        }

        public override long GetMediaLength(string filename)
        {
            long length = -1;
            using (var stream = new FileStream(GetMediaLocalFilePath(filename), FileMode.Open))
            {
                length = stream.Length;
            }
            return length;
        }
    }
}
