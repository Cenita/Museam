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
    public class register_body
    {
        public users users { get; set; }
    }
    public class login_body
    {
        public string phone { get; set; }
        public string password { get; set; }
    }
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class usersController : ControllerBase
    {
        private readonly MuseamAPIOContext _context;

        public usersController(MuseamAPIOContext context)
        {
            _context = context;
        }
        public ReturnJson.ModelsJson UserManage()
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            return ReturnJson.Page(1,1,_context.users.Select(b=>new { b.id,b.name,b.phone,b.card,addTime = b.addTime.ToString("yyyy-MM-dd HH:mm:ss") }).Where(b=>b.id!=7).ToList());
        }
        /**
         * 登录函数
         * 若登录成功则返回整个User的所有信息
         * 
         * 
         */
        // GET: api/users/5
        [HttpPost]
        public ReturnJson.ModelsJson Login([FromBody] login_body user)
        {
            string c = user.phone;
            var login_user = _context.users.Where(b => b.phone == user.phone && b.password == user.password).FirstOrDefault();
            if (login_user != null)
            {
                HttpContext.Session.SetString("user_name", login_user.name);
                HttpContext.Session.SetString("user_id", login_user.id.ToString());
                if (login_user.phone == "admin")
                {
                    HttpContext.Session.SetString("Auth","True");
                }
                return ReturnJson.Success(login_user);
            }
            else
            {
                return ReturnJson.Error("账号或者密码错误");
            }
        }

        [HttpPost]
        public ReturnJson.ModelsJson LoginOut()
        {
            if (HttpContext.Session.GetString("user_name")!=null)
            {
                HttpContext.Session.Clear();
                return ReturnJson.Success();
            }
            else
            {
                return ReturnJson.Error();
            }
        }

       

        // POST: api/users
        [HttpPost]
        public ReturnJson.ModelsJson Register([FromBody] register_body users)
        {
            var check = _context.users.Where(b => b.name == users.users.name).FirstOrDefault();
            if (check != null)
            {
                return ReturnJson.Error("名字已经存在");
            }
            check = _context.users.Where(b => b.phone == users.users.phone).FirstOrDefault();
            if (check != null)
            {
                return ReturnJson.Error("该手机号已经存在");
            }
            check = _context.users.Where(b => b.card == users.users.card).FirstOrDefault();
            if (check != null)
            {
                return ReturnJson.Error("该身份证已经登记");
            }
            users.users.addTime = DateTime.Now.ToLocalTime();
            _context.users.Add(users.users);
            _context.SaveChanges();
            return ReturnJson.Success(users);
        }

        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Putusers([FromRoute] int id, [FromBody] users users)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            if (id != users.id)
            {
                return ReturnJson.Error("ID号无法匹配");
            }
            _context.Entry(users).State = EntityState.Modified;
            _context.SaveChanges();
            return ReturnJson.Success(users);
        }


        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deleteusers([FromRoute] int id)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var users = _context.users.Where(b => b.id == id).FirstOrDefault();
            if (users == null)
            {
                return ReturnJson.Error();
            }
            _context.users.Remove(users);
            _context.SaveChanges();
            return ReturnJson.Success(users);
        }
    }
}