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
        void SaveMedia(string sourcepath, string filename);

        void SaveMedia(string filename, byte[] bytes);

        void DeleteMedia(string filename);

    }
}
