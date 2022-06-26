using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class StatusDto
    {
        public int StatusId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ApplyTo { get; set; }
        public int Sequence { get; set; }
    }
}