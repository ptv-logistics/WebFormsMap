<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebFormsMap.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>What is this?</h2>
    </hgroup>

    <article>
        This <a href="https://github.com/ptv-logistics/WebFormsMap">Visual Studio WebForms sample</a>
        shows the basic technique for embedding an interactive data-driven map into a WebForm application that's 
        created from scratch. It utilizes the JavaScript mapping library <a href="https://github.com/ptv-logistics/PoiLocator/wiki">Leaflet</a>
        to display the data in an interactive map. Leaflet is wrapped as a WebForms control, so it can easily embedded with the
        Visual Studio WebForms designer.
        <h2>That's just the beginning...</h2>
        You can use this sample to jump-start your business application with geo content.
        You can find more samples on the <a href="https://github.com/ptv-logistics">PTV Logistics GitHub page.</a>.
        <ol class="round">
           <li class="one">
                 <h5>Add interaction</h5>
                 Add more client-interaction with Leaflet + xServer internet. 
                 <a href="https://github.com/ptv-logistics/PoiLocator/wiki">Learn more…</a>
                <iframe src="http://ptv-logistics.github.io/PoiLocator/" style="height:300px;width:100%"></iframe>
            </li>
           <li class="two">
                 <h5>Themtic Mapping</h5>
                Add more map types, for example choropleths.
                 <a href="http://leafletjs.com/examples/choropleth.html">Learn more…</a>
                <iframe src="http://80.146.239.139/VectorTest/ClientSideVector.html" style="height:300px;width:100%"></iframe>
            </li>
            <li class="three">
                 <h5>Advanced Rendering</h5>
                To display complex data, you can reander your data server-side.
                 <a href="https://github.com/ptv-logistics/SpatialTutorial/wiki">Learn more…</a>
                <iframe src="http://80.146.239.139/VectorTest/LeafletSpatial.html" style="height:300px;width:100%"></iframe>
            </li>
            <li class="four">
                <h5>Additional Analysis with PTV xServer</h5>
                With xRouteServer you can calculate isochrones and coverages.
                 <a href="https://github.com/ptv-logistics/SpatialTutorial/wiki">Learn more…</a>
                <iframe src="http://80.146.239.139/CoverageDemo/" style="height:300px;width:100%"></iframe>
            </li>
            <li class="five">
                 <h5>Leaflet Addons</h5>
                Leaflet offers many plugins, for example 3D or clustering.
                 <a href="http://leafletjs.com/plugins.html">Learn more…</a>
                <iframe src="http://80.146.239.139/vectortest/clientsidevector3d.html" style="height:300px;width:100%"></iframe>
            </li>
        </ol>
    </article>

    <aside>
        <h3>Aside Title</h3>
        <p>
            Use this area to provide additional information.
       
        </p>
        <ul>
            <li><a runat="server" href="~/">Home</a></li>
            <li><a runat="server" href="~/About">About</a></li>
            <li><a runat="server" href="~/Contact">Contact</a></li>
        </ul>
    </aside>
</asp:Content>
