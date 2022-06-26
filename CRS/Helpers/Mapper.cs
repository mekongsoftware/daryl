using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace CRS.Helpers
{
    public static class Mapper<T> where T: new()
    {
        /// <summary>
        /// Get values from another class, using reflection base on Property's name
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public static T Map(object source)
        {
            var target = new T();
            foreach(PropertyInfo sourceProp in source.GetType().GetProperties())
            {
                var targetProp = target.GetType().GetProperties().FirstOrDefault(p => p.Name == sourceProp.Name);
                if (targetProp != null && targetProp.GetType().Name == sourceProp.GetType().Name)
                {
                    targetProp.SetValue(target, sourceProp.GetValue(source));
                }
            }
            return target;
        }
    }
}