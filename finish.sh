#!/bin/bash

output_file="Tasks"
echo "# Spojene soubory" > "$output_file"
echo >> "$output_file"

for i in {1..3}; do
    file="task$i.sh"
    echo "##############################" >> "$output_file"
    echo "# TASK $i" >> "$output_file"
    if [ -f "$file" ]; then
        echo "# !/bin/bash" >> "$output_file"
        cat "$file" >> "$output_file"
    else
        echo "# Soubor '$file' nenalezen." >> "$output_file"
    fi
    echo >> "$output_file"
done

echo "Vsechny ukoly spojene do souboru '$output_file'."
