#!/bin/bash
# Script to check Linux final exam results and assign points by segment

TOTAL=0

echo "--- Checking Exam Segments ---"

# Segment 1: Users/Groups/Permissions
SEG1=0
if id ops &>/dev/null && id kali &>/dev/null && grep -q "finals" /etc/group; then
  if id ops | grep -qE 'groups=.*\bfinals\b.*\bsudo\b' && id kali | grep -qE '\bfinals\b'; then
    if [ -d /home/ops ] && [ "$(stat -c %G /home/ops)" = "finals" ] && [ "$(stat -c %A /home/ops)" =~ g.w ]; then
      SEG1=2
    else
      SEG1=1
    fi
  fi
fi
TOTAL=$((TOTAL + SEG1))
echo "Users/Groups/Perms: $SEG1 b"

# Segment 2: Files and Commands
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
  last_line=$(tail -n 1 task2)
  if [ "$last_line" = "$group_count" ]; then
    check2=true
  fi
fi

if $check1 && $check2; then SEG2=2
elif $check1 || $check2; then SEG2=1
fi
TOTAL=$((TOTAL + SEG2))
echo "Commands: $SEG2 b"

#3 archives
SEG3=0
if [ -d ~/archive ]; then
  if [ -f ~/archive/final.tar ] && ls ~/archive/*.txt &>/dev/null; then
    SEG3=2
  else
    SEG3=1
  fi
fi
TOTAL=$((TOTAL + SEG3))
echo "Archives: $SEG3 b"

# UFW config
SEG4=0
if ufw status | grep -q "Status: active"; then
  SEG4=2
fi
TOTAL=$((TOTAL + SEG4))
echo "UFW Setup: $SEG4 b"

# Final total
echo "----------------------------"
echo "TOTAL SCORE: $TOTAL / 8"
echo "----------------------------"
