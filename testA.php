<?php
header('Content-Type: text/html; charset=UTF-8');

$message = "";  // Pro uložení zprávy pro uživatele

if (isset($_POST['button'])) {
    // Název souboru, do kterého budeme zapisovat
    $filename = "time.txt";
    
    // Otevře (vytvoří) soubor pro přidávání (append)
    $fileHandle = @fopen($filename, "a");
    
    if ($fileHandle) {
        // Získáme aktuální čas
        $timestamp = date("Y-m-d H:i:s");
        
        // Zapíšeme čas + nový řádek
        fwrite($fileHandle, $timestamp . "\n");
        
        fclose($fileHandle);
        
        $message = "Čas byl úspěšně zapsán do souboru <strong>$filename</strong>.";
    } else {
        $message = "Nepodařilo se otevřít nebo vytvořit soubor <strong>$filename</strong>.";
    }
}
?>
<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="UTF-8">
    <title>Vytvořit (pokud neexistuje) jeden soubor a zapsat do něj čas</title>
</head>
<body>
    <h1>Vytvoření souboru a zapsání času</h1>
    <form method="post">
        <button type="submit" name="button">Zapsat čas do souboru</button>
    </form>

    <?php if (!empty($message)): ?>
        <p><?php echo $message; ?></p>
    <?php endif; ?>

    <p><small>Pokud soubor neexistoval, vytvoří se automaticky. Další kliknutí připíše další čas na konec souboru.</small></p>
</body>
</html>
