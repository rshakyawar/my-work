$(document).ready( function() {
  var mod = (function() {
    var obj = {};
    obj.href = $("#below_image_tag").attr("href");
    obj.expose = function() {
      var today = new Date();
/*      $.cookie('doors_opened', 'yep', { expires : 2 });*/
      $('#door_left').animate({left: '-=436'}, 2000);
      $('#door_right').animate({left: '+=436'}, 2000, function() {
        $('#black_bg').css('display','none');
        $("#popup1").dialog({ modal:true ,resizable: false,position: ["50%","50%"], close: function(event, ui){go_to_home();} });
      });
    };
    obj.placeBkd = function() {
      var pageHeight = $(window).height();
      // move doors the right way
      $('body').css('background-position', '50% '+ ( -(2000-pageHeight)/2 + 38) + 'px');
    };

    obj.versusLeftClick = function(this_obj) {
      $("#quizBlock_bg").html("Thank you for collaborating with Werk");
      $("#versus_image_choice").val("left");
      $(this_obj).removeClass("blue_border_versus");
      $(this_obj).addClass("red_border_versus");
      $("#versusRight").removeClass("red_border_versus");
      $("#versusRight").addClass("blue_border_versus");  
      $("#reward_thank_you_id").removeClass("dis_none");  
      $("#questio_id").removeClass("dis_none");       
      $("#old_questio_id").addClass("dis_none");       
      $("#questio_id").attr("href", this.href + "/left" );                
      $("#reward_thank_you_id").attr("href", this.href + "/left" );         
    };

    obj.versusRightClick = function(this_obj) {
      $("#quizBlock_bg").html("Thank you for collaborating with Werk");
      $("#versus_image_choice").val("right");
      $(this_obj).removeClass("blue_border_versus");
      $(this_obj).addClass("red_border_versus");
      $("#versusLeft").removeClass("red_border_versus");
      $("#versusLeft").addClass("blue_border_versus");
      //href = $("#below_image_tag").attr("href");
      $("#reward_thank_you_id").removeClass("dis_none");        
      $("#questio_id").removeClass("dis_none");  
      $("#old_questio_id").addClass("dis_none");        
      $("#questio_id").attr("href", this.href + "/right" );        
      $("#reward_thank_you_id").attr("href", this.href + "/right" );   
    };
    
    obj.rewardClick = function(this_obj) { 
      $.ajax({
        type: "GET",
        url: "/save_count_choice",
        data: "",
        datatype: "xml",
        success: function(json_obj){
          if(json_obj.member_count % 40 == 0){
            var go_to_link = "/your_reward/" + $("#versus_image_choice").val();
            $("#winner_pop_close_id").attr("href", go_to_link );
            var html_code = "Winner Code: TSB krwe" + json_obj.winner_code ;
            $("#promo_generate_code").html(html_code);
            $("#content_winner_code_id").removeClass("dis_none");
            return false;
          }
          else{
            window.location.href = "/your_reward/" + $("#versus_image_choice").val();
            return true;
          }
        }
      });
    };
    
    return obj;
  }());
  $(function() {
    mod.placeBkd();
    $("#versusLeft").click(function() { mod.versusLeftClick(this); });
    $("#versusRight").click(function() { mod.versusRightClick(this); });
    //$("#below_image_tag").click(function() { mod.rewardClick(this); });
    // move the form back to center on window resize
    $(window).resize( mod.placeBkd );
    $('#door_left').css('display','block').click(function() { mod.expose(); });
    $('#door_right').css('display', 'block').click(function() { mod.expose(); });
    $('#door_left_visible').css('display','none');
    $('#door_right_visible').css('display','none');

  });
})

