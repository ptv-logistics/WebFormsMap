<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MapControl.ascx.cs" Inherits="WebFormsMap.MapControl" %>
<div style="height:300px;" id="map"></div>
<script>
    $(document).ready(function () {
        var token = ''; // add your xServer internet token here
        var cluster = 'eu-n-test';

        if (!token)
            alert('you need an xServer internet token for this sample!');

        // create a map in the "map" div, set the view to hamberug, street level
        var map = L.map('map').setView([53.550556, 9.993333], 10);

        // initialize xServer internet base map
        getXMapBaseLayers(cluster, "sandbox", token).addTo(map);

        // add the application data
        $.get("./MapData.ashx?somerequestparameters=hello", function (data) {
            L.geoJson(data, {
                onEachFeature: function (feature, layer) {
                    layer.bindPopup('<h2>' + feature.id + '</h2><br>' + feature.description);
                }
            }).addTo(map);
        });

        // returns a layer group for xmap back- and foreground layers
        function getXMapBaseLayers(cluster, style, token) {
            var attribution = '<a href="http://www.ptvgroup.com">PTV</a>, TOMTOM';

            var background = L.tileLayer('https://ajaxbg{s}-' + cluster + '.cloud.ptvgroup.com' +
                '/WMS/GetTile/xmap-ajaxbg-' + style + '/{x}/{y}/{z}.png', {
                    minZoom: 0,
                    maxZoom: 19,
                    opacity: token ? 1.0 : 0.5,
                    attribution: attribution,
                    subdomains: '1234',
                });

            if (!token) // only render background layer, if no token
                return background;

            var foreground = new L.NonTiledLayer.WMS('https://ajaxfg-' + cluster + '.cloud.ptvgroup.com/WMS/WMS' + '?xtok=' + token, {
                minZoom: 0, maxZoom: 19, opacity: 1.0,
                layers: style ? 'xmap-ajaxfg-' + style : 'xmap-ajaxfg',
                format: 'image/png', transparent: true,
                attribution: attribution
            });

            return L.layerGroup([background, foreground]);
        }
    });
</script>