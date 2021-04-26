$(function(){
		$('.news').each(function(){
			var txt1 = $(this).html();
			$(this).html(txt1.replace(/【採用情報】/g,'<span class="newsRecruit">【採用情報】</span>'));
			$('.newsRecruit').parent().next('em').addClass('newsRecruitDate');
			var txt2 = $(this).html();
			$(this).html(txt2.replace(/【会社情報】/g,'<span class="newsCompany">【会社情報】</span>'));
			$('.newsCompany').parent().next('em').addClass('newsCompanyDate');
			var txt3 = $(this).html();
			$(this).html(txt3.replace(/【お知らせ】/g,'<span class="newsNotice">【お知らせ】</span>'));
			$('.newsNotice').parent().next('em').addClass('newsNoticeDate');
		});
});
