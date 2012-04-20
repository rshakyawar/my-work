function setPanelControls(panelEle) {
		$(panelEle).mapbox({
			mousewheel: false,
			layerSplit: 20//smoother transition for mousewheel
		});
		
		$(".removeImg").click(function() {//control panel
			$(panelEle).css({display : 'none'});
			if (panelEle == '#bottomBannerBlock')
			{
					$('#bottomBannerBlock').css({display : 'none'});
			}
      $('#is_removed').val(true);
			$("#viewport").css({display : 'block'});
		
			$("#slider01").slider('value', 0);
			$('#slider').val(0);
			$('<div id="overlay"></div>').appendTo('#control');	
	
		});
		
		$(".map-control a").click(function() {//control panel
			var viewport = $(panelEle);
			viewport.mapbox(this.className);
			return false;
		});
		
		$(".back").click(function() {//control panel
			var view = $(panelEle);
			view.mapbox('back', 1);//step twice
			
			var valore;
			valore = parseInt($("#slider01").slider('value')) - 1;
			$("#slider01").slider('value', valore);
			$('#slider').val(valore);
			
			return false;
		});
		
		$(".zoom").click(function() {//control panel
			var view = $(panelEle);
			view.mapbox('zoom', 1);//step twice
			
			var valore;
			valore = parseInt($("#slider01").slider('value')) + 1;
			$("#slider01").slider('value', valore);
			$('#slider').val(valore);
			
			return false;
		});
		
		$(".resetTxt").click(function() {//control panel
			var view = $(panelEle);
			var reset_val = parseInt($('#slider').val());
			view.mapbox('back', reset_val);
			$("#slider01").slider('value', 0);
			$('#slider').val(0);
			return false;
		});
		
		$("#slider01").slider({
			value:0,
			min: 0,
			max: 20,
			step: 1,
			slide: function( event, ui ) {
				var new_val = ui.value;
				var old_val = parseInt($('#slider').val());
				var viewport = $(panelEle);
				var step;
				if (new_val > old_val)
				{
					step = new_val - old_val;
					viewport.mapbox('zoom', step);
				}
				else
				{
					step = old_val - new_val;
					viewport.mapbox('back', step);
				}
				$('#slider').val(new_val);
				
			}
		});
}		


function setClearFields(field1, field2, text1, text2) {
							
			$(field1).focusin(function(){
				if($(field1).val()==text1) {
					$(field1).val('');
				}

				$(field1).keyup(function(){
					$(field2).val($(field1).val());
				})
				
			})

			$(field1).focusout(function(){
				if($(field1).val()=='') {
					$(field1).val(text1);
					$(field2).val(text2);
				}
			})
			

			$(field2).focusin(function(){
				if($(field2).val()==text2) {
					$(field2).val('');
				}

				$(field2).keyup(function(){
					$(field1).val($(field2).val());
				})
				
			})

			$(field2).focusout(function(){
				if($(field2).val()=='') {
					$(field1).val(text1);
					$(field2).val(text2);
				}
			})
		}	


