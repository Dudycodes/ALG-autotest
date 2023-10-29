#!/usr/bin/env bash

# Name: ALG-autotest test_script.sh
# Author: dudacek_t
# Version: 1.0 (29.10.2023)
# Licence: MIT

function usage() {
  printf "Usage: \n %s [-h] -m <relative path to main> -t <relative path to test folder>\n" "$(basename "$0")"
}
# colour def
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[1;32m'

# check arguments
no_args_a=true
no_args_b=true
while getopts "hm:t:" opt; do
  case $opt in
    # main path
    m)TEST_FILE="${OPTARG}"
      # check file existence
      if [[ -f "$TEST_FILE" ]]
      then
        no_args_a=false
        echo "Path to main set as: $OPTARG"
      else
        echo -e "${RED} Wrong path to main ${NC}"
      fi
      ;;
    # test files
    t)INS_OUTS="${OPTARG}"
      # check dir existence
      if [[ -d "$INS_OUTS" ]]; 
      then 
        no_args_b=false
        echo "path to test data folder set as: $OPTARG"
      else
        echo -e "${RED} Wrong path to test files ${NC}"
      fi
      ;;
    # help
    h) 
      usage
      exit 0
      ;;
  esac
done

# check if arguments were given
if [[ "$no_args_a" == true ]] || [[ "$no_args_b" == true ]]
then
  usage
  exit 0;
fi

# list test files
INS_LST=($(ls ./"$INS_OUTS"pub*.in ))

# stats cc
correct_cc=0
wrong_cc=0

# run tests
for IN in "${INS_LST[@]}"
do
  out_fname="${IN/.in/_my.out}"
  echo "TESTING WITH INPUT FILE $IN :"
  ./"$TEST_FILE" < "$IN" > "$out_fname"
  dif_res=$(diff "${IN/.in/.out}" "$out_fname")
  if [ "${#dif_res}" -gt 0 ] 
  then
    echo -e "${RED} outputs do not match - diff result (< should be; > is): ${NC}"
    echo "$dif_res"
    wrong_cc="$((wrong_cc + 1))"
  else
    echo -e "${GREEN} correct - outputs match ${NC}"
    correct_cc="$((correct_cc + 1))"
  fi
done

echo -e "\nSTATS: $correct_cc out of ${#INS_LST[@]} were correct!"

# KEEP UP THE GOOD WORK!
if [ "$wrong_cc" -eq 0 ]
then
  echo "CONGRATS! *symbolic PAT PAT PAT on your back*"
fi


