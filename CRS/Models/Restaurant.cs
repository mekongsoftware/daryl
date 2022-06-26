using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class Restaurant
    {
        public int RestaurantId { get; set; }
        public string Name { get; set; }
        public string Location { get; set; }
        public string Code { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string Phone { get; set; }
        public string Owner { get; set; }
        public string OnwerPhone { get; set; }
        public Nullable<decimal> TaxPercent { get; set; }
        public Nullable<int> GroupPeople { get; set; }
        public Nullable<decimal> GroupChargePercent { get; set; }
        public Nullable<decimal> RecommendedTipPercent { get; set; }
        public Nullable<decimal> CreditCardSurcharge { get; set; }
        public Nullable<int> SlowOrderWarningMinutes { get; set; }
    }
}