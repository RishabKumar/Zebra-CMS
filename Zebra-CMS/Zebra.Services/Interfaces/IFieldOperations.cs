using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Interfaces
{
    public interface IFieldOperations
    {
        FieldType GetFieldType(string fieldid);

        string GetFieldView(string fieldid);

        List<Field> GetAllFields();

        List<Field> GetFieldsFromTemplate(string templateid);

        string GetRenderedField(string fieldid);

        Field GetField(string fieldid);

    }
}
