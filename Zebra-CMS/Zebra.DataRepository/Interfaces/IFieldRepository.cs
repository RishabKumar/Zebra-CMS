using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;
using Zebra.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface IFieldRepository
    {
        List<FieldType> GetAllFieldTypes();
        FieldType GetFieldType(IEntity field);

        Field GetField(IEntity field);

        List<Field> GetFieldsFromTemplate(Template template);

        List<FieldType> GetFieldTypeFromField(Field field);

        FieldType CreateFieldType(FieldType ft);

        Field CreateField(Field ft);
    }
}
