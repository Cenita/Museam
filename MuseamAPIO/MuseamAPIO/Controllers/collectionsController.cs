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
    public class collectionsController : ControllerBase
    {
        //藏品信息
        private readonly MuseamAPIOContext _context;

        public collectionsController(MuseamAPIOContext context)
        {
            _context = context;
        }

        /*GET方法
         * url:api/collections
         * 获取所有藏品信息
         * address:展馆id
         * name:藏品名字
         * pageIndex:页面索引
         * pageSize:所有页面一个有多少
        */
        [HttpGet]
        public ReturnJson.ModelsJson getAllCollection([FromQuery] ReturnJson.QueryJson qj)
        {
            qj.name = qj.name == null ? "" : qj.name;
            var collection = _context.collection.Where(b=>b.title.Contains(qj.name));
            if (qj.address != null && qj.address != "" && qj.address != "-1")
            {
                collection = collection.Where(b => b.succinct_id == int.Parse(qj.address));
            }

            return ReturnJson.Success(collection.Select(b => new {
                b.id,
                b.title,
                b.img,
                b.succinct_id,
                succinct_name = _context.succincts.Where(a => a.id == b.succinct_id).FirstOrDefault().classname,
                b.introduce,
                b.hot
            }).ToList());
        }

        /*GET方法
         * url:api/collections/5
         * 获取单个藏品信息
         * id:藏品ID
        */
        [HttpGet("{id}")]
        public ReturnJson.ModelsJson Getcollection([FromRoute] int id)
        {
            return ReturnJson.Success(_context.collection.Where(b => b.id == id).Select(b => new { b.title, b.img,b.introduce }).FirstOrDefault());
        }

        /*PUT方法
         * url:api/collections/5
         * 修改单个藏品信息
         * id:藏品ID
        */
        [HttpPut("{id}")]
        public ReturnJson.ModelsJson Putcollection([FromRoute] int id, [FromBody] collection collection)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            _context.Entry(collection).State = EntityState.Modified;
            _context.SaveChanges();
            return ReturnJson.Success(collection);
        }

        /*POST方法
         * url:api/collections
         * 增加单个藏品
         * collection 整个藏品对象
        */
        [HttpPost]
        public ReturnJson.ModelsJson Postcollection([FromBody] collection collection)
        {
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            if (collection.succinct_id == 0)
            {
                return ReturnJson.Error("未选择所属展馆");
            }
            _context.collection.Add(collection);
            _context.SaveChanges();
            return ReturnJson.Success();
        }

        /*DELETE方法
         * url:api/collections/5
         * 删除单个藏品
         * id:藏品ID
        */
        [HttpDelete("{id}")]
        public ReturnJson.ModelsJson Deletecollection([FromRoute] int id)
        {
            
            if (HttpContext.Session.GetString("Auth") == null)
            {
                return ReturnJson.NoAuth();
            }
            var collection = _context.collection.Where(b => b.id == id).FirstOrDefault();
            if (collection == null)
            {
                return ReturnJson.Error();
            }
            _context.collection.Remove(collection);
            _context.SaveChanges();
            return ReturnJson.Success();
        }

    }
}