$(document).ready(function(){
  jQuery('.np').css('padding', '0px');
  $(".numbers-link").each( function(index_i){
    $(this).find("a").each(function(index_j){
      $(this).click( function(){
        OpenDialog(this, index_i+1, index_j+1);
      });
      $(this).hover( function(){
        OpenDialogomMouse(this, 10*(index_i+1) + index_j+1);
      });
      $(this).mouseout( function(){
        CloseDialog(this, 10*(index_i+1) + index_j+1);
      });
    });
  });
});

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
  $("#popup" + number).dialog({ resizable: false,position: [x,y],close:function(e){close_dialog(number);} });
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
  $("#popup" + number).dialog({ resizable: false,position: [x,y], dialogClass: 'ui-dialog-new'});
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
    selected_popupbox = $('div.popupbox:hidden').length;
    selected_option = 26 - selected_popupbox;
    if (selected_option > 2)
    {
      $('form').submit();
      return true;
    }
    else
    {
      $("#popup6").dialog({ closeText: '', dialogClass:"ui-dialog_custom" ,modal:true , resizable: false,position: [500,100], open : function(e){open_popup(this);}});
      return false;
    }
}

function open_popup(this_obj){
    $(this_obj).parent().find("a").attr("class","custom_close ui-corner-all");
  }
