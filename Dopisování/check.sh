#!/bin/bash

TOTAL=0
SEG1=0
if id logger &>/dev/null && grep -q "logteam" /etc/group && \
   id logger | grep -qE '\blogteam\b' && id logger | grep -qE '\bsudo\b' && \
   id kali | grep -qE '\blogteam\b'; then
  SEG1=1
fi
TOTAL=$((TOTAL + SEG1))
echo "User & Group Setup: $SEG1"
SEG2=0
if getent passwd logger | grep -q "/bin/bash"; then
  SEG2=1
fi
TOTAL=$((TOTAL + SEG2))
echo "Default Shell: $SEG2"
SEG3=0
if [ -f SystemLogs.txt ]; then
  if [ -f task1 ]; then
    expected1=$(grep ERROR SystemLogs.txt | head -15)
    actual1=$(cat task1)
    if diff <(echo "$expected1") <(echo "$actual1") &>/dev/null; then
      SEG3=$((SEG3+1))
    fi
  fi
  if [ -f task2 ]; then
    expected2=$(cut -d ";" -f 3 SystemLogs.txt | sort -u)
    actual2=$(cat task2)
    if diff <(echo "$expected2") <(echo "$actual2") &>/dev/null; then
      SEG3=$((SEG3+1))
    fi
  fi
fi
TOTAL=$((TOTAL + SEG3))
echo "Task Checks: $SEG3"

SEG5=0
if [[ -d Downloads/archive/data ]]; then
	echo "funugje"
	SEG5=1
	if [[ -h ops  ]]; then
		SEG5=2
	fi
fi
TOTAL=$((TOTAL + SEG5))
echo "Link & Archive:: $SEG5"

SEG4=0
if ufw status | grep -q "Status: active"; then
  SEG4=1
  if ufw status | grep -q "ALLOW" && ufw status | grep -q "DENY"; then
  	SEG4=2
  fi
fi
TOTAL=$((TOTAL + SEG4))
echo "UFW Setup: $SEG4"

echo "----------------------------"
echo "TOTAL SCORE: $TOTAL / 8"
echo "----------------------------"
