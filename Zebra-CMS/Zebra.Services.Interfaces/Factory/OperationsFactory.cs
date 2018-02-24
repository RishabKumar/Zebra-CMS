using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Services.Interfaces;

namespace Zebra.Services.Operations
{
    public class OperationsFactory
    {
        public OperationsFactory(IPageOperations PageOperations, IStructureOperations StructureOperations, INodeOperations NodeOperations, IFieldOperations FieldOperations, IUserOperations UserOperations)
        {
            _pageoperations = PageOperations ?? _pageoperations;
            _structureoperations = StructureOperations ?? _structureoperations;
            _nodeoperations = NodeOperations ?? _nodeoperations;
            _fieldoperations = FieldOperations ?? _fieldoperations;
            _useroperations = UserOperations ?? _useroperations;
        }

        private static IStructureOperations _structureoperations { get; set; }

        private static IPageOperations _pageoperations { get; set; }
        private static INodeOperations _nodeoperations { get; set; }
        private static IFieldOperations _fieldoperations { get; set; }
        private static IUserOperations _useroperations { get; set; }

        public static IStructureOperations StructureOperations { get { return _structureoperations; } }

        public static IPageOperations PageOperations { get { return _pageoperations; } }
        public static INodeOperations NodeOperations { get { return _nodeoperations; } }
        public static IFieldOperations FieldOperations { get { return _fieldoperations; } }
        public static IUserOperations UserOperations { get { return _useroperations; } }
    }
}
