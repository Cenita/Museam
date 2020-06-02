using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MuseamAPIO.Models;

namespace MuseamAPIO.Models
{
    public class MuseamAPIOContext : DbContext
    {
        public MuseamAPIOContext (DbContextOptions<MuseamAPIOContext> options)
            : base(options)
        {
        }

        public DbSet<MuseamAPIO.Models.exhibit> exhibit { get; set; }

        public DbSet<MuseamAPIO.Models.succincts> succincts { get; set; }

        public DbSet<MuseamAPIO.Models.collection> collection { get; set; }

        public DbSet<MuseamAPIO.Models.questions> questions { get; set; }

        public DbSet<MuseamAPIO.Models.banner> banner { get; set; }

        public DbSet<MuseamAPIO.Models.home_banner> home_banner { get; set; }

        public DbSet<MuseamAPIO.Models.users> users { get; set; }

        public DbSet<MuseamAPIO.Models.exhibit_reservation> exhibit_reservation { get; set; }

        public DbSet<MuseamAPIO.Models.appointment> appointment { get; set; }

        public DbSet<MuseamAPIO.Models.config> config { get; set; }
    }
}
