using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Zebra.DataRepository.ProviderModels
{
    public class Mediaprovidersetting
    {
        [JsonProperty("active")]
        public bool Active { get; set; }

        [JsonProperty("mediapath")]
        public string Mediapath { get; set; }

        public string MediaLocalPath {  get { return HttpContext.Current.Server.MapPath(Mediapath); } }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("config")]
        public dynamic Config { get; set; }
    }

    public class RootObject
    {
        [JsonProperty("mediaprovidersettings")]
        public List<Mediaprovidersetting> Mediaprovidersettings { get; set; }

    }
}
