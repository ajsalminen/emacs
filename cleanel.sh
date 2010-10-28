find . -type f -name *.elc -print0 | xargs -0 rm
rm -rf ~/.elispcache