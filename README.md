# WebFormsMap
Add a data-driven map to a WebForms application

http://80.146.239.139/WebFormsMap/

The sample shows how to visualize your geographic data in a [ASP.NET WebForms application](http://www.asp.net/web-forms). Starting with a newly created ASP.NET WebForms project, it demonstrates the steps that are required to add an interactive map and display your data on it.

To run this code, you need

* Microsoft Visual Studio or Visual Studio Express 2013 for Web http://www.visualstudio.com/en-us/products/visual-studio-express-vs.aspx
* An xServer internet token. Go to http://xserver.ptvgroup.com/en-uk/products/ptv-xserver-internet/test/ to get a trial token.

### 01 - Create the solution and prepare for Leaflet

* In Visual Studio create a new Solution of type "ASP.NET Web Forms Application"
* Add a link to the Leaflet style sheet in  Site.Master [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L9)
* Add a link to the Leaflet JavaScript source in  Site.Master [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L23)
* PTV xMapServer requires an addon for single-tile images. The code is provided by [this GitHub project](https://github.com/ptv-logistics/Leaflet.NonTiledLayer). Add the two files NonTiledLayer.js and NonTiledLayer.WMS.js to the Scripts folder of the project and link it to the Site.Master file [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L24-25)
