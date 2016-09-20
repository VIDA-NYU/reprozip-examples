Django Blog
===========

This is an example of a web application written using the [Django](https://www.djangoproject.com/) web framework. It can easily be run again on different machines or in the cloud.

Implementation
--------------

The blog is an implementation of the [Django Girls Tutorial](http://tutorial.djangogirls.org/en/), and the code can be found [here](https://github.com/remram44/djangogirls-blog-tutorial). The website simply displays a list of blog posts and allows the admin to edit them or post new messages. Although simple, this website is a realistic small web application with dynamic content stored in a SQLite3 database.

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/nc9ipxmtalj9dy1lbeb0r4xp9s95pc48) (19 MB). The administrative interface is setup at `/admin/` with username `admin` and password `adminadmin`.

How to Reproduce
----------------

The server can be started as follows:

    $ reprounzip docker setup djangogirls_blog.rpz blog/
    $ reprounzip docker run blog/ --docker-option=-p --docker-option=8000:8000

Note that you need to pass `-p 8000:8000` to Docker for it to expose the port from the container. You can then access the website at `http://IP:8000/`, where `IP` is your docker-machine's IP address (which can be retrieved by running `docker-machine ip`). The administrative interface is setup at `http://IP:8000/admin/` with username `admin` and password `adminadmin`.

How to Run in the Cloud
-----------------------

Running the website in a cloud server is just a matter of provisioning and using a cloud instance. For example, using [docker-machine](https://docs.docker.com/machine/) to run on [AWS](https://aws.amazon.com/), you can use the following:

    $ docker-machine create --driver amazonec2 --amazonec2-access-key AWS_ID --amazonec2-secret-key AWS_KEY aws01
    $ eval $(docker-machine env aws01)
    $ reprounzip docker setup djangogirls_blog.rpz blog-aws/
    $ reprounzip docker run -d blog-aws/ --docker-option=-p --docker-option=80:8000
    $ docker ps

where `AWS_ID` is the AWS Access Key ID and `AWS_KEY` is the AWS Secret Access Key.
