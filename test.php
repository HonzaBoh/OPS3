<?php
$dir = "storage";
$filename = $dir . "/data_" . time() . ".txt";

/* 1 MB of data */
$data = str_repeat("A", 1024 * 1024);

file_put_contents($filename, $data);

echo "<h1>File created</h1>";
echo "<p>$filename</p>";
?>
