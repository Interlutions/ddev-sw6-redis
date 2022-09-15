#!/usr/bin/env bash
#ddev-generated
set -e

if [[ $DDEV_PROJECT_TYPE != php ]] || [[ $DDEV_PROJECT_TYPE =~ ^shopware6$ ]] ;
then
  exit 0
fi

if ( ddev debug configyaml 2>/dev/null | grep 'disable_settings_management:\s*true' >/dev/null 2>&1 ) ; then
  exit 0
fi


if [[ -d "${DDEV_APPROOT}/config/packages/" ]] ;
then
  cp -n redis/config/sw6-redis.yaml "${DDEV_APPROOT}/config/packages/sw6-redis.yaml"
elif [[ -d "${DDEV_APPROOT}/project/config/packages/" ]] ;
then
  cp -n redis/config/sw6-redis.yaml "${DDEV_APPROOT}/project/config/packages/sw6-redis.yaml"
elif [[ -d "${DDEV_APPROOT}/${DDEV_DOCROOT}/../config/packages/" ]] ;
then
  cp -n redis/config/sw6-redis.yaml "${DDEV_APPROOT}/${DDEV_DOCROOT}/../config/packages/sw6-redis.yaml"
else
  echo "Test"
fi