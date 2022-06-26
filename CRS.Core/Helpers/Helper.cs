using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace CRS.Core.Helpers
{
    public static class Helper 
    {
        /// <summary>
        /// returns true if object is null or true
        /// </summary>
        /// <param name="nullable"></param>
        /// <returns></returns>
        public static bool NullOrTrue (bool? nullable)
        {
            return !nullable.HasValue || nullable.Value == true;
        }

        /// <summary>
        /// returns datetime tamp, using UTC
        /// </summary>
        /// <returns></returns>
        public static DateTime TimeStamp()
        {
            return DateTime.UtcNow;
        }
    }
}
