//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CRS.Core.ModelsEF
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
    
        public System.Guid AddonId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string PriceId { get; set; }
        public Nullable<System.Guid> CategoryId { get; set; }
        public string CategoryCode { get; set; }
        public string Code { get; set; }
        public string NameEn { get; set; }
        public string NameVi { get; set; }
        public string NameKo { get; set; }
        public string NameEs { get; set; }
        public string NameZh { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<int> PrepareMinutes { get; set; }
        public Nullable<bool> IsModifer { get; set; }
        public Nullable<bool> IsPriceChangeable { get; set; }
        public Nullable<bool> IsActive { get; set; }
    
        public virtual Category Category { get; set; }
        public virtual Restaurant Restaurant { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProductAddon> OrderProductAddons { get; set; }
    }
}