using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MuseamAPIO.Models;

namespace MuseamAPIO.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class home_bannerController : ControllerBase
    {
        private readonly MuseamAPIOContext _context;

        public home_bannerController(MuseamAPIOContext context)
        {
            _context = context;
        }

        // GET: api/home_banner
        [HttpGet]
        public ReturnJson.ModelsJson Gethome_banner()
        {
            return ReturnJson.Page(1,1,_context.home_banner.ToList());
        }

        // PUT: api/home_banner/5
        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Puthome_banner([FromRoute] int id, [FromBody] home_banner home_banner)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            if (id != home_banner.id)
            {
                return ReturnJson.Error();
            }
            _context.Entry(home_banner).State = EntityState.Modified;
            _context.SaveChanges();
            return ReturnJson.Success();
        }

        // POST: api/home_banner
        [HttpPost]
        public ReturnJson.ModelsJson Posthome_banner([FromBody] home_banner home_banner)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            _context.home_banner.Add(home_banner);
            _context.SaveChanges();

            return ReturnJson.Success(home_banner);
        }

        // DELETE: api/home_banner/5
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deletehome_banner([FromRoute] int id)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var home_banner =  _context.home_banner.Where(b=>b.id==id).FirstOrDefault();
            if (home_banner != null)
            {
                _context.home_banner.Remove(home_banner);
                _context.SaveChanges();
                return ReturnJson.Success();
            }
            else
            {
                return ReturnJson.Error();
            }
            
        }
    }
}