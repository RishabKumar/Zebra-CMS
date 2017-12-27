using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface ILanguageRepository
    {
        Language CreateLanguage(Language language);

        bool DeleteLanguage(IEntity language);

        Language UpdateLanguage(Language language);

        Language GetLanguage(IEntity language);

        Language GetLanguage(string culturename);

        List<Language> GetAllLanguages();

        Language GetDefaultLanguage();
    }
}
