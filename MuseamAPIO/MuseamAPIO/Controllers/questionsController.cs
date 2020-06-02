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
    public class questionsController : ControllerBase
    {
        private readonly MuseamAPIOContext _context;

        public questionsController(MuseamAPIOContext context)
        {
            _context = context;
        }

        // GET: api/questions GET获得 GET+id是获得单条数据 POST是增加数据 PUT+id是修改这个id的这条的数据 DELETE+id就是删除这个id
        [HttpGet]
        public ReturnJson.ModelsJson Getquestions()
        {
            return ReturnJson.Page(1,1,_context.questions.Where(b=>b.answer!=null).Select(b => new { addtime = b.addtime.ToString("yyyy-MM-dd"), content = b.question,reply = b.answer,b.type}).ToList());
        }
        
        [HttpGet]
        [Route("[action]")]
        public ReturnJson.ModelsJson GetTypeQuesiton()
        {
            return ReturnJson.Page(1, 1, new
            {
                unreply = _context.questions.Where(b=>b.answer==null).Select(b => new {b.user_id,user_name = _context.users.Where(a=>a.id==b.user_id).FirstOrDefault().name,b.id, addtime = b.addtime.ToString("yyyy-MM-dd"),  b.question, b.answer, b.type }).ToList(),
                reply = _context.questions.Where(b=>b.answer!=null).Select(b => new { b.user_id, user_name = _context.users.Where(a => a.id == b.user_id).FirstOrDefault().name, b.id, addtime = b.addtime.ToString("yyyy-MM-dd"), b.question, b.answer, b.type }).ToList()
            });
        }

        // GET: api/questions/5
        [Route("[action]")]
        [HttpGet]
        public ReturnJson.ModelsJson getUserAsk()
        {
            string user_id = HttpContext.Session.GetString("user_id");
            if (user_id != null)
            {
                int this_user_id = int.Parse(user_id);
                return ReturnJson.Success(_context.questions.OrderByDescending(b=>b.addtime).Take(5).Where(b => b.user_id == this_user_id).Select(b => new { addtime = b.addtime.ToString("yyyy-MM-dd"), b.question, b.answer }).ToList());
            }
            else
            {
                return ReturnJson.Error("该账号未登录");
            }
        }

        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Putquestions([FromRoute] int id, [FromBody] questions questions)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            _context.Entry(questions).State = EntityState.Modified;
            _context.SaveChanges();
            return ReturnJson.Success();
        }

        [Route("[action]")]
        [HttpPost]
        public ReturnJson.ModelsJson addQuestion([FromBody] questions questions)
        {
            string user = HttpContext.Session.GetString("user_id");
            if (user != null)
            {
                questions.user_id = int.Parse(user);
                _context.questions.Add(questions);
                _context.SaveChangesAsync();
                return ReturnJson.Success("添加成功");
            }
            else
            {
                return ReturnJson.Error();
            }

        }

        // DELETE: api/questions/5
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deletequestions([FromRoute] int id)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var questions = _context.questions.Where(b => b.id == id).FirstOrDefault();
            if (questions == null)
            {
                return ReturnJson.Error();
            }

            _context.questions.Remove(questions);
            _context.SaveChanges();
            return ReturnJson.Success();
        }

    }
}