using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebFormsMap
{
    /// <summary>
    /// Summary description for MapAction
    /// </summary>
    public class MapAction : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}