/* Information
----------------------------------------------
File Name : inquiryjs
--------------------------------------------*/

var retJson;
$(function(){
	$('#btn_inquiry').on('click', function(){
		targeturl = '/cgi-bin/inquiry.pl';
		postdata = $('#frm_inquiry').serialize();
		$('#btn_inquiry').prop('disabled', true);
		$('#msg_inquiry').html('送信しています。暫くお待ち下さい。').addClass('warning').removeClass('success');
		var promiss = ajaxProc(targeturl,postdata);
		promiss.done(function(){
			if ( retJson.result == 1 ) {
				$('#msg_inquiry').html('お問い合わせを承りました。').addClass('success').removeClass('warning');
				//$('#btn_inquiry').prop('disabled', false);
				location.href = "contact_thanks.html";
			} else if ( retJson.result == 0 ) {
				$('#msg_inquiry').html(retJson.message).removeClass('success').removeClass('warning');
				$('#btn_inquiry').prop('disabled', false);
			}
		});
	});
	$('input[type="reset"]').on('click', function(){
		$('#msg_inquiry').html('').removeClass('success').removeClass('warning');
	});
});

//Deferを使用し複数のAjaxに対応
function ajaxProc(targeturl,postdata){
	var defer = $.Deferred();
	var jqxhr = $.ajax({
		type: "POST",
		url: targeturl,
		data: postdata,
		dataType: 'json'
	}).always(function(msg){
		retJson = msg;
		defer.resolve();
	});
	return defer;
};