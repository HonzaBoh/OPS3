#!/bin/bash

TOTAL=0

echo "--- Kontrola ---"

#Uzivatele
SEG1=0
if id ops &>/dev/null && id kali &>/dev/null && grep -q "finals" /etc/group; then
  if id ops | grep -qE '\bfinals\b' && id ops | grep -qE '\bsudo\b' && id kali | grep -qE '\bfinals\b'; then
    if [ -d /home/ops ] && [ "$(stat -c %G /home/ops)" = "finals" ] && [[ $(stat -c %A /home/ops) == *w* ]]; then
      SEG1=2
    else
      SEG1=1
    fi
  fi
fi
TOTAL=$((TOTAL + SEG1))
echo "Users/Groups/Permissions: $SEG1 b"

#Prikazy
SEG2=0
check1=false
check2=false

if [ -f task1 ]; then
  expected=$(ls -l /etc 2>/dev/null | sort -k5 -n | awk '{print $9}' | grep -v '^$')
  actual=$(awk '{print $9}' task1 | grep -v '^$')
  if diff <(echo "$expected") <(echo "$actual") &>/dev/null; then
    check1=true
  fi
fi

if [ -f task2 ]; then
  group_count=$(wc -l < /etc/group)
  last_line=$(tail -n 1 task2 | awk '{print $1}')
  if [ "$last_line" = "$group_count" ]; then
    check2=true
  fi
fi

if $check1 && $check2; then SEG2=2
elif $check1 || $check2; then SEG2=1
fi
TOTAL=$((TOTAL + SEG2))
echo "Commands: $SEG2 b"

# Archivy
SEG3=0
if [ -d ~/archive ] && ls ~/archive/*.txt &>/dev/null; then
  if [ -f ~/archive/final.tar ]; then
    SEG3=2
  else
    SEG3=1
  fi
fi
TOTAL=$((TOTAL + SEG3))
echo "Archivy: $SEG3 b"

# Segment 4: UFW Configuration
SEG4=0
if ufw status | grep -q "Status: active"; then
  SEG4=2
fi
TOTAL=$((TOTAL + SEG4))
echo "UFW Setup: $SEG4 b"

# Final total
echo "----------------------------"
echo "TOTAL : $TOTAL / 8"
echo "----------------------------"
