platform='unknown'
unamestr=`uname`
install_string=''
emacs_string''
eed=~/.emacs.d
org_make_string=''

if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    EMACS=`which emacs`
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='freebsd'
    install_string='EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs LISPDIR=/Applications/Emacs.app/Contents/Resources/site-lisp'
    emacs_string='--with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs'
    prefix=/Applications
    lispdir = $(prefix)/Emacs.app/Contents/Resources/site-lisp
    infodir = $(prefix)/Emacs.app/Contents/Resources/info
    org_make_string="-f $eed/orgmakefile_mac"
fi

echo $org_make_string

cd $eed/org-mode
make clean
make $org_make_string
make install

cd $eed/el-get/bbdb
make clean
./configure $emacs_string
make autoloads
make

cd $eed/el-get/apel
make clean
make $install_string
make install $install_string

cd $eed/flim
make clean
make $install_string
make install $install_string

cd $eed/semi
make clean
make $install_string
make install $install_string

cd $eed/wanderlust
make clean
make $install_string
make install $install_string

cd $eed/org-mode
make clean
make $install_string
make install $install_string

cd $eed/muse-3.20
make clean
make $install_string
make install $install_string

for i in `ls $eed`; do cd $eed/$i && make; done;
find $eed/site-lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/elpa/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/haskell-mode/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/reftex*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/elib* -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/jdee-*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
cd $eed/yatex* && make elc
for i in `find $eed/* -type f -name *.el`; do emacs -batch -f batch-byte-compile $i; done;
#cd $eed/bbdb-* && make
#cd $eed/bbdb-*/lisp && make
