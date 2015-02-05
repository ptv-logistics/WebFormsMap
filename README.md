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
* We can also provide some request parameters, so we can fetch our data with a HTTP get http://80.146.239.139/WebFormsMap/MapData.ashx?someRequestParams=foo
* Our MapControl has a property DataRequest that can be used to [initialize the map with a data url](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Default.aspx#L32). The [implementation](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L19-22) fetches the data via jQuery and initializes a new layer with the response.

### 04 - Style the Data

* We want to display different balloon, depending on the type property of the GeoJson data. For this purpose we add [new Leaflet icons](https://github.com/ptv-logistics/WebFormsMap/tree/master/WebFormsMap/Images/Markers) to our web project.
* Our control has two properties: PopupStyle and MarkerStyle. PopupStyle contains the string builder for the marker tooltip, and MarkerStyle the js code to return the color.
* In the control part these properties are used to create dynamic pushpins with the Leaflet [pointToLayer function](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Default.aspx#L33-35).

After these steps we see [colored and clickable pushpins in a map](http://80.146.239.139/WebFormsMap/).
