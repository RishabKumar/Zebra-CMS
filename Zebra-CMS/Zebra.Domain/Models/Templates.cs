//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Zebra.Domain.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Templates
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Templates()
        {
            this.TemplateFieldMaps = new HashSet<TemplateFieldMap>();
        }
    
        public int TemplateId { get; set; }
        public string TemplateName { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TemplateFieldMap> TemplateFieldMaps { get; set; }
    }
}
