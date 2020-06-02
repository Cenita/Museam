using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MuseamAPIO.Models
{
    public class users
    {
        public int id { get; set; }
        public string name { get; set; }
        public string card { get; set; }
        public string password { get; set; }
        public string phone { get; set; }
        public DateTime addTime { get; set; }
    }
}
