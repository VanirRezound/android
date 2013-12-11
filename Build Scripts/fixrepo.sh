#/bin/bash 
#

cd ~/Android/cm10.2-rezound

# reset all git projects
repo forall -c git reset --hard HEAD

# clear old repo software and manifests:
rm -rf .repo/repo
rm -rf .repo/manifests .repo/manifests.git .repo/manifest.xml

# re-init the repo
repo init -b cm-10.2 -u git://github.com/vigor/android.git

# remove the sync-c=true line from manifest.xml; this ensures we get SDK 19
pushd .repo
    sed -i "s/sync-c=\"true\"//g" manifest.xml 
popd

# sync the repo
repo sync -j16

# get the prebuilts files and make sure they are up to date
pushd vendor/cm
    ./get-prebuilts
popd


