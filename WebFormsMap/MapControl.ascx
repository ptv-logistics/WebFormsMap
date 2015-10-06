<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MapControl.ascx.cs" Inherits="WebFormsMap.MapControl" %>
<div style="height: 100%; width: 100%" id="<%=this.ID + "Map"%>"></div>
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
        getXMapBaseLayers(cluster, "sandbox", token).addTo(map);

        var markerMap = {};

        // add the application data
        $.get('./MapData.ashx?someRequestParams=foo&someOtherParams=goo', function (data) {
            var fg = L.geoJson(data, {
                pointToLayer: function (feature, latlng) {
                    var color = (feature.properties.type === 'VMG' || feature.properties.type === 'VMK') ? 'red' : 
                        (feature.properties.type === 'SM') ? 'green' : (feature.properties.type === 'DIS') ? 'blue' : 'grey';
                    var item =  L.marker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]], {
                        icon: new L.Icon.Default({
                            iconUrl: './Images/Markers/marker-' + color + '.png',
                            iconRetinaUrl: './Images/Markers/icons/marker-' + color + '-2x.png'
                        })
                    });
                    
                    // bind a popup with information and a link to delete
                    item.bindPopup('<h3>' + feature.properties.id + '</h3><br>' + feature.properties.type + '<br>' + feature.properties.description + '<br>' + 
                        '<a href="#" id="location' + feature.properties.id + '" class="delete">Delete</a>');

                    markerMap[feature.properties.id] = item;
                    return item;
                }
            }).addTo(map);

            map.fitBounds(fg.getBounds(), { maxZoom: 14 });
        });
        
        // The HTML we put in bindPopup doesn't exist yet, so we can't just say
        // $('#mybutton'). Instead, we listen for click events on the map element which
        // will bubble up from the tooltip, once it's created and someone clicks on it.
        $('#<%=this.ID + "Map" %>').on('click', '.delete', function(ev) {
            var id = ev.target.id.substr("location".length);
            $.post('./MapAction.ashx?action=delete&id=' + id, "", function() {
                // serer-side deletion succeeded
                map.removeLayer(markerMap[id]);
            });
        });

        // returns a layer group for xmap back- and foreground layers
        function getXMapBaseLayers(baseUrl, style, xparam) {
            var isXSI = !(baseUrl.indexOf('http://') == 0 || baseUrl.indexOf('https://') == 0); // is xServer internet
            var isGC = isXSI && (baseUrl.indexOf('cn-n') > -1 || baseUrl.indexOf('jp-n') > -1); // is global coverage server
	
            var dataProviderString = isXSI? (isGC? "deCarta" : (baseUrl.indexOf('eu-n') > -1)? "TOMTOM" : "HERE") : xparam;			
            var tokenString = isXSI? '?xtok=' + token : '';
		
            var attribution = '<a href="http://www.ptvgroup.com">PTV</a>, ' + dataProviderString;
	
            var bgUrl = (isXSI? 'https://ajaxbg{s}-' + baseUrl + '.cloud.ptvgroup.com' : baseUrl) + '/WMS/GetTile';	
            var bgStyle = ((style && !isGC) ? 'xmap-' + style + '-bg' : 'xmap-ajaxbg');
            var background = L.tileLayer( bgUrl + '/' + bgStyle + 
                             '/{x}/{y}/{z}.png' + ((isGC)?  '?xtok=' + token : ''), {
                                 minZoom: 0, maxZoom: 19, opacity: 1.0,
                                 attribution: attribution,
                                 subdomains: '1234'
                             });

            if(isGC)
                return background;
		
            var fgUrl = (isXSI? 'https://ajaxfg-' + baseUrl + '.cloud.ptvgroup.com' : baseUrl) + '/WMS/WMS';
            var fgStyle = ((style && !isGC) ? 'xmap-' + style + '-fg' : 'xmap-ajaxfg');
            var foreground = new L.NonTiledLayer.WMS(fgUrl + tokenString, {
                minZoom: 0, maxZoom: 19, opacity: 1.0,
                layers: fgStyle,
                format: 'image/png', transparent: true,
                attribution: attribution,
                pane: map._panes.labelPane
            });

            return L.layerGroup([background, foreground]);
        }
    });
</script>
