#! /bin/bash
#cd $1
#texindy -C utf8 -M style1.xdy xfhl-top.idx
#texindy -C utf8 -M style1.xdy xfhl-per.idx

makeindex xfhl-top.idx
makeindex xfhl-per.idx

exit 0
