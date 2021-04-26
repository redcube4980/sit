$(function() {
	$('#company').mouseover(function() {
		megaMenuClose();
		$('#megaMenuCompany').slideDown('fast');
		$(this).addClass('hover');
	});
	$('#megaMenuCompany').mouseleave(function() {
		$('#megaMenuCompany').slideUp('fast');
		$('#company').removeClass('hover');
	});

	$('#safety').mouseover(function() {
		megaMenuClose();
		$('#megaMenuSafety').slideDown('fast');
		$(this).addClass('hover');
	});
	$('#megaMenuSafety').mouseleave(function() {
		$('#megaMenuSafety').slideUp('fast');
		$('#safety').removeClass('hover');
	});

	$('#recruit').mouseover(function() {
		megaMenuClose();
		$('#megaMenuRecruit').slideDown('fast');
		$(this).addClass('hover');
	});
	$('#megaMenuRecruit').mouseleave(function() {
		$('#megaMenuRecruit').slideUp('fast');
		$('#recruit').removeClass('hover');

	});
	$('#home,#bsiness,#service').mouseover(function() {
		megaMenuClose();
	});
});

function megaMenuClose() {
	$('.megaMenu').hide();
	$('#globalNav .container .Nav li.hover').removeClass('hover');
}


/*$(function(){
	$('#spBtn a').click(function() {
	if ($(this).attr('href') == '#modalSet') {
		$(this).children().removeClass('active');
		$(this).attr('href', '#!');
	}else{
		$(this).attr('href', '#modalSet');
		$(this).children().addClass('active');
	}
	});
	
});*/

$(function(){
	$('#spBtn').click(function() {
		$(this).children().toggleClass('active');
		$('#modalSet').toggleClass('active');
		$('#modalSet').slideToggle('fast');
		
		
		});
	
});