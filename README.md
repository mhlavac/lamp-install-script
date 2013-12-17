MHlavac Symfony2 Ubuntu 13.10 LAMP
==================================

Get started in minutes. Say no more to days of setting your programming environment and finding everything yourself.

This LAMP configuration allows you to install your working environment in few minutes. It's completely open source (MIT license), this means you can check what this
installation does and you can see for yourself that it is not going to track your work in any way.

MHlavac Symfony2 LAMP is created with Virtual servers in mind and that should be your main platform where to use this script.

You can still use it on your workstation, but you should use plugins separately to change only parts of your system.

Installation guide
==================

You can install everything in one simple step:

``` sh
curl https://raw.github.com/mhlavac/lamp-install-script/master/run.sh | sudo sh
```

How to create new project
-------------------------

How to create new project in LAMP? It's just one step and you can start working.

``` sh
mkdir -p /var/www/website.example/web
```

In this command we created a `website.example` directory in `/var/www` directory. Any directory created in `/var/www` will automaticaly
create a new *Apache2 Virtual Host* and new *Bind 9 zones settings* for this directory.

That said, if you create `website.example` directory a new virtualhost on address webiste.example is created. You can access it in your browser
via this URL address: `http://website.example`.

Currently the website does not have any index page. To test it out you can simply create one with following command:

``` sh
echo "Hello on your website example" > /var/www/example/website/web/index.html
```

What is inside?
===============

* *PHP 5.5.x*
    * composer
    * pear
    * pecl
* *node.js*
    * npm
    * yeoman
    * grunt (contrib-sass, contrib-coffee)
    * bower
* *Apache2*
    * mod_rewrite - Nice urls example.com/<strong>something</strong>
    * vhost_alias - More advanced virtualhost settings
    * xsendfile - File provisioning (you can send your files through PHP with ease)
* Code versioning
    * *git*
* Continuous integration
    * Jenkins CI - Accesible at jenkins.lamp
* Databases and caches
    * *Memcached* - Fast key-value cache
    * *MySQL* - SQL database
        * phpmyadmin accesable at http://mysql.lamp
    * *PostgreSQL* - SQL database
    * *MongoDB* - Document database
        * rockmongo accesable at http://mongo.lamp
* Build tools
    * *ant*
    * *gradle*
* System utilities
    * *Etckeeper* - Backups your LAMP's system settings in local git
    * *jdk7* - Java development kit (needed for jenkins ci)
    * *Samba* - Share files with windows
    * *wkhtmltopdf* - Generates pdf from given url
    * *postfix* - Sends emails

License
=======

This project is under MIT license, you can use it for free for any means. You can also alter it as you like ;-)

Thank you
=========

Lastly i want to thank you for reading to this point and for using my LAMP configuration. If you have any ideas or if you found any bugs please report
them as issues on github.
