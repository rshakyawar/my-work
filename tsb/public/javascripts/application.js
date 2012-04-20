$(document).ready(function() {
  $("#viewport1").mapbox({
    mousewheel: false,
    layerSplit: 8//smoother transition for mousewheel
  });

  $(".removeImg").click(function() {//control panel

    $("#viewport1").css({display : 'none'});
    $("#viewport").css({display : 'block'});

    $("#slider01").slider('value', 0);
    $('#slider').val(0);
    $('<div id="overlay"></div>').appendTo('#control');

  });
  $(".map-control a").click(function() {//control panel
    var viewport = $("#viewport1");
    viewport.mapbox(this.className);
    return false;
  });

  $(".back").click(function() {//control panel
    var view = $("#viewport1");
    view.mapbox('back', 1);//step twice

    var valore;
    valore = parseInt($("#slider01").slider('value')) - 1;
    $("#slider01").slider('value', valore);
    $('#slider').val(valore);

    return false;
  });

  $(".zoom").click(function() {//control panel
    var view = $("#viewport1");
    view.mapbox('zoom', 1);//step twice

    var valore;
    valore = parseInt($("#slider01").slider('value')) + 1;
    $("#slider01").slider('value', valore);
    $('#slider').val(valore);

    return false;
  });

  $(".resetTxt").click(function() {//control panel
    var view = $("#viewport1");
    var reset_val = parseInt($('#slider').val());
    view.mapbox('back', reset_val);
    $("#slider01").slider('value', 0);
    $('#slider').val(0);
    return false;
  });

  $("#slider01").slider({
    value:0,
    min: 0,
    max: 8,
    step: 1,
    slide: function( event, ui ) {
      var new_val = ui.value;
      var old_val = parseInt($('#slider').val());
      var viewport = $("#viewport1");
      var step;
      if (new_val > old_val)
      {
        step = new_val - old_val;
        viewport.mapbox('zoom', step);
      }
      else
      {
        step = old_val - new_val;
        viewport.mapbox('back', step);
      }
      $('#slider').val(new_val);
    }
  });
});
