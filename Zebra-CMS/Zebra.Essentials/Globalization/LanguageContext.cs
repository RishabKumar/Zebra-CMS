using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.Globalization
{
    public class LanguageContext
    {
        public static LanguageContext Current { get; set; }

        public LanguageContext()
        {
            
        }

        static LanguageContext()
        {
            Current = new LanguageContext();
        }

        public Language LanguageInfo { get; set; }

        //public bool TryParse(string locale, out Language Language)
        //{
            
        //    return false;
        //}
  
    }
}
