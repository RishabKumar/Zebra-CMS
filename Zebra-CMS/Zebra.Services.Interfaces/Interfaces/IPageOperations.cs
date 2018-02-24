using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Interfaces
{
    public interface IPageOperations
    {
        void CreateContentMap(Node startnode, string path = "");

        void Initialize();
        void CreateContentMap();

        Node GetPageNode(string relativepagepath);
    }
}
