using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface IFrameworkRepository
    {
        bool SaveFrameworkData(FrameworkData frameworkData);
        FrameworkData GetFrameworkData(FrameworkData frameworkData);
        bool DeleteFrameworkData(FrameworkData frameworkData);
        void UpdateFrameworkData(FrameworkData frameworkData);
    }
}
