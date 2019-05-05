

/* SAS�еĺ��׼��ʽ�ǣ���&��ͷ����.���� */

/* ���������ݼ� */
data _null_;
set Sasfindt.Lstkinfo;
a='%a(';  /* �ַ�aΪ��%a( */
b=',';    /* �ַ�bΪ��,   */
c=');';   /* �ַ�cΪ��); */

/* ������ⲿ�ļ�sampstock.txt����������·������ */
file "F:\sasfindt\sampstock.txt"; 

/* �������a��stkcd��lstknm��c��ȫ�������ַ��ͱ��� */
put a $ stkcd $ b $ lstknm $ c $;
run;

/* �������ⲿ�ļ�sampstock.txt������ */
/* %a( 000001 , �չA );    */
/* %a( 000002 , ���A );      */
/* %a( 000004 , ST��ũ );     */
/* %a( 000005 , ������Դ );   */
/* %a( 000007 , ST���� );     */
/* %a( 000009 , �й����� );   */
/* %a( 000011 , S*ST��ҵ );   */
/* %a( 000012 , �ϲ�A );      */
/* %a( 000016 , ���A );    */
/* %a( 000017 , SST�л�A );   */
/* %a( 200011 , *ST��ҵB );   */
/* %a( 200012 , �ϲ�B );      */
/* %a( 200016 , ���B );    */
/* %a( 200017 , ST�л�B );    */
/* %a( 200020 , ST����B );    */
/* %a( 600601 , �����Ƽ� );   */
/* %a( 600602 , ������ );   */
/* %a( 600603 , ST��ҵ );     */
/* %a( 600604 , *ST���Ļ� );  */
/* %a( 600605 , ��ͨ��Դ );   */
/* %a( 600651 , �������� );   */


/* ������к�ĵ��Խ׶� */

/* ��ӡ��չ�����ɵ�sas������ */

options mprint;

/* ��a��������Ϊa1��a2 */
%macro a(a1,a2);

data stk&a1.(label="&a2.|&a1.");
set sasfindt.qttndist;
if stkcd="&a1.";
run;

%mend a;
%include "F:\sasfindt\sampstock.txt";


/* ��selstk�������Ϊdat��stkcd��dattxt��x��term��start��endt */
%macro selstk(dat,stkcd,dattxt,x,term,start,endt);

/* ����datΪ�߼���sasfindt�µ�һ�����ݼ� */

data _null_;
set sasfindt.&dat.;
a='%dret_stk(';  /* ����aΪ��%dret_stk( */
b=',';           /* ����bΪ��, */
c=');';          /* ����cΪ��); */
x1=&x;           /* ����x��ֵΪx1 */
term1=&term;     /* ����tern��ֵΪterm1 */
start1=&start;   /* ����start��ֵΪstart1 */
endt1=&endt;     /* ����endt��ֵΪendt1 */
trdflg="&dattxt";/* ����dattxt��ֵΪtrdflg */
%if %upcase(&dattxt)=SHSTK %then %do; /* ��������ΪSHstk������%upcase���������ַ����Ĵ�Сд����Ȼ���� */
if substr(&stkcd,1,1) in (6,9) or substr(&stkcd,1,2)=99; /* ��������stkcd�ĵ�һ���ַ���6����9������stkcd��ǰ�����ַ�Ϊ99 */
file "F:\sasfindt\&dattxt..txt"; /* ��ô������ⲿ�ļ�F:\sasfindt\&dattxt..txt */
put a $ trdflg $ b &stkcd $ b $ x1 $ b $ term1 $ b $ start1 $ b $ endt1 $ c $;
%end;
%if %upcase(&dattxt)=SZSTK %then %do; /* ��������ΪSZstk������%upcase���������ַ����Ĵ�Сд����Ȼ���� */
if substr(&stkcd,1,1) = 0 or substr(&stkcd,1,2)=20; /* ��������stkcd�ĵ�һ���ַ���0������stkcd��ǰ�����ַ�Ϊ20 */
file "F:\sasfindt\&dattxt..txt"; /* ��ô������ⲿ�ļ�F:\sasfindt\&dattxt..txt */
put a $ trdflg $ b &stkcd $ b $ x1 $ b $ term1 $ b $ start1 $ b $ endt1 $ c $;
%end;
%mend selstk;

%selstk(Lstkinfo,stkcd,SHstk,'d','��','1990','2005');
run;
%selstk(Lstkinfo,stkcd,SZstk,'d','��','1990','2005');
run;

/* �ļ�SHstk.txt�������� */
/* %dret_stk( SHstk , 600601 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600602 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600603 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600604 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600605 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600651 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600652 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600653 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600654 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600656 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900901 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900902 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900903 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900904 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900905 , d , �� , 1990 , 2005 ); */

/* �ļ�SZstk.txt�������� */
/* %dret_stk( SZstk , 000001 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000002 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000004 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000005 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000007 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000009 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000011 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000012 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000016 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000017 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200011 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200012 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200016 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200017 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200020 , d , �� , 1990 , 2005 ); */


/* ��termendflg�������Ϊdat��date */
%macro termendflg(dat,date);
/* ����dat���߼���sasfindt�е����ݼ�,date�����ݼ�dat�е�һ��ʱ����� */
data termfinflg;
set sasfindt.stk&dat.;
year=year(Date);
qtr=qtr(Date);
month=month(Date);
run;

/* ���� */
data termfinflg;
set termfinflg;
last_y=last.year; 
last_q=last.qtr; 
last_m=last.month;
by year qtr month;
run;
%mend termendflg;

/* �½�work.dr_sh���ݼ�����stk600601�еĴ��ڵ���1990����С�ڵ���2005���ʱ���ȡ */
%let start=1990;
%let endt=2005;
data dr_sh(keep=date);
set stk600601;
if &start<=year(date)<=&endt;
run;

/* ��dret_stk */
%macro dret_stk(dattxt,stkcd,x,term,start,endt);
/* �����dattxt������֤\��֤ */
/* �����stkcd������Ʊ */
/* �����x����d */
/* �����term������ */
/* �����start������ʼ��� */
/* �����endt������ֹ��� */

/* ���ú�termendflg */
/* �����stkcd������ǣ���Ʊ���� */
%termendflg(&stkcd);


/* �½�work.dret_stk���ݼ�������date��adjclpr��r_pct��r_log */
/* ���ҽ�r_log�ı�ǩ����Ϊ���������� */
data &x.ret_stk(keep=date adjclpr r_pct r_log label="&term.������");
set termfinflg; 
if &start<=year(date) <= &endt; /* ���ʱ�䷶Χ��1990��2005�ķ�Χ�� */
adjclpr=clpr*mcfacpr; /* �����ɼ�=�۸�����ۻ��ɼ۵������� */
r_pct=dif(adjclpr)/lag(adjclpr); /* �հٷֱ������� */
r_log=log(adjclpr)-log(lag(adjclpr)); /* �ն��������� */
run;

/* �½���work.drstk+��Ʊ���룩���ݼ� */
data &x.rstk&stkcd; 
set &x.ret_stk;
where r_pct^=. and r_log^=.; 
/* ѡȡ�հٷֱ������ʺ��ն��������ʾ���Ϊȱʧֵ�Ĺ۲� */
run;

/* ��work.dr_sh���ݼ��ͣ�work.drstk+��Ʊ���룩���ݼ����кϲ� */
/* �ϲ������ݼ�work.dr_sh�У���r_pct������Ϊ��rpct+��Ʊ���룩����r_log������Ϊ��rlg+��Ʊ���룩 */
/* ���ձ���date���кϲ� */
data dr_sh(rename=(r_pct=rpct&stkcd r_log=rlg&stkcd));
merge dr_sh &x.rstk&stkcd;
by date;
run;

/* ���б������� */
data dr_sh; 
set dr_sh;
if rpct&stkcd=. then rpct&stkcd=0; /* �����rpct+��Ʊ���룩Ϊȱʧֵ����ô����rpct+��Ʊ���룩��ֵΪ0 */
else rpct&stkcd=rpct&stkcd; /* ����rpct+��Ʊ���룩Ϊ�Լ����� */
if rlg&stkcd=. then rlg&stkcd=0; /* �����rlg+��Ʊ���룩Ϊȱʧֵ����ô����rlg+��Ʊ���룩��ֵΪ0 */
else rlg&stkcd=rlg&stkcd; /* ����rlg+��Ʊ���룩Ϊ�Լ����� */
run;

%mend dret_stk;

/* �ļ�SHstk.txt�������� */
/* %dret_stk( SHstk , 600601 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600602 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600603 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600604 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600605 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600651 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600652 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600653 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600654 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600656 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900901 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900902 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900903 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900904 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900905 , d , �� , 1990 , 2005 ); */

%include "F:\sasfindt\SHstk.txt";
run;


data dr_sz(keep=date);
set stk000001;
if &start<=year(date)<=&endt;
run;

%macro dret_stk(dattxt,stkcd,x,term,start,endt);

%termendflg(&stkcd);

data &x.ret_stk(keep=date adjclpr r_pct r_log label="&term.������");
set termfinflg; 
if &start<=year(date) <= &endt;
adjclpr=clpr*mcfacpr; 
r_pct=dif(adjclpr)/lag(adjclpr);
r_log=log(adjclpr)-log(lag(adjclpr));
run;

/* �½���work.drstk+��Ʊ���룩���ݼ� */
data &x.rstk&stkcd; 
set &x.ret_stk;
where r_pct^=. and r_log^=.; 
/* ѡȡ�հٷֱ������ʺ��ն��������ʾ���Ϊȱʧֵ�Ĺ۲� */
run;

data dr_sz(rename=(r_pct=rpct&stkcd r_log=rlg&stkcd));
merge dr_sz &x.rstk&stkcd;
by date;
run;

/* ���б������� */
data dr_sz; 
set dr_sz;
if rpct&stkcd=. then rpct&stkcd=0;
else rpct&stkcd=rpct&stkcd;
if rlg&stkcd=. then rlg&stkcd=0;
else rlg&stkcd=rlg&stkcd;
run;

%mend dret_stk;

/* �ļ�SZstk.txt�������� */
/* %dret_stk( SZstk , 000001 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000002 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000004 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000005 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000007 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000009 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000011 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000012 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000016 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000017 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200011 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200012 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200016 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200017 , d , �� , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200020 , d , �� , 1990 , 2005 ); */

%include "F:\sasfindt\SZstk.txt";
run;

/* �����x��start��endt */
%macro a(x,start,endt);
/* ѡȡ������ݵĹ�Ʊ�ŵ�work.a�� */
data a;
set sasfindt.Lstkinfo;
if &start<=year(Lstdt)<=&endt;
run;

/* �½�work.dat1990_2005������ݼ� */
data dat%eval(&start)_%eval(&endt);
set a;
a='%a('; /* ����aΪ��%a( */
c=");";  /* ����cΪ��); */
put a $ stkcd $ c $;
run;

/* ����_tmp_��ͼ */
/* ranuni�������ؾ��ȷֲ���������� */
proc sql noprint;
create view _tmp_ as select *, ranuni(3) as _ran_ 
from a 
order by calculated _ran_; /* ����_ran_��ֵ������������ */
quit;

/* �½�random���ݼ� */
data random;
set _tmp_(obs=20);
drop _ran_;
a='%selstkret('; 
b=","; 
c=");";
y=&x;
file"F:\sasfindt\z.txt";
put a $ y $ b $ stkcd $ c $;
run;

%mend a;

%a('d',1990,2005);
run;

/* %selstkret( d , 600651 ); */
/* %selstkret( d , 600603 ); */
/* %selstkret( d , 900905 ); */
/* %selstkret( d , 000016 ); */
/* %selstkret( d , 000004 ); */
/* %selstkret( d , 000017 ); */
/* %selstkret( d , 200017 ); */
/* %selstkret( d , 600652 ); */
/* %selstkret( d , 600656 ); */
/* %selstkret( d , 200011 ); */
/* %selstkret( d , 900901 ); */
/* %selstkret( d , 000001 ); */
/* %selstkret( d , 200016 ); */
/* %selstkret( d , 200012 ); */
/* %selstkret( d , 000012 ); */
/* %selstkret( d , 000011 ); */
/* %selstkret( d , 600653 ); */
/* %selstkret( d , 600605 ); */
/* %selstkret( d , 900904 ); */
/* %selstkret( d , 000007 ); */


/* ��shszretcom */
%macro shszretcom(x);

proc sql;
/* ����shsz_dr���ݼ� */
create table shsz_&x.r as select * 
from &x.r_sh(drop=adjclpr) a full join &x.r_sz(drop=adjclpr)  b 
on a.Date=b.Date;
quit;

%mend shszretcom;

%shszretcom(d);
run;



%macro creatcomret(x);

data Shsz_&x.r;
set Shsz_&x.r;
if date^=.;
run;

proc sort data=Shsz_&x.r;
by date;
run;

data &x.comstkrpct(keep=date);
set shsz_&x.r;
if date^=.;
run;

proc sort data=&x.comstkrpct;
by date;
run;

data &x.comstkrlg(keep=date);
set shsz_&x.r;
if date^=.;
run;

proc sort data=&x.comstkrlg;
by date;
run;

%mend creatcomret;

%creatcomret(d);
run;


%macro selstkret(x,stkcd);

data &x.comstkrpct;
merge &x.comstkrpct Shsz_&x.r(keep=date rpct&stkcd);
by date;
run;

data &x.comstkrlg;
merge &x.comstkrlg Shsz_&x.r(keep=date rpct&stkcd);
by date;
run;

%mend selstkret;

/* %selstkret( d , 600651 ); */
/* %selstkret( d , 600603 ); */
/* %selstkret( d , 900905 ); */
/* %selstkret( d , 000016 ); */
/* %selstkret( d , 000004 ); */
/* %selstkret( d , 000017 ); */
/* %selstkret( d , 200017 ); */
/* %selstkret( d , 600652 ); */
/* %selstkret( d , 600656 ); */
/* %selstkret( d , 200011 ); */
/* %selstkret( d , 900901 ); */
/* %selstkret( d , 000001 ); */
/* %selstkret( d , 200016 ); */
/* %selstkret( d , 200012 ); */
/* %selstkret( d , 000012 ); */
/* %selstkret( d , 000011 ); */
/* %selstkret( d , 600653 ); */
/* %selstkret( d , 600605 ); */
/* %selstkret( d , 900904 ); */
/* %selstkret( d , 000007 ); */

%include "F:\sasfindt\z.txt";
run;



/****************************************************************************/


proc iml;

rv=ranuni(repeat(0,20,1)); 
/* 0Ϊ����ֵ��20Ϊ�����������1Ϊ��������� */
sumcol=rv[+, ];
/* ÿһ�н��м��� */
w=rv/sumcol;
create wx from w; /* �ɾ���w����SAS���ݼ�work.wx */
append from w; /* ������w��������䵽���ݼ�work.wx�� */
close wx; /* �ر����ݼ�wx */

use dcomstkrpct(drop=date);
read all var _num_ into x;
x[loc(x=.)]=0; 
create xx from x;
append from x;
close xx;

comrpct=x*w;

create comrpct from comrpct;
append from comrpct;
close comrpct;
show names;
quit;

data comrpct;
set comrpct;
if _n_=1 then delete;
run;

data dcomstkrpct;
set dcomstkrpct;
if _n_=1 then delete;
run;

data porfrpct20;
merge dcomstkrpct comrpct(rename=(col1=portfr20));
run;




