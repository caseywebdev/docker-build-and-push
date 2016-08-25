set -e

if [ "$BUILD_AND_PUSH_GITHUB_TOKEN" ]; then
  Q="?access_token=$BUILD_AND_PUSH_GITHUB_TOKEN"
fi

SHA=`curl -sSL https://api.github.com/repos/$GITHUB_REPO/commits/$REF$Q | jq -r .sha`
REF_TAG=$IMAGE_REPO:$REF
SHA_TAG=$IMAGE_REPO:$SHA
TMP=/tmp/$SHA_TAG
REPO_URL=https://api.github.com/repos/$GITHUB_REPO/tarball/$SHA$Q

rm -fr $TMP
mkdir -p $TMP
curl -sSL $REPO_URL | tar xz --strip-components 1 -C $TMP
cd $TMP

echo 'Building:'
echo $REF_TAG
echo $SHA_TAG
docker build -t $REF_TAG -t $SHA_TAG --build-arg VERSION=$SHA .

rm -fr $TMP

echo 'Pushing:'
echo $REF_TAG
docker push $REF_TAG

echo 'Pushing:'
echo $SHA_TAG
docker push $SHA_TAG

echo 'Successfully built and pushed:'
echo $REF_TAG
echo $SHA_TAG
