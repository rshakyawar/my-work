$(document).ready( function() {
  var mod = (function() {
    var obj = {};
    obj.expose = function() {
    };
    obj.placeBkd = function() {
      var pageHeight = $(window).height();
      // move doors the right way
      $('body').css('background-position', '50% '+ ( -(2000-pageHeight)/2 + 38) + 'px');
    };
    return obj;
  }());
  $(function() {
    /*if ($.cookie('doors_opened') == 'yep') {
      $('#black_bg').css('display', 'none');
    }*/
    mod.placeBkd();
    // move the form back to center on window resize
    $(window).resize( mod.placeBkd );
  });
})
