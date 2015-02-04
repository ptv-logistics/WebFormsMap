<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebFormsMap.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Your app description page.</h2>
    </hgroup>

    <article>
        <h2>Blubber</h2>
        <ol class="round">
           <li class="one">
                 <h5>Add interaction</h5>
                 ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
                <iframe src="http://ptv-logistics.github.io/PoiLocator/" style="height:300px;width:100%"></iframe>
            </li>
           <li class="two">
                 <h5>Themtic Mapping</h5>
                 ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
                <iframe src="http://80.146.239.139/VectorTest/ClientSideVector.html" style="height:300px;width:100%"></iframe>
            </li>
            <li class="three">
                 <h5>Advanced Rendering</h5>
                 ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
                <iframe src="http://80.146.239.139/VectorTest/LeafletSpatial.html" style="height:300px;width:100%"></iframe>
            </li>
            <li class="four">
                 <h5>Additional Analysis with PTV xServer</h5>
                 ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
                <iframe src="http://80.146.239.139/CoverageDemo/" style="height:300px;width:100%"></iframe>
            </li>
            <li class="five">
                 <h5>Leaflet Addons</h5>
                 ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
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
