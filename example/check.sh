#!/bin/bash

TOTAL=0
# Segment 1: Users/Groups
SEG1=0
if id exam &>/dev/null && grep -q "ops" /etc/group && \
   id exam | grep -qE '\bops\b' && id exam | grep -qE '\busers\b' && \
   id kali | grep -qE '\bops\b'; then
  SEG1=1
fi
TOTAL=$((TOTAL + SEG1))
echo "User & Group Setup: $SEG1"

# Segment 2: Default Shell
SEG2=0
if getent passwd exam | grep -q "/bin/bash"; then
  SEG2=1
fi
TOTAL=$((TOTAL + SEG2))
echo "Default Shell Check: $SEG2"
SEG3=0
if [ -f Movies.txt ]; then
  if [ -f task1 ]; then
    expected1=$(head -n 20 Movies.txt | sort)
    actual1=$(cat task1)
    if diff <(echo "$expected1") <(echo "$actual1") &>/dev/null; then
      SEG3=$((SEG3+1))
    fi
  fi
  if [ -f task2 ]; then
    expected2=$(cut -d ";" -f 1 Movies.txt | nl)
    actual2=$(cat task2)
    if diff <(echo "$expected2") <(echo "$actual2") &>/dev/null; then
      SEG3=$((SEG3+1))
    fi
  fi
fi
TOTAL=$((TOTAL + SEG3))

echo "Command Task Checks: $SEG3"


# Segment 4: SSH Server Check
SEG4=0
SEG10=0
if dpkg -l | grep -q openssh-server && systemctl is-active --quiet ssh; then
  SEG4=1
	if [[ -f logged ]]; then
		if grep "192.168.56.1" logged &>/dev/null; then
			SEG10=1
		fi
	fi
fi
TOTAL=$((TOTAL + SEG4 + SEG10))
echo "SSH:: $SEG4"
echo "Log_SSH:: $SEG10"
# 
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
# Final Output
echo "----------------------------"
echo "TOTAL SCORE: $TOTAL / 8"
echo "----------------------------"

