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
    
    public partial class Status
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Status()
        {
            this.Orders = new HashSet<Order>();
            this.OrderProducts = new HashSet<OrderProduct>();
            this.OrderProductAddons = new HashSet<OrderProductAddon>();
            this.Tables = new HashSet<Table>();
        }
    
        public int StatusId { get; set; }
        public string ApplyTo { get; set; }
        public Nullable<int> Sequence { get; set; }
        public string NameEn { get; set; }
        public string NameVi { get; set; }
        public string NameKo { get; set; }
        public string NameEs { get; set; }
        public string NameZh { get; set; }
        public string DescriptionEn { get; set; }
        public string DescriptionVi { get; set; }
        public string DescriptionKo { get; set; }
        public string DescriptionEs { get; set; }
        public string DescriptionZh { get; set; }
        public Nullable<bool> IsActive { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProduct> OrderProducts { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProductAddon> OrderProductAddons { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Table> Tables { get; set; }
    }
}
