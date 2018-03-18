using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Utilities.UtilityProcessor
{
    public interface IZebraUtility
    {
        bool HasExecutionRights(ref object obj);
        dynamic Process(ref object obj);

        string RenderView(ref object obj);
    }
}
