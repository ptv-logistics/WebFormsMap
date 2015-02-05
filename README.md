# WebFormsMap
Add a data-driven map to a WebForms application

http://80.146.239.139/WebFormsMap/

The sample shows how to visualize your geographic data in a [ASP.NET WebForms application](http://www.asp.net/web-forms). Starting with a newly created ASP.NET WebForms project, it demonstrates the steps that are required to add an interactive map and display your data on it.

To run this code, you need

* Microsoft Visual Studio or Visual Studio Express 2013 for Web http://www.visualstudio.com/en-us/products/visual-studio-express-vs.aspx
* An xServer internet token. Go to http://xserver.ptvgroup.com/en-uk/products/ptv-xserver-internet/test/ to get a trial token.

### 01 - Create the solution and prepare it for Leaflet

* In Visual Studio create a new Solution of type "ASP.NET Web Forms Application"
* Add a link to the Leaflet style sheet in  Site.Master. [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L9)
* Add a link to the Leaflet JavaScript source in Site.Master. [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L23)
* PTV xMapServer requires an addon for single-tile images. The code is provided by [this GitHub project](https://github.com/ptv-logistics/Leaflet.NonTiledLayer). Add the two files NonTiledLayer.js and NonTiledLayer.WMS.js to the Scripts folder of the project and link it to the Site.Master file. [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L24-25)

### 02 - Create a MapControl and add it to a Page
* In Visual Studio we create a new item of type "Web Forms User Control" and name it MapControl
* The [Markup Code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx) contains the initialization of Leaflet with some properties, that are provides by the [Code Behind](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx.cs).
* The control itself has no size parameters. To place it in our page, we first drop a Panel from to toolbox on the page in the designer, set a size, and then drop the map control on the panel. To initialize the control, we have to set the cluster name and our token. [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Default.aspx#L29-31#L33)

### 03 - Provide the Control with Data and display it on the Map
* To simulate our database, we just use a plain [CSV file](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/App_Data/Baufeldt.txt) that contains some retail stores with geographic coordinates. 
* We want to provide this data as [GeoJson](http://geojson.org/), ecause Leaflet can display this data out-of-the box. So we create a new item of type "Generic Handler" in Visual Studio. The [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapData.ashx.cs) reads our "database" and converts the data to GeoJson. 
* We can also provide some request parameters, so we can fetch our data with a HTTP get http://80.146.239.139/WebFormsMap/MapData.ashx?someRequestParams=foo&someOtherParams=goo
* Our MapControl has a property DataRequest https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L19-22
https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Default.aspx#L32



### 04 - Style the Data

https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L23-34
