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
        public FileProvider(string path) : base(path)
        {
        }

        public byte[] GetMediaBytes()
        {
            byte[] bytes = null;
            try
            {
                bytes = File.ReadAllBytes(MediaPath);
            }
            catch(Exception e) { }
            return bytes;
        }

        public void SaveMedia(string sourcepath, string filename)
        {
            if (!string.IsNullOrWhiteSpace(sourcepath))
            {
                byte[] data = File.ReadAllBytes(sourcepath);
                File.WriteAllBytes(MediaPath + filename, data);
            }
        }

        public void SaveMedia(string filename, byte[] bytes)
        {
            if (!string.IsNullOrWhiteSpace(filename))
            {
                File.WriteAllBytes(MediaPath + filename, bytes);
            }
        }

        public void DeleteMedia(string filename)
        {
            File.Delete(MediaPath + filename);
        }

    }
}
