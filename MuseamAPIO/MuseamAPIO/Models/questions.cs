using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MuseamAPIO.Models
{
    public class questions
    {
        public int id { get; set; }
        public string question { get; set; }
        public DateTime addtime { get; set; }
        public int user_id{ get; set; }
        public string img{ get; set; }
        public string type{ get; set; }
        public string answer{ get; set; }
    }
}
