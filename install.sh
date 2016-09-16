export DEBIAN_FRONTEND=noninteractive

echo '>> Updating information about packages...'
sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list' # R
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' # PostgreSQL
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get -y update
apt-get -y install vim

echo '>> Installing pip...'
wget --quiet https://bootstrap.pypa.io/get-pip.py
apt-get -y install python
python get-pip.py
apt-get -y install python-dev build-essential

echo 'Installing virtualenv...'
pip install -U virtualenv==15.0.3
pip install -U virtualenvwrapper==4.7.2
sh -c 'echo "\nexport WORKON_HOME=~/Envs" >> .bashrc'
source /usr/local/bin/virtualenvwrapper.sh

echo '>> Installing dependencies for ReproZip...'
apt-get -y install gcc libsqlite3-dev libyaml-dev
pip install -U reprozip

echo '>> Installing git...'
apt-get -y install git

echo '>> Installing dependencies for digits-sklearn...'
mkvirtualenv --system-site-packages digits-sklearn
cd reprozip-examples/digits-sklearn/
pip install -r requirements.txt
cd ../
deactivate

echo '>> Installing dependencies for digits-sklearn-opencv...'
mkvirtualenv --system-site-packages digits-sklearn-opencv
cd digits-sklearn-opencv/
pip install -r requirements.txt
cd ../../
apt-get -y install cmake pkg-config
apt-get -y install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
apt-get -y install libgtk2.0-dev
apt-get -y install libatlas-base-dev gfortran
git clone https://github.com/opencv/opencv.git
cd opencv/
git checkout 3.0.0
cd ../
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib/
git checkout 3.0.0
cd ../opencv/
mkdir build
cd build/
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D BUILD_EXAMPLES=ON ..
make -j4
make install
ldconfig
cd ../../
deactivate

echo '>> Installing dependencies for bechdel-test...'
mkvirtualenv --system-site-packages bechdel-test
cd reprozip-examples/bechdel-test/
pip install -r requirements.txt
cd ../../
deactivate

echo '>> Installing dependencies for irish-schools...'
apt-get -y install r-base
su - -c "R -e \"install.packages('ggplot2', repos = 'http://cran.rstudio.com/')\""

echo '>> Installing dependencies for bus-vis...'
apt-get -y install default-jre
apt-get -y install default-jdk
apt-get -y install maven
git clone https://github.com/JosuaKrause/BusVis.git
cd BusVis/
mvn clean package
cd ../

echo '>> Installing dependencies for stacked-up...'
dpkg --configure -a
apt-get -f install
mkvirtualenv --system-site-packages stacked-up
git clone https://github.com/fchirigati/sdp_curricula.git
DB_NAME=sdp_curricula
PROJECT_DIR=/home/vagrant/sdp_curricula
PGSQL_VERSION=9.1
cp -p $PROJECT_DIR/etc/install/etc-bash.bashrc /etc/bash.bashrc
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
locale-gen --purge en_GB.UTF-8
dpkg-reconfigure locales
sh -c 'echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list' # PostgreSQL dependencies
apt-get -y install debian-archive-keyring
apt-get -y update
apt-get -y install postgresql-$PGSQL_VERSION libpq-dev
apt-get -y install zlib1g-dev libfreetype6-dev liblcms2-dev
cp $PROJECT_DIR/etc/install/pg_hba.conf /etc/postgresql/$PGSQL_VERSION/main/
/etc/init.d/postgresql reload
createdb -Upostgres $DB_NAME
echo 'sqlparse==0.1.19' >> $PROJECT_DIR/requirements.txt 
pip install -r $PROJECT_DIR/requirements.txt
echo -e '#!../Envs/stacked-up/bin/python\nimport os\nimport sys\n\nif __name__ == "__main__":\n    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "sdp_curricula.settings")\n    from django.core.management import execute_from_command_line\n    execute_from_command_line(sys.argv)' > $PROJECT_DIR/manage.py
chmod a+x $PROJECT_DIR/manage.py
pg_restore -U postgres -d sdp_curricula $PROJECT_DIR/sdp_curricula.dump # load all the datas
/etc/init.d/postgresql stop
deactivate
