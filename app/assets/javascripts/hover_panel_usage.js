  options = {
    image_srcs: (function(){
      var r = [];
      for(var i = 0; i < 17; i++){
        r.push('/images/images-' + i + '.jpeg');
      }
      return r;
    })(),
    animate: {
      over:{top:166},
      left:{top:266},
      right:{top:266},
      other:{top:0},
    }
  };
  $('#my-hover-panel').hover_panel(options);  // set it up
