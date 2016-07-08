# docker-build-and-push

Do a clean build of a given `GITHUB_REPO` at a given `REF`
(branch/commit/tag/commitish), tag the image with the SHA1, and push to the
given `IMAGE_REPO`.

## Dependencies

The script requires `curl`, `jq` and `docker` to be available.

## Usage

```bash
curl -sSL \
  https://github.com/caseywebdev/docker-build-and-push/raw/master/run.sh | \
  REF=master \
  GITHUB_REPO=user/repo \
  IMAGE_REPO=quay.io/user/repo \
  bash
```
