Stacked Up
==========

[Stacked Up](http://stackedup.org/) is a website created to explore the textbook inventory of Philadelphia public schools, where citizens can check the book records at neighborhood schools. This web application was written using the [Django](https://www.djangoproject.com/) web framework, and all the data is stored under a local PostgreSQL database. It can easily be run again on different machines or in the cloud.

Implementation
--------------

The website can be accessed [here](http://stackedup.org/), and the original implementation of the website is available [here](https://github.com/merbroussard/sdp_curricula). However, the ReproZip package that we provide is based on a [fork](https://github.com/fchirigati/sdp_curricula) of the original project implementation, which fixes some issues, such as missing dependencies.

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/6th8wz15byzm2etkpbwkmtabggfgj5ei) (58 MB).

In the original implementation, to locally run the web application, one needs to run the following:

    $ ./manage.py runserver 0.0.0.0:8000
    
However, to properly pack the web application, the database also needs to be traced. Therefore, a script, named [runserver](https://github.com/fchirigati/sdp_curricula/blob/master/runserver), was created to include both the database and the website:

    $ /etc/init.d/postgresql start        ## Start Database Server
    $ ./manage.py runserver 0.0.0.0:8000  ## Run Stacked Up
    $ /etc/init.d/postgresql stop         ## Stop Database Server

and this script was then traced by ReproZip:

    $ reprozip trace ./runserver

This guarantees that both the database and the website are properly identified and traced.

In addition, in the [configuration file](http://reprozip.readthedocs.io/en/stable/packing.html#editing-the-configuration-file), all the database and web application files were included under the ``additional_patterns`` section:

    additional_patterns:
      - /var/lib/postgresql/9.1/main/**  # all the database files
      - /home/vagrant/sdp_curricula/**   # all the web application files

How to Reproduce
----------------

The web application can be started as follows:

    $ reprounzip docker setup stacked-up.rpz stacked-up/
    $ reprounzip docker run stacked-up/ --docker-option=-p --docker-option=8000:8000

Note that you need to pass `-p 8000:8000` to Docker for it to expose the port from the container. You can then access your local Stacked Up application at `http://IP:8000/`, where `IP` is your docker-machine's IP address (which can be retrieved by running `docker-machine ip`).

How to Run in the Cloud
-----------------------

Running the website in a cloud server is just a matter of provisioning and using a cloud instance. For example, using [docker-machine](https://docs.docker.com/machine/) to run on [AWS](https://aws.amazon.com/), you can use the following:

    $ docker-machine create --driver amazonec2 --amazonec2-access-key AWS_ID --amazonec2-secret-key AWS_KEY aws01
    $ eval $(docker-machine env aws01)
    $ reprounzip docker setup stacked-up.rpz stacked-up-aws/
    $ reprounzip docker run -d stacked-up-aws/ --docker-option=-p --docker-option=80:8000 
    $ docker ps

where `AWS_ID` is the AWS Access Key ID and `AWS_KEY` is the AWS Secret Access Key.