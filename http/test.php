<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8">
  <title>PHP write permission test</title>
</head>
<body>
  <h1>PHP file write test</h1>

  <pre>
<?php
$file = "test.txt";

if (!file_exists($file)) {
    echo "ERROR: File 'test.txt' does not exist.\n";
    echo "Create the file in the same directory as this page.\n";
    exit;
}


$result = file_put_contents(
    $file,
    date("Y-m-d H:i:s") . " - line written by PHP\n",
    FILE_APPEND
);

if ($result === false) {
    echo "ERROR: Cannot write to 'test.txt'.\n";
} else {
    echo "SUCCESS: Line appended to 'test.txt'.\n";
}
?>
  </pre>

</body>
</html>
