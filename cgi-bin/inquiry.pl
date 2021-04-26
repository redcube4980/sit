#!/usr/bin/perl
# 2016/02/28
# send mail => 2004/04/26 written by H.Ito
#use CGI::Carp qw(fatalsToBrowser);

print "Content-type: text/json; charset=utf-8\n\n";
#
#   漢字コード変換ライブラリをインクルード
#use Jcode;
#use Unicode::Japanese;
require 'Jcode.pm';
#require '/var/www/cgi-bin/jcode.pl';
#
#   ＄ｓｔｒに入力データを入れる
if ($ENV{'REQUEST_METHOD'} eq "POST") {
    read(STDIN, $str, $ENV{'CONTENT_LENGTH'});
} else {
    $str = $ENV{'QUERY_STRING'};
}
#
#   デコード
@part = split('&', $str);
foreach $i (@part) {
    ($variable, $value) = split('=', $i);
    $value =~ tr/+/ /;
    $value =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack("C", hex($1))/eg;
    #&jcode'convert(*value, 'euc'); 以前のページがEUCの為 削除
    $value =~ s/</&lt;/g;
    $value =~ s/>/&gt;/g;
		#↓↓サニタイジング不足対応↓↓
		$value =~ s/</＜/g;
		$value =~ s/>/＞/g;
		$value =~ s/'/’/g;
		$value =~ s/"/”/g;
		$value =~ s/`/｀/g;
		#波ダッシュ問題

    $value =~ s/\015\012/\012/g;
    $value =~ s/\015/\012/g;
    #&jcode'convert(*value, );
		#波ダッシュ問題対応(cp932を経由,BadKnowHowだとは思うけど)
		$value = Jcode::convert( $value, 'cp932' ); 
		$value = Jcode::convert( $value, 'sjis' ); 
    $cgi{$variable} = $value;
}
#
# ----- 初期設定 -----
$nkf = "/usr/bin/nkf -j";

#テスト環境
#$nkf = "/usr/local/bin/nkf -j";

$question1   = $cgi{'question1'};
$question2   = $cgi{'question2'};
$question3   = $cgi{'question3'};
$other       = $cgi{'other'};
$company     = $cgi{'company'};
$dept        = $cgi{'dept'};
$post        = $cgi{'post'};
$name        = $cgi{'name'};
$add         = $cgi{'add'};
$add2        = $cgi{'add2'};
$add3        = $cgi{'add'} . '-' . $cgi{'add2'};
$address1    = $cgi{'address1'};
$address2    = $cgi{'address2'};
$address3    = $cgi{'address3'};
$tel1        = $cgi{'tel1'};
$tel2        = $cgi{'tel2'};
$tel3        = $cgi{'tel3'};
$tel         = $cgi{'tel'};
#$tel         = $cgi{'tel1'} . '-' . $cgi{'tel2'}. '-' . $cgi{'tel3'};
$fax1        = $cgi{'fax1'};
$fax2        = $cgi{'fax2'};
$fax3        = $cgi{'fax3'};
$fax         = $cgi{'fax'};
#$fax         = $cgi{'fax1'} . '-' . $cgi{'fax2'}. '-' . $cgi{'fax3'};
$email       = $cgi{'email'};
$type        = $cgi{'type'};

$title[1] = '問合せ（愛ちゃんFamiliar）';
$temai[1] = 's-ohhara@te.d-sit.co.jp, k-nomura@sy.d-sit.co.jp';
$tcmai[1] = 'koho@sw.d-sit.co.jp';

$title[2] = '問合せ（大同ネット）';
$temai[2] = 't-kozawa@xa.d-sit.co.jp';
$tcmai[2] = 'koho@sw.d-sit.co.jp';

#3のみ、Ccなし(Toと同じアドレスを指定する)
$title[3] = '問合せ（本社）';
$temai[3] = 'koho@sw.d-sit.co.jp';
$tcmai[3] = 'koho@sw.d-sit.co.jp';

$title[4] = '問合せ（まかせて！データ分析）';
$temai[4] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[4] = 'koho@sw.d-sit.co.jp';

$title[6] = '問合せ（スタースチール熱処理）';
$temai[6] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[6] = 'koho@sw.d-sit.co.jp';

$title[7] = '問合せ（スタースチール二次加工）';
$temai[7] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[7] = 'koho@sw.d-sit.co.jp';

$title[8] = '問合せ（給ちゃんシリーズ）';
$temai[8] = 's-ohhara@te.d-sit.co.jp';
$tcmai[8] = 'koho@sw.d-sit.co.jp';

$title[9] = '問合せ（スタースチール卸）';
$temai[9] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[9] = 'koho@sw.d-sit.co.jp';

$title[10] = '問合せ（スタースチール鍛造・機械加工）';
$temai[10] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[10] = 'koho@sw.d-sit.co.jp';

$title[11] = '問合せ（まかせて！勤務表）';
$temai[11] = 'k-shimizu@hr.d-sit.co.jp, s-ohhara@te.d-sit.co.jp';
$tcmai[11] = 'koho@sw.d-sit.co.jp';

$title[12] = '問合せ（愛ちゃん自立支援）';
$temai[12] = 's-ohhara@te.d-sit.co.jp, k-nomura@sy.d-sit.co.jp';
$tcmai[12] = 'koho@sw.d-sit.co.jp';

$title[13] = '問合せ（まかせて！卸「鋼太郎」）';
$temai[13] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[13] = 'koho@sw.d-sit.co.jp';

$subject     = $title[$type];
$mymail      = $temai[$type];
$ccmail      = $tcmai[$type];

$mailto      = "/usr/lib/sendmail " . $mymail;

#テストのため強制的に送信先を変更
#$mymail      = 'it-t@redcube.jp';
#$ccmail      = 'it-t@redcube.jp';

#テスト環境
#$mailto      = "/usr/sbin/sendmail " . $mymail;

#
# ----- プログラム本体 -----
#
# 申し込み者へ送信完了の知らせ

$flg1=0;
$flg2=0;
# 貴社名チェック
if(length $company == 0){
 $flg1=1;
 $item='[貴社名]';
}
# お名前チェック
if(length $name == 0){
 $flg1=1;
 $item='[お名前]';
}
# ご住所（都道府県）チェック
if(length $address1 == 0){
 $flg1=1;
 $item='[ご住所（都道府県）]';
}

# ご住所（市区町村から番地）チェック
if(length $address2 == 0){
 $flg1=1;
 $item='[ご住所（市区町村から番地）]';
}
# ＴＥＬチェック
if(length $tel == 0){
 $flg1=1;
 $item='[ＴＥＬ]';
}
#if(length $tel1 == 0){
# $flg1=1;
# $item='[ＴＥＬ]';
#}
# ＴＥＬチェック
#if(length $tel2 == 0){
# $flg1=1;
# $item='[ＴＥＬ]';
#}
# ＴＥＬチェック
#if(length $tel3 == 0){
# $flg1=1;
# $item='[ＴＥＬ]';
#}

# 未入力個所があった場合
if($flg1 == 1){
 $item = Jcode::convert( '<span class=\"danger\">'.$item.'</span>が未入力です。<br>', 'utf8' ); #utf8に何故か変換しないとsjisで出力されてしまう
 #$item = '<span class=\"danger\">'.$item.'</span>が未入力です。<br>';
}

# 必須項目にモレがないか？
if($flg1 == 1){
	$ret = '{"result":0,"message":"' . $item . '"}';
open(STDOUT);
print STDOUT $ret;
close(STDOUT);
exit(0);
}

$ret = '{"result":1,"message":""}';
open(STDOUT);
print STDOUT $ret;


#
# 内容をメールで送る
#---- 問合せ内容（選択）---------------------------------
#1.説明またはデモ  　　　　： $question1
#2.概算費用  　　　　　　　： $question2
#3.試用版CD  　　　　　　　： $question3
open(MAIL, "| $nkf | $mailto $ccmail");
print MAIL <<EOF;
From: $email.
To: $mymail.
Cc: $ccmail.
Content-Type: text/plain; charset="ISO-2022-JP"
Subject: $subject\n

---- 入力者情報 ----------------------------------------
企業名もしくは学校名　　　： $company
氏名　  　　　　　        ： $name
郵便番号          　　　　： $add
ご住所(都道府県)          ： $address1
ご住所(市区町村から番地)  ： $address2
ご住所(ビル名など)        ： $address3
ＴＥＬ        　　　　　　： $tel
ＦＡＸ　　　　　　　　　　： $fax
e-mailアドレス          　： $email
---- お問い合わせ内容（自由記述）-----------------------
$other
--------------------------------------------------------
EOF
close(MAIL);
close(STDOUT);
exit;
