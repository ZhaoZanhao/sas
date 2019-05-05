

/* SAS中的宏标准格式是：以&开头，以.结束 */

/* 不建立数据集 */
data _null_;
set Sasfindt.Lstkinfo;
a='%a(';  /* 字符a为：%a( */
b=',';    /* 字符b为：,   */
c=');';   /* 字符c为：); */

/* 输出到外部文件sampstock.txt，具体物理路径如下 */
file "F:\sasfindt\sampstock.txt"; 

/* 输入变量a、stkcd、lstknm、c，全部都是字符型变量 */
put a $ stkcd $ b $ lstknm $ c $;
run;

/* 以下是外部文件sampstock.txt的内容 */
/* %a( 000001 , 深发展A );    */
/* %a( 000002 , 万科A );      */
/* %a( 000004 , ST国农 );     */
/* %a( 000005 , 世纪星源 );   */
/* %a( 000007 , ST达声 );     */
/* %a( 000009 , 中国宝安 );   */
/* %a( 000011 , S*ST物业 );   */
/* %a( 000012 , 南玻A );      */
/* %a( 000016 , 深康佳A );    */
/* %a( 000017 , SST中华A );   */
/* %a( 200011 , *ST物业B );   */
/* %a( 200012 , 南玻B );      */
/* %a( 200016 , 深康佳B );    */
/* %a( 200017 , ST中华B );    */
/* %a( 200020 , ST华发B );    */
/* %a( 600601 , 方正科技 );   */
/* %a( 600602 , 广电电子 );   */
/* %a( 600603 , ST兴业 );     */
/* %a( 600604 , *ST二纺机 );  */
/* %a( 600605 , 汇通能源 );   */
/* %a( 600651 , 飞乐音响 );   */


/* 下面进行宏的调试阶段 */

/* 打印宏展开生成的sas语句代码 */

options mprint;

/* 宏a，参数名为a1和a2 */
%macro a(a1,a2);

data stk&a1.(label="&a2.|&a1.");
set sasfindt.qttndist;
if stkcd="&a1.";
run;

%mend a;
%include "F:\sasfindt\sampstock.txt";


/* 宏selstk，宏参数为dat、stkcd、dattxt、x、term、start、endt */
%macro selstk(dat,stkcd,dattxt,x,term,start,endt);

/* 参数dat为逻辑库sasfindt下的一个数据集 */

data _null_;
set sasfindt.&dat.;
a='%dret_stk(';  /* 变量a为：%dret_stk( */
b=',';           /* 变量b为：, */
c=');';          /* 变量c为：); */
x1=&x;           /* 参数x赋值为x1 */
term1=&term;     /* 参数tern赋值为term1 */
start1=&start;   /* 参数start赋值为start1 */
endt1=&endt;     /* 参数endt赋值为endt1 */
trdflg="&dattxt";/* 参数dattxt赋值为trdflg */
%if %upcase(&dattxt)=SHSTK %then %do; /* 如果宏参数为SHstk（这里%upcase函数忽略字符串的大小写），然后做 */
if substr(&stkcd,1,1) in (6,9) or substr(&stkcd,1,2)=99; /* 如果宏参数stkcd的第一个字符是6或者9，或者stkcd的前两个字符为99 */
file "F:\sasfindt\&dattxt..txt"; /* 那么输出到外部文件F:\sasfindt\&dattxt..txt */
put a $ trdflg $ b &stkcd $ b $ x1 $ b $ term1 $ b $ start1 $ b $ endt1 $ c $;
%end;
%if %upcase(&dattxt)=SZSTK %then %do; /* 如果宏参数为SZstk（这里%upcase函数忽略字符串的大小写），然后做 */
if substr(&stkcd,1,1) = 0 or substr(&stkcd,1,2)=20; /* 如果宏参数stkcd的第一个字符是0，或者stkcd的前两个字符为20 */
file "F:\sasfindt\&dattxt..txt"; /* 那么输出到外部文件F:\sasfindt\&dattxt..txt */
put a $ trdflg $ b &stkcd $ b $ x1 $ b $ term1 $ b $ start1 $ b $ endt1 $ c $;
%end;
%mend selstk;

%selstk(Lstkinfo,stkcd,SHstk,'d','日','1990','2005');
run;
%selstk(Lstkinfo,stkcd,SZstk,'d','日','1990','2005');
run;

/* 文件SHstk.txt内容如下 */
/* %dret_stk( SHstk , 600601 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600602 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600603 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600604 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600605 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600651 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600652 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600653 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600654 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600656 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900901 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900902 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900903 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900904 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900905 , d , 日 , 1990 , 2005 ); */

/* 文件SZstk.txt内容如下 */
/* %dret_stk( SZstk , 000001 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000002 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000004 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000005 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000007 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000009 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000011 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000012 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000016 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000017 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200011 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200012 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200016 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200017 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200020 , d , 日 , 1990 , 2005 ); */


/* 宏termendflg，宏参数为dat和date */
%macro termendflg(dat,date);
/* 参数dat是逻辑库sasfindt中的数据集,date是数据集dat中的一个时间变量 */
data termfinflg;
set sasfindt.stk&dat.;
year=year(Date);
qtr=qtr(Date);
month=month(Date);
run;

/* 打标记 */
data termfinflg;
set termfinflg;
last_y=last.year; 
last_q=last.qtr; 
last_m=last.month;
by year qtr month;
run;
%mend termendflg;

/* 新建work.dr_sh数据集，将stk600601中的大于等于1990并且小于等于2005年的时间截取 */
%let start=1990;
%let endt=2005;
data dr_sh(keep=date);
set stk600601;
if &start<=year(date)<=&endt;
run;

/* 宏dret_stk */
%macro dret_stk(dattxt,stkcd,x,term,start,endt);
/* 宏参数dattxt代表：上证\深证 */
/* 宏参数stkcd代表：股票 */
/* 宏参数x代表：d */
/* 宏参数term代表：日 */
/* 宏参数start代表：起始年份 */
/* 宏参数endt代表：终止年份 */

/* 调用宏termendflg */
/* 宏参数stkcd代表的是：股票代码 */
%termendflg(&stkcd);


/* 新建work.dret_stk数据集，保留date、adjclpr、r_pct、r_log */
/* 并且将r_log的标签设置为：日收益率 */
data &x.ret_stk(keep=date adjclpr r_pct r_log label="&term.收益率");
set termfinflg; 
if &start<=year(date) <= &endt; /* 如果时间范围在1990到2005的范围内 */
adjclpr=clpr*mcfacpr; /* 调整股价=价格乘以累积股价调整因子 */
r_pct=dif(adjclpr)/lag(adjclpr); /* 日百分比收益率 */
r_log=log(adjclpr)-log(lag(adjclpr)); /* 日对数收益率 */
run;

/* 新建（work.drstk+股票代码）数据集 */
data &x.rstk&stkcd; 
set &x.ret_stk;
where r_pct^=. and r_log^=.; 
/* 选取日百分比收益率和日对数收益率均不为缺失值的观测 */
run;

/* 将work.dr_sh数据集和（work.drstk+股票代码）数据集进行合并 */
/* 合并到数据集work.dr_sh中，将r_pct重命名为（rpct+股票代码），将r_log重命名为（rlg+股票代码） */
/* 按照变量date进行合并 */
data dr_sh(rename=(r_pct=rpct&stkcd r_log=rlg&stkcd));
merge dr_sh &x.rstk&stkcd;
by date;
run;

/* 进行变量处理 */
data dr_sh; 
set dr_sh;
if rpct&stkcd=. then rpct&stkcd=0; /* 如果（rpct+股票代码）为缺失值，那么将（rpct+股票代码）赋值为0 */
else rpct&stkcd=rpct&stkcd; /* 否则（rpct+股票代码）为自己本身 */
if rlg&stkcd=. then rlg&stkcd=0; /* 如果（rlg+股票代码）为缺失值，那么将（rlg+股票代码）赋值为0 */
else rlg&stkcd=rlg&stkcd; /* 否则（rlg+股票代码）为自己本身 */
run;

%mend dret_stk;

/* 文件SHstk.txt内容如下 */
/* %dret_stk( SHstk , 600601 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600602 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600603 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600604 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600605 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600651 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600652 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600653 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600654 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 600656 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900901 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900902 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900903 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900904 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SHstk , 900905 , d , 日 , 1990 , 2005 ); */

%include "F:\sasfindt\SHstk.txt";
run;


data dr_sz(keep=date);
set stk000001;
if &start<=year(date)<=&endt;
run;

%macro dret_stk(dattxt,stkcd,x,term,start,endt);

%termendflg(&stkcd);

data &x.ret_stk(keep=date adjclpr r_pct r_log label="&term.收益率");
set termfinflg; 
if &start<=year(date) <= &endt;
adjclpr=clpr*mcfacpr; 
r_pct=dif(adjclpr)/lag(adjclpr);
r_log=log(adjclpr)-log(lag(adjclpr));
run;

/* 新建（work.drstk+股票代码）数据集 */
data &x.rstk&stkcd; 
set &x.ret_stk;
where r_pct^=. and r_log^=.; 
/* 选取日百分比收益率和日对数收益率均不为缺失值的观测 */
run;

data dr_sz(rename=(r_pct=rpct&stkcd r_log=rlg&stkcd));
merge dr_sz &x.rstk&stkcd;
by date;
run;

/* 进行变量处理 */
data dr_sz; 
set dr_sz;
if rpct&stkcd=. then rpct&stkcd=0;
else rpct&stkcd=rpct&stkcd;
if rlg&stkcd=. then rlg&stkcd=0;
else rlg&stkcd=rlg&stkcd;
run;

%mend dret_stk;

/* 文件SZstk.txt内容如下 */
/* %dret_stk( SZstk , 000001 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000002 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000004 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000005 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000007 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000009 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000011 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000012 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000016 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 000017 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200011 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200012 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200016 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200017 , d , 日 , 1990 , 2005 ); */
/* %dret_stk( SZstk , 200020 , d , 日 , 1990 , 2005 ); */

%include "F:\sasfindt\SZstk.txt";
run;

/* 宏参数x、start、endt */
%macro a(x,start,endt);
/* 选取合适年份的股票放到work.a中 */
data a;
set sasfindt.Lstkinfo;
if &start<=year(Lstdt)<=&endt;
run;

/* 新建work.dat1990_2005这个数据集 */
data dat%eval(&start)_%eval(&endt);
set a;
a='%a('; /* 变量a为：%a( */
c=");";  /* 变量c为：); */
put a $ stkcd $ c $;
run;

/* 创建_tmp_视图 */
/* ranuni函数返回均匀分布的随机变量 */
proc sql noprint;
create view _tmp_ as select *, ranuni(3) as _ran_ 
from a 
order by calculated _ran_; /* 按照_ran_的值进行升序排列 */
quit;

/* 新建random数据集 */
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


/* 宏shszretcom */
%macro shszretcom(x);

proc sql;
/* 创建shsz_dr数据集 */
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
/* 0为种子值，20为随机数个数，1为随机数列数 */
sumcol=rv[+, ];
/* 每一列进行加总 */
w=rv/sumcol;
create wx from w; /* 由矩阵w创建SAS数据集work.wx */
append from w; /* 将矩阵w的数据填充到数据集work.wx中 */
close wx; /* 关闭数据集wx */

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




