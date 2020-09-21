#!/bin/bash -x

TARGET=$1

if [[ ! -e /tmp/qemu-aarch64-static ]]; then
  BUILD_ARCH=aarch64
  QEMU_USER_STATIC_ARCH=$([ "${BUILD_ARCH}" == "armhf" ] && echo "${BUILD_ARCH::-2}" || echo "${BUILD_ARCH}")
  QEMU_USER_STATIC_DOWNLOAD_URL="https://github.com/multiarch/qemu-user-static/releases/download"
  QEMU_USER_STATIC_LATEST_TAG=$(curl -s https://api.github.com/repos/multiarch/qemu-user-static/tags \
      | grep 'name.*v[0-9]' \
      | head -n 1 \
      | cut -d '"' -f 4)
  curl -SL "${QEMU_USER_STATIC_DOWNLOAD_URL}/${QEMU_USER_STATIC_LATEST_TAG}/x86_64_qemu-${QEMU_USER_STATIC_ARCH}-static.tar.gz" \
      | tar xzv -C /tmp
  docker run --rm --privileged multiarch/qemu-user-static:register --reset
fi

cp docker /usr/local/bin/docker || true
sudo cp docker /usr/local/bin/docker || true

pushd $TARGET
pwd
ls -alh
cat ../patches/$TARGET.patch

patch -N --dry-run --silent -p1 -i ../patches/$TARGET.patch 2>/dev/null
[[ $? -eq 0 ]] && patch -p1 -i ../patches/$TARGET.patch

if [[ ! -e scripts/version.org ]]; then
  sudo mv scripts/version scripts/version.org || true
  sudo chmod 777 scripts/version || true
  mv scripts/version scripts/version.org || true
  source scripts/version.org
  { for N in COMMIT GIT_TAG VER VERSION GITCOMMIT BUILDDATE; do echo "$N=${!N}"; done } > scripts/version
  echo VERSION=latest >> scripts/version
  echo VER=latest >> scripts/version
  echo REPO=index.docker.io/yaamai >> scripts/version
  echo "echo \${VER}" >> scripts/version
  sudo chmod +x scripts/version || true
  chmod +x scripts/version || true
fi

# in dapper, cannot inject arm64 related configs
make build || true
make package || true
scripts/package

if [[ $TARGET == "instance-manager" && -e bin/latest_image ]]; then
  tag=$(cat bin/latest_image | cut -d: -f2)
  docker tag yaamai/instance-manager:$tag yaamai/longhorn-instance-manager:latest || true
fi

docker tag longhornio/longhorn-ui:latest yaamai/longhorn-ui:latest || true
docker tag longhornio/longhorn-manager:latest yaamai/longhorn-manager:latest || true
docker tag yaamai/instance-manager:v1_20200921 yaamai/longhorn-instance-manager:latest || true
docker tag yaamai/engine:latest yaamai/longhorn-engine:latest || true

popd
