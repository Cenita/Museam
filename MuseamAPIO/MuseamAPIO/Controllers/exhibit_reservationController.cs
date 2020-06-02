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
    public class exhibit_reservationController : ControllerBase
    {
        
        //展览预约信息
        private readonly MuseamAPIOContext _context;

        public exhibit_reservationController(MuseamAPIOContext context)
        {
            _context = context;
        }


        /*POST方法
        * url:api/exhibit_reservation
        * 预约展览
        * exhibit_reservation 传入预约展览对象
       */
        [HttpPost]
        public ReturnJson.ModelsJson postReservation([FromBody] exhibit_reservation exhibit_reservation)
        {
            var user = HttpContext.Session.GetString("user_id");
            if (user != null)
            {
                int user_id = int.Parse(user);
                var relation = _context.exhibit_reservation.Where(b => b.exhibit_id == exhibit_reservation.exhibit_id && b.user_id == user_id).FirstOrDefault();
                if (relation == null)
                {
                    exhibit_reservation.user_id = user_id;
                    exhibit_reservation.addTime = DateTime.Now.ToLocalTime();
                    _context.Add(exhibit_reservation);
                    _context.SaveChanges();
                    return ReturnJson.Success(exhibit_reservation);
                }
                else
                {
                    return ReturnJson.Error();
                }
            }
            else
            {
                return ReturnJson.Error();
            }
        }

        /*DELETE方法
        * url:api/exhibit_reservation/5
        * 取消预约
        * id:预约ID
       */
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deleteexhibit_reservation([FromRoute] int id)
        {
            var er = _context.exhibit_reservation.Where(b => b.id == id).FirstOrDefault();
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