using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MuseamAPIO.Models
{
    
    public class ReturnJson
    {
        public class QueryJson
        {
            public string address { get; set; }
            public string name { get; set; }
            public int pageIndex { get; set; }
            public int pageSize { get; set; }
        }
        public class ModelsJson
        {
            public string status { get; set; }
            public string interpret { get; set; }
            public object data { get; set; }
        }
        public class PageJson
        {
            public int total { get; set; }
            public int currentpage { get; set; }
            public object data { get; set; }
        }
        public static ModelsJson Success(object rtnData = null)
        {
            ModelsJson returnJson = new ModelsJson()
            {
                status = "200",
                interpret = "请求成功",
                data = rtnData
            };
            return returnJson;
        }
        public static ModelsJson NoLogin()
        {
            ModelsJson returnJson = new ModelsJson()
            {
                status = "401",
                interpret = "请登录账号",
            };
            return returnJson;
        }
        public static ModelsJson NoAuth()
        {
            ModelsJson returnJson = new ModelsJson()
            {
                status = "402",
                interpret = "没有权限做这项操作",
            };
            return returnJson;
        }
        public static ModelsJson Error(string error_text="请求失败")
        {
            ModelsJson returnJson = new ModelsJson()
            {
                status = "400",
                interpret = error_text,
            };
            return returnJson;
        }
        public static ModelsJson Page(int total = 1, int page = 1, object rtnData = null)
        {
            PageJson pg = new PageJson()
            {
                total = total,
                currentpage = page,
                data = rtnData
            };
            return Success(pg);
        }
        public static string dateToString(DateTime dt)
        {
            return dt.ToString("yyyy-MM-dd");
        }
    }
}
