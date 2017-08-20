using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface ITemplateRepository
    {
        Template CreateTemplate(Template template);
        Template GetTemplate(Template template);
    }
}
