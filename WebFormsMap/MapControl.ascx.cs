using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormsMap
{
    public partial class MapControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// The xServer internet cluster name (e.g. eu-n-test)
        /// </summary>
        public string Cluster { get; set; }

        /// <summary>
        /// The xServer internet token
        /// </summary>
        public string Token { get; set; }

        /// <summary>
        /// The initial latitude value
        /// </summary>
        public double Latitude { get; set; }

        /// <summary>
        /// The initial longitude value
        /// </summary>
        public double Longitude { get; set; }

        /// <summary>
        /// The initial zoom level
        /// </summary>
        public int Zoom { get; set; }
    }
}