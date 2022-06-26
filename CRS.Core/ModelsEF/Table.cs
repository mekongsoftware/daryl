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
    
    public partial class Table
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Table()
        {
            this.Orders = new HashSet<Order>();
        }
    
        public System.Guid TableId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string PriceId { get; set; }
        public Nullable<int> SequenceNo { get; set; }
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
        public Nullable<int> TableShapeId { get; set; }
        public Nullable<int> Seats { get; set; }
        public Nullable<int> LocationY { get; set; }
        public Nullable<int> LocationX { get; set; }
        public Nullable<bool> IsForCustomer { get; set; }
        public Nullable<System.DateTime> LastActivity { get; set; }
        public Nullable<int> StatusId { get; set; }
        public string LastUpdatedBy { get; set; }
        public Nullable<bool> IsActive { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
        public virtual Restaurant Restaurant { get; set; }
        public virtual Status Status { get; set; }
        public virtual TableShape TableShape { get; set; }
    }
}