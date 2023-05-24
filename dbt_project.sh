# /bin/bash
# allen.tsai
# dbt for dolphin worker    
# Projects need to Upload Resoures by DolphinScheduler UI ex.jaffle_shop.tgz

# example: dbt.sh jaffle_shop

project=${1:-'coffee_shop'}

if [[ -d /workspace ]];then
    tar xvf $project.tgz -C /workspace
else
    echo -e 'no such workspace directory'
fi
cd /workspace/$project && dbt debug
RC=$?
if [[ $RC == 0 ]]; then
    cd /workspace/$project && dbt seed && dbt run
else
    echo -e 'profile or project files Error'
fi