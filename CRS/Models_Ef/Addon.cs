//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CRS.Models_Ef
{
    using System;
    using System.Collections.Generic;
    
    public partial class Addon
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Addon()
        {
            this.OrderProductAddons = new HashSet<OrderProductAddon>();
        }
    
        public int AddonId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public Nullable<int> Category { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string VName { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<int> PrepareMinutes { get; set; }
        public string IsActive { get; set; }
    
        public virtual Category Category1 { get; set; }
        public virtual Restaurant Restaurant { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProductAddon> OrderProductAddons { get; set; }
    }
}
