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
    public class CollectionJson
    {
        public int total { get; set; }
        public int currentpage { get; set; }
        public string classname { get; set; }
        public object data { get; set; }
    }

    [Route("api/[controller]")]
    [ApiController]
    public class succinctsController : ControllerBase
    {
        private readonly MuseamAPIOContext _context;

        public succinctsController(MuseamAPIOContext context)
        {
            _context = context;
        }

        // GET: api/succincts
        [HttpGet]
        public ReturnJson.ModelsJson Getsuccincts()
        {
            /*HttpContext.Session.SetString("password", "123456");
            var password = HttpContext.Session.GetString("password");
            return ReturnJson.Success(password);*/
            return ReturnJson.Success(_context.succincts.Select(b => new { b.id, b.classname,b.img}).ToList());
        }

       
        

        // GET: api/succincts/5
        [HttpGet("{id}")]
        public ReturnJson.ModelsJson Getsuccincts([FromRoute] int id)
        {
            var thisSuccincts = _context.succincts.Where(b => b.id == id).FirstOrDefault();
            if (thisSuccincts!=null)
            {
                var Data = _context.collection.Where(b => b.succinct_id == id).Select(b => new { b.id, b.title, b.img }).ToList();
                var RtnData = new CollectionJson()
                {
                    classname = thisSuccincts.classname,
                    currentpage = 1,
                    total = 1,
                    data = Data
                };
                return ReturnJson.Success(RtnData);
            }
            return ReturnJson.Success();
        }

        // PUT: api/succincts/5
        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Putsuccincts([FromRoute] int id, [FromBody] succincts succincts)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            if (id != succincts.id)
            {
                return ReturnJson.Error("ID号无法匹配");
            }
            _context.Entry(succincts).State = EntityState.Modified;
            _context.SaveChanges();
            return ReturnJson.Success(succincts);
        }

        // POST: api/succincts
        [HttpPost]
        public ReturnJson.ModelsJson Postsuccincts([FromBody] succincts succincts)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            _context.succincts.Add(succincts);
            _context.SaveChanges();
            return ReturnJson.Success();
        }

        // DELETE: api/succincts/5
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deletesuccincts([FromRoute] int id)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var succincts = _context.succincts.Where(b=>b.id==id).FirstOrDefault();
            if (succincts == null)
            {
                return ReturnJson.Error();
            }
            _context.succincts.Remove(succincts);
            _context.SaveChanges();
            return ReturnJson.Success(succincts);
        }

    }
}