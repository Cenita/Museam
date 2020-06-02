using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MuseamAPIO.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        // POST: api/Image
        [HttpPost]
        public object Post()
        {
            var re = Request.Form; //取全部post过来的参数
            var files = re.Files;
            long size = files.Sum(f => f.Length);
            // 临时文件的路径
            var filePath = Path.GetTempFileName();
            List<string> pathList = new List<string>();
            foreach (var formFile in files)
            {
                //取后缀名
                var fileN = formFile.FileName.ToString();
                var fileLastName = fileN.Substring(fileN.LastIndexOf(".") + 1,
                    (fileN.Length - fileN.LastIndexOf(".") - 1));
                var time = DateTime.Now.ToFileTime().ToString();
                filePath = @"wwwroot\images\" + time + fileN;//保存文件的路径
                if (formFile.Length > 0)
                {
                    //根据路径创建文件
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        formFile.CopyTo(stream);
                    }
                }
                pathList.Add("images/"+ time + fileN);
            }
            return Ok(new { fcount = files.Count, fsize = size,list = pathList.ToArray() });
        }
    }
}
