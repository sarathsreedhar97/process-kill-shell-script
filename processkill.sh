
#!/bin/sh

check_mem_val=5.0
check_cpu_val=5.0

while(true)
do
  ps -e -o pmem=,pcpu=,pid=,user=,comm= --sort=-pmem |
  while read size cpu pid user comm
  do
    kill_mem=0
    kill_cpu=0
    if [ "$user" = "ctse@ctse-39" ]
    then
      kill_mem=$( echo "$size>$check_mem_val" | bc )
      kill_cpu=$( echo "$cpu>$check_cpu_val" | bc )
      if [ "$kill_mem" = "1" ]
      then
        kill $pid
      elif [ "$kill_cpu" = "1" ]
      then
        kill $pid 
      else
        continue
      fi
    fi
  done
  sleep 1
done
