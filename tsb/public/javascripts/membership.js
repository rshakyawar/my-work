$(document).ready(function(){
  jQuery('.np').css('padding', '0px');
});

/*
$(".ui-dialog").keypress(function () {
  alert("asdfasdf"); 
});*/

// function toggleClass(){
//   this.hide();
// }

function change_select_text(th) 
  {     
   $('#select6').html(th.options[th.selectedIndex].text);
  }
function change_date_text(th) 
{
   $('#select7').html(th.options[th.selectedIndex].text);
}

function change_month_text(th)
{
   $('#select8').html(th.options[th.selectedIndex].text);
}

function change_year_text(th)
{
   $('#select9').html(th.options[th.selectedIndex].text);
}

function change_state_text(th)  
{
   $('#select10').html(th.options[th.selectedIndex].text);
}  
function OpenDialog(inputObj, number, selected_value) {
  $("#popup"+ number).dialog("close");
  var pagescrl = getScrollXY();
	var object = $(inputObj);
	var offset = object.offset();
  var x=0, y=0;
  y = offset.top - 4 - pagescrl; x = offset.left - 2;
  switch (number) {
      case 1:
          $("#member_survey_one_sms").removeAttr("disabled");
          $("#member_survey_one_sms").val(selected_value);
          break;
      case 2:
          $("#member_survey_one_calls").removeAttr("disabled");
          $("#member_survey_one_calls").val(selected_value);
          break;
      case 3:
          $("#member_survey_one_email").removeAttr("disabled");
          $("#member_survey_one_email").val(selected_value);
          break;
      case 4:
          $("#member_survey_one_social_networking").removeAttr("disabled");
          $("#member_survey_one_social_networking").val(selected_value);
          break;
      case 5:
          $("#member_survey_one_humans").removeAttr("disabled");
          $("#member_survey_one_humans").val(selected_value);
          break;

  }
  $("#popup" + number).dialog({ resizable: false,close:function(e){close_dialog(number);} });
}

function close_dialog(number){
    switch (number) {
        case 1:
            $("#member_survey_one_sms").attr("disabled","disabled");
            break;
        case 2:
            $("#member_survey_one_calls").attr("disabled","disabled");
            break;
        case 3:
            $("#member_survey_one_email").attr("disabled","disabled");
            break;
        case 4:
            $("#member_survey_one_social_networking").attr("disabled","disabled");
            break;
        case 5:
            $("#member_survey_one_humans").attr("disabled","disabled");
            break;
    }
  }

function OpenDialogomMouse(inputObj,number){
  var pagescrl = getScrollXY();
	var object = $(inputObj);
	var offset = object.offset();
  var x=0, y=0;
  y = offset.top - 110 - pagescrl; x = offset.left - 50;
  $("#popup" + number).dialog({ resizable: false});
}

function CloseDialog(inputObj,number){
  $("#popup"+ number).dialog("close");
}

function getScrollXY() {
  var scrOfX = 0, scrOfY = 0;
  if (typeof (window.pageYOffset) == 'number') {
      //Netscape compliant
      scrOfY = window.pageYOffset;
      scrOfX = window.pageXOffset;
  } else if (document.body && (document.body.scrollLeft || document.body.scrollTop)) {
      //DOM compliant
      scrOfY = document.body.scrollTop;
      scrOfX = document.body.scrollLeft;
  } else if (document.documentElement && (document.documentElement.scrollLeft || document.documentElement.scrollTop)) {
      //IE6 standards compliant mode
      scrOfY = document.documentElement.scrollTop;
      scrOfX = document.documentElement.scrollLeft;
  }
  return scrOfY;
}

function validate_survey_one(){
//     selected_popupbox = $('div.popupbox:hidden').length;
//     selected_option = 26 - selected_popupbox
   var count=0;
   var els = document.getElementsByTagName("input");
   for (var i=0; i < els.length; i++) {
      if (els[i].type === "radio" && els[i].checked)
        count++;
   }
   if (count==5){
     if (validate_survey_two()){
       $('form').submit();
        return true;       
     }
     else{
        return false;       
     }    
   }
   else{
       $("#popup50").dialog({ closeText: '' ,modal:true , resizable: false, open : function(e){open_popup(this);$('.ui-widget-overlay').click(function() { $("#popup50").dialog("close"); });},  close: function(event, ui){ 
         window.location = '#communication_box';
         return false;
       }});
     return false; 
   }
}

function open_popup(this_obj){
    $(this_obj).parent().find("a").attr("class","custom_close ui-corner-all");
  }

function select_unselect_values(type,id){
  for(i=1;i<5;i++)
  {
    if (i==id)
    {
      $("."+type+"_cross_"+i+"").show();
    }
    else
    {
      $("."+type+"_cross_"+i+"").hide();
    }
  }
  $("#member_survey_one_"+type+"").val(id);
}


function validate_survey_two(){
    var count_div =0;
    $('.step2_img_links_row input').each(function(){
      if($(this).attr('disabled') == true ){}else{
        count_div = count_div + 1;
      }
    });
    if(count_div > 2){
      if (save_member_survey_form_three()){
        return true;  
      }
      else{
        return false;
      }
    }else{
    $("#popup13").dialog({ modal:true , resizable: false, open : function(e){open_popup(this);$('.ui-widget-overlay').click(function() { $("#popup13").dialog("close"); });},   close: function(event, ui){ 
         window.location = '#everybody';
         return false;
       }});
    return false;
    }
}

function save_member_survey_form_three(){
    var count_div =0;
    $('.box3_img_bg input').each(function(){
      if($(this).attr('disabled') == true ){}else{
        count_div = count_div + 1;
      }
    });
    if (count_div == 5){
      return true;
    }else{ 
    $("#popup51").dialog({ modal:true , resizable: false, open : function(e){open_popup(this);$('.ui-widget-overlay').click(function() { $("#popup51").dialog("close"); });},  close: function(event, ui){ 
         window.location = '#stash_status';
         return false;
       }});   
    return false;}
}

