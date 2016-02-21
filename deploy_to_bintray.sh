if [ ! -z "$TRAVIS_TAG" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  for path in build/libs/*; do
    version=$(basename $path | awk -F- '{print $3}' | cut -d. -f1-3)
    file=$(basename $path)
    echo "Uploading $file"
    curl -T $path -u$USER:$BINTRAY_KEY https://api.bintray.com/content/radl/RADL/radl/radl-specification/$version/$(basename $path)\;bt_package=radl-specification\;bt_version=$version\;publish=1\;override=1
  done
else
  echo TRAVIS_TAG=$TRAVIS_TAG
  echo TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST
  echo TRAVIS_SECURE_ENV_VARS=$TRAVIS_SECURE_ENV_VARS
fi
