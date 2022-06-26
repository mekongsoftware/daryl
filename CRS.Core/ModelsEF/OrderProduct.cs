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
    
    public partial class OrderProduct
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public OrderProduct()
        {
            this.OrderProductAddons = new HashSet<OrderProductAddon>();
        }
    
        public System.Guid OrderProductId { get; set; }
        public Nullable<System.Guid> OrderId { get; set; }
        public Nullable<System.Guid> ProductId { get; set; }
        public Nullable<int> StatusId { get; set; }
        public Nullable<System.Guid> Sequence { get; set; }
        public Nullable<int> Quantity { get; set; }
        public Nullable<int> SeatNumber { get; set; }
        public Nullable<System.DateTime> OrderTime { get; set; }
        public Nullable<System.DateTime> FinishTime { get; set; }
        public Nullable<System.DateTime> DeliverTime { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<bool> IsComplementary { get; set; }
        public Nullable<bool> IsToGo { get; set; }
        public string Notes { get; set; }
    
        public virtual Order Order { get; set; }
        public virtual Product Product { get; set; }
        public virtual Status Status { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProductAddon> OrderProductAddons { get; set; }
    }
}
