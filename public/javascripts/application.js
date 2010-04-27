// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function openRGBWindow(){
  if (UI.defaultWM.getWindow($('colorswindow'))) {
     UI.defaultWM.getWindow($('colorswindow')).focus();
  }else{
    var w =new UI.Window({
       theme: 'alphacube',
       shadow: true,
       id: 'colorswindow',
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
       w.focus();
  }
}
function openSmilesWindow(){
  if (UI.defaultWM.getWindow($('smileswindow'))) {
     UI.defaultWM.getWindow($('smileswindow')).focus();
  }else{
    var w =new UI.Window({
       theme: 'alphacube',
       shadow: true,
       id: 'smileswindow',
       draggable: true,
       resizable: true,
       width: 350,
       height: 290,
       minWidth: 350, minHeight: 260, maxWidth: 350, maxHeight: 260,
       top: 300,left: 50
   });
       w.show();
       w.header.update("Smiles");
       w.content.update($('smileswrapper').innerHTML);
       w.focus();
  }
}

function smilesPaginator(id){
 
  $$('#smileswrapper div').each(function(element){
      element.hide();
  });

 $$('a.sm-paginator-active').each(function(element){
     element.removeClassName('sm-paginator-active');
 });
 pid = 'page' + id;
 lid = 'link' + id;
 
 $(pid ).show();
 $(lid ).addClassName('sm-paginator-active');
  
 UI.defaultWM.getWindow($('smileswindow')).content.update($('smileswrapper').innerHTML);

}