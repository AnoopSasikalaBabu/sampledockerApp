#!/bin/sh

# In real world we'd clear the database between runs since not all our tests clean up after themselves properly

# echo Resetting database
# wget --spider -q -T 90 $RESET_DB

echo "Executing tests"
#pabot --processes 3 --outputdir ./results ./robot/tests/
#pabot --processes 3 --outputdir /usr/local/bin/rslt  Cust*.robot
#cd  /usr/local/bin/
#tar xvzf UIV3.tar

cd  /usr/local/bin/UIV3/src
pabot --processes 1 --outputdir /usr/local/bin/rslt --output outputs01.xml  Cust*.robot

if [ $? -eq 0 ]
then
  echo "Tests successful, skipping rerun"
  exit 0
fi

for COUNT in 1 2 3
do
  echo "Some tests failed, starting $COUNT. rerun"
  
  #echo "Resetting database"
  # wget --spider -q -T 90 $RESET_DB

  if [ $? -ne 0 ]
  then
    echo "Error resetting database before rerun"
    exit 1
  fi

  echo "Executing failed tests"
  cd rslt
  pabot --processes 2 --rerunfailed /usr/local/bin/rslt/outputs01.xml --outputdir /usr/local/bin/rslt --output outputs01re.xml  TC*.robot  

  echo "Merging results"
  cd rslt	
  rebot --merge outputs01.xml outputs01re.xml

  if [ $? -eq 0 ]
  then
    echo "All tests passed"
    break
  fi
done
