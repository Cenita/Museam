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
    public class requestForm
    {
        public string selectTime { set; get; }
    }
    [Route("api/[controller]")]
    [ApiController]
    public class appointmentsController : ControllerBase
    {
        private readonly MuseamAPIOContext _context;

        public appointmentsController(MuseamAPIOContext context)
        {
            _context = context;
        }
        [Route("[action]")]
        [HttpGet("{ga}")]
        public ReturnJson.ModelsJson AppManage([FromQuery] requestForm ga)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var app = _context.appointment.Where(b=>b.id!=-1);
            if (ga.selectTime != null)
            {
                app = app.Where(b => b.date.Date.ToString() == ga.selectTime);
            }
            return ReturnJson.Page(1, 1, app.Select(b => new { name = _context.users.Where(a=>a.id==b.user_id).FirstOrDefault().name, b.id, date = b.date.Date.ToString(), addtime = b.addtime.ToString("yyyy-MM-dd HH:mm:ss") }).ToList());
        }
        [HttpGet]
        public ReturnJson.ModelsJson GetAppoiment()
        {
            var user_id = HttpContext.Session.GetString("user_id");
            if (user_id == null)
            {
                return ReturnJson.NoLogin();
            }
            var name = _context.users.Where(a => a.id == int.Parse(user_id)).FirstOrDefault();
            var today = DateTime.Now.Date;
            var list = _context.appointment.Where(b => b.user_id == int.Parse(user_id)).Select(b=>new {name= name.name, b.id,date=b.date.Date.ToString(),addtime=b.addtime.ToString("yyyy-MM-dd HH:mm:ss")}).OrderBy(b => b.date).ToList();
            return ReturnJson.Success(list);
        }


        // POST: api/appointments
        [HttpPost]
        public ReturnJson.ModelsJson Postappointment([FromBody] appointment appointment)
        {
            var user_id = HttpContext.Session.GetString("user_id");
            if (user_id == null)
            {
                return ReturnJson.NoLogin();
            }
            appointment.user_id = int.Parse(user_id);
            appointment.addtime = DateTime.Now.ToLocalTime();
            _context.appointment.Add(appointment);
            _context.SaveChanges();

            return ReturnJson.Success("预约成功");
        }

        // DELETE: api/appointments/5
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deleteappointment([FromRoute] int id)
        {
            var user_id = HttpContext.Session.GetString("user_id");
            if (user_id == null)
            {
                return ReturnJson.NoLogin();
            }
            var er = _context.appointment.Where(b => b.id == id).FirstOrDefault();
            if (er != null)
            {
                _context.Remove(er);
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