set -e

SHA=`curl -sSL https://api.github.com/repos/$GITHUB_REPO/commits/$REF | jq -r .sha`
REPO_URL=https://api.github.com/repos/$GITHUB_REPO/tarball/$SHA
IMAGE=$IMAGE_REPO:$SHA
TMP=/tmp/$IMAGE

rm -fr $TMP
mkdir -p $TMP
curl -sSL $REPO_URL | tar xz --strip-components 1 -C $TMP
cd $TMP

echo "Building $IMAGE"
docker build -t latest -t $IMAGE --build-arg VERSION=$SHA .

rm -fr $TMP

echo "Pushing $IMAGE"
docker push $IMAGE

echo "Successfully built and pushed $IMAGE"
