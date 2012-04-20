function change_like_color(like_id,expert_id,select_id,span_like_id, input_like, input_select, number){
  if($("#popup" + number).dialog( "isOpen" ) == true){
    return true;
  }else{
    if (document.getElementById(span_like_id.replace("#","")).style.display == "inline")
    {
  //     $(select_id).hide();
      $(input_like).attr("disabled","disabled");
      $(span_like_id).hide();
      $(like_id).css('background-color', '');
      $(input_select).attr("disabled","disabled");
    }
    else{
      $(expert_id).css('background-color', '');
      $(span_like_id).show();
  //     $(select_id).hide();
      $(input_like).removeAttr("disabled");
      $(input_select).attr('disabled','disabled');
      $(like_id).css('background-color', 'orange');
    }
  }
}

function change_expert_color_two(like_id,expert_id,select_id,span_like_id, input_like, input_select, number){
    $(like_id).css('background-color', '');
    $(expert_id).css('background-color', '#3BB9FF');
    $(span_like_id).hide();
    $(input_like).attr('disabled','disabled');
    $(span_like_id).attr("disabled","disabled");
    $("#popup" + number).dialog({ modal:true , resizable: false, open : function(e){open_popup_two(select_id);$('.ui-widget-overlay').click(function() { $("#popup"+ number).dialog("close"); });}, close : function(e){close_popup_two(select_id, input_select, expert_id);}}); 
}

function open_popup_two(select_id){
    $(select_id).children("input:checkbox").click(function(e){
    var selected_id = $(this).id;

    });
  }

function close_popup_two(parent_check_boxes_id, input_select, expert_id){
    var flag = 0;
    var set_value = "";
    $(parent_check_boxes_id).children("input:checkbox").each(function(){
      if($(this).attr('checked')==true){
        flag = 1;
        $(input_select).removeAttr("disabled");
        set_value += $(this).attr('value');
        set_value +="@ "; 
        $(input_select).val((set_value.substring(0,(set_value.length-2))));
      }
    })
    if(flag == 0){
      $(input_select).attr("disabled","disabled");
      $(expert_id).css('background-color', '');
    }
  }



