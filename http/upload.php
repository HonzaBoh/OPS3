<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>PHP folder</title>
</head>
<body>
  <h1>PHP directory write test</h1>

  <p>
    This page expects a directory named <strong>inputs</strong> in the <em>same folder</em> as this page.
    On each refresh it will try to create a new text file inside it.
  </p>

  <pre>
<?php
$dir = "inputs";

/* 1) Check directory exists */
if (!is_dir($dir)) {
    echo "ERROR: Directory '$dir' does not exist.\n";
    echo "Create it in the same directory as this page.\n";
    exit;
}

/* 2) Check directory is writable by the web server user (www-data) */
if (!is_writable($dir)) {
    echo "ERROR: Directory '$dir' is not writable.\n";
    echo "Fix ownership/permissions so Apache (www-data) can write into it.\n";
    exit;
}

/* 3) Create a new file each request */
$filename = $dir . "/input_" . date("Ymd_His") . "_" . bin2hex(random_bytes(3)) . ".txt";
$content  = "Created at: " . date("Y-m-d H:i:s") . "\n";
$content .= "Written by PHP running under Apache.\n";

$result = file_put_contents($filename, $content);

/* 4) Report result */
if ($result === false) {
    echo "ERROR: Failed to create file:\n$filename\n";
    echo "Check Apache error log for details.\n";
} else {
    echo "SUCCESS: Created file:\n$filename\n";
    echo "Bytes written: $result\n";
}
?>
  </pre>

</body>
</html>
