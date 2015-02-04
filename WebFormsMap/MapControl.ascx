<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MapControl.ascx.cs" Inherits="WebFormsMap.MapControl" %>
<div style="height:100%;width:100%" id="<%=this.ID + "Map"%>"></div>
<script>
    $(document).ready(function () {
        var token = '<%=this.Token %>'; 
        var cluster = '<%=this.Cluster %>';

        if (!token)
            alert('you need an xServer internet token for this sample!');

        // create a map in the "map" div, set the view to hamberug, street level
        var map = L.map('<%=this.ID + "Map" %>').setView(
            [<%=this.Latitude.ToString(System.Globalization.CultureInfo.InvariantCulture)%>, 
                <%=this.Longitude.ToString(System.Globalization.CultureInfo.InvariantCulture)%>], <%= this.Zoom %> );

        // initialize xServer internet base map
        getXMapBaseLayers(cluster, "sandbox", token).addTo(map);

        <% if(!string.IsNullOrEmpty(this.DataRequest)) { %>
            // add the application data
            $.get("./MapData.ashx?<%=this.DataRequest %>", function (data) {
                var fg = L.geoJson(data, {
                    <% if(!string.IsNullOrEmpty(this.PopupStyle)) { %>
                    onEachFeature: function (feature, layer) {
                        layer.bindPopup(<%= this.PopupStyle %>);
                    }
                    <% } %>
                }).addTo(map);

                map.fitBounds(fg.getBounds());
           });
        <% } %>

        // returns a layer group for xmap back- and foreground layers
        function getXMapBaseLayers(cluster, style, token) {
            var attribution = '<a href="http://www.ptvgroup.com">PTV</a>, TOMTOM';

            var background = L.tileLayer('https://ajaxbg{s}-' + cluster + '.cloud.ptvgroup.com' +
                '/WMS/GetTile/xmap-ajaxbg-' + style + '/{x}/{y}/{z}.png', {
                    minZoom: 0,
                    maxZoom: 19,
                    opacity: token ? 1.0 : 0.5, // only a pale bg, if no token
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