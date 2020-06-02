using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MuseamAPIO.Models
{
    public class collection
    {
        public int id { get; set; }
        public string title { get; set; }
        public string img { get; set; }
        public string introduce { get; set; }
        public int _new { get; set; }
        public int hot { get; set; }
        public int succinct_id { get; set; }
    }
}
