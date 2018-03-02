/*
 (function t(key) {
    if(!key){ return "N/A"; }
    
    var keys = key.split(".");
    var comp = window.I18n;
    
    $(keys).each(function(_, value) {
      if(comp){ comp = comp[value]; }
    });

    if(!comp && console){
      console.debug("No translation found for key: " + key);
      return key;
    }
    return comp;
});


$(document).ready( function() {
  $(document).foundation( {
    topbar: {
      custom_back_text: true,
      back_text: t('back')
    }
  }); 
});*/