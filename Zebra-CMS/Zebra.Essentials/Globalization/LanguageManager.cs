using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Globalization;

namespace Zebra.Globalization
{
    public class LanguageManager
    {
        private static ILanguageRepository _langrepo;
        public LanguageManager(ILanguageRepository Langrepo)
        {
            _langrepo = Langrepo;
        }

        public static void CreateEmptyLanguage(Guid? Id = null)
        {
            if (Id == null)
                Id = Guid.NewGuid();
            _langrepo.CreateLanguage(new Language() { Id = Id.Value, Name = string.Empty, CountryCode = string.Empty, CultureName = string.Empty, LanguageCode = string.Empty });
        }

        public static Language GetDefaultLanguage()
        {
            return _langrepo.GetLanguage(new Language() { Id = Guid.Parse("B45089D2-CF01-4351-B6A6-40FBFFD64DC3") });
        }

        public static List<Language> GetAllLanguages()
        {
            return _langrepo.GetAllLanguages();
        }

        public static void CreateLanguage(string displayname, string countrycode, string languagecode, Guid? Id = null)
        {
            if(!string.IsNullOrWhiteSpace(displayname) && !string.IsNullOrWhiteSpace(languagecode))
            {
                var culturename = GetCulture(ref countrycode, ref languagecode);

                if (Id == null)
                    Id = Guid.NewGuid();
                _langrepo.CreateLanguage(new DataRepository.Models.Language() { Id= Id.Value, Name = displayname, CountryCode = countrycode, CultureName = culturename, LanguageCode = languagecode});
            }   
        }

        private static string GetCulture(ref string countrycode, ref string languagecode)
        {
            var culturename = string.Empty;
            languagecode = languagecode.Substring(0, 2);
            if (!string.IsNullOrWhiteSpace(countrycode))
            {
                countrycode = countrycode.Substring(0, 2);
                culturename = languagecode + "-" + countrycode;
            }
            else
            {
                countrycode = string.Empty;
                culturename = languagecode;
            }
            return culturename;
        }

        /// <summary>
        /// Returns Language, if present.
        /// </summary>
        /// <param name="culturename">Hint: en-us</param>
        /// <returns></returns>
        public static Language GetLanguage(string culturename)
        {
            var tmp = culturename.Split('-');
            if ((tmp.Length > 1 && tmp[0].Length > 1 && tmp[1].Length > 1) || culturename.Length == 2)
            {
                var lang = new Language();
                lang = _langrepo.GetLanguage(culturename);
                return lang;
            }
            else
            {
                return null;
            }
        }

        public static Language GetLanguageById(string languageid)
        {
            if(string.IsNullOrWhiteSpace(languageid))
            {
                return null;
            }
            var lang = _langrepo.GetLanguage(new Language() { Id = Guid.Parse(languageid)});
            return lang;    
        }

        public static void RemoveLanguage(string culturename)
        {
            var lang = GetLanguage(culturename);
            _langrepo.DeleteLanguage(lang);
        }

        public static void UpdateLanguage(Guid id, string displayname, string countrycode, string languagecode)
        {
            string culturename = GetCulture(ref countrycode, ref languagecode);
            _langrepo.UpdateLanguage(new Language() { Id = id, Name = displayname, CountryCode = countrycode, CultureName = culturename, LanguageCode = languagecode });
        }
    }
}
