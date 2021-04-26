#!/usr/bin/perl
# 2016/02/28
# send mail => 2004/04/26 written by H.Ito
#use CGI::Carp qw(fatalsToBrowser);

print "Content-type: text/json; charset=utf-8\n\n";
#
#   �����R�[�h�ϊ����C�u�������C���N���[�h
#use Jcode;
#use Unicode::Japanese;
require 'Jcode.pm';
#require '/var/www/cgi-bin/jcode.pl';
#
#   ���������ɓ��̓f�[�^������
if ($ENV{'REQUEST_METHOD'} eq "POST") {
    read(STDIN, $str, $ENV{'CONTENT_LENGTH'});
} else {
    $str = $ENV{'QUERY_STRING'};
}
#
#   �f�R�[�h
@part = split('&', $str);
foreach $i (@part) {
    ($variable, $value) = split('=', $i);
    $value =~ tr/+/ /;
    $value =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack("C", hex($1))/eg;
    #&jcode'convert(*value, 'euc'); �ȑO�̃y�[�W��EUC�̈� �폜
    $value =~ s/</&lt;/g;
    $value =~ s/>/&gt;/g;
		#�����T�j�^�C�W���O�s���Ή�����
		$value =~ s/</��/g;
		$value =~ s/>/��/g;
		$value =~ s/'/�f/g;
		$value =~ s/"/�h/g;
		$value =~ s/`/�M/g;
		#�g�_�b�V�����

    $value =~ s/\015\012/\012/g;
    $value =~ s/\015/\012/g;
    #&jcode'convert(*value, );
		#�g�_�b�V�����Ή�(cp932���o�R,BadKnowHow���Ƃ͎v������)
		$value = Jcode::convert( $value, 'cp932' ); 
		$value = Jcode::convert( $value, 'sjis' ); 
    $cgi{$variable} = $value;
}
#
# ----- �����ݒ� -----
$nkf = "/usr/bin/nkf -j";

#�e�X�g��
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

$title[1] = '�⍇���i�������Familiar�j';
$temai[1] = 's-ohhara@te.d-sit.co.jp, k-nomura@sy.d-sit.co.jp';
$tcmai[1] = 'koho@sw.d-sit.co.jp';

$title[2] = '�⍇���i�哯�l�b�g�j';
$temai[2] = 't-kozawa@xa.d-sit.co.jp';
$tcmai[2] = 'koho@sw.d-sit.co.jp';

#3�̂݁ACc�Ȃ�(To�Ɠ����A�h���X���w�肷��)
$title[3] = '�⍇���i�{�Ёj';
$temai[3] = 'koho@sw.d-sit.co.jp';
$tcmai[3] = 'koho@sw.d-sit.co.jp';

$title[4] = '�⍇���i�܂����āI�f�[�^���́j';
$temai[4] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[4] = 'koho@sw.d-sit.co.jp';

$title[6] = '�⍇���i�X�^�[�X�`�[���M�����j';
$temai[6] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[6] = 'koho@sw.d-sit.co.jp';

$title[7] = '�⍇���i�X�^�[�X�`�[���񎟉��H�j';
$temai[7] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[7] = 'koho@sw.d-sit.co.jp';

$title[8] = '�⍇���i�������V���[�Y�j';
$temai[8] = 's-ohhara@te.d-sit.co.jp';
$tcmai[8] = 'koho@sw.d-sit.co.jp';

$title[9] = '�⍇���i�X�^�[�X�`�[�����j';
$temai[9] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[9] = 'koho@sw.d-sit.co.jp';

$title[10] = '�⍇���i�X�^�[�X�`�[���b���E�@�B���H�j';
$temai[10] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[10] = 'koho@sw.d-sit.co.jp';

$title[11] = '�⍇���i�܂����āI�Ζ��\�j';
$temai[11] = 'k-shimizu@hr.d-sit.co.jp, s-ohhara@te.d-sit.co.jp';
$tcmai[11] = 'koho@sw.d-sit.co.jp';

$title[12] = '�⍇���i������񎩗��x���j';
$temai[12] = 's-ohhara@te.d-sit.co.jp, k-nomura@sy.d-sit.co.jp';
$tcmai[12] = 'koho@sw.d-sit.co.jp';

$title[13] = '�⍇���i�܂����āI���u�|���Y�v�j';
$temai[13] = 'y-takada@bw.d-sit.co.jp, t-kurihara@ac.d-sit.co.jp';
$tcmai[13] = 'koho@sw.d-sit.co.jp';

$subject     = $title[$type];
$mymail      = $temai[$type];
$ccmail      = $tcmai[$type];

$mailto      = "/usr/lib/sendmail " . $mymail;

#�e�X�g�̂��ߋ����I�ɑ��M���ύX
#$mymail      = 'it-t@redcube.jp';
#$ccmail      = 'it-t@redcube.jp';

#�e�X�g��
#$mailto      = "/usr/sbin/sendmail " . $mymail;

#
# ----- �v���O�����{�� -----
#
# �\�����ݎ҂֑��M�����̒m�点

$flg1=0;
$flg2=0;
# �M�Ж��`�F�b�N
if(length $company == 0){
 $flg1=1;
 $item='[�M�Ж�]';
}
# �����O�`�F�b�N
if(length $name == 0){
 $flg1=1;
 $item='[�����O]';
}
# ���Z���i�s���{���j�`�F�b�N
if(length $address1 == 0){
 $flg1=1;
 $item='[���Z���i�s���{���j]';
}

# ���Z���i�s�撬������Ԓn�j�`�F�b�N
if(length $address2 == 0){
 $flg1=1;
 $item='[���Z���i�s�撬������Ԓn�j]';
}
# �s�d�k�`�F�b�N
if(length $tel == 0){
 $flg1=1;
 $item='[�s�d�k]';
}
#if(length $tel1 == 0){
# $flg1=1;
# $item='[�s�d�k]';
#}
# �s�d�k�`�F�b�N
#if(length $tel2 == 0){
# $flg1=1;
# $item='[�s�d�k]';
#}
# �s�d�k�`�F�b�N
#if(length $tel3 == 0){
# $flg1=1;
# $item='[�s�d�k]';
#}

# �����͌����������ꍇ
if($flg1 == 1){
 $item = Jcode::convert( '<span class=\"danger\">'.$item.'</span>�������͂ł��B<br>', 'utf8' ); #utf8�ɉ��̂��ϊ����Ȃ���sjis�ŏo�͂���Ă��܂�
 #$item = '<span class=\"danger\">'.$item.'</span>�������͂ł��B<br>';
}

# �K�{���ڂɃ������Ȃ����H
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
# ���e�����[���ő���
#---- �⍇�����e�i�I���j---------------------------------
#1.�����܂��̓f��  �@�@�@�@�F $question1
#2.�T�Z��p  �@�@�@�@�@�@�@�F $question2
#3.���p��CD  �@�@�@�@�@�@�@�F $question3
open(MAIL, "| $nkf | $mailto $ccmail");
print MAIL <<EOF;
From: $email.
To: $mymail.
Cc: $ccmail.
Content-Type: text/plain; charset="ISO-2022-JP"
Subject: $subject\n

---- ���͎ҏ�� ----------------------------------------
��Ɩ��������͊w�Z���@�@�@�F $company
�����@  �@�@�@�@�@        �F $name
�X�֔ԍ�          �@�@�@�@�F $add
���Z��(�s���{��)          �F $address1
���Z��(�s�撬������Ԓn)  �F $address2
���Z��(�r�����Ȃ�)        �F $address3
�s�d�k        �@�@�@�@�@�@�F $tel
�e�`�w�@�@�@�@�@�@�@�@�@�@�F $fax
e-mail�A�h���X          �@�F $email
---- ���₢���킹���e�i���R�L�q�j-----------------------
$other
--------------------------------------------------------
EOF
close(MAIL);
close(STDOUT);
exit;
