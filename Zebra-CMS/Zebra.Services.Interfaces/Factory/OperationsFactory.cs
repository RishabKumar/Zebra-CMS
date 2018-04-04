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
        public OperationsFactory(Lazy<IPageOperations> PageOperations, Lazy<IStructureOperations> StructureOperations, Lazy<INodeOperations> NodeOperations, Lazy<IFieldOperations> FieldOperations, Lazy<IUserOperations> UserOperations)
        {
            _pageoperations = PageOperations ?? _pageoperations;
            _structureoperations = StructureOperations ?? _structureoperations;
            _nodeoperations = NodeOperations ?? _nodeoperations;
            _fieldoperations = FieldOperations ?? _fieldoperations;
            _useroperations = UserOperations ?? _useroperations;
        }

        private static Lazy<IStructureOperations> _structureoperations { get; set; }
        private static Lazy<IPageOperations> _pageoperations { get; set; }
        private static Lazy<INodeOperations> _nodeoperations { get; set; }
        private static Lazy<IFieldOperations> _fieldoperations { get; set; }
        private static Lazy<IUserOperations> _useroperations { get; set; }

        public static IStructureOperations StructureOperations { get { return _structureoperations.Value; } }
        public static IPageOperations PageOperations { get { return _pageoperations.Value; } }
        public static INodeOperations NodeOperations { get { return _nodeoperations.Value; } }
        public static IFieldOperations FieldOperations { get { return _fieldoperations.Value; } }
        public static IUserOperations UserOperations { get { return _useroperations.Value; } }
    }
}
