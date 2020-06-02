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

    public class homeJson
    {
        public object banner;
        public object exhibit;
        public object relic;
        public object questions;
        public object time;
        public object relic_banner;
        public object exhibit_banners;
        public object collection;
        public string _switch;
        public string is_acc;
        public int view_number;
        public string latest;
    }

    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {

        private readonly MuseamAPIOContext _context;
        private config the_config;
        public HomeController(MuseamAPIOContext context)
        {
            _context = context;
            the_config = _context.config.Where(b => b.id == 1).FirstOrDefault();
        }

        // GET: api/Home
        [HttpGet]
        public ReturnJson.ModelsJson GetHome()
        {
            var home_banner = _context.home_banner.ToList();
            var exhibit = _context.exhibit.Select(b => new { b.id, b.title, b.introduce, b._new, b.hot }).Take(4).ToList();
            var relic = _context.collection.Select(b => new { b.id, b.title, b.introduce, b._new, b.hot }).Take(4).ToList();
            var questions = _context.questions.Select(b => new { b.id, b.question, addtime = ReturnJson.dateToString(b.addtime), b.answer }).Take(8).ToList();
            var relic_banner = _context.collection.Select(b => new { b.img }).Take(4).ToList();
            var exhibit_banners = _context.exhibit.Select(b => new { b.img }).Take(4).ToList();
            var collection = _context.succincts.Select(b => new { b.id, title = b.classname, b.img }).ToList();
            var rtnData = new homeJson() {
                banner = home_banner,
                exhibit = exhibit,
                relic = relic,
                questions = questions,
                relic_banner = relic_banner,
                exhibit_banners = exhibit_banners,
                collection = collection,
                time = new { time_sta=the_config.A1,time_end=the_config.A2},
                _switch = the_config.A3,
                latest = "https://img.dpm.org.cn/Uploads/Picture/2017/01/20/s5881a93f882e4.png",
            };
            return ReturnJson.Success(rtnData);
        }

        // GET: api/Home/5
        [Route("[action]")]
        [HttpGet]
        public ReturnJson.ModelsJson getViewNumber()
        {
            return ReturnJson.Success(the_config.A4);
        }

        [HttpGet]
        [Route("[action]")]
        public ReturnJson.ModelsJson getBaseConfig()
        {
            return ReturnJson.Success(the_config);
        }

        // PUT: api/Home/5
        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Put(int id, [FromBody] config value)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            the_config.A1 = value.A1;
            the_config.A2 = value.A2;
            the_config.A3 = value.A3;
            the_config.A4 = value.A4;
            the_config.A5 = value.A5;
            the_config.A6 = value.A6;
            _context.SaveChanges();
            return ReturnJson.Success();
        }

    }
}
