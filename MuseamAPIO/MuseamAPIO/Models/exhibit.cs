using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MuseamAPIO.Models
{
    public class exhibit
    {
        public int id { get; set; }
        public string title { get; set; }
        public string img { get; set; }
        public string introduce { get; set; }
        public string address { get; set; }
        public DateTime start_time { get; set; }
        public DateTime end_time { get; set; }
        public short _new {get; set;}
        public short hot { get; set; }
        public string content { get; set; }
        public int type { get; set; }
    }
}
