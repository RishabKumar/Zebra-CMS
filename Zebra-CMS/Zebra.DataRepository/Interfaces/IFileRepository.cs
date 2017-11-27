using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;
using Zebra.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface IFileRepository
    {
        string SaveLargeMedia(string sourcepath, string filename);

        string SaveMedia(string filename, byte[] bytes);

        void DeleteMedia(string filename);

        string GetMediaFilePath(string filename);

        byte[] GetMediaBytes(string filename);

    }
}
