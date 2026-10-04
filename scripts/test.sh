#!/usr/bin/env bash

for file in test/*; do
	expected_return="$(basename "$file")"
	expected_return="${expected_return:0:1}"
	if [[ "$expected_return" = "y" || "$expected_return" = "i" ]]; then
		expected_return=0
	else
		expected_return=1
	fi
	(./a.out < "$file") > /dev/null 2>&1 
	if [[ "$expected_return" != "$?" ]];then
		echo "$file FAILED"
		(( failed+=1 ))
	fi
done
echo "$failed"
