// version:<<V1>>
// 1.add some code
// 2.fix some bug
// version:<<V2>>
// 1.add some code
// 2.fix some bug
// version:<<E22>>
// 1.add some code
// 2.fix some bug
version:<<V3>>
// relase version

GROUP,TID,DESCRIPTION,FUNCTION,TIMEOUT,PARAM1,PARAM2,UNIT,LOW,HIGH,KEY,VAL

// with the normal testplan format 

FIXTURE_INIT,RESET_FIXTURE,,reset.reset,10000,,,,,,,


//FIXTURE_INIT,SD_CARD_OUT,,control.SDCardOut,10000,,,,,,,
-- GET_S_BUILD,S_BUILD,,querysfc.getsbuild,10000,[[scanned_sn]],<<S_BUILD>>,,,,,


// because SFC not ready, So skip it！
** cheCK_MaC_miNI,hw version,,version.macCheck,,hw,,,,,,
** check mac mini,oS_VerSiON,,version.macCheck,,os,,,,,,

// with the key words
g:fixture init,n:sd card in,f:control.SDCardOut,
n:delay 10s,f:fixture.delay,p1:10000,t:15000,u:ms,

g:reset fixture,n:reset power board,f:reset.reset,t:20000,l:10,h:50,

//this line had a invalid functions,will return a fail!
n:delay 10s ,f:fixture.bbb,p1:10000,t:15000,u:ms,


