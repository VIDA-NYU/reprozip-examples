Website built with Django
=========================

This example is a web application written using the Django web framework. It can easily be run again on different machines or in the cloud.

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/nc9ipxmtalj9dy1lbeb0r4xp9s95pc48) (19 MB). The administrative interface is setup at `/admin/` with username `admin` and password `adminadmin`.

Django Blog
-----------

This is an example implementation of the [Django Girls Tutorial](http://tutorial.djangogirls.org/en/). The code can be found [here on GitHub](https://github.com/remram44/djangogirls-blog-tutorial). It doesn't do much, just display a list of blog posts and allow the admin to edit them or post new one, but is a realistic small web application with dynamic content (stored in a SQLite3 database).

How to Reproduce
----------------

The server can be started as follows:

    $ reprounzip docker setup djangogirls_blog.rpz blog/
    $ reprounzip docker --docker-option=-p --docker-option=8000:8000 run blog/

Note that we need to pass `-p 8000:8000` to Docker for it to expose the port from the container. You can then access the website at `http://127.0.0.1:8000/` (or at your docker-machine's IP). The administrative interface is setup at `http://127.0.0.1:8000/admin/` with username `admin` and password `adminadmin`.
