<?php
    $projects = [];

    foreach (new DirectoryIterator('/var/www') as $fileInfo) {
        if (!$fileInfo->isDot() && $fileInfo->isDir()) {
            $projects[] = $fileInfo->getFilename();
        }
    }
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Projects | Lamp</title>
</head>
<body>
    <h1>Lamp's Projects</h1>
    <ul>
    <?php
        foreach ($projects as $project) {
            echo '<li><a href="http://' . $project . '">' . $project . '</li>';
        }
    ?>
    </ul>

    <p>You can create new project by creating new directory in <strong>/var/www</strong>.</p>
</body>
</html>
