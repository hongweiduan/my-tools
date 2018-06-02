#! /bin/bash
if [ $# -ne 4 ]
then 
    echo "usage $0  <IP_Adderss> <Port> <Log_path> <File_Name>"
    exit 1 
fi  
IP=$1
PORT=$2
PATH=$3
FILENAME=$4
cd $PATH
/usr/bin/ftp -i -n $IP $PORT<<EOF
user user 12345
put $FILENAME $FILENAME 
q
EOF
echo  $FILENAME
echo  $IP
exit 0

