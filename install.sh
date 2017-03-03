#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo '>> Updating information about packages...' >&2
sudo apt-get -y update
echo '>> Installing dependencies...' >&2
sudo apt-get -y install vim git python python-dev python-pip python-virtualenv build-essential libsqlite3-dev virtualenvwrapper python-numpy libffi-dev

echo '>> Removing default X server...' >&2
sudo service xserver stop
sudo rm /etc/init.d/xserver && sudo update-rc.d xserver remove
sudo killall Xorg

echo '>> Setting up Xfce...' >&2
sudo apt-get -y install xfce4 xserver-xorg-legacy
sudo sh -c '(echo "allowed_users=anybody"; echo "needs_root_rights=yes") > /etc/X11/Xwrapper.config'
sudo ed /etc/xdg/xfce4/xinitrc <<'END'
1a

unset SSH_CONNECTION
.
wq
END

echo '>> Setting up virtualenvwrapper...' >&2
rm -rf .virtualenvs
mkdir .virtualenvs
echo -e "\nexport WORKON_HOME=$HOME/.virtualenvs\nsource /usr/share/virtualenvwrapper/virtualenvwrapper.sh" >>.bash_profile
. .bash_profile

cd reprozip-examples

echo '>> Installing dependencies for digits-sklearn...' >&2
cd digits-sklearn/
mkvirtualenv --system-site-packages digits-sklearn
#sudo apt-get -y install libblas-dev liblapack-dev gfortran
pip install -r requirements.txt
deactivate
cd ..

echo '>> Installing dependencies for digits-sklearn-opencv...' >&2
cd digits-sklearn-opencv/
sudo apt-get -y install python-opencv
mkvirtualenv --system-site-packages digits-sklearn-opencv
pip install -r requirements.txt
deactivate
cd ..

echo '>> Installing dependencies for bechdel-test...' >&2
cd bechdel-test/
mkvirtualenv --system-site-packages bechdel-test
pip install -r requirements.txt
deactivate
cd ..

echo '>> Installing dependencies for irish-schools...' >&2
sudo apt-get -y install r-base r-cran-ggplot2

echo '>> Installing dependencies for bus-vis...' >&2
cd bus-vis/
sudo apt-get -y install default-jre default-jdk maven
test -e BusVis || git clone https://github.com/JosuaKrause/BusVis.git
cd BusVis/
mvn clean package
cd ../..

echo '>> Installing dependencies for stacked-up...' >&2
cd stacked-up
mkvirtualenv --system-site-packages stacked-up
test -e sdp_curricula || git clone https://github.com/fchirigati/sdp_curricula.git
cd sdp_curricula
sudo apt-get -y install postgresql-9.5 libpq-dev
sudo -u postgres pg_dropcluster --stop 9.5 main
sudo -u postgres pg_createcluster --port 5432 --locale en_US.UTF-8 --start 9.5 main
DB_NAME=sdp_curricula
sudo -u postgres createdb $DB_NAME
sudo -u postgres psql $DB_NAME <<END
CREATE ROLE vagrant LOGIN PASSWORD '@x1s2013';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO vagrant;
ALTER ROLE postgres WITH PASSWORD '@x1s2013';
END
sudo sh -c "echo 'local all all trust' >/etc/postgresql/9.5/main/pg_hba.conf"
sudo sh -c "echo 'host all all 127.0.0.1/32 trust' >>/etc/postgresql/9.5/main/pg_hba.conf"
sudo service postgresql restart
pip install -r requirements.txt
cat >manage.py <<'END'
#!/home/vagrant/.virtualenvs/stacked-up/bin/python
import os
import sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "sdp_curricula.settings")
    from django.core.management import execute_from_command_line
    execute_from_command_line(sys.argv)
END
chmod +x manage.py
pg_restore -d $DB_NAME sdp_curricula.dump # load all the data
sudo /etc/init.d/postgresql stop
deactivate
cd ../..

echo '>> Installing brain-segmentation...' >&2
wget -O- http://neuro.debian.net/lists/xenial.au.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9
sudo apt-get -y update
sudo apt-get -y install python-dipy

echo '>> Installing reprozip...' >&2
mkvirtualenv --system-site-packages reprozip
pip install --upgrade reprozip reprounzip[all]
mkdir $HOME/.bin
ln -s $HOME/.virtualenvs/reprozip/bin/reprozip $HOME/.virtualenvs/reprozip/bin/reprounzip $HOME/.bin/
echo -e 'PATH=$HOME/.bin:$PATH\nexport PATH' >>$HOME/.bash_profile
