set -e

if [ "$BUILD_AND_PUSH_GITHUB_TOKEN" ]; then
  Q="?access_token=$BUILD_AND_PUSH_GITHUB_TOKEN"
  CREDS="$BUILD_AND_PUSH_GITHUB_TOKEN:@"
fi

SHA=`curl -sSL https://api.github.com/repos/$GITHUB_REPO/commits/$REF$Q | jq -r .sha`
REF_TAG=$IMAGE_REPO:$REF
SHA_TAG=$IMAGE_REPO:$SHA
REPO_URL=https://${CREDS}github.com/$GITHUB_REPO.git#$SHA

docker build -t $REF_TAG -t $SHA_TAG --build-arg VERSION=$SHA \
  $BUILD_AND_PUSH_EXTRA_ARGS $REPO_URL

docker push $REF_TAG
docker push $SHA_TAG

echo 'Successfully built and pushed:'
echo $REF_TAG
echo $SHA_TAG
