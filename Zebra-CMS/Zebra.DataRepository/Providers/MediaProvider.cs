using System;

namespace Zebra.DataRepository.Providers
{
    public class MediaProvider
    {
        public MediaProvider(string path)
        {
            MediaPath = path;
        }
        public string MediaPath { get; set; }
    }
}