using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.DataRepository.Models;

namespace Zebra.ModelView
{
    public class NodeBrowserModel
    {
        public List<string> fields;
        public IEnumerable<string> nodefieldids;
        public Node node;
        public Template template;
        public Language currentlanguage;
        public IEnumerable<Language> alllanguages;
        public IEnumerable<Language> allnodelanguages;
    }
}