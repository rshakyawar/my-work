(function($) {

  var permList  = 'email'; 

  $(document).ready(function() {
    $.getScript(document.location.protocol + "//connect.facebook.net/en_US/all.js");

    var fb_reload = true;

    window.fbAsyncInit = function() {
      FB.init({
        appId   : $("#fb_share_app_id").val(),//$('meta[property="fb:app_id"]').attr('content'),
        status  : true, // check login status
        cookie  : true, // enable cookies to allow the server to access the session
        xfbml   : true, // parse XFBML
        logging : true
      });

      function facebookAction(action, func) {
        FB.getLoginStatus(function(response) {
          if (response.session) { 
            action(function() {
              func(response) 
            }) 
          } else {
            func(response);
          } 
        });
      }

      function facebookLogout(func) {
        facebookAction(FB.logout, func)
      }

      FB.Event.subscribe("auth.sessionChange", function(response) {
        if (response.session) fb_reload && window.location.reload(true);
      });

      $('.logout_link').live('click', function(e) {
        e.preventDefault();
        href = this.href;
        facebookLogout(function(response) {
          if (href) window.location = href;  
          else window.location.reload(true);
        })
      });

      $('#fb_signup_header, #fb_header, #signin_using_fb, #popup_fb_header').live('click', function(e) {
        e.preventDefault();
        fb_reload = false;
        FB.login(function(response) {
          if(response.status == "connected")
          {
// To retrive friends list
//             FB.api("/me/friends", function(response) {
//               if(response.data) {
//                 $.each(response.data,function(index,friend) {
//                   alert(friend.name + ' has id:' + friend.id);
//                 });
//               } else {
//                 alert("Error!");
//               }
//             });
            FB.api("/me", function(user_info){ 

              $('form#fb_connect').append('<input type="hidden" value="' + user_info.id + '" name="uid"/>');
              $('form#fb_connect').append('<input type="hidden" value="' + user_info.first_name + '" name="user[first_name]"/>');
              $('form#fb_connect').append('<input type="hidden" value="' + user_info.last_name + '" name="user[last_name]"/>');
              $('form#fb_connect').append('<input type="hidden" value="' + user_info.email + '" name="user[email]"/>').submit();
            });
          }
        }, { perms: permList });
      })
    };
  })

  // pop up a dialogue to allow for publishing to wall
  $('.Ernestschwag_facebook_bttn').live('click',function(e){      
      e.preventDefault();
      var msg_text = "http://thestashbox.com/";
      fb_popup_wall_post({"message":msg_text,"description":msg_text});
  });

  var fb_popup_wall_post = function(obj){
    FB.ui({
      method: 'feed',
      link:$("#fb_image_link").val(),
      message: "message",
      description: $("#fb_share_text").val(),
      picture: $("#fb_share_image").attr("src"),
      display:"popup"
    }, function(response) {
       if (response && response.post_id) {
        window.location.href = $("#fb_share_return_url").val();
       } else {
         // console.log('handle fail case here');
       }
    });                  
  };
})(jQuery);
