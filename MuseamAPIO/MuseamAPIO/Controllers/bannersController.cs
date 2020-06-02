using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MuseamAPIO.Models;

namespace MuseamAPIO.Controllers
{
    //顶部导航栏图片
    [Route("api/[controller]")]
    [ApiController]
    public class bannersController : ControllerBase
    {
        private readonly MuseamAPIOContext _context;

        public bannersController(MuseamAPIOContext context)
        {
            _context = context;
        }
        /*GET方法
         * url:api/banners/藏品信息
         * 获取页面头部Banner
         * name:页面名字
        */
        [HttpGet("{name}")]
        public ReturnJson.ModelsJson Getbanner([FromRoute] string name)
        {
            return ReturnJson.Success(_context.banner.Where(b => b.name == name).Select(b=>new { b.img }).FirstOrDefault());
        }
    }
}