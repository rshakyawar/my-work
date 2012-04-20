function select_schwag_number(this_obj, index){
    $(this_obj).addClass("none_display");
    $("#schwag_number_"+index).removeClass("none_display");
    old_value = $("#schwag_magic_numbers").val();
    $("#schwag_magic_numbers").val(old_value + "@@" + index + "--"); 
  }
function unselect_schwag_number(this_obj, index){
    $(this_obj).addClass("none_display");
    $("#schwag_"+index).removeClass("none_display");
    old_value = $("#schwag_magic_numbers").val();
    new_value = old_value.replace("@@" + index + "--", "");
    $("#schwag_magic_numbers").val(new_value);     
  }
