using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MuseamAPIO.Models
{
    public class exhibit_reservation
    {
        public int id { get; set; }
        public int exhibit_id { get; set; }
        public int user_id { get; set; }
        public DateTime addTime { get; set; }
    }
}
