//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Zebra.DataRepository.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class TemplateFieldMap
    {
        public int MapId { get; set; }
        public int TemplateId { get; set; }
        public int FieldId { get; set; }
    
        public virtual Templates Template { get; set; }
        public virtual Fields Field { get; set; }
    }
}