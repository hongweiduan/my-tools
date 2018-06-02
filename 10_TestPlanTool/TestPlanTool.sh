basepath=$(cd `dirname $0`; pwd)

######### the path setting ######### 
codePath=${basepath}/testplanToolCode/ # must: the testplanToolCode path
# echo ${codePath}
# TestMangerDic=${basepath}/TestplanToolTest/TestManger/ # must: the testManger directory path
# TestMangerDic=$2 # must: the testManger directory path
# echo ${TestMangerDic}
# TestPlanPath=${basepath}/TestplanToolTest/TestPlan__P1.c # must: the testPlan raw file path
# TestPlanPath=$1 # must: the testPlan raw file path
# echo ${TestPlanPath}



####### running code ############
# TestPlanTmpPath=${TestMangerDic}"Profile/"${TestPlanPath##*/}
TestPlanTmpPath=$1
# echo ${TestPlanTmpPath}
TestPlanToolFile=${codePath}getTestPlan.lua
# echo ${TestPlanToolFile}

cd ${codePath}
# cp ${TestPlanPath} ${TestPlanTmpPath}
/usr/local/bin/lua ${TestPlanToolFile} -f ${TestPlanTmpPath} -i -b
sleep 0.01
# rm ${TestPlanTmpPath}
