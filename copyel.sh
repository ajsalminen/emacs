eed=~/.emacs.d
mkdir -p ~/.elispcache
for i in `find $eed/ -type f -name *.el`;do cp $i* ~/.elispcache; done;
