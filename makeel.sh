set_make_params(){
    current_dirname=$(pwd)
    platform='unknown'

    unamestr=`uname`
    install_string=''
    emacs_string=''
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
}

make_org(){
    cd $eed/org-mode
    cp $eed/org_make_mac_new $eed/org-mode/local.mk
    make clean
    make
    make install
    cd $current_dirname
}

make_cedet(){
    cd $eed/cedet-1.0
    make clean
    make
    cd $current_dirname
}

make_w3m(){
    cd $eed/emacs-w3m
    autoconf
    make clean

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
    cd $current_dirname
}

make_bbdb(){
    cd $eed/el-get/bbdb
    make clean
    ./configure $emacs_string
    make autoloads
    make
    cd $current_dirname
}

make_and_install(){
    if [ "$1" ]
    then
        cd $eed/$1
        make clean
        make $install_string
        make install $install_string
    else
        echo "specify directory"
    fi
    cd $current_dirname
}

make_elget(){
    if [ "$1" ]
    then
        dirname="el-get/${$1}"
        make_and_install $dirname
    fi
}

make_apel(){
    make_elget "apel"
}

make_flim(){
    make_elget "flim"
}

make_semi(){
    make_elget "semi"
}

make_wanderlust(){
    make_elget "wanderlust"
}

make_muse(){
    make_elget "muse-3.20"
}

make_ac(){
    cd $eed/auto-complete-1.3.1
    make clean
    make $install_string
}

make_scala(){
    cd $eed/scala
    make clean
    make
    cd $current_dirname
}

make_tramp(){
    rm -rf $eed/tramp-2.2.1
    tar xzvf $eed/tramp-2.2.1.tar.gz
    cd $eed/tramp-2.2.1
    make clean
    ./configure --with-contrib
    make $install_string
    sudo make install
    cd $eed
    rm -rf tramp-2.2.1
    cd $current_dirname
}

byte_compile_all_lisp(){
    for i in `ls $eed`; do cd $eed/$i && make; done;
    find $eed/site-lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    find $eed/elpa/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    find $eed/haskell-mode/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    find $eed/reftex*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    find $eed/elib* -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    find $eed/jdee-*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    find $eed/ensime*/elisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
    for i in `find $eed/* -type f -name *.el`; do emacs -batch -f batch-byte-compile $i; done;
    #cd $eed/bbdb-* && make
    #cd $eed/bbdb-*/lisp && make
    cd $eed/yatex* && make elc
    cd $current_dirname
}

set_make_params

make_all_elisp(){
    make_org
    make_cedet
    make_w3m
    make_bbdb
    make_apel
    make_flim
    make_semi
    make_wanderlust
    make_muse
    make_ac
    make_scala
    make_tramp
    byte_compile_all_lisp
}


while [ $# -gt 0 ]; do
    opt="$1"
    shift
    case "$opt" in
        --all) make_all_elisp ;;
        *) die "Unexpected option: $opt" ;;
    esac
done
