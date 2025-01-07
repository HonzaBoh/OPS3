<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['name'])) {
    $name = htmlspecialchars($_POST['name']);
    setcookie('username', $name, time() + (86400 * 30), "/");
    header("Location: " . $_SERVER['PHP_SELF']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['message']) && isset($_COOKIE['username'])) {
    $message = htmlspecialchars($_POST['message']);
    $name = htmlspecialchars($_COOKIE['username']);
    $entry = "$name: $message" . PHP_EOL;

    $file = 'messages.txt';
    if (!file_exists($file)) {
        file_put_contents($file, "");
    }
    file_put_contents($file, $entry, FILE_APPEND);

    header("Location: " . $_SERVER['PHP_SELF']);
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages</title>
</head>
<body>
    <?php if (!isset($_COOKIE['username'])): ?>
        <h2>Zadejte svůj nick</h2>
        <form method="post">
            <label for="name">Nick:</label>
            <input type="text" id="name" name="name" required>
            <button type="submit">Set nickname</button>
        </form>
    <?php else: ?>
        <h2>Zprávy budete zadávat jako: <?php echo htmlspecialchars($_COOKIE['username']); ?>.</h2>
        <form method="post">
            <label for="message">Zadejte zprávu:</label>
            <input type="text" id="message" name="message" required>
            <button type="submit">Submit</button>
        </form>

        <h3>Zadané zprávy</h3>
        <div>
            <?php
            $file = 'messages.txt';
            if (file_exists($file)) {
                echo nl2br(htmlspecialchars(file_get_contents($file)));
            } else {
                echo "No messages yet.";
            }
            ?>
        </div>
    <?php endif; ?>
</body>
</html>