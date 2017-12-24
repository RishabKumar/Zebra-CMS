using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class ContentMapRepository
    {
        public static ContentMap _contentmap = null;

        static ContentMapRepository()
        {
            if(_contentmap == null)
            {
                _contentmap = new ContentMap();
            }
        }

        public static void Reset()
        {
            _contentmap = new ContentMap();
        }

        public static void Add(string key, Guid id)
        {
            try
            {
                _contentmap.map.Add(key.ToLowerInvariant(), id);
            }
            catch (Exception e)
            {

            }
        }

        public static void Delete(string key)
        {
            key = key.ToLowerInvariant();
            _contentmap.map.Remove(key);
        }

        public static Guid FindNodeId(string key)
        {
            key = key.ToLowerInvariant();
            if(key[0] == '/')
            {
                key = key.Remove(0, 1);
            }
            if(string.IsNullOrWhiteSpace(key))
            {
                return Guid.Empty;
            }
            return _contentmap.map.ContainsKey(key) ? _contentmap.map[key] : Guid.Empty;
        }

    }
}
