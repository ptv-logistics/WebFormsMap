<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MapControl.ascx.cs" Inherits="WebFormsMap.MapControl" %>
<div style="height:100%;width:100%" id="<%=this.ID + "Map"%>"></div>
<script>
    $(document).ready(function () {
        var token = '<%=this.Token %>'; 
        var cluster = '<%=this.Cluster %>';

        if (!token)
            alert('you need an xServer internet token for this sample!');

        // create a map in the "map" div and set the viewport
        var map = L.map('<%=this.ID + "Map" %>').setView(
            [<%=this.Latitude.ToString(System.Globalization.CultureInfo.InvariantCulture)%>, 
                <%=this.Longitude.ToString(System.Globalization.CultureInfo.InvariantCulture)%>], <%= this.Zoom %> );

        // initialize xServer internet base map
        getBaseLayers(cluster, "sandbox", token).addTo(map);

        <% if(!string.IsNullOrEmpty(this.DataRequest)) { %>
            // add the application data
            $.get('<%=this.DataRequest %>', function (data) {
                var fg = L.geoJson(data, {
                    <% if (!string.IsNullOrEmpty(this.PopupStyle) || !string.IsNullOrEmpty(this.MarkerStyle)) { %>
                    pointToLayer: function (feature, latlng) {
                        var color = <%= String.IsNullOrEmpty(this.MarkerStyle)? "'blue'" : this.MarkerStyle %>;
                        var item =  L.marker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]], {
                            icon: new L.Icon.Default({
                                iconUrl: './Images/Markers/marker-' + color + '.png',
                                iconRetinaUrl: './Images/Markers/icons/marker-' + color + '-2x.png'
                            })
                        });
                        item.bindPopup(<%= this.PopupStyle %>);
                        return item;
                    }
                    <% } %>
                }).addTo(map);

                map.fitBounds(fg.getBounds(), { maxZoom: 14 });
           });
        <% } %>

        // returns a layer group for xmap back- and foreground layers
        function getBaseLayers(cluster, style, token) {
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
