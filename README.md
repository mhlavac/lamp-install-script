MHlavac symfony2 lamp
=====================

I use this script to setup my ubuntu workstation... it's LAMP with MySQL and Mongodb... it also does a nice Virtual Host trick how i can test lots of different domains on my workstation.

This script can be also used for virtual servers. If you don't believe already prepared virtual servers with PHP, MySQL and Mongo already preconfigures, you can use this script to create your own environment in minutes and you can be 100% sure that there is nothing that might harm you in future.

BE AWARE
========

I still work on this script and as such it can contain some bugs... Feel free to report issues, or request new features.

Login
-----

username: **lamp**
password: **lamp**

You are in sudoers group... so don't worry and do anything you want ;-)

How to create new domains
-------------------------

It's really simple to create new domains and test them out. Just create directory with your domain in `/var/www` like this:

``` sh
mkdir -p /var/www/example/website/web
```

Then create a index.html file containing *Hello on your website example* by using following command:

``` sh
echo "Hello on your website example" > /var/www/example/website/web/index.html
```

Lastly alter your hosts so you domain is accessible by following command:

``` sh
sudo echo "127.0.0.1 website.example" >> /etc/hosts
```

You can now see the website in your browser by entering *http://webiste.example*

What next
---------

I am currently thinking about script which would create new webiste for you... Also i would love to create bind9 configuration which would take care about resolving your local domains for you.
