function OpenDialog(inputObj, number) {
	$("#popup1").dialog("close");
	$("#popup2").dialog("close");
	$("#popup3").dialog("close");
	$("#popup4").dialog("close");
	$("#popup5").dialog("close");
	$("#popup6").dialog("close");
	var pagescrl = getScrollXY();
	var object = $(inputObj);
	var offset = object.offset();
	var x = 0,
	y = 0;
	switch (number) {
	case 1:
		y = offset.top - 250 - pagescrl;
		x = offset.left - 130;
		//x = 310; y = 220;
		break;
	case 2:
		y = offset.top - 250 - pagescrl;
		x = offset.left - 110;
		//x = 675; y = 220;
		break;
	case 3:
		y = offset.top - 250 - pagescrl;
		x = offset.left - 70;
		//x = 310; y = 280;
		break;
	case 4:
		y = offset.top - 10 - pagescrl;
		x = offset.left - 130;
		//x = 675; y = 220;
		break;
	case 5:
		y = offset.top - 10 - pagescrl;
		x = offset.left - 110;
		//x = 675; y = 220;
		break;
	case 6:
		y = offset.top - 10 - pagescrl;
		x = offset.left - 70;
		//x = 675; y = 220;
		break;
	}
	$("#popup" + number).dialog({
		resizable: false,
		position: [x, y]
	});
}
function getScrollXY() {
	var scrOfX = 0,
	scrOfY = 0;
	if (typeof(window.pageYOffset) == 'number') {
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

