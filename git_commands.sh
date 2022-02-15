#!/usr/bin/env bash

for i in "$@"
do
case $i in
    -m=*|--message=*)
    MESSAGE="${i#*=}"
    shift # past argument=value
    ;;
    -v=*|--version=*)
    VERSION="${i#*=}"
    shift # past argument=value
    ;;
esac
done

git add .
git commit -m "$MESSAGE" --quiet
git push origin main --quiet
gh release create 4.1.1 ../SDKFlowsenseiOS/build/4.1.1.zip


