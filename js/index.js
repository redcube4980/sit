$(function(){
    $('.columnService').click(
        function() {
           window.location=$(this).find('a').attr('href');
           return false;
        }
    );

		$('.news dt').each(function(){
			var txt1 = $(this).html();
			$(this).html(txt1.replace(/【採用情報】/g,'<span class="newsRecruit">【採用情報】</span>'));
			$('.newsRecruit').prev('em').addClass('newsRecruitDate');
			var txt2 = $(this).html();
			$(this).html(txt2.replace(/【会社情報】/g,'<span class="newsCompany">【会社情報】</span>'));
			$('.newsCompany').prev('em').addClass('newsCompanyDate');
			var txt3 = $(this).html();
			$(this).html(txt3.replace(/【お知らせ】/g,'<span class="newsNotice">【お知らせ】</span>'));
			$('.newsNotice').prev('em').addClass('newsNoticeDate');
		});
});
