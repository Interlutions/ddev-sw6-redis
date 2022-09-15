setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-sw6-redis
  mkdir -p $TESTDIR
  export PROJNAME=test-sw6-redis
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  mkdir -p "${TESTDIR}/project/config/packages"
  ddev start -y >/dev/null
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart

  # Test expected configurations
  ddev redis-cli INFO | grep "^redis_version:6."

  [ -f project/config/packages/sw6-redis.yaml ]
  ddev exec 'echo $REDIS_CACHE_HOST' | grep "redis"
  ddev exec 'echo $REDIS_CACHE_PORT' | grep "6379"
  ddev exec 'echo $REDIS_CACHE_DB' | grep "0"
  ddev exec 'echo $REDIS_SESSION_HOST' | grep "redis"
  ddev exec 'echo $REDIS_SESSION_PORT' | grep "6379"
  ddev exec 'echo $REDIS_SESSION_DB' | grep "2"
  ddev exec 'echo $REDIS_FPC_HOST' | grep "redis"
  ddev exec 'echo $REDIS_FPC_PORT' | grep "6379"
  ddev exec 'echo $REDIS_FPC_DB' | grep "1"
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get interlutions/ddev-sw6-redis with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get interlutions/ddev-sw6-redis
  ddev restart >/dev/null

  # Test expected configurations
  ddev redis-cli INFO | grep "^redis_version:6."
  [ -f project/config/packages/sw6-redis.yaml ]
  ddev exec 'echo $REDIS_CACHE_HOST' | grep "redis"
  ddev exec 'echo $REDIS_CACHE_PORT' | grep "6379"
  ddev exec 'echo $REDIS_CACHE_DB' | grep "0"
  ddev exec 'echo $REDIS_SESSION_HOST' | grep "redis"
  ddev exec 'echo $REDIS_SESSION_PORT' | grep "6379"
  ddev exec 'echo $REDIS_SESSION_DB' | grep "2"
  ddev exec 'echo $REDIS_FPC_HOST' | grep "redis"
  ddev exec 'echo $REDIS_FPC_PORT' | grep "6379"
  ddev exec 'echo $REDIS_FPC_DB' | grep "1"
}
