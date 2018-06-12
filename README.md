# WebFormsMap
Add a data-driven map to a WebForms application

[Demo](http://176.95.37.29/WebFormsMap/)

The sample shows how to visualize your geographic data in a [ASP.NET WebForms application](http://www.asp.net/web-forms). Starting with a newly created ASP.NET WebForms project, it demonstrates the steps that are required to add an interactive map and display your data on it.

To run this code, you need

* Microsoft Visual Studio or Visual Studio Express 2013 for Web http://www.visualstudio.com/en-us/products/visual-studio-express-vs.aspx
* An xServer internet token. Go to http://xserver.ptvgroup.com/en-uk/products/ptv-xserver-internet/test/ to get a trial token.

### 01 - Create the Solution and prepare it for Leaflet

* In Visual Studio create a new Solution of type "ASP.NET Web Forms Application"
* Add a link to the Leaflet style sheet in  Site.Master [here](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L9).
* Add a link to the Leaflet JavaScript source in Site.Master [here](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L23).
* PTV xMapServer requires an addon for single-tile map images. The code is provided by [this GitHub project](https://github.com/ptv-logistics/Leaflet.NonTiledLayer). Add the two files NonTiledLayer.js and NonTiledLayer.WMS.js to the Scripts folder of the project and link to them in the Site.Master file [here](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Site.Master#L24-L25).

### 02 - Create a MapControl and add it to a Page
* In Visual Studio we create a new item of type "Web Forms User Control" and name it MapControl
* The [Markup Code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx) contains the initialization of Leaflet with some properties that are provided by the [Code Behind](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx.cs).
* The control itself has no size parameters. To place it in our page, we first drop a Panel from to toolbox on the page in the designer, set a size, and then drop the map control on the panel. To initialize the control, we have to set the cluster name and our token [here](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/Default.aspx#L29-31#L33).

### 03 - Supply the Control with Data and display it on the Map
* To simulate our database, we just use a plain [CSV file](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/App_Data/Baufeldt.txt) that contains some retail stores with geographic coordinates. 
* We want to provide this data as [GeoJson](http://geojson.org/), because Leaflet can display this data out-of-the box. So we create a new item of type "Generic Handler" in Visual Studio. The [code](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapData.ashx.cs) reads our "database" and converts the data to GeoJson. 
* We can also provide some request parameters, so we can fetch our data with a HTTP get http://80.146.239.139/WebFormsMap/MapData.ashx?someRequestParams=foo
* The [data initialization](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L22) fetches the data via jQuery and initializes a new layer with the response.

### 04 - Style the Data

* We want to display different balloon icons, depending on the type property of the GeoJson data. For this purpose we add [new Leaflet icons](https://github.com/ptv-logistics/WebFormsMap/tree/master/WebFormsMap/Images/Markers) to our web project.
* In the control part these properties are used to create dynamic pushpins with the Leaflet [pointToLayer function](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L24-L40).

### 05 - Add interaction

* We want to provide a delete function for a pushpin that calls a function on our ASP-Site to delete a location.
* We just implement a new [dummy-handler](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapAction.ashx.cs) which is called from the map and would delete a location from our database.
* For the leaflet popup we add a [link button](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L34-L36) and a [callback with jQuery](https://github.com/ptv-logistics/WebFormsMap/blob/master/WebFormsMap/MapControl.ascx#L49-L55) that calls our ASP-method and deletes the client-side icon if succeeded.

After these steps we see [colored and clickable pushpins in a map](http://80.146.239.139/WebFormsMap/). On the about page i've added [some other samples](http://80.146.239.139/WebFormsMap/About).  While these are just included as iframe, they use the same components: Leaflet, some with ASP.NET as data service. You could add these in WebForms with this technique.
