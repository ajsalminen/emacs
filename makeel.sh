eed=~/.emacs.d
for i in `ls $eed`; do cd $eed/$i && make; done;
find $eed/site-lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/elpa/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/haskell-mode/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/reftex*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/elib* -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/jdee-*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
cd $eed/yatex* && make elc
for i in `find $eed/* -type f -name *.el`; do emacs -batch -f batch-byte-compile $i; done;
cd $eed/bbdb-* && make
cd $eed/bbdb-*/lisp && make