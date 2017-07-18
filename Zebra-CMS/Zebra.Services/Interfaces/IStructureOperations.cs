using System.Collections.Generic;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Interfaces
{
    interface IStructureOperations
    {
        List<Field> GetFieldsByTemplate(Template t);

        Template CreateTemplate(Template t);

        bool CreateField(Field f);

        bool CreateField(List<Field> lst);

        Template AddField(Field f, Template t);

        Template UpdateTemplate(List<Field> lst, Template t);

        bool DeleteTemplate(Template t);

        bool DeleteField(Field f);

    }
}
