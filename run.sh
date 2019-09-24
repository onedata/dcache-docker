#!/bin/sh

# Wait for postgres to become online
printf "Wating for postress to become online"
while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/localhost/5432 2>&1' 2>&1 ; do 
  printf "."
  sleep 1
done

# Poor man way to wait for postgress to intialize
while true ; do 
  dcache database update
  if [ $? = 0 ]; then
    break
  fi 
  sleep 10
done

# Init and start
dcache database update
dcache start

# While lock exitsts we assume dcachae is running
lock=$(dcache property dcache.paths.lock.file) ;
while [ -f "$lock" ]; do sleep 10 ; done ;