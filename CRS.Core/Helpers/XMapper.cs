using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace CRS.Core.Helpers
{
    public static class XMapper<T> where T: new()
    {
        /// <summary>
        /// Get values from another class, using reflection base on Property's name
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public static T Map(object source, string language = "")
        {
            var target = new T();
            Map(source, target, language);
            return target;
        }

        public static void Map(object source, T target, string language = "")
        {
            foreach (PropertyInfo sourceProp in source.GetType().GetProperties())
            {
                var targetProp = ((sourceProp.Name.IndexOf("Name") >= 0) || (sourceProp.Name.IndexOf("Description") >= 0))
                    ? target.GetType().GetProperties().FirstOrDefault(p => (p.Name + language).ToLower() == sourceProp.Name.ToLower())
                    : target.GetType().GetProperties().FirstOrDefault(p => p.Name == sourceProp.Name);


                // need more work...
                try
                {
                    if (targetProp != null && targetProp.GetType().Name == sourceProp.GetType().Name)
                    {
                        targetProp.SetValue(target, sourceProp.GetValue(source));
                    }
                }
                catch
                {
                    //targetProp.SetValue(target, null);
                }
            }
        }

        
        /// <summary>
        /// Map a list of objects
        /// </summary>
        /// <param name="source"></param>
        /// <param name="language"></param>
        /// <returns></returns>
        public static IEnumerable<T> Map(IEnumerable<object> source, string language = "")
        {
            var target = new List<T>();
            foreach (var item in source)
            {
                target.Add(Map(item, language));
            }
            return target;
        }
    }
}
