## A really basic shell script for managing compiled
## Files for emacs since these need to be regenerated

dir=~/.emacs.d

rm -rf ~/.elispcache

cd $dir/auctex-11.86
make clean
./configure
make
sudo make install

cd $dir/ispell-3.3.02
make clean
make
sudo make install

cd $dir/cedet-1.0
make clean-autoloads
make clean-all
make


cd $dir/yatex1.74
make clean
make elc
make
sudo make install
