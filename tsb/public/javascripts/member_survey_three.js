
function show_drop_down(select_id,inner_id){
  if ($(select_id).is(":visible"))
  {
    $(select_id).hide();
    $(inner_id).attr("disabled","disabled");
  }
  else{
    $(select_id).show();
    $(inner_id).removeAttr('disabled');
  } 
}

function change_expert_color(expert_id,select_id, input_select, number){
    $(expert_id).css('background-color', '#3BB9FF');
    $("#popup" + number).dialog({ modal:true , resizable: false, open : function(e){open_popup(select_id);$('.ui-widget-overlay').click(function() { $("#popup"+ number).dialog("close"); });}, close : function(e){close_popup(select_id, input_select, expert_id);}});
//   } 
}

function open_popup(select_id){
   if (select_id == '#select_18_id'){
     $(select_id).children("input:checkbox").click(function(e){
     var selected_id = $(this).id;
    });
   }
   else{
     $(select_id).children("input:checkbox").click(function(e){
     var selected_id = $(this).id;
     if($(this).attr('checked')==true) {
         $(select_id).children("input:checkbox").each(function() {
         $(this).attr('checked',false);
     })
         $(this).attr('checked',true)
     }
     });
   }
  }

function close_popup(parent_check_boxes_id, input_select, expert_id){
    var flag = 0;
    if (parent_check_boxes_id == '#select_18_id'){ 
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
    }
    else{   
      $(parent_check_boxes_id).children("input:checkbox").each(function(){
        if($(this).attr('checked')==true){
          flag = 1;
          $(input_select).removeAttr("disabled");
          set_value = $(this).attr('value');
          $(input_select).val(set_value);
        }
      })
    }  
    if(flag == 0){
      $(input_select).attr("disabled","disabled");
      $(expert_id).css('background-color', '');
    }
  }
