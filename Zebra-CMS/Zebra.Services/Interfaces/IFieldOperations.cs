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

        List<FieldType> GetAllFieldTypes();

        List<Field> GetExclusiveFieldsOfTemplate(string templateid);

        List<Field> GetInclusiveFieldsOfTemplate(string nodeid, List<Field> fields = null);

        string GetRenderedField(string nodeid, string fieldid, string fieldrenderid = null);

        Field GetField(string fieldid);

      //  Field CreateField(Field field, Template template);
        FieldType CreateFieldType(FieldType ft);

        Field DeleteField(string fieldid);

        Field DeleteField(Field field);

        Field UpdateField(Field field);

        Field UpdateField(string fieldid, string fieldname, string typeid);

    }
}
