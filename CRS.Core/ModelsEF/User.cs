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
    
    public partial class User
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public User()
        {
            this.Orders = new HashSet<Order>();
            this.Orders1 = new HashSet<Order>();
            this.Orders2 = new HashSet<Order>();
            this.UserHistories = new HashSet<UserHistory>();
        }
    
        public System.Guid UserId { get; set; }
        public Nullable<System.Guid> AuthenticationId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string NameEn { get; set; }
        public string Phone1 { get; set; }
        public string Phone2 { get; set; }
        public Nullable<System.Guid> UserType { get; set; }
        public string DefaultLanguage { get; set; }
        public string Note { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<System.DateTime> LastLogin { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders2 { get; set; }
        public virtual Restaurant Restaurant { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserHistory> UserHistories { get; set; }
    }
}
