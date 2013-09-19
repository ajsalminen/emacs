#!/bin/sh

# for each path that was subtree merged
for path in `git log --grep Squashed --oneline | awk '{ print $3 }' | sort | uniq | sed "s/'//g" | sed "s/\/$//g"`; do

    # check to see if the subpath is already in .gittrees
    git config -f .gittrees subtree.$path.url &> /dev/null
    if [ $? -eq 0 ]; then
        echo "$path already configured"
    else

        # look for the most recent commit
        commit=`git log --grep "Squashed '$path/'" --oneline | head -n 1 | awk '{ print $NF }'`
        if [[ $commit =~ '..' ]]; then
            commit=`echo $commit | cut -d . -f 3`
        fi
        echo "last commit for $path is $commit";

        # ask for the git url
        echo "Enter url: "
        read URL

        # record the subtree info
        git config -f .gittrees --unset subtree.$path.url
        git config -f .gittrees --add subtree.$path.url $URL
        git config -f .gittrees --unset subtree.$path.path
        git config -f .gittrees --add subtree.$path.path $path
        git config -f .gittrees --unset subtree.$path.branch
        git config -f .gittrees --add subtree.$path.branch master
    fi

    echo "------------------------------"
done