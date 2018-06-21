# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=pxe2
# image name
IMAGE=ipxe-builder

# Ensure the repo is up to date
git pull

# Bump Version
docker run --rm -v "$PWD":/app treeder/bump patch
VERSION=`cat VERSION`
set -x
echo "version: $VERSION"

# run build
./build.sh -v

# tag it
git add -A
git commit -m "version $VERSION"
git tag -a "$VERSION" -m "version $VERSION"
git push
git push --tags
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
push it
docker push $USERNAME/$IMAGE
