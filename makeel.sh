eed=~/.emacs.d
for i in `ls $eed`; do cd $eed/$i && make; done;
cd $eed/yatex* && make elc
cd $eed/bbdb*/lisp && make
find $eed/site-lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/elpa/ -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/reftex*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/elib* -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
find $eed/jdee-*/lisp -type f -name *.el -print0 | xargs -0 emacs -batch -f batch-byte-compile
