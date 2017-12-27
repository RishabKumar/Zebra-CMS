using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class LanguageRepository : BaseRepository<Language>, ILanguageRepository
    {
        public Language CreateLanguage(Language language)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                language = _context.Languages.Add(language);
                _context.SaveChanges();
                dbt.Commit();
            }
            return language;
        }

        public bool DeleteLanguage(IEntity language)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var tmplanguage = GetLanguage(language);
                if (language != null)
                {
                    _context.Languages.Remove(tmplanguage);
                    _context.SaveChanges();
                    dbt.Commit();
                }
                else
                {
                    return false;
                }
            }
            return true;
        }

        public List<Language> GetAllLanguages()
        {
            return _context.Languages.ToList();
        }

        public override List<Language> GetByCondition(Expression<Func<Language, bool>> selector)
        {
            return _context.Languages.Where(selector).ToList();
        }

        public override Language GetByName(Language t)
        {
            return _context.Languages.Where(x => x.Name.ToLower().Equals(t.Name.ToLower())).FirstOrDefault();
        }

        public Language GetDefaultLanguage()
        {
            throw new NotImplementedException();
        }

        public Language GetLanguage(string culturename)
        {
            return _context.Languages.Where(x => x.CultureName.ToLower().Equals(culturename.ToLower())).FirstOrDefault();
        }

        public Language GetLanguage(IEntity language)
        {
            return _context.Languages.Where(x => x.Id == language.Id).FirstOrDefault();
        }

        public override List<Language> GetListById(IEntity t)
        {
            return _context.Languages.Where(x => x.Id == t.Id).ToList();
        }

        public Language UpdateLanguage(Language language)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var oldlanguage = GetLanguage(language);
                if (oldlanguage != null)
                {
                    _context.Entry(oldlanguage).CurrentValues.SetValues(language);
                    _context.SaveChanges();
                    dbt.Commit();
                }
            }
            return GetLanguage(language);
        }
    }
}
