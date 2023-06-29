# /bin/bash
# allen.tsai
# dbt for dolphin worker    
# Projects need to Upload Resoures by DolphinScheduler UI ex.jaffle_shop.tgz

# example: dbt.sh jaffle_shop

project="parallel_test"
model=$1

if [[ -d /workspace ]];then # -d file : File does exist and is directory.
    tar xvf $project.tgz -C /workspace
else
    echo -e 'no such workspace directory'
fi
cd /workspace/$project && dbt debug
RC=$?
if [[ $RC == 0 ]]; then
    cd /workspace/$project && dbt run --select $model
else
    echo -e 'profile or project files Error'
fi