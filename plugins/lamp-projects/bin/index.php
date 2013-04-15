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

    foreach (scandir('/var/www') as $directoryName) {
        if (0 === strpos($directoryName, '.')) {
            continue;
        }

        echo "<li><a href=\"http://$directoryName\">$directoryName</a></li>";
    }
    ?>
    </ul>

    <p>Create new directory in /var/www to create new project.</p>
</body>
</html>
