// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function openRGBWindow(){

    var w =new UI.Window({
       theme: 'alphacube',
       shadow: true,
       draggable: true,
       resizable: true,
       width: 350,
       height: 260,
       minWidth: 350, minHeight: 260, maxWidth: 350, maxHeight: 260,
       top: 20,left: 50,
       setFooter: 'false'
   });
       w.show();
       w.header.update("RGB colors palette");
       w.content.update($('rgbcolorswrapper').innerHTML);
              
}
function openSmilesWindow(){

    var w =new UI.URLWindow({
       theme: 'alphacube',
       shadow: true,
       draggable: true,
       resizable: true,
       width: 350,
       height: 550,
       minWidth: 350, minHeight: 550, maxWidth: 350, maxHeight: 550,
       top: 300,left: 50,
       url: '/main/carousel'
   });
       w.show();
       w.header.update("Smiles");
       

}