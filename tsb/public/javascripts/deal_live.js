function sms_pop_up()
  {
    $("#popup1").dialog({ modal:true ,resizable: false,position: [520,250] });
  }
function sendmail_pop_up()
  {
    $("#popup2").dialog({ modal:true ,resizable: false,position: [520,250] });
  }      
function validate_email(){
    var pattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    var email = $("#email_id").val(); 
    if(pattern.test(email) == true) 
    {
     $('#mail_form').submit();
     $("#popup4").dialog({ modal:true ,resizable: false,position: [520,250], close: function(event, ui){go_to_home(); }});      
     return true;
    }
    else
    {
     $("#popup3").dialog({ modal:true ,resizable: false,position: [520,250] });
     return false;
    }
}  
function go_to_home()
 {
    window.location.href = '/members/the_deal';
 } 
