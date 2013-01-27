MHlavac Symfony2 lamp
=====================

Get started in minutes. Say no more to days of setting your programming environment and finding everything yourself.

This LAMP configuration allows you to install your working environment in few minutes. It's completely open source (MIT license), this means you can check what this
installation does and you can see for yourself that it is not going to track your work in any way.

MHlavac Symfony2 LAMP is created in Virtual servers in mind and that should be your main platform where to use this scripts. You can still use it on your workstation,
but check the plugins as it does few changes to `rc` in installation process to make the terminal little friendlier to new comers :-)

Installation guide
==================

You can install everything in one simple step:

``` sh
curl https://raw.github.com/mhlavac/lamp-install-script/master/run.sh | sudo sh
```

How to create new project
-------------------------

How to create new project in LAMP? It's quite easy, it takes only one step and your site is up and you can start working.

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

License
=======

This project is under MIT license, you can use it for free for any means. You can also alter it as you like ;-)

Thank you
=========

Lastly i want to thank you for reading to this point and for using my LAMP configuration. If you have any ideas or if you found any bugs please report
them as issues on github.
