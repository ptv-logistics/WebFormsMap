using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

namespace WebFormsMap
{
    /// <summary>
    /// Summary description for MapData
    /// </summary>
    public class MapData : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            // you can apply some request parameters for filtering or styling
            var someRequestParams = context.Request.Params["someRequestParams"];
            var someOtherParams = context.Request.Params["someOtherParams"];

            // the return type is json
            context.Response.ContentType = "application/json";

            // our database is simulated by a csv file, i'm using the Microsoft.VisualBasic.FileIO TextFileReader class
            var parser = new TextFieldParser(HttpRuntime.AppDomainAppPath + "\\App_Data\\Baufeldt.txt");
            parser.Delimiters = new string[] { ";" };

            // we're just writing GeoJson brute-force, without any libraries (JSON.NET would be a good choice)
            context.Response.Write(@"{""type"": ""FeatureCollection"", ""features"": ["); // start json

            bool isFirstFeature = true;
            while (true)
            {
                string[] parts = parser.ReadFields();
                if (parts == null)
                {
                    break;
                }

                if (!isFirstFeature)
                    context.Response.Write(",");
                else
                    isFirstFeature = false;

                // write coordinate
                context.Response.Write(string.Format(CultureInfo.InvariantCulture,
                    @"{{""type"": ""Feature"", ""geometry"": {{""type"": ""Point"",""coordinates"": [{0}, {1}]}}, ", 
                    parts[13], parts[14]));

                // write attributes
                context.Response.Write(string.Format(CultureInfo.InvariantCulture,
                    @"""properties"": {{""id"": ""{0}"", ""description"": ""{1}"", ""type"": ""{2}""}}}}",
                    parts[0], parts[1], parts[6]));
            }

            context.Response.Write("]}"); // close json
        }

        public bool IsReusable
        {
            get
            {
                return true;
            }
        }
    }
}