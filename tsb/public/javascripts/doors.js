var mod = (function() {
	var obj = {};

	obj.expose = function() {
		var today = new Date();
		$.cookie('doors_opened', 'yep', { expires : 2 });
		$('#black_bg').css('background','none');
		$('#door_left').animate({left: '-=500'}, 2000);
		$('#door_right').animate({left: '+=500'}, 2000, function() {
			$('#black_bg').css('display','none');
		});
	};

	obj.placeBkd = function() {
		var pageHeight = $(window).height();
		// move doors the right way
		$('body').css('background-position', '50% '+ ( -(2000-pageHeight)/2 + 38) + 'px');
		
		$('div#sign-up-container').height(pageHeight);
	};
	
	obj.showHIW = function(hiwPopup) {
		$('#m-code, #m-voice, #m-safe, #m-schwag').fadeOut(400);
		$(hiwPopup).slideDown(400);
	}
	
	return obj;
}());

$(function() {
	// check for cookies. if so, hide the doors.
	if ($.cookie('doors_opened') == 'yep') {
		$('#black_bg').css('display', 'none');
	}
	mod.placeBkd();
	// move the form back to center on window resize
	$(window).resize( mod.placeBkd );

	var flashvars = {};
	var params = {wmode: 'transparent'};
	var attributes = {};
	//swfobject.embedSWF("swf/crowd.swf", "flash_crowd", "1000", "560", "9.0.0", "expressInstall.swf", flashvars, params, attributes);

	$('#door_left').css('display','block').click(function() { mod.expose(); });
	$('#door_right').css('display', 'block').click(function() { mod.expose(); });
	$('#door_left_visible').css('display','none');
	$('#door_right_visible').css('display','none');
});