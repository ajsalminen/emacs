## Original instructions cribbed from
## http://journal.mycom.co.jp/column/osx/020/

mkdir -p ~/tmp
wget http://jaist.dl.sourceforge.jp/nkf/44486/nkf-2.1.0.tar.gz
tar -xzvf nkf*
cd nkf
make
sudo make install


## http://www.namazu.org/~tsuchiya/sdic/index.html#download

cd ..
wget http://www.namazu.org/~tsuchiya/sdic/sdic-2.1.3.tar.gz
tar -xzvf sdic-*

wget http://www.namazu.org/~tsuchiya/sdic/data/gene95.tar.bz2
wget http://www.namazu.org/~tsuchiya/sdic/data/edict.gz

./configure --with-eijirou=/usr/local/share/dict
sudo make install
sudo make install-info
make dict
sudo make install-dict


## for faster lookups
cd ..
wget http://ftp.gnu.org/gnu/libtool/libtool-2.4.tar.gz
tar -xzvf libto*
cd libtoo*
./configure
make
sudo make install


## getting this setup is pretty hairy if you try the "newer" version
cd ..
wget http://nais.to/~yto/tools/sufary/src/sufary-2.1.1.tar.gz
tar -zxvf sufary-*
cd sufary-*
mv lib/Makefile lib/Makefile.org
sed 's/echo/ranlib/g' lib/Makefile.org > lib/Makefile
make
sudo cp array/array /usr/local/bin/
sudo cp mkary/mkary /usr/local/bin/

## obsoletes above
wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.25.tar.gz
tar -xzvf pkgc*
cd pkgc*
./configure
make
sudo make install

## truckload of dependencies, freakin' ridiculous

wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.18.1.1.tar.gz
tar -xzvf gett*
cd gett*
./configure
make
sudo make install

wget http://ftp.acc.umu.se/pub/GNOME/sources/glib/2.24/glib-2.24.1.tar.gz
tar -xzvf glib*
cd glib*
./configure
make
sudo make install

## this is to speed up your lookups
wget http://sary.sourceforge.net/sary-1.2.0.tar.gz
cd sary-*
./configure
make
sudo make install



### Make Eijiro dict
### You're on your own as you need to buy it from http://eijiro.jp
### It's like $20 or $30 depending on Yen fluctuations

### http://nox-insomniae.ddo.jp/insomnia/2009/01/eijiro-emacs.html

wget http://github.com/baron/emacs/raw/master/pdic2sdic.rb
cp pdic2sdic.rb ~/Downloads/EDP-124/EIJIRO/
cd ~/Downloads/EDP-124/EIJIRO
## EIJI-124.TXT    REIJI124.TXT    RYAKU124.TXT    WAEI-124.TXT

cat EIJI-124.TXT RYAKU124.TXT | nkf -w8 | pdic2sdic.rb > eijirou.sdic

nkf -w8 WAEI-124.TXT | ruby pdic2sdic.rb > waeijirou.sdic

sudo cp *.sdic /usr/local/share/dict/

## just for backup
tar -czvf eijidict.tar *.sdic 

## if you don't use utf8 you may need to adjust
## http://blog.2310.net/archives/200
## this one takes a whille without the -b option (need more RAM)
## http://sary.sourceforge.net/FAQ.html#tooslow
cd /usr/local/share/dict
sudo mksary -b eijirou.sdic 
sudo mksary -b waeijirou.sdic