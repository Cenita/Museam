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
    public class exhibitsController : ControllerBase
    {
        //展览信息
        private readonly MuseamAPIOContext _context;
        //根据时间信息从而得到类型Type
        private int getTypeByTime(DateTime start_time,DateTime end_time)
        {
            var now = DateTime.Now;
            if (now < start_time)
            {
                return 2;
            }else if (now >= start_time && now <= end_time)
            {
                return 1;
            }
            else
            {
                return 3;
            }
        }

        public exhibitsController(MuseamAPIOContext context)
        {
            _context = context;
        }


        /*GET方法
        * url:api/
        * 预约展览
        * exhibit_reservation 传入预约展览对象
       */
        [HttpGet]
        public ReturnJson.ModelsJson Getexhibits([FromQuery] ReturnJson.QueryJson qj)
        {
            var nowDate = DateTime.Now;
            var name = qj.name == null ? "" : qj.name;
            var type = int.Parse(qj.address==null?"-1":qj.address);
            var checkData = _context.exhibit.Where(b => b.title.Contains(name));
            if (type == 1)
            {
                checkData = checkData.Where(b => nowDate >= b.start_time && nowDate <= b.end_time);
            }
            else if(type==2)
            {
                int user_id = HttpContext.Session.GetString("user_id") != null ? int.Parse(HttpContext.Session.GetString("user_id")) : -1;
                var jieguo =  checkData.Where(b => nowDate<b.start_time).Select(b => new {
                    b.id,
                    b.img,
                    b.title,
                    b.introduce,
                    type = this.getTypeByTime(b.start_time, b.end_time),
                    b.address,
                    start_time = ReturnJson.dateToString(b.start_time),
                    end_time = ReturnJson.dateToString(b.end_time),
                    is_reservation = _context.exhibit_reservation.Where(a=>a.user_id==user_id&&a.exhibit_id==b.id).FirstOrDefault()
                }).ToList();
                return ReturnJson.Page(1, 1, jieguo);
            }else if (type == 3)
            {
                checkData = checkData.Where(b => nowDate > b.end_time);
            }
            else if (type == 4)
            {
                int user_id = HttpContext.Session.GetString("user_id") != null ? int.Parse(HttpContext.Session.GetString("user_id")) : -1;
                var exhibit_sql = checkData.Select(b => new
                {
                    b.id,
                    b.img,
                    b.title,
                    b.introduce,
                    type = this.getTypeByTime(b.start_time, b.end_time),
                    b.address,
                    start_time = ReturnJson.dateToString(b.start_time),
                    end_time = ReturnJson.dateToString(b.end_time),
                    is_reservation = _context.exhibit_reservation.Where(a => a.user_id == user_id && a.exhibit_id == b.id).FirstOrDefault()
                });
                var jieguo = _context.exhibit_reservation.Where(b => b.user_id == user_id).Select(b => new { data = exhibit_sql.Where(a => a.id == b.exhibit_id).FirstOrDefault() }).ToList();
                return ReturnJson.Page(1,1,jieguo);
            }
            return ReturnJson.Page(1,1,checkData.OrderByDescending(b=>b.start_time).Select(b => new
            {
                b.id,
                b.img,
                b.title,
                b.introduce,
                type = this.getTypeByTime(b.start_time, b.end_time),
                b.address,
                b.content,
                reservation_number = _context.exhibit_reservation.Where(a => a.exhibit_id == b.id).Count(),
                start_time = ReturnJson.dateToString(b.start_time),
                end_time = ReturnJson.dateToString(b.end_time)
            }).ToList());
        }

        // GET: api/exhibits/5
        [HttpGet("{id}")]
        public ReturnJson.ModelsJson Getexhibit([FromRoute] int id)
        {
            return ReturnJson.Success(_context.exhibit.Where(b=>b.id==id).Select(b=>new { b.id,b.title,b.content,b.img,b.introduce,b.address, start_time = ReturnJson.dateToString(b.start_time), end_time = ReturnJson.dateToString(b.end_time) }).FirstOrDefault());
        }

        [Route("[action]")]
        [HttpGet]
        public ReturnJson.ModelsJson GetReverList([FromQuery] int id)
        {
            var thisSuccincts = _context.succincts.Where(b => b.id == id).FirstOrDefault();
            if (thisSuccincts != null)
            {
                return ReturnJson.Error("ID号不存在");
            }
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var data = _context.exhibit_reservation.Where(b => b.exhibit_id == id).Select(b => new {
                list = _context.users.Where(a => a.id == b.user_id).Select(c => new { c.name, c.phone, c.card,addTime = c.addTime.ToString("yyyy-MM-dd HH:mm:ss") }).FirstOrDefault()
            }).ToList();
            return ReturnJson.Page(1, 1, data);

        }

        // PUT: api/exhibits/5
        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Putexhibit([FromRoute] int id, [FromBody] exhibit exhibit)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            _context.Entry(exhibit).State = EntityState.Modified;
            _context.SaveChanges();
            return ReturnJson.Success(exhibit);
            
        }

        // POST: api/exhibits
        [HttpPost]
        public ReturnJson.ModelsJson Postexhibit([FromBody] exhibit exhibit)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            _context.exhibit.Add(exhibit);
            _context.SaveChanges();
            return ReturnJson.Success();
        }

        // DELETE: api/exhibits/5
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deleteexhibit([FromRoute] int id)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var exhibit =  _context.exhibit.Where(b=>b.id==id).FirstOrDefault();
            if (exhibit == null)
            {
                return ReturnJson.Error();
            }
            _context.exhibit.Remove(exhibit);
            _context.SaveChanges();
            return ReturnJson.Success();
        }
    }
}