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
    prefix='/Applications'
    lispdir=$prefix'/Emacs.app/Contents/Resources/site-lisp'
    infodir=$prefix'/Emacs.app/Contents/Resources/info'
    lisp_string='--with-lispdir='$lispdir
    lisplocal_string='--with-lispdir=~/emacs.d/site-lisp'
fi

if [[ "$unamestr" == 'Linux' ]]; then
    ./configure
    make
    make install
elif [[ "$unamestr" == 'Darwin' ]]; then
    ./configure $emacs_string $lisp_string
    make
    make install
    make clean
    ./configure $emacs_string $lisplocal_string
    make
    make install
fi

cd $eed/el-get/bbdb
make clean
./configure $emacs_string
make autoloads
make

cd $eed/el-get/apel
make clean
make $install_string
make install $install_string

cd $eed/el-get/flim
make clean
make $install_string
make install $install_string

cd $eed/el-get/semi
make clean
make $install_string
make install $install_string

cd $eed/el-get/wanderlust
make clean
make $install_string
make install $install_string