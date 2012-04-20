$(document).ready( function() {
  var mod = (function() {
    var obj = {};
    obj.expose = function() {
      var today = new Date();
      $.cookie('doors_opened', 'yep', { expires : 2 });
      $('#door_left').animate({left: '-=436'}, 2000);
      $('#door_right').animate({left: '+=436'}, 2000, function() {
        $('#black_bg').css('display','none');
        $("#popup5").dialog({ modal: true , resizable: false,dialogClass: 'vimeo_video', close :function(event, ui){
           iframe = document.getElementById("iframe_video"); 
           iframe.src = iframe.src; 
        }});
      });
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
    $('#door_left').css('display','block').click(function() { mod.expose(); });
    $('#door_right').css('display', 'block').click(function() { mod.expose(); });
    $('#door_left_visible').css('display','none');
    $('#door_right_visible').css('display','none');

  });
})
